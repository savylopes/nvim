return {
	"neovim/nvim-lspconfig",
	dependencies = {
		{ "williamboman/mason.nvim", config = true },
		{ "williamboman/mason-lspconfig.nvim" },
		{ "WhoIsSethDaniel/mason-tool-installer.nvim" },
		{ "j-hui/fidget.nvim", opts = {} },
	},
	config = function()
		-- 1. Global Diagnostic Settings (This makes errors/warnings visible)
		vim.diagnostic.config({
			virtual_text = {
				prefix = "●", -- Displays the message at the end of the line
				spacing = 4,
			},
			signs = true, -- Show icons in the gutter
			underline = true, -- Underline error text
			update_in_insert = false,
			severity_sort = true,
			float = {
				border = "rounded",
				source = "always", -- Shows which LSP provided the error
			},
		})

		-- 2. Set Gutter Icons (Optional but highly recommended)
		local signs = { Error = "✘", Warn = "▲", Hint = "⚑", Info = "»" }
		for type, icon in pairs(signs) do
			local hl = "DiagnosticSign" .. type
			vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
		end

		-- 3. Diagnostic Keymaps (To navigate and read errors)
		vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic" })
		vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic" })
		vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show error message" })
		vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic list" })

		local mason_lspconfig = require("mason-lspconfig")
		local mason_tool_installer = require("mason-tool-installer")

		mason_lspconfig.setup({
			ensure_installed = {
				"terraformls",
				"tflint",
				"ts_ls",
				"html",
				"cssls",
				"lua_ls",
				"rust_analyzer",
				"pyright",
				"codebook",
			},
			handlers = {
				function(server_name)
					if server_name == "lua_ls" then
						vim.lsp.config("lua_ls", {
							settings = {
								Lua = {
									diagnostics = { globals = { "vim" } },
									workspace = { checkThirdParty = false },
								},
							},
						})
					end

					if server_name == "pyright" then
						local util = require("lspconfig.util")
						local path = util.path

						local function get_python_path(workspace)
							-- Use activated virtualenv.
							if vim.env.VIRTUAL_ENV then
								return path.join(vim.env.VIRTUAL_ENV, "bin", "python")
							end

							-- Find and use virtualenv from pipenv in workspace directory.
							local match = vim.fn.glob(path.join(workspace, "Pipfile"))
							if match ~= "" then
								local venv = vim.fn.trim(vim.fn.system("PIPENV_PIPFILE=" .. match .. " pipenv --venv"))
								return path.join(venv, "bin", "python")
							end

							-- Fallback to local .venv for uv/venv
							local venv_path = path.join(workspace, ".venv", "bin", "python")
							if vim.loop.fs_stat(venv_path) then
								return venv_path
							end

							-- Default to system python
							return vim.fn.exepath("python3") or vim.fn.exepath("python") or "python"
						end

						vim.lsp.config("pyright", {
							before_init = function(_, config)
								config.settings.python.pythonPath = get_python_path(config.root_dir)
							end,
							settings = {
								python = {
									analysis = {
										autoSearchPaths = true,
										useLibraryCodeForTypes = true,
										diagnosticMode = "workspace",
									},
								},
							},
						})
					end

					-- Enable the server
					vim.lsp.enable(server_name)
				end,
			},
		})

		mason_tool_installer.setup({
			ensure_installed = {
				"terraformls",
				"tflint",
				"ts_ls",
				"html",
				"cssls",
				"lua_ls",
				"rust_analyzer",
				"pyright",
				"ruff", -- Python linter/formatter
				"black", -- Python formatter
			},
			auto_install = true,
		})

		-- Filetype detection fix for Terraform/HCL
		vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
			pattern = { "*.tf", "*.tfvars", "*.hcl" },
			callback = function()
				vim.bo.filetype = "terraform"
			end,
		})

		-- Format on save
		vim.api.nvim_create_autocmd("BufWritePre", {
			pattern = {
				"*.tf",
				"*.tfvars",
				"*.js",
				"*.ts",
				"*.html",
				"*.css",
				"*.lua",
				"*.rs",
				"*.py",
			},
			callback = function()
				vim.lsp.buf.format()
			end,
		})
	end,
}

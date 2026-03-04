return {
	'neovim/nvim-lspconfig',
	dependencies = {
		{ 'williamboman/mason.nvim',          config = true },
		{ 'williamboman/mason-lspconfig.nvim' },
		{ 'j-hui/fidget.nvim',                opts = {} },
	},
	config = function()
		-- 1. Global Diagnostic Settings
		vim.diagnostic.config({
			virtual_text = {
				prefix = '●',
				spacing = 4,
			},
			signs = true,
			underline = true,
			update_in_insert = false,
			severity_sort = true,
			float = {
				border = 'rounded',
				source = 'always',
			},
		})
		-- 2. Gutter Icons
		local signs = { Error = "✘", Warn = "▲", Hint = "⚑", Info = "»" }
		for type, icon in pairs(signs) do
			local hl = "DiagnosticSign" .. type
			vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
		end
		-- 3. Diagnostic Keymaps
		vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic' })
		vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic' })
		vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show error message' })
		vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic list' })

		-- 4. Mason: just ensure servers are installed
		require('mason-lspconfig').setup({
			ensure_installed = {
				'terraformls',
				'tflint',
				'ts_ls',
				'html',
				'cssls',
				'lua_ls',
				'rust_analyzer',
			},
		})

		-- 5. Configure each LSP server directly via vim.lsp.config (nvim 0.11+)
		vim.lsp.config("lua_ls", {
			settings = {
				Lua = {
					diagnostics = { globals = { "vim" } },
					workspace = { checkThirdParty = false },
				},
			},
		})

		vim.lsp.config("rust_analyzer", {
			settings = {
				["rust-analyzer"] = {
					cargo = {
						allFeatures = true,
						loadOutDirsFromCheck = true,
					},
					checkOnSave = {
						command = "clippy",
						extraArgs = { "--no-deps" },
					},
					procMacro = {
						enable = true,
					},
					inlayHints = {
						bindingModeHints = { enable = true },
						chainingHints = { enable = true },
						closingBraceHints = { enable = true },
						parameterHints = { enable = true },
						typeHints = { enable = true },
					},
					diagnostics = {
						enable = true,
						experimental = { enable = true },
					},
				},
			},
		})

		-- 6. Enable all servers (picks up the configs above)
		vim.lsp.enable({
			'terraformls',
			'tflint',
			'ts_ls',
			'html',
			'cssls',
			'lua_ls',
			'rust_analyzer',
		})

		-- Filetype detection for Terraform/HCL
		vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
			pattern = { "*.tf", "*.tfvars", "*.hcl" },
			callback = function()
				vim.bo.filetype = "terraform"
			end,
		})

		-- Filetype detection for Rust
		vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
			pattern = { "*.rs" },
			callback = function()
				vim.bo.filetype = "rust"
			end,
		})

		-- Format on save
		vim.api.nvim_create_autocmd("BufWritePre", {
			pattern = {
				"*.tf", "*.tfvars", "*.js", "*.ts",
				"*.html", "*.css", "*.lua", "*.rs"
			},
			callback = function()
				vim.lsp.buf.format({ async = false })
			end,
		})
	end,
}

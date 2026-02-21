return {
	"nvim-tree/nvim-tree.lua",
	dependencies = { "nvim-tree/nvim-web-devicons", "akinsho/toggleterm.nvim" },
	config = function()
		vim.g.loaded_netrw = 1
		vim.g.loaded_netrwPlugin = 1

		-- Função para abrir o ToggleTerm no diretório do nó selecionado
		local function open_terminal_at_node()
			local api = require("nvim-tree.api")
			local node = api.tree.get_node_under_cursor()

			-- Pega o caminho do nó ou o diretório atual como fallback
			local path = node.absolute_path or vim.uv.cwd()

			-- Se for um arquivo, pegamos o diretório pai (folder) dele
			if node.type ~= "directory" then
				path = vim.fn.fnamemodify(path, ":h")
			end

			-- Abre o terminal enviando o comando 'cd' para a pasta selecionada
			-- O número '1' é o ID do terminal
			require("toggleterm").exec("cd " .. path .. " && clear", 1)
			require("toggleterm").toggle(1)
		end

		require("nvim-tree").setup({
			sync_root_with_cwd = true,
			respect_buf_cwd = true,
			update_focused_file = {
				enable = true,
				update_root = true,
			},
			-- Configuração dos mapeamentos customizados
			on_attach = function(bufnr)
				local api = require("nvim-tree.api")

				local function opts(desc)
					return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
				end

				-- Aplica os mapeamentos padrão do Nvim-Tree primeiro
				api.config.mappings.default_on_attach(bufnr)

				-- Adiciona o mapeamento para abrir o terminal com a tecla 'T'
				vim.keymap.set("n", "T", open_terminal_at_node, opts("Open Terminal at Path"))
			end,
		})
	end,
}

return {
	"iamcco/markdown-preview.nvim",
	cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
	ft = { "markdown", "html" },
	-- This adds the keymap and tells lazy.nvim to lazy-load on this key combination
	keys = {
		{ "<leader>mp", "<cmd>MarkdownPreviewToggle<cr>", desc = "Toggle Markdown Preview" },
	},
	build = function()
		vim.fn["mkdp#util#install"]()
	end,
	config = function()
		-- Optional configuration settings
		vim.g.mkdp_auto_start = 0
		vim.g.mkdp_filetypes = { "markdown", "html" }
	end,
}

return {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
	vim.g.loaded_netrw = 1
	vim.g.loaded_netrwPlugin = 1
        require("nvim-tree").setup({
	  sync_root_with_cwd = true,     -- Changes the tree when you :cd
  	  respect_buf_cwd = true,        -- Respects the folder of the file you are in
  	  update_focused_file = {
    	    enable = true,
    	    update_root = true,          -- This is the "magic" setting
  	  },
	})
    end,
}



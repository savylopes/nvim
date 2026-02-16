-- in your plugins file (e.g. lua/plugins/treesitter.lua)

return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter").setup({
      ensure_installed = { 
      	"rust",
	"terraform",
	'hcl',
	"javascript", 
	"lua", 
	"vim", 
	"vimdoc",
	"markdown",
	"json",
      },

      highlight = { enable = true },
      indent = { enable = true },
      incremental_selection = { enable = true },
      -- textobjects = { ... },
    })
  end,
}



return {
  'nvim-telescope/telescope.nvim',
  -- REMOVE THIS LINE: tag = '0.1.8', 
  -- Removing the tag defaults to the 'master' branch which has the fix.
  dependencies = {
    'nvim-lua/plenary.nvim',
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' }
  },
  config = function()
    local telescope = require("telescope")
    telescope.setup({
      defaults = {
        mappings = {
          i = {
            ["<C-k>"] = "move_selection_previous",
            ["<C-j>"] = "move_selection_next",
          },
        },
      },
    })
    telescope.load_extension("fzf")
  end
}

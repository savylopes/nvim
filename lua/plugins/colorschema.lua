return {
  -- Let's use TokyoNight as an example
  {
    "folke/tokyonight.nvim",
    lazy = false, -- Load this during startup
    priority = 1000, -- Load this before other plugins
    config = function()
      vim.cmd([[colorscheme tokyonight-night]])
    end,
  },
}

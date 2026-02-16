return {
  'nvim-pack/nvim-spectre',
  dependencies = { 'nvim-lua/plenary.nvim' },
  keys = {
    { "<leader>f", '<cmd>lua require("spectre").toggle()<CR>', desc = "Toggle Spectre" },
  }
}

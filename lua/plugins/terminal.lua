return {
  {
    'akinsho/toggleterm.nvim',
    version = "*",
    config = function()
      require("toggleterm").setup({
        -- size can be a number or a function
        size = 20,
        -- The key used to toggle the terminal
        open_mapping = [[<C-\>]], -- You can change this to [[<C-j>]] if you prefer
        -- hide_numbers = true, 
        -- shade_terminals = true,
        -- start_in_insert = true,
        -- insert_mappings = true,   -- whether or not the open mapping applies in insert mode
        -- terminal_mappings = true, -- whether or not the open mapping applies in the opened terminals
        -- persist_size = true,
        direction = 'float', -- This makes it look like VS Code (bottom)
        -- direction = 'horizontal', -- This makes it look like VS Code (bottom)
        -- close_on_exit = true, 
        -- shell = vim.o.shell,
      })
      local Terminal = require('toggleterm.terminal').Terminal
      local lazygit = Terminal:new({ cmd = "lazygit", hidden = true, direction = "float" })

      function _lazygit_toggle()
        lazygit:toggle()
      end

      vim.api.nvim_set_keymap("n", "<leader>lg", "<cmd>lua _lazygit_toggle()<CR>", {noremap = true, silent = true})
    end
  }
}

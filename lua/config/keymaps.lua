local builtin = require('telescope.builtin')

vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>")
-- Search for files by name
vim.keymap.set('n', '<leader>pp' , builtin.find_files, {})
-- Search for text inside files (requires 'ripgrep' installed on your OS)
vim.keymap.set('n', '<leader>pg', builtin.live_grep, {})
-- Search through open buffers
vim.keymap.set('n', '<leader>pb', builtin.buffers, {})
-- Search through help tags
vim.keymap.set('n', '<leader>ph', builtin.help_tags, {})


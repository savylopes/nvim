return {
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" }, -- Only loads when you open a file
    opts = {
      current_line_blame = true, -- This gives you the "Git Blame" ghost text
      current_line_blame_opts = {
        delay = 500, -- Show blame after half a second
      },
      signs = {
        add          = { text = '┃' },
        change       = { text = '┃' },
        delete       = { text = '_' },
        topdelete    = { text = '‾' },
        changedelete = { text = '~' },
        untracked    = { text = '┆' },
      },
      on_attach = function(bufnr)
	    -- Style the "Blame" ghost text
	    vim.api.nvim_set_hl(0, 'GitSignsCurrentLineBlame', { fg = '#586e75', italic = true })
	    
	    -- Style the gutter signs (the bars on the left)
	    vim.api.nvim_set_hl(0, 'GitSignsAdd', { fg = '#b5bd68' })    -- Green
	    vim.api.nvim_set_hl(0, 'GitSignsChange', { fg = '#f0c674' }) -- Yellow
	    vim.api.nvim_set_hl(0, 'GitSignsDelete', { fg = '#cc6666' }) -- Red
	  end,
    },
  },
}

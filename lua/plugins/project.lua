return {
  "ahmedkhalf/project.nvim",
  config = function()
    require("project_nvim").setup({
      -- Detection methods: 'lsp' uses language server, 'pattern' uses files like .git
      detection_methods = { "pattern" },
      patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json" },
      -- Automatically change directory
      update_cwd = true,
    })
  end
}

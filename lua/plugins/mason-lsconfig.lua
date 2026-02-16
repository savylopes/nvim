return {
  'neovim/nvim-lspconfig',
  version = 'v2.*',
  dependencies = {
    { 'williamboman/mason.nvim', config = true },
    { 'williamboman/mason-lspconfig.nvim', version = 'v1.*' },
    { 'j-hui/fidget.nvim', opts = {} },
  },
  config = function()
    local lspconfig = require('lspconfig')
    local mason_lspconfig = require('mason-lspconfig')

    mason_lspconfig.setup({
      ensure_installed = { 'terraformls', 'tflint' },
    })

    mason_lspconfig.setup_handlers({
      function(server_name)
        lspconfig[server_name].setup({})
      end,
    })

    -- Filetype detection fix
    vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
      pattern = {"*.tf", "*.tfvars", "*.hcl"},
      callback = function()
        vim.bo.filetype = "terraform"
      end,
    })

    -- Format on save
    vim.api.nvim_create_autocmd("BufWritePre", {
      pattern = {"*.tf", "*.tfvars"},
      callback = function()
        vim.lsp.buf.format()
      end,
    })
  end, -- This closes the 'config' function
}

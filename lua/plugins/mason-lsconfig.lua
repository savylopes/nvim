return {
  'neovim/nvim-lspconfig',
  dependencies = {
    { 'williamboman/mason.nvim', config = true },
    { 'williamboman/mason-lspconfig.nvim' },
    { 'j-hui/fidget.nvim', opts = {} },
  },
  config = function()
    local mason_lspconfig = require('mason-lspconfig')

    mason_lspconfig.setup({
      -- Added: rust_analyzer
      ensure_installed = { 
        'terraformls', 
        'tflint', 
        'ts_ls', 
        'html', 
        'cssls', 
        'lua_ls',
        'rust_analyzer'
      },
    })

    -- The New 0.11+ Handler
    mason_lspconfig.setup_handlers({
      function(server_name)
        -- Special config for Lua
        if server_name == "lua_ls" then
          vim.lsp.config("lua_ls", {
            settings = {
              Lua = {
                diagnostics = { globals = { "vim" } },
                workspace = { checkThirdParty = false },
              },
            },
          })
        end

        -- Note: rust_analyzer works great with default settings in 0.11
        vim.lsp.enable(server_name)
      end,
    })

    -- Filetype detection fix for Terraform/HCL
    vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
      pattern = {"*.tf", "*.tfvars", "*.hcl"},
      callback = function()
        vim.bo.filetype = "terraform"
      end,
    })

    -- Format on save (Added *.rs)
    vim.api.nvim_create_autocmd("BufWritePre", {
      pattern = {
        "*.tf", "*.tfvars", "*.js", "*.ts", 
        "*.html", "*.css", "*.lua", "*.rs"
      },
      callback = function()
        vim.lsp.buf.format()
      end,
    })
  end,
}

return {
  {
    "yetone/avante.nvim",
    build = "bash build.sh", -- prebuilt libs; `make` needs rustc >= 1.94
    event = "VeryLazy",
    version = false, -- never set this to "*"
    ---@module 'avante'
    ---@type avante.Config
    opts = {
      -- Runs Claude Code via ACP (`claude-agent-acp`), using the Pro subscription `claude` is logged in with
      provider = "claude-code",
      instructions_file = "avante.md",
      acp_providers = {
        ["claude-code"] = {
          env = {
            ACP_PERMISSION_MODE = "default", -- ask before edits/commands (avante defaults to bypassPermissions)
          },
        },
      },
      input = {
        provider = "snacks", -- popup window instead of the easily-dismissed native cmdline prompt
      },
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-telescope/telescope.nvim", -- file selector
      "hrsh7th/nvim-cmp", -- completion for avante commands and mentions
      "nvim-tree/nvim-web-devicons",
      "MeanderingProgrammer/render-markdown.nvim",
      { "folke/snacks.nvim", opts = { input = { enabled = true } } },
    },
  },
}

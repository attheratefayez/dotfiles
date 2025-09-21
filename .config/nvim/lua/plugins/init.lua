-- default plugins
return {
  {
    "L3MON4D3/LuaSnip",
    dependencies = { "rafamadriz/friendly-snippets" },
    event = "VeryLazy"
  },

  {
    "folke/which-key.nvim",
    event = "VeryLazy",
  },

  {
    "nvim-focus/focus.nvim",
    event = "winEnter",
    version = "*",
    opts = {
      enabled = true,
      autoresize = {
        width = 120,
        height = 30,
        minwidth = 40,
        minheight = 10,
      },
    },
  },

  {
    "folke/persistence.nvim",
    event = "BufReadPre", -- this will only start session saving when an actual file was opened
    opts = {
      -- add any custom options here
    },
  },

  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
    event = "VeryLazy",
  },

  {
    "stevearc/conform.nvim",
    event = "BufWritePre", -- uncomment for format on save
    opts = require "configs.conform",
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "lua",
        "vimdoc",
        "markdown",
        "cpp",
        "c",
        "python",
      },
    },
  },
}

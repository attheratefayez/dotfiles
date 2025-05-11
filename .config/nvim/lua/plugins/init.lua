return {
    -- Lua
    {
        "Vigemus/iron.nvim",
        event = "BufEnter *.py",
        config = function()
            local iron = require "iron.core"
            local common = require "iron.fts.common"

            iron.setup {
                config = {
                    -- Whether a repl should be discarded or not
                    scratch_repl = true,
                    -- Your repl definitions come here
                    repl_definition = {
                        sh = {
                            -- Can be a table or a function that
                            -- returns a table (see below)
                            command = { "bash" },
                        },
                        python = {
                            command = { "ipython" }, -- or { "ipython", "--no-autoindent" }
                            format = common.bracketed_paste_python,
                            block_dividers = { "# %%", "#%%" },
                        },
                    },
                    -- How the repl window will be displayed
                    -- See below for more information
                    repl_open_cmd = require("iron.view").split.vertical.botright(50),
                },
                -- Iron doesn't set keymaps by default anymore.
                -- You can set them here or manually add keymaps to the functions in iron.core
                keymaps = {
                    -- If repl_open_command is a table as above, then the following keymaps are
                    -- available
                    -- toggle_repl_with_cmd_1 = "<space>rv",
                    -- toggle_repl_with_cmd_2 = "<space>rh",
                    restart_repl = "<space>rR", -- calls `IronRestart` to restart the repl
                    send_motion = "<space>sc",
                    visual_send = "<space>sc",
                    send_file = "<space>sf",
                    send_line = "<space>sl",
                    send_paragraph = "<space>sp",
                    send_until_cursor = "<space>su",
                    send_mark = "<space>sm",
                    send_code_block = "<space>sb",
                    send_code_block_and_move = "<space>sn",
                    mark_motion = "<space>mc",
                    mark_visual = "<space>mc",
                    remove_mark = "<space>md",
                    cr = "<space>s<cr>",
                    interrupt = "<space>s<space>",
                    exit = "<space>sq",
                    clear = "<space>cl",
                },
                -- If the highlight is on, you can change how it looks
                -- For the available options, check nvim_set_hl
                highlight = {
                    italic = true,
                },
                ignore_blank_lines = true, -- ignore blank lines when sending visual select lines
            }

            -- iron also has a list of commands, see :h iron-commands for all available commands
            vim.keymap.set("n", "<space>rs", "<cmd>IronRepl<cr>")
            vim.keymap.set("n", "<space>rr", "<cmd>IronRestart<cr>")
            vim.keymap.set("n", "<space>rf", "<cmd>IronFocus<cr>")
            vim.keymap.set("n", "<space>rh", "<cmd>IronHide<cr>")
        end,
    },

    {
        "NeogitOrg/neogit",
        dependencies = {
            "nvim-lua/plenary.nvim", -- required
            "sindrets/diffview.nvim", -- optional - Diff integration
            -- Only one of these is needed.
            "nvim-telescope/telescope.nvim", -- optional
        },
        event = "VeryLazy",
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
        "danymat/neogen",
        config = true,
        event = "VeryLazy",
    },

    {
        "christoomey/vim-tmux-navigator",
        cmd = {
            "TmuxNavigateLeft",
            "TmuxNavigateDown",
            "TmuxNavigateUp",
            "TmuxNavigateRight",
            "TmuxNavigatePrevious",
        },
        keys = {
            { "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
            { "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
            { "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
            { "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
            { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
        },
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

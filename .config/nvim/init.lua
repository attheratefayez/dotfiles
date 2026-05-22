-- https://echasnovski.com/blog/2026-03-13-a-guide-to-vim-pack#lazy-loading
-- Enable faster startup by caching compiled Lua modules
vim.loader.enable()

-- options should be loaded first
require 'options'

local gh = require('vim_pack_nvim').gh

require 'plugins.conform_nvim' -- formatting
require 'plugins.debug' -- debugging (python)
require 'plugins.focus_nvim' -- in multiwindow view, biggen the window that have cursor
require 'plugins.git_signs_nvim' -- provide git signs
require 'plugins.iron_nvim' -- iron repl for python
-- wtf: mini.completion should be loaded before lsp-gets configured
require 'plugins.mini_nvim' -- collection of plugins (filemanager, icons, statusline, tabline)
require 'plugins.lsp_config' -- lsp
-- wtf resolved
require 'plugins.markview_nvim' -- markdown viewer
require 'plugins.neogen_nvim' -- documentation format generator
require 'plugins.nvim_tree_sitter_nvim' -- highlighting
require 'plugins.persistence_nvim' -- persistence over sessions
require 'plugins.todo_comments_nvim' -- special tag hl and search (TODO, NOTE, HACK, FIX, WARN)
require 'plugins.telescope_nvim' -- picker, search etc.
-- require("plugins.vimtex_nvim")        -- latex help (disabled for most part)
require 'plugins.which_key_nvim' -- shows keyboard shortcuts

require 'mappings'
require 'custom.custom_pyright'

vim.pack.add { gh 'EdenEast/nightfox.nvim' }
vim.cmd.colorscheme 'nightfox'

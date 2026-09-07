-- https://echasnovski.com/blog/2026-03-13-a-guide-to-vim-pack#lazy-loading

-- NOTE: 
-- vim.pack.add {github-link-of-plugin} 
--  install if necessary
--  load it (add to the runtimepath)
--  plugin is not configured yet ( require('plugin-name').setup{} is not called yet ) 
-- NOTE:
-- vim.pack.add { {github-link-of-plugin}, {load = false} } 
--  install if necessary
--  not loaded (not added to runtimepath, require() will fail)
--  have to explicitly load it later

-- Enable faster startup by caching compiled Lua modules
vim.loader.enable()

-- Define config table to be able to pass data between scripts
-- It is a global variable which can be use both as `_G.Config` and `Config`

-- options should be loaded first
require 'options'

require 'plugins.conform_nvim' -- formatting
require 'plugins.debug' -- debugging (python, cpp)
require 'plugins.focus_nvim' -- in multiwindow view, biggen the window that have cursor
-- require 'plugins.git_signs_nvim' -- provide git signs
require 'plugins.iron_nvim' -- iron repl for python
-- wtf: mini.completion should be loaded before lsp-gets configured
require 'plugins.mini_nvim' -- collection of plugins (filemanager, icons, statusline, tabline)
require 'plugins.lsp_config' -- lsp
-- wtf resolved
require 'plugins.markview_nvim' -- markdown viewer
require 'plugins.neogen_nvim' -- documentation format generator
require 'plugins.nvim_tree_sitter_nvim' -- highlighting
require 'plugins.opencode_nvim' -- highlighting
require 'plugins.persistence_nvim' -- persistence over sessions
require 'plugins.todo_comments_nvim' -- special tag hl and search (TODO, NOTE, HACK, FIX, WARN)
-- require("plugins.vimtex_nvim")        -- latex help (disabled for most part)
require 'plugins.which_key_nvim' -- shows keyboard shortcuts

require 'mappings'
require 'custom.custom_pyright'

vim.pack.add { 'https://github.com/EdenEast/nightfox.nvim' }
vim.cmd.colorscheme 'nightfox'

-- guide to vim.pack
-- https://echasnovski.com/blog/2026-03-13-a-guide-to-vim-pack#lazy-loading
-- Enable faster startup by caching compiled Lua modules
vim.loader.enable()

-- options should be loaded first 
require('options')

local gh = require('vim_pack_nvim').gh

require("plugins.conform_nvim")
require("plugins.debug")
require("plugins.focus_nvim")
require("plugins.git_signs_nvim")
require("plugins.iron_nvim")
require("plugins.lsp_config")
require("plugins.lua_snip_nvim")
require("plugins.markview_nvim")
require("plugins.mini_nvim")
require("plugins.neogen_nvim")
require("plugins.nvim_surround_nvim")
require("plugins.nvim_tree_sitter_nvim")
require("plugins.persistence_nvim")
require("plugins.todo_comments_nvim")
require("plugins.telescope_nvim")
-- require("plugins.vimtex_nvim")
require("plugins.which_key_nvim")

require('mappings')

require('custom.custom_pyright')
-- ============================================================
-- SECTION 3: UI / CORE UX PLUGINS
-- guess-indent, gitsigns, which-key, colorscheme, todo-comments, mini modules
-- ============================================================
  if vim.g.have_nerd_font then vim.pack.add { gh 'nvim-tree/nvim-web-devicons' } end

  -- [[ Colorscheme ]]
  -- You can easily change to a different colorscheme.
  -- Change the name of the colorscheme plugin below, and then
  -- change the command under that to load whatever the name of that colorscheme is.
  --
  -- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
  vim.pack.add { gh 'EdenEast/nightfox.nvim' }
  -- Load the colorscheme here.
  -- Like many other themes, this one has different styles, and you could load
  -- any other, such as 'tokyonight-storm', 'tokyonight-moon', or 'tokyonight-day'.
  vim.cmd.colorscheme 'nightfox'

-- ============================================================
-- SECTION 6: FORMATTING
-- conform.nvim setup and keymap
-- ============================================================

-- ============================================================
-- SECTION 7: AUTOCOMPLETE & SNIPPETS
-- blink.cmp and luasnip setup
-- ============================================================

-- ============================================================
-- SECTION 9: OPTIONAL EXAMPLES / NEXT STEPS
-- kickstart.plugins.* examples
-- ============================================================
do
  -- The following comments only work if you have downloaded the kickstart repo, not just copy pasted the
  -- init.lua. If you want these files, they are in the repository, so you can just download them and
  -- place them in the correct locations.

  -- NOTE: Next step on your Neovim journey: Add/Configure additional plugins for Kickstart
  --
  --  Here are some example plugins that I've included in the Kickstart repository.
  --  Uncomment any of the lines below to enable them (you will need to restart nvim).
  --
  -- require 'kickstart.plugins.debug'
  -- require 'kickstart.plugins.indent_line'
  -- require 'kickstart.plugins.lint'
  -- require 'kickstart.plugins.autopairs'
  -- require 'kickstart.plugins.neo-tree'
  -- require 'kickstart.plugins.gitsigns' -- adds gitsigns recommended keymaps

  -- NOTE: You can add your own plugins, configuration, etc from `lua/custom/plugins/*.lua`
  --
  --  Uncomment the following line and add your plugins to `lua/custom/plugins/*.lua` to get going.
  -- require 'custom.plugins'
end

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et

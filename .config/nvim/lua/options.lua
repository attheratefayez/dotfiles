-- General ====================================================================
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.o.mouse = 'a' -- Enable mouse mode, can be useful for resizing splits for example!
vim.g.have_nerd_font = true -- Set to true if you have a Nerd Font installed and selected in the terminal
vim.opt.guicursor = {
  'n-v-i-c:block', -- normal, visual, insert, command-line
  'r-cr-o:block', -- replace, confirm, operator-pending
}
-- no swapfile, maintain undodir
vim.o.swapfile = false
vim.o.backup = false
vim.o.undofile = true
vim.o.undodir = vim.fn.stdpath 'data' .. '/undodir'

-- create undodir if it doesn't exist
if vim.fn.isdirectory(vim.o.undodir) == 0 then vim.fn.mkdir(vim.o.undodir, 'p') end

-- Enable all filetype plugins and syntax (if not enabled, for better startup)
vim.cmd 'filetype plugin indent on'
if vim.fn.exists 'syntax_on' ~= 1 then vim.cmd 'syntax enable' end

-- [[ Setting options ]]
--  See `:help vim.o`
-- NOTE: You can change these options as you wish!
--  For more options, you can see `:help option-list`

-- UI =========================================================================
vim.o.breakindent = true -- Enable break indent
vim.o.cursorline = true -- Enable current line highlighting
vim.o.number = true -- Show line numbers
vim.o.pumborder = 'rounded' -- Use border in popup menu
vim.o.pumheight = 10 -- Make popup menu smaller
vim.o.pummaxwidth = 100 -- Make popup menu not too wide
vim.opt.shortmess:append 'c'
vim.o.showmode = false -- Don't show the mode, since it's already in the status line
vim.o.signcolumn = 'yes' -- Keep signcolumn on by default
vim.o.splitright = true -- Configure how new splits should be opened
vim.o.splitbelow = true
vim.o.winborder = 'rounded'

-- Editing ====================================================================
vim.o.expandtab = true -- Convert tabs to spaces
vim.o.ignorecase = true -- case-insensitive searching
-- vim.o.incsearch = true -- show search matches while typing
vim.o.inccommand = 'split' -- Preview substitutions live, as you type!

vim.o.smartcase = true
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.smartindent = true

-- Built-in completion
vim.opt.completeopt = 'menuone,noselect,fuzzy,nosort'
vim.opt.completetimeout = 300

-- Sync clipboard between OS and Neovim.
-- Schedule the setting after `UiEnter` because it can increase startup-time.
-- Remove this option if you want your OS clipboard to remain independent.
-- See `:help 'clipboard'`
vim.schedule(function() vim.o.clipboard = 'unnamedplus' end)

-- vim.o.cmdheight = 0
-- neovim checks and turns it on if available
-- vim.o.termguicolors = true

vim.o.updatetime = 500 -- Decrease update time
vim.o.timeoutlen = 300 -- Decrease mapped sequence wait time
vim.o.scrolloff = 15 -- Minimal number of screen lines to keep above and below the cursor.

-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
  callback = function() vim.hl.on_yank() end,
})

-- disable autocomment new line
vim.api.nvim_create_autocmd('BufEnter', {
  callback = function() vim.opt_local.formatoptions:remove { 'c', 'r', 'o' } end,
})

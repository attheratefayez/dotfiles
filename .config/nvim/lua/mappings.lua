-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- exit insert mode with jk
vim.keymap.set('i', 'jk', '<ESC>', { noremap = true, silent = true })
-- exit terminal mode
vim.keymap.set('t', 'jk', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Clear highlights on search when pressing <Esc> in normal mode
vim.keymap.set('n', '<CR>', '<cmd>nohlsearch<CR>', { noremap = true, silent = true })

vim.keymap.set('n', 'gt', ':bnext<CR>', { noremap = true, silent = true, desc = 'Go to next buffer.' })
vim.keymap.set('n', 'gT', ':bprevious<CR>', { noremap = true, silent = true, desc = 'Go to previous buffer.' })
vim.keymap.set('n', '<leader>x', ':bd<CR>', { noremap = true, silent = true, desc = 'Close current buffer.' })

-- Diagnostic Config & Keymaps
--  See `:help vim.diagnostic.Opts`
vim.diagnostic.config {
  update_in_insert = false,
  severity_sort = true,
  float = { border = 'rounded', source = 'if_many' },
  underline = { severity = { min = vim.diagnostic.severity.WARN } },

  -- Can switch between these as you prefer
  virtual_text = true, -- Text shows up at the end of the line
  virtual_lines = false, -- Text shows up underneath the line, with virtual lines

  -- Auto open the float, so you can easily read the errors when jumping with `[d` and `]d`
  jump = {
    on_jump = function(_, bufnr)
      vim.diagnostic.open_float {
        bufnr = bufnr,
        scope = 'cursor',
        focus = false,
      }
    end,
  },
}

-- press enter to jump to a location in either location list / quick-fix list
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'qf',
  callback = function()
    vim.keymap.set('n', '<CR>', function()
      local wininfo = vim.fn.getwininfo(vim.api.nvim_get_current_win())[1]
      if wininfo.loclist == 1 then
        vim.cmd '.ll' -- jump from location list
      else
        vim.cmd '.cc' -- jump from quickfix list
      end
    end, { buffer = true, silent = true })
  end,
})

vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- mini.files keymapping

vim.keymap.set('n', '<C-n>', function()
  local mini_files = require 'mini.files'
  if not mini_files.close() then mini_files.open() end
end, { desc = 'Toggle file explorer' })
vim.keymap.set('n', '-', function() MiniFiles.open(vim.api.nvim_buf_get_name(0)) end, {
  desc = 'Open MiniFiles',
})

-- compile command
vim.keymap.set('n', '<leader>c', function()
  local cmd = vim.fn.input 'Compile command: '

  cmd = vim.trim(cmd)

  -- Cancel if empty
  if cmd == '' then return end

  vim.g.focus_disable = true
  -- Open terminal split at bottom
  vim.cmd 'botright 5split'

  -- Start terminal with command
  vim.cmd('terminal ' .. cmd)
  vim.cmd 'startinsert'
  vim.g.focus_disable = false
end,
	{
		desc = "Run Commands."
	}
)

-- open a floating terminal
local terminal = {
  buf = nil,
  win = nil,
}

vim.keymap.set('n', '<leader>t', function()
  -- toggle close
  if terminal.win and vim.api.nvim_win_is_valid(terminal.win) then
    vim.api.nvim_win_close(terminal.win, true)
    terminal.win = nil
    return
  end

  -- create buffer if needed
  if not terminal.buf or not vim.api.nvim_buf_is_valid(terminal.buf) then
    terminal.buf = vim.api.nvim_create_buf(false, true)

    vim.bo[terminal.buf].bufhidden = 'hide'
  end

  -- floating window size
  local width = math.floor(vim.o.columns * 0.35)
  local height = math.floor(vim.o.lines * 0.3)

  -- local row = math.floor((vim.o.lines - height) / 2)
  -- local col = math.floor((vim.o.columns - width) / 2)
  local padding = 4
  local row = math.floor(vim.o.lines - height - padding)
  local col = math.floor(padding)

  -- create floating window
  terminal.win = vim.api.nvim_open_win(terminal.buf, true, {
    relative = 'editor',
    width = width,
    height = height,
    row = row,
    col = col,
    border = 'rounded',
  })

  -- disable focus.nvim resizing
  vim.w[terminal.win].focus_disable = true

  -- start terminal INSIDE this buffer
  if vim.bo[terminal.buf].buftype ~= 'terminal' then
    vim.cmd.terminal()
    terminal.buf = vim.api.nvim_get_current_buf()
  end

  -- enter insert mode
  vim.cmd.startinsert()
end,
	{
		desc = "Open floating terminal."
	}
	)

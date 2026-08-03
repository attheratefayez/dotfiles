local gh = require('vim_pack_nvim').gh

vim.pack.add { gh 'nvim-mini/mini.nvim' }
vim.pack.add { gh 'rafamadriz/friendly-snippets' }

local MiniComment = require 'mini.comment'
local MiniCompletion = require 'mini.completion'
local MiniExtra = require 'mini.extra'
local MiniFiles = require 'mini.files'
local MiniIcons = require 'mini.icons'
local MiniNotify = require 'mini.notify'
local MiniPairs = require 'mini.pairs'
local MiniPick = require 'mini.pick'
local MiniSnippets = require 'mini.snippets'
local MiniStatusline = require 'mini.statusline'
local MiniSurround = require 'mini.surround'
local MiniTabline = require 'mini.tabline'

-- mini.comment config
MiniComment.setup {
  mappings = {
    comment_line = '<leader>/',
    comment_visual = '<leader>/',
  },
}

-- mini.completion config
MiniCompletion.setup {
  lsp_completion = {
    auto_setup = true,
    source_func = 'omnifunc',
    process_items = function(items, base)
      return MiniCompletion.default_process_items(items, base, {
        filtersort = 'fuzzy',
        kind_priority = {Text = -1, Snippet = 99},
      })
    end,
  },
}

vim.api.nvim_create_autocmd(
  'LspAttach',
  { callback = function(ev) vim.bo[ev.buf].omnifunc = 'v:lua.MiniCompletion.completefunc_lsp' end, desc = "Set 'OmniFunc'" }
)

-- Advertise to servers that Neovim now supports certain set of completion and
-- signature features through 'mini.completion'.
vim.lsp.config('*', { capabilities = MiniCompletion.get_lsp_capabilities() })

-- mini.files config
MiniFiles.setup {
  windows = { preview = true },
}

-- mini.file keybind: <C-s> -> horizontal split, <C-v> vertical split
local map_split = function(buf_id, lhs, direction)
  local rhs = function()
    -- Make new window and set it as target
    local cur_target = MiniFiles.get_explorer_state().target_window
    local new_target = vim.api.nvim_win_call(cur_target, function()
      vim.cmd(direction .. ' split')
      return vim.api.nvim_get_current_win()
    end)

    MiniFiles.set_target_window(new_target)
    MiniFiles.go_in()

    -- This intentionally doesn't act on file under cursor in favor of
    -- explicit "go in" action (`l` / `L`). To immediately open file,
    -- add appropriate `MiniFiles.go_in()` call instead of this comment.
  end

  -- Adding `desc` will result into `show_help` entries
  local desc = 'Split ' .. direction
  vim.keymap.set('n', lhs, rhs, { buffer = buf_id, desc = desc })
end

vim.api.nvim_create_autocmd('User', {
  pattern = 'MiniFilesBufferCreate',
  callback = function(args)
    local buf_id = args.data.buf_id
    -- Tweak keys to your liking
    map_split(buf_id, '<C-s>', 'belowright horizontal')
    map_split(buf_id, '<C-v>', 'belowright vertical')
    -- map_split(buf_id, '<C-t>', 'tab')
  end,
})

-- mini.icons config
MiniIcons.setup {}

-- mini.notify config
MiniNotify.setup {
  lsp_progress = {
    enable = false,
  },
}

-- mini.pairs config
MiniPairs.setup()

-- mini.snippets config

-- start the snippet server, but don't perform match
-- mini.completion will take care of that (fuzzy matching)
MiniSnippets.start_lsp_server { match = false }

-- load snippets automatically per language and expand them using MiniSnippets’
-- default engine with clean empty placeholders
MiniSnippets.setup {
  snippets = {
    MiniSnippets.gen_loader.from_lang(),
  },
  expand = {
    insert = function(snippet) MiniSnippets.default_insert(snippet, { empty_tabstop = '' }) end,
  },
}

-- clears underline markings and other decoratory stuffs
vim.api.nvim_create_autocmd('ColorScheme', {
  callback = function()
    vim.api.nvim_set_hl(0, 'MiniSnippetsCurrent', {})
    vim.api.nvim_set_hl(0, 'MiniSnippetsCurrentReplace', {})
    vim.api.nvim_set_hl(0, 'MiniSnippetsFinal', {})
    vim.api.nvim_set_hl(0, 'MiniSnippetsVisited', {})
    vim.api.nvim_set_hl(0, 'MiniSnippetsUnvisited', {})
  end,
})

-- mini.pick config
MiniPick.setup {}
MiniExtra.setup {}

vim.keymap.set('n', '<leader>fb', function() MiniPick.builtin.buffers() end, { desc = 'Find buffers' })
vim.keymap.set('n', '<leader>ff', function() MiniPick.builtin.files() end, { desc = 'Find files' })
vim.keymap.set('n', '<leader>fg', function() MiniPick.builtin.grep_live() end, { desc = 'Find pattern in project(all sub-dir)' })
vim.keymap.set('n', '<leader>fh', function() MiniPick.builtin.help() end, { desc = 'Find in nvim-help' })
vim.keymap.set('n', '<leader>fn', function() MiniPick.builtin.files({}, { source = { cwd = '~/.config/nvim/' } }) end, { desc = 'Find in neovim config-files' })
vim.keymap.set('n', '<leader>fr', function() MiniPick.builtin.resume() end, { desc = 'Resume last-search' })
vim.keymap.set('n', '<leader>fw', function() MiniExtra.pickers.buf_lines() end, { desc = 'Find pattern in loaded buffers' })

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('mini_picker-lsp-attach', { clear = true }),
  callback = function(event)
    local buf = event.buf
    vim.keymap.set('n', 'gO', function() MiniExtra.pickers.lsp { scope = 'document_symbol' } end, { buffer = buf, desc = 'Document Symbols' })
    vim.keymap.set('n', 'grr', function() MiniExtra.pickers.lsp { scope = 'references' } end, { buffer = buf, desc = 'References' })
  end,
})

-- mini.statusline config
MiniStatusline.setup {
  content = {
    active = function()
      local mode, mode_hl = MiniStatusline.section_mode { trunc_width = 120 }
      local diagnostics = MiniStatusline.section_diagnostics { trunc_width = 75 }
      local filename = MiniStatusline.section_filename { trunc_width = 140 }
      local fileinfo = MiniStatusline.section_fileinfo { trunc_width = 120 }
      local location = MiniStatusline.section_location { trunc_width = 75 }

      -- LSP section
      local lsp = ''
      local clients = vim.lsp.get_clients { bufnr = 0 }

      if #clients > 0 then
        local names = {}

        for _, client in ipairs(clients) do
          if client:supports_method 'textDocument/hover' then table.insert(names, client.name) end
          -- table.insert(names, client.name)
        end
        if #names > 0 then
          lsp = '󰒋 ' .. table.concat(names, ', ')
        else
          lsp = '󰒋 ' .. '✖'
        end
      end

      return MiniStatusline.combine_groups {
        { hl = mode_hl, strings = { mode } },
        { hl = 'MiniStatuslineDevinfo', strings = { diagnostics } },
        '%<', -- truncate point
        { hl = 'MiniStatuslineFilename', strings = { filename } },
        '%=', -- right align
        { hl = 'MiniStatuslineInfo', strings = { lsp } },
        { hl = 'MiniStatuslineFileinfo', strings = { fileinfo } },
        { hl = mode_hl, strings = { location } },
      }
    end,
  },
}

---@diagnostic disable-next-line: duplicate-set-field
MiniStatusline.section_location = function() return '%p%% %2l:%-2L' end

-- mini.surround config
MiniSurround.setup {
  n_lines = 5,
  search_method = 'cover',
}

-- mini.tabline config
MiniTabline.setup {}

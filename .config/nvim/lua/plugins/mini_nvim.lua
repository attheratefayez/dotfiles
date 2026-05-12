local gh = require('vim_pack_nvim').gh

vim.pack.add { gh 'nvim-mini/mini.nvim' }

-- Simple and easy statusline.
--  You could remove this setup call if you don't like it,
--  and try some other statusline plugin
require('mini.comment').setup {
  mappings = {
    comment_line = '<leader>/',
    comment_visual = '<leader>/',
  },
}
require('mini.diff').setup()
require('mini.files').setup()
require('mini.git').setup()
-- require('mini.notify').setup()
require('mini.pairs').setup()
require('mini.tabline').setup()

require('mini.statusline').setup {
  use_icons = vim.g.have_nerd_font,

  content = {
    active = function()
      local mode, mode_hl = MiniStatusline.section_mode { trunc_width = 120 }

      local git = MiniStatusline.section_git { trunc_width = 75 }

      local diagnostics = MiniStatusline.section_diagnostics { trunc_width = 75 }

      local filename = MiniStatusline.section_filename { trunc_width = 140 }

      local fileinfo = MiniStatusline.section_fileinfo { trunc_width = 120 }

      local location = MiniStatusline.section_location { trunc_width = 75 }

      return MiniStatusline.combine_groups {
        {
          hl = mode_hl,
          strings = { mode },
        },

        {
          hl = 'MiniStatuslineDevinfo',
          strings = {
            git,
            diagnostics,
          },
        },

        '%<',

        {
          hl = 'MiniStatuslineFilename',
          strings = { filename },
        },

        '%=',

        {
          hl = 'MiniStatuslineFileinfo',
          strings = {
            fileinfo,
            location,
          },
        },
      }
    end,
  },
}

-- You can configure sections in the statusline by overriding their
-- default behavior. For example, here we set the section for
-- cursor location to LINE:COLUMN
---@diagnostic disable-next-line: duplicate-set-field
require('mini.statusline').section_location = function() return '%2l:%-2v %p%%' end




local map_split = function(buf_id, lhs, direction)
  local rhs = function()
    -- Make new window and set it as target
    local cur_target = MiniFiles.get_explorer_state().target_window
    local new_target = vim.api.nvim_win_call(cur_target, function()
      vim.cmd(direction .. ' split')
      return vim.api.nvim_get_current_win()
    end)

    MiniFiles.set_target_window(new_target)

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
    map_split(buf_id, '<C-t>', 'tab')
  end,
})









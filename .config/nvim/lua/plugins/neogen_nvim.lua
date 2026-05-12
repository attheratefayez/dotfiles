local gh = require('vim_pack_nvim').gh
local selective_load = require('vim_pack_nvim').selective_load

vim.pack.add({ { src = gh 'danymat/neogen', data = { manual_load = true } } }, { load = selective_load })

vim.api.nvim_create_autocmd('BufEnter', {
  pattern = { '*.py', '*.c', '*.cpp' },
  callback = function()
    vim.cmd.packadd 'neogen'
    require('neogen').setup {
      snippet_engine = 'luasnip',
      languages = {
        ['cpp.doxygen'] = require 'neogen.configurations.cpp',
        ['python.google_docstrings'] = require 'neogen.configurations.python',
      },
    }
    vim.keymap.set('n', '<leader>Nff', '<cmd>Neogen file<CR>', { desc = 'Generate Doxygen comment of type file.' })
    vim.keymap.set('n', '<leader>Nfn', '<cmd>Neogen func<CR>', { desc = 'Generate Doxygen comment of type func.' })
    vim.keymap.set('n', '<leader>Nfc', '<cmd>Neogen class<CR>', { desc = 'Generate Doxygen comment of type class' })
  end,
})

local gh = require('vim_pack_nvim').gh

vim.pack.add({ { src = gh 'danymat/neogen' } }, { load = false})

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
    vim.keymap.set('n', '<leader>Nff', '<cmd>Neogen file<CR>', { desc = 'Generate comment of type file.' })
    vim.keymap.set('n', '<leader>Nfn', '<cmd>Neogen func<CR>', { desc = 'Generate comment of type func.' })
    vim.keymap.set('n', '<leader>Nfc', '<cmd>Neogen class<CR>', { desc = 'Generate comment of type class' })
  end,
})

local gh = require('vim_pack_nvim').gh
local selective_load = require('vim_pack_nvim').selective_load

vim.pack.add({ { src = gh 'OXY2DEV/markview.nvim', data = { manual_load = true } } }, { load = selective_load })

vim.api.nvim_create_autocmd('BufEnter', {
  pattern = '*.md',
  callback = function()
    vim.cmd.packadd 'markview.nvim'
    require('markview').setup {
      preview = {
        enable = false,
      },
    }
  end,
})

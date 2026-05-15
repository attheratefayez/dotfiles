local gh = require('vim_pack_nvim').gh

vim.pack.add({ { src = gh 'OXY2DEV/markview.nvim' } }, { load = false})

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'markdown',
  callback = function()
    vim.cmd.packadd 'markview.nvim'
    require('markview').setup {
      preview = {
        enable = false,
      },
    }
  end,
})

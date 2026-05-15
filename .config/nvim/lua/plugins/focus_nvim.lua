local gh = require('vim_pack_nvim').gh

vim.pack.add { gh 'nvim-focus/focus.nvim' }
vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWinEnter' }, {
  once = true,
  callback = function()
    require('focus').setup {
      autoresize = {
        width = 120,
        height = 30,
        minwidth = 40,
        minheight = 10,
      },
    }
  end,
})

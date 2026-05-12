local gh = require('vim_pack_nvim').gh

vim.schedule(function()
  vim.pack.add { gh 'nvim-focus/focus.nvim' }

  require('focus').setup {
    autoresize = {
      width = 120,
      height = 30,
      minwidth = 40,
      minheight = 10,
    },
  }
end)

local gh = require('vim_pack_nvim').gh

vim.schedule(function()
  vim.pack.add { gh 'folke/todo-comments.nvim' }
  require('todo-comments').setup { signs = false }
end)

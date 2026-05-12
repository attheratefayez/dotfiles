local gh = require('vim_pack_nvim').gh
local selective_load = require('vim_pack_nvim').selective_load

vim.pack.add({{src = gh "folke/persistence.nvim", data = {manual_load = true}}}, {load = selective_load})

vim.api.nvim_create_autocmd('BufReadPre', {
  callback = function()
    vim.cmd.packadd('persistence.nvim')
    require("persistence").setup({
			need = 0
		})

    -- load the session for the current directory
    vim.keymap.set('n', '<leader>pl', function() require('persistence').load() end, {desc = "load session for cwd"})

    -- select a session to load
    vim.keymap.set('n', '<leader>pS', function() require('persistence').select() end, {desc = "select a session (if exists)"})

    -- load the last session
    vim.keymap.set('n', '<leader>pp', function() require('persistence').load { last = true } end, {desc = "load the last session"})

    -- stop Persistence => session won't be saved on exit
    vim.keymap.set('n', '<leader>pq', function() require('persistence').stop() end, {desc = "stop persistence (session won't be saved)"})
  end,
})

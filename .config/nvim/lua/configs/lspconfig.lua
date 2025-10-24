require("nvchad.configs.lspconfig").defaults()

local servers = { "clangd", "pyright" }
vim.lsp.enable(servers)

-- read :h vim.lsp.config for changing options of lsp servers 
--
require "configs.custom_pyright"

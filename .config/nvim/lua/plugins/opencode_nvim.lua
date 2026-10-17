vim.pack.add({
  {
    src = "https://github.com/nickjvandyke/opencode.nvim",
    -- Defaults to "main", supporting OpenCode v2.
    -- Uncomment to pull the latest stable release, supporting OpenCode v1.
    -- version = vim.version.range("*"),
  },
})

---@type opencode.Opts
vim.g.opencode_opts = {
  -- Your configuration, if any; goto definition on the type for details
}


-- Recommended/example keymaps
vim.keymap.set({ "n", "x" }, "<leader>za",   function() require("opencode").ask("@this: ") end,                          { desc = "Ask Opencode" })
vim.keymap.set({ "n", "x" }, "<leader>ze",   function() require("opencode").prompt("Explain @this and its context") end,                          { desc = "Explain with opencode" })
vim.keymap.set({ "n", "x" }, "<leader>zf",   function() require("opencode").prompt("Fix @diagnostics") end,                          { desc = "Fix with opencode" })
vim.keymap.set({ "n", "x" }, "<leader>zs",   function() require("opencode").select() end,                          { desc = "Select OpenCode opts" })

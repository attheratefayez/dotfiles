require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

local options = {
    noremap = true,
    silent = true,
}

map("i", "jk", "<ESC>")
map("n", "<CR>", ":noh<CR>", options)

-- neogen keymaps
map("n", "<leader>Nff", "<cmd>Neogen file<CR>", { desc = "Generate Doxygen comment of type file." })
map("n", "<leader>Nfn", "<cmd>Neogen func<CR>", { desc = "Generate Doxygen comment of type func." })
map("n", "<leader>Nfc", "<cmd>Neogen class<CR>", { desc = "Generate Doxygen comment of type class" })

-- persistence keymaps
-- load the session for the current directory
map("n", "<leader>qs", function() require("persistence").load() end, { desc = "Load the session for the current directory."})

-- select a session to load
map("n", "<leader>qS", function() require("persistence").select() end, { desc = "Select a session to load."})

-- load the last session
map("n", "<leader>ql", function() require("persistence").load({ last = true }) end, { desc = "Load the last session."})

-- stop Persistence => session won't be saved on exit
map("n", "<leader>qd", function() require("persistence").stop() end, { desc = "Stop Persistence"})

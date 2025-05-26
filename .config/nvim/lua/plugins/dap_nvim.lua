return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "rcarriga/nvim-dap-ui",
    "nvim-neotest/nvim-nio",
  },
  event = "VeryLazy",
  config = function()
    local dap, dapui = require "dap", require "dapui"

    vim.keymap.set("n", "<Leader>dt", dap.toggle_breakpoint, {})
    vim.keymap.set("n", "<Leader>dc", dap.continue, {})

    require("mason-nvim-dap").setup()
    dapui.setup()
    dap.listeners.before.attach.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.launch.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated.dapui_config = function()
      dapui.close()
    end
    dap.listeners.before.event_exited.dapui_config = function()
      dapui.close()
    end
    -- dap.adapters.codelldb = {
    --   type = "executable",
    --   command = "codelldb", -- or if not in $PATH: "/absolute/path/to/codelldb"
    --
    --   -- On windows you may have to uncomment this:
    --   -- detached = false,
    -- }
    -- dap.configurations.cpp = {
    --   {
    --     name = "Launch",
    --     type = "codelldb",
    --     request = "launch",
    --     program = function()
    --       return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
    --     end,
    --     cwd = "${workspaceFolder}",
    --     stopAtBeginningOfMainSubprogram = false,
    --   },
    -- }
  end,
}

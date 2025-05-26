return {
  "mfussenegger/nvim-dap",

  dependencies = {
    "rcarriga/nvim-dap-ui",
    "nvim-neotest/nvim-nio",
  },
  event = "VeryLazy",
  config = function()
    local dap, dapui = require "dap", require "dapui"

    vim.keymap.set("n", "<Leader>db", dap.toggle_breakpoint, { desc = "Toggle Breakpoint" })
    vim.keymap.set("n", "<Leader>dB", dap.clear_breakpoints, { desc = "Clear Breakpoints" })

    vim.keymap.set("n", "<Leader>dc", dap.continue, { desc = "Continue Execution" })
    vim.keymap.set("n", "<Leader>dC", dap.close, { desc = "Close Current Session" })
    vim.keymap.set("n", "<Leader>dq", dap.terminate, { desc = "Terminate Current Debug Session" })

    vim.keymap.set("n", "<Leader>do", dap.step_over, { desc = "Execute Current Line" })
    vim.keymap.set("n", "<Leader>di", dap.step_into, { desc = "Step into the current function or method if possible" })
    vim.keymap.set("n", "<Leader>du", dap.step_out, { desc = "Step out of current funtion or method if possible" })

    vim.keymap.set("n", "<Leader>dh", function()
      require("dap.ui.widgets").hover()
    end, { desc = "View expression under cursor" })

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
  end,
}

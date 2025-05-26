return {
    "mfussenegger/nvim-dap-python",
    config = function()
        local path = "~/.local/share/nvim/mason/packages/debugpy/venv/bin/python3"
        require("dap-python").setup(path)
    end
}


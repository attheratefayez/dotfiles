-- Behavior of this file
-- When you open the first Python file → it auto-selects .venv/bin/python if available, otherwise asks.
--
-- Running :SwitchPython opens a Telescope picker with fuzzy search.
--
-- Once you pick an interpreter, Pyright restarts immediately and uses it.
--
-- If Telescope isn’t installed, it falls back to the old inputlist UI.

local lspconfig = require("lspconfig")
local util = require("lspconfig/util")
local cached_python_path = nil

-- Collect available interpreters
local function collect_python_paths(workspace)
  local paths = {}

  -- Local .venv
  local venv = workspace .. "/.venv/bin/python3"

  if vim.fn.filereadable(venv) == 1 then
    table.insert(paths, venv)
  end

  -- System python fallback
  if vim.fn.filereadable("/usr/bin/python3") == 1 then
    table.insert(paths, "/usr/bin/python3")
  end

  return paths
end

-- Pick python path (either cached or prompt)
local function get_python_path(workspace, force_select)
  if cached_python_path ~= nil and not force_select then
    return cached_python_path
  end

  local paths = collect_python_paths(workspace)
  vim.notify_once("found paths: " .. vim.inspect(paths), vim.log.levels.INFO)

  if #paths == 0 then
    return "/usr/bin/python3"
  elseif #paths == 1 then
    cached_python_path = paths[1]
    return cached_python_path
  else
    -- Use inputlist fallback if Telescope not available
    local ok, pickers = pcall(require, "telescope.pickers")
    if not ok then
      local choice = vim.fn.inputlist(vim.list_extend({ "Select Python interpreter:" }, paths))
      cached_python_path = paths[choice] or paths[1]
      return cached_python_path
    end

    -- Otherwise use Telescope
    local finders = require("telescope.finders")
    local conf = require("telescope.config").values
    local actions = require("telescope.actions")
    local action_state = require("telescope.actions.state")

    pickers.new({}, {
      prompt_title = "Select Python Interpreter",
      finder = finders.new_table { results = paths },
      sorter = conf.generic_sorter({}),
      attach_mappings = function(_, map)
        local function select_and_close(prompt_bufnr)
          local selection = action_state.get_selected_entry()
          actions.close(prompt_bufnr)
          cached_python_path = selection[1]

          -- Restart Pyright immediately
          for _, client in ipairs(vim.lsp.get_active_clients({ name = "pyright" })) do
            client.stop(true)
          end
          vim.defer_fn(function()
            vim.cmd("edit")
            vim.notify("Switched Pyright to: " .. cached_python_path, vim.log.levels.INFO)
          end, 100)
        end
        map("i", "<CR>", select_and_close)
        map("n", "<CR>", select_and_close)
        return true
      end,
    }):find()

    return cached_python_path
  end
end

-- Setup pyright
lspconfig.pyright.setup{
  before_init = function(_, config)
    config.settings = config.settings or {}
    config.settings.python = config.settings.python or {}
    config.settings.python.pythonPath = get_python_path(vim.fn.getcwd())
  end,
  root_dir = util.find_git_ancestor or util.path.dirname,
}

-- Command for switching Python interpreter
vim.api.nvim_create_user_command("SwitchPython", function()
  get_python_path(vim.fn.getcwd(), true)
end, { desc = "Select and switch Python interpreter for Pyright" })

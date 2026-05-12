-- Behavior of this file
-- When you open the first Python file → it auto-selects .venv/bin/python if available, otherwise asks.
--
-- Running :SwitchPython opens a Telescope picker with fuzzy search.
--
-- Once you pick an interpreter, Pyright restarts immediately and uses it.
--
-- If Telescope isn’t installed, it falls back to the old inputlist UI.

local cached_python_path = nil

-- ----------------------------
-- PATH HANDLING
-- ----------------------------

local function set_vim_path(python_path)
  if not python_path then
    return
  end

  local venv_bin = python_path:gsub("/python[%d.]*$", "")

  if not string.find(vim.env.PATH, venv_bin, 1, true) then
    vim.env.PATH = vim.env.PATH .. ":" .. venv_bin
  end
end

local function collect_python_paths(workspace)
  local paths = {}

  local venv = workspace .. "/.venv/bin/python3"
  if vim.fn.filereadable(venv) == 1 then
    table.insert(paths, venv)
  end

  if vim.fn.filereadable("/usr/bin/python3") == 1 then
    table.insert(paths, "/usr/bin/python3")
  end

  return paths
end

local function get_default_python(workspace)
  if cached_python_path then
    return cached_python_path
  end

  local paths = collect_python_paths(workspace)
  cached_python_path = paths[1] or "/usr/bin/python3"

  set_vim_path(cached_python_path)

  return cached_python_path
end

-- ----------------------------
-- LSP SAFE APPLY (ASYNC)
-- ----------------------------

local function apply_python_path_async(path)
  vim.schedule(function()
    cached_python_path = path
    set_vim_path(path)

    -- stop pyright safely
    for _, client in ipairs(vim.lsp.get_clients({ name = "pyright" })) do
      client.stop(true)
    end

    vim.notify("Pyright switched to: " .. path, vim.log.levels.INFO)
  end)
end

-- ----------------------------
-- TELESCOPE SELECTOR
-- ----------------------------

local function select_python_interpreter()
  local workspace = vim.fn.getcwd()
  local paths = collect_python_paths(workspace)

  if #paths == 0 then
    vim.notify("No Python interpreters found", vim.log.levels.WARN)
    return
  end

  if #paths == 1 then
    apply_python_path_async(paths[1])
    return
  end

  local ok, pickers = pcall(require, "telescope.pickers")
  if not ok then
    local choice = vim.fn.inputlist(
      vim.list_extend({ "Select Python interpreter:" }, paths)
    )

    apply_python_path_async(paths[choice] or paths[1])
    return
  end

  local finders = require("telescope.finders")
  local conf = require("telescope.config").values
  local actions = require("telescope.actions")
  local action_state = require("telescope.actions.state")

  pickers.new({}, {
    prompt_title = "Select Python Interpreter",

    initial_mode = "insert",
    selection_strategy = "reset",
    sorting_strategy = "ascending",

    layout_config = {
      prompt_position = "top",
    },

    finder = finders.new_table {
      results = paths,
    },

    sorter = conf.generic_sorter({}),

    attach_mappings = function(_, map)
      local function select(prompt_bufnr)
        local selection = action_state.get_selected_entry()

        actions.close(prompt_bufnr)

        -- IMPORTANT: async-safe apply AFTER UI closes
        apply_python_path_async(selection[1])
      end

      map("i", "<CR>", select)
      map("n", "<CR>", select)

      return true
    end,
  }):find()
end

-- ----------------------------
-- LSP CONFIG
-- ----------------------------

vim.lsp.config["pyright"] = {
  before_init = function(_, config)
    config.settings = config.settings or {}
    config.settings.python = config.settings.python or {}

    config.settings.python.pythonPath =
      get_default_python(vim.fn.getcwd())
  end,
}

-- initialize cache early
get_default_python(vim.fn.getcwd())

-- ----------------------------
-- USER COMMAND
-- ----------------------------

vim.api.nvim_create_user_command("SwitchPython", function()
  select_python_interpreter()
end, {
  desc = "Select Python interpreter for Pyright",
})

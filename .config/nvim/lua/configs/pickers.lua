-- local M = {}
--
-- M.find_in_dir = function()
--   local handle = io.popen("fzf --walker=dir --walker-root=$HOME")
--   if not handle then return end
--
--   local result = handle:read("*a")
--   handle:close()
--
--   local dir = result:gsub("\n", "")
--   if dir == "" then return end
--
--   require("telescope.builtin").find_files({
--     cwd = dir,
--     previewer = true,
--   })
-- end
--
-- return M
local M = {}

M.find_in_dir = function()
  local pickers = require("telescope.pickers")
  local finders = require("telescope.finders")
  local actions = require("telescope.actions")
  local action_state = require("telescope.actions.state")
  local conf = require("telescope.config").values

  pickers.new({}, {
    prompt_title = "Select Directory",

    -- finder = finders.new_oneshot_job({
    --   "find", ".", "-type", "d",
    --   "!", "-path", "*/.git/*"
    -- }),

    finder = finders.new_oneshot_job({
      "find", "/home/fayez", "-type", "d", "-maxdepth", "3",
      "!", "-path", "*/[@.]*"
    }),
    sorter = conf.generic_sorter({}), -- uses fzf if extension loaded
    attach_mappings = function(prompt_bufnr)
      actions.select_default:replace(function()
        local selection = action_state.get_selected_entry()
        actions.close(prompt_bufnr)

        require("telescope.builtin").find_files({
          cwd = selection[1],
          previewer = true,
        })
      end)
      return true
    end,
  }):find()
end

M.live_grep_in_dir = function()
  local pickers = require("telescope.pickers")
  local finders = require("telescope.finders")
  local actions = require("telescope.actions")
  local action_state = require("telescope.actions.state")
  local conf = require("telescope.config").values

  pickers.new({}, {
    prompt_title = "Select Directory",

    -- finder = finders.new_oneshot_job({
    --   "find", ".", "-type", "d",
    --   "!", "-path", "*/.git/*"
    -- }),

    finder = finders.new_oneshot_job({
      "find", "/home/fayez", "-type", "d", "-maxdepth", "3",
      "!", "-path", "*/[@.]*"
    }),
    sorter = conf.generic_sorter({}), -- uses fzf if extension loaded
    attach_mappings = function(prompt_bufnr)
      actions.select_default:replace(function()
        local selection = action_state.get_selected_entry()
        actions.close(prompt_bufnr)

        require("telescope.builtin").live_grep({
          cwd = selection[1],
          previewer = true,
        })
      end)
      return true
    end,
  }):find()
end


return M

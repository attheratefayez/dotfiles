return {
  "OXY2DEV/markview.nvim",
  lazy = false,

  config = function()
    require("markview").setup {
      preview = {
        enable = false,
      },
    }
  end,

  -- For blink.cmp's completion
  -- source
  -- dependencies = {
  --     "saghen/blink.cmp"
  -- },
}

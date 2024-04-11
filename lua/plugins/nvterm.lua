return {
  {
    "NvChad/nvterm",
    keys = {
      {
        "<A-i>",
        function()
          require("nvterm.terminal").toggle "float"
        end,
        desc="Toggle floating terminal",
        mode={"n", "t"}
      },
      {
        "<A-h>",
        function()
          require("nvterm.terminal").toggle "horizontal"
        end,
        desc="Toggle horizontal term",
        mode={"n", "t"},
      },
      {
        "<A-v>",
        function()
          require("nvterm.terminal").toggle "vertical"
        end,
        "Toggle vertical term",
      }
    },
    opts = {},
    config = function (opts)
      require("nvterm").setup(opts)
    end

  },
}


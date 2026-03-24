return {
  {
    "mistweaverco/kulala.nvim",
    keys = {
      { "<CR>",  function() require("kulala").run() end, ft="http", mode={ "v", "n" }, desc = "Send request" },
    },
    ft = {"http", "rest"},
    opts = {
      global_keymaps = false,
      global_keymaps_prefix = "<leader>R",
      kulala_keymaps_prefix = "",
    },
  },
}

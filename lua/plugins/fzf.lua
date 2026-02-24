return {
  {
    "ibhagwan/fzf-lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
      { "g/",         function() FzfLua.grep_project() end,           desc = "Grep current working directory" },
      { "<leader>ff", function() FzfLua.files() end,                      desc = "Find files" },
      { "<leader>fb", function() FzfLua.buffers() end,                    desc = "Find buffers" },
      { "<leader>fs", function() FzfLua.lsp_live_workspace_symbols() end, desc = "Find symbols" },
      { "<leader>fd", function() FzfLua.diagnostics_document() end,       desc = "Find diagnostics in document" },
      { "<leader>fD", function() FzfLua.diagnostics_workspace() end,      desc = "Find diagnostics in workspace" }
    },
    opts = {
    }
  }

}

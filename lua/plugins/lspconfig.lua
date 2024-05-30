return {
  {
    "neovim/nvim-lspconfig",
    keys = {
      {
        "<leader>e",
        function ()
          vim.diagnostic.open_float({scope="line"})
        end,
        desc="LSP Diagnostics for this line"
      },
      {
        "<leader>rr",
        function()
          require("renamer").rename()
        end,
        desc="LSP rename",
      },
      {
        "<leader>ca",
        function()
          vim.lsp.buf.code_action()
        end,
        desc="LSP code action",
      },
      --[[ {
        "K",
        function()
          vim.lsp.buf.hover()
          require("crates").show_popup()
        end,
        desc="LSP hover",
      }, ]]
      {
        "gr",
        function ()
          require("telescope.builtin").lsp_references()
        end,
        desc="LSP Go to references"
      },
      {
        "gd",
        function ()
          vim.lsp.buf.definition()
        end,
        desc="LSP Go to definition"
      },
      {
        "gD",
        function ()
          vim.lsp.buf.declaration()
        end,
        desc="LSP Go to declaration"
      },
      {
        "<leader>fm",
        function()
          vim.lsp.buf.format { async = true }
        end,
        desc="LSP formatting",
      }
    },
    dependencies={
      "mrcjkb/rustaceanvim",
      {
        "filipdutescu/renamer.nvim",
        branch="master",
        opts = {},
      },
    }
  },
}

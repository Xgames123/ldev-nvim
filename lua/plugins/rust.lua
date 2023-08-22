local plugins = {
  {
    'saecki/crates.nvim',
    ft = {"toml"},
    keys = {
      {
        "<leader>cu", 
        function ()
          require('crates').upgrade_all_crates()
        end,
        desc = "Update crates"
      },
      {
        "<leader>cd",
         function ()
            require("crates").show_dependencies_popup()
          end,
      },
      {
        "<leader>cv",
        function ()
          require("crates").show_versions_popup()
        end,
      }
    },
    config = function(_, opts)
      local crates = require('crates')
      crates.setup(opts)
      require('cmp').setup.buffer({
        sources = { { name = "crates" }}
      })
      crates.show()
    end,
  },
  {
    "rust-lang/rust.vim",
    ft = "rust",
    init = function ()
      vim.g.rustfmt_autosave = 1
    end
  },
  -- {
  --   "simrat39/rust-tools.nvim",
  --   ft = "rust",
  --   dependencies = "neovim/nvim-lspconfig",
  --   opts = function ()
  --     return require "custom.configs.rust-tools"
  --   end,
  --   config = function(_, opts)
  --     require('rust-tools').setup(opts)
  --   end
  -- },
}
return plugins

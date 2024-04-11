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
  {
    'mrcjkb/rustaceanvim',
    version = '^3', -- Recommended
    ft = { 'rust' },
    keys={
      {
        "<leader>rc",
        function ()
          vim.cmd.RustLsp('openCargo')
        end,
        desc="Rust open Cargo.toml"
      },
      {
        "<leader>rx",
        function ()
          vim.cmd.RustLsp('expandMacro')
        end,
        desc="Rust expand macros"
      },
      {
        "K",
        function ()
          vim.cmd.RustLsp { 'hover', 'actions' }
        end,
        desc="Rust hover"

      },
      {
        "<leader>j",
        function ()
          vim.cmd.RustLsp { 'moveItem',  'down' }
        end,
        desc="Rust move item up"
      }
    },
    config=function ()
      vim.g.rustaceanvim = {
        -- Plugin configuration
        tools = {
          hover_actions={
            replace_builtin_hover=true,
            border="single"
          }
        },
        -- LSP configuration
        server = {
          on_attach = function(client, bufnr)
            -- you can also put keymaps in here
          end,
          settings = {
            -- rust-analyzer language server configuration
            ['rust-analyzer'] = {
              diagnostics={
                enable=false,
              },
              cargo = {
                allFeatures=true,
              },
              inlayHints = {
                typeHints={
                  enable=true,
                }
              }
            }
          },
        },
        -- DAP configuration
        dap = {
        },
      }

    end
  }
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

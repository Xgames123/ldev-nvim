return {
  {
    'saecki/crates.nvim',
    ft = {"toml"},
    event = { "BufRead Cargo.toml" },
    opts={

      lsp = {
        enabled = true,
        on_attach = function(client, bufnr)
          require("mappings").load({
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

          })
        end,
        actions = true,
        completion = true,
        hover = true,
      },
    },
    config = function(_, opts)
      require("crates").setup(opts)
    end,
    dependencies={
      "neovim/nvim-lspconfig"
    }
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
    version = '^4', -- Recommended
    lazy=false,
    config=function ()
      vim.g.rustaceanvim = {
        -- Plugin configuration
        tools = {
          hover_actions={
            replace_builtin_hover=true,
            border={ "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
          }
        },
        -- LSP configuration
        server = {
          on_attach = function(client, bufnr)
            require("mappings").load({
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
            })
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

    end,
    dependencies={
      "neovim/nvim-lspconfig"
    }
  }
}

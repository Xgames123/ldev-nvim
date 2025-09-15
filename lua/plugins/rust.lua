return {
  {
    'saecki/crates.nvim',
    ft = { "toml" },
    event = { "BufRead Cargo.toml" },
    opts = {
      neoconf = {
        enabled = true
      },
      lsp = {
        enabled = true,
        on_attach = function(client, bufnr)
          require("mappings").load({
            {
              "<leader>cu",
              function()
                require('crates').upgrade_all_crates()
              end,
              desc = "Update crates"
            },
            {
              "<leader>cd",
              function()
                require("crates").show_dependencies_popup()
              end,
            },
            {
              "<leader>cv",
              function()
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
  },
  {
    'mrcjkb/rustaceanvim',
    version = '^6',
    lazy = false,
    init = function()
      vim.g.rustaceanvim = {
        -- Plugin configuration
        tools = {
          hover_actions = {
            replace_builtin_hover = true,
            border = "rounded",
          }
        },
        -- LSP configuration
        server = {
          on_attach = function(client, bufnr)
            require("mappings").load({
              {
                "<leader>e",
                function()
                  vim.cmd.RustLsp("renderDiagnostic", "current")
                end,
                desc = "Rust diagnostics",
              },
              {
                "ga",
                function()
                  vim.cmd.RustLsp('codeAction')
                end,
                desc = "Rust code action",
              },
              {
                "<leader>rd",
                function()
                  vim.cmd.RustLsp("openDocs")
                end,
                "Open rust docs"
              },
              {
                "<leader>rc",
                function()
                  vim.cmd.RustLsp('openCargo')
                end,
                desc = "Rust open Cargo.toml"
              },
              {
                "<leader>rx",
                function()
                  vim.cmd.RustLsp('expandMacro')
                end,
                desc = "Rust expand macros"
              },
              {
                "K",
                function()
                  vim.cmd.RustLsp { 'hover', 'actions' }
                end,
                desc = "Rust hover"

              },
              {
                "K",
                mode = "v",
                function()
                  vim.cmd.RustLsp { 'moveItem', 'up' }
                end,
                desc = "Rust move item up"
              },
              {
                "J",
                mode = "v",
                function()
                  vim.cmd.RustLsp { 'moveItem', 'down' }
                end,
                desc = "Rust move item down"
              },
            }, bufnr)
          end,
          settings = {
            -- rust-analyzer language server configuration
            ['rust-analyzer'] = {
              installCargo = false,
              installRustc = false,
              diagnostics = {
                enable = false,
              },
              cargo = {
                allFeatures = true,
              },
              inlayHints = {
                typeHints = {
                  lifetimeElisionHints = {
                    enable = "always",
                  },
                  enable = true,
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
}

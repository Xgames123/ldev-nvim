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

          }, bufnr)
        end,
        actions = true,
        completion = true,
        hover = true,
      },
    },
  },
}

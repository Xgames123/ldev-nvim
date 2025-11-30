vim.api.nvim_create_autocmd('LspAttach', {

  callback = function(args)
    local client_id = args.data.client_id
    local client = vim.lsp.get_client_by_id(client_id)
    local bufnr = args.buf

    local lsp_status = require("lsp-status")
    lsp_status.register_progress()
    lsp_status.on_attach(client)

    local fastaction = require("fastaction")
    local telescope = require("telescope.builtin")
    require("mappings").load({
      {
        "<leader>e",
        function()
          vim.diagnostic.open_float()
        end,
        desc = "LSP Diagnostics for this line"
      },
      {
        "ga",
        function()
          fastaction.code_action()
        end,
        desc = "LSP code action",
      },
      {
        "grr",
        function()
          vim.lsp.buf.rename()
        end,
        desc = "LSP rename",
      },
      {
        "K",
        function()
          vim.lsp.buf.hover()
        end,
        desc = "LSP hover or diagnostics",
      },
      {
        "gt",
        function()
          telescope.lsp_type_definitions()
        end,
        desc = "LSP Go to type definition"
      },
      {
        "gr",
        function()
          telescope.lsp_references()
        end,
        desc = "LSP Go to references"
      },
      {
        "gd",
        function()
          telescope.lsp_definitions()
        end,
        desc = "LSP Go to definition"
      },
      {
        "gD",
        function()
          vim.lsp.buf.declaration()
        end,
        desc = "LSP Go to declaration"
      },
    }, bufnr)
  end,
})

vim.lsp.inlay_hint.enable(true)
vim.lsp.enable("lua_ls")
vim.lsp.enable("ts_ls")
vim.lsp.enable("hls")
vim.lsp.enable("gopls")
vim.lsp.config("rust_analyzer", {
  settings = {
    ["rust-analyzer"] = {
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
  }
})
vim.lsp.enable("rust_analyzer")
--vim.lsp.enable("jsonls")

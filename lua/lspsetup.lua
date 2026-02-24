vim.api.nvim_create_autocmd('LspAttach', {

  callback = function(args)
    local client_id = args.data.client_id
    local client = vim.lsp.get_client_by_id(client_id)
    local bufnr = args.buf

    local lsp_status = require("lsp-status")
    lsp_status.register_progress()
    lsp_status.on_attach(client)

    local telescope = require("telescope.builtin")
    local fzf = require("fzf-lua")
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
          fzf.lsp_code_actions()
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
          fzf.lsp_typedefs()
        end,
        desc = "LSP Go to type definition"
      },
      {
        "gr",
        function()
          fzf.lsp_references()
        end,
        desc = "LSP Go to references"
      },
      {
        "gd",
        function()
          fzf.lsp_definitions()
        end,
        desc = "LSP Go to definition"
      },
      {
        "gD",
        function()
          fzf.lsp_declaration()
        end,
        desc = "LSP Go to declaration"
      },
    }, bufnr)
  end,
})

vim.lsp.inlay_hint.enable(true)
vim.lsp.enable("lua_ls")
vim.lsp.config("ts_ls", {

})
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

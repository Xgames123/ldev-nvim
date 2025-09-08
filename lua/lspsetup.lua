vim.api.nvim_create_autocmd('LspAttach', {
  -- This is where we attach the autoformatting for reasonable clients
  callback = function(args)
    local client_id = args.data.client_id
    local client = vim.lsp.get_client_by_id(client_id)
    local bufnr = args.buf

    local lsp_status = require("lsp-status")
    lsp_status.register_progress()
    lsp_status.on_attach(client)

    -- Create an autocmd that will run *before* we save the buffer.
    --  Run the formatting command for the LSP that has just attached.
    vim.api.nvim_create_autocmd('BufWritePre', {
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.format {
          async = false,
          filter = function(c)
            return c.id == client.id
          end,
        }
      end,
    })

    require("mappings").load({
      {
        "<leader>e",
        function()
          vim.diagnostic.open_float({ scope = "line", border = "rounded" })
        end,
        desc = "LSP Diagnostics for this line"
      },
      {
        "ga",
        function()
          vim.lsp.buf.code_action()
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
          vim.lsp.buf.hover({ border = "rounded" })
        end,
        desc = "LSP hover",
      },
      {
        "gt",
        function()
          require("telescope.builtin").lsp_type_definitions()
        end,
        desc = "LSP Go to type definition"
      },
      {
        "gr",
        function()
          require("telescope.builtin").lsp_references()
        end,
        desc = "LSP Go to references"
      },
      {
        "gd",
        function()
          require("telescope.builtin").lsp_definitions()
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
      {
        "<leader>fm",
        function()
          vim.lsp.buf.format { async = true }
        end,
        desc = "LSP formatting",
      }
    }, bufnr)
  end,
})
vim.lsp.inlay_hint.enable(true)
vim.lsp.enable("lua_ls")
vim.lsp.enable("ts_ls")
vim.lsp.enable("hls")
--vim.lsp.enable("jsonls")

local autogroup = vim.api.nvim_create_augroup("LspFormatting",{})
local null_ls = require("null-ls")

local opts = {
  sources = {
    null_ls.builtins.formatting.gofmt,
    null_ls.builtins.formatting.goimports_revisor,
    null_ls.builtins.formatting.golines,
  },
  on_attach=function(client, bufnum)
    if client.supports_method("textDocument/formatting") then
      vim.api.nvim_clear_autocmds({
        group = autogroup,
        buffer = bufnum,
      })
      vim.api.nvim_create_autocmd("BufWritePre", {
        group=autogroup,
        buffer = bufnum,
        callback=function ()
          vim.lsp.buf.format({bufnr=bufnum})
        end
      })
    end
  end
}

return opts

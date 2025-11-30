local function format(bufnr, async)
  if vim.g.noformat then
    return
  end
  local clients = vim.lsp.get_clients({ bufnr = bufnr })
  for _, client in pairs(clients) do
    if client.server_capabilities.documentFormattingProvider then
      vim.lsp.buf.format {
        async = async,
        filter = function(c)
          return c.id == client.id
        end,
      }
      return
    end
  end

  -- no LSP formatting available: run Neoformat
  vim.cmd("Neoformat")
end


local function init()
  vim.api.nvim_create_user_command("WriteNoFormat", function(data)
    local old = vim.g.noformat
    vim.g.noformat = true
    vim.cmd("w")
    vim.g.noformat = old
  end, { nargs = 0 })

  vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*",
    callback = function(args)
      format(args.buf, false)
    end,
  })
end

return {
  format = format,
  setup = init
}

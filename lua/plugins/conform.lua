local PRETTIER_CONFIG = { "prettierd", "prettier", stop_after_first = true, lsp_format="never" }

return {
  {
    'stevearc/conform.nvim',
    opts = {
      formatters_by_ft = {
        javascript = PRETTIER_CONFIG,
        typescript = PRETTIER_CONFIG,
        markdown = PRETTIER_CONFIG,
        css = PRETTIER_CONFIG,
        json = PRETTIER_CONFIG,
        json5 = PRETTIER_CONFIG,
        jsonc = PRETTIER_CONFIG,
        html = PRETTIER_CONFIG,
      },
      default_format_opts = {
        lsp_format = "prefer",
      },
      format_on_save = {
        timeout_ms = 500,
      },
    },
  }
}


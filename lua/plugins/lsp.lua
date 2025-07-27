return {
  {
    "neovim/nvim-lspconfig",
  },
  {
    event = "LspAttach",
    "nvim-lua/lsp-status.nvim",
    cogfig = function()
      require("lsp-status").config({})
    end
  },
  {
    event = "LspAttach",
    "folke/neoconf.nvim"
  },
}

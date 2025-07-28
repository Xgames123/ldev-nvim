return {
  {
    "neovim/nvim-lspconfig",
  },
  {
    "nvim-lua/lsp-status.nvim",
    event = "LspAttach",
    cogfig = function()
      require("lsp-status").config({})
    end
  },
}

return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      {
        "nvim-lua/lsp-status.nvim",
        config = function(_, _)
          local lsp_status = require("lsp-status")
          lsp_status.register_progress()
        end
      },
      {
        "filipdutescu/renamer.nvim",
        branch = "master",
        config = function(_, _)
          require("configs.lspconfig")
        end
      },
    }
  }
}

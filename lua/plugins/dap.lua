return {
  {
    "mfussenegger/nvim-dap",
    keys = {
      {
        "<leader>db",
        function ()
          require("dap").toggle_breakpoint()
        end,
        desc = "Set breakpoint"
      },
      {
        "<leader>dus",
        function ()
          local widgets = require('dap.ui.widgets');
          local sidebar = widgets.sidebar(widgets.scopes);
          sidebar.open();
        end,
        desc="Open debugging sidebar"
      }
    },
    config = function()
      require("configs.dap")
    end
  },
  {
    "theHamsta/nvim-dap-virtual-text",
    lazy = false,
    config = function(_, opts)
      require("nvim-dap-virtual-text").setup(opts)
    end
  },
}

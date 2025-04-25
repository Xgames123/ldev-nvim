return {
  {
    "NeogitOrg/neogit",
    cmd = "Neogit",
    opts = {

      kind = "replace",
      disable_hints = true,
      mappings = {
        popup = {
          ["l"] = false,
        },
        finder = {
          ["<c-n>"] = false,
          ["n"] = "Next",
          ["N"] = "Previous",
        },
        status = {
          ["<c-n>"] = false,
          ["n"] = "NextSection",
          ["N"] = "PreviousSection",
        }
      }
    },
    keys = {
      {
        "<leader>g",
        function()
          local status, treeapi = pcall(require, "nvim-tree.api")
          if status then
            if treeapi.tree.is_tree_buf(vim.api.nvim_get_current_buf()) then
              treeapi.tree.close()
            end
          end
          for _, buf in ipairs(vim.api.nvim_list_bufs()) do
            if vim.api.nvim_get_option_value('modified', { buf = buf }) then
              error("UNSAVED CHANGES in " .. vim.api.nvim_buf_get_name(buf))
              return
            end
          end
          require("neogit").open()
        end,
        desc = "NeoGit",
      }
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim"
    },
    config = true,
  },
}

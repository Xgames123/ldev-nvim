vim.api.nvim_create_autocmd("Filetype", {
  pattern = "norg",
  callback = function()
    require("mappings").load({
      { "g0",         "<cmd>Neorg toc<CR>" },
      { "<leader>th", "<Plug>(neorg.qol.todo-items.todo.task-on-hold)" },
      { "<leader>tp", "<Plug>(neorg.qol.todo-items.todo.task-pending)" },
      { "<leader>tc", "<Plug>(neorg.qol.todo-items.todo.task-cancelled)" },
      { "<leader>tr", "<Plug>(neorg.qol.todo-items.todo.task-recurring)" }
    }, vim.api.nvim_get_current_buf())
  end,
})

return {
  {
    "nvim-neorg/neorg",
    version = "*", -- Pin Neorg to the latest stable release
    config = true,
    lazy = false,
    opts = {
      load = {
        ["core.defaults"] = {},
        ["core.dirman"] = {
          config = {
            workspaces = {
              notes = "~/source/repos/notes",
            },
            default_workspace = "notes",
          },
        },
        ["core.concealer"] = {},
        ["core.keybinds"] = {},
        ["core.completion"] = {
          config = {
            engine = "nvim-cmp"
          }
        }
      }
    }

  }
}

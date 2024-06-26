return {
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      {"<leader>fg", "<cmd> Telescope live_grep <CR>",desc="Grep current working directory"},
      {"<leader>ff", "<cmd> Telescope find_files <CR>",desc= "Find files"},
      {"<leader>fb", "<cmd> Telescope buffers <CR>",desc= "Find buffers"},
      {"<leader>fs", "<cmd> Telescope lsp_workspace_symbols <CR>",desc= "Find symbols"},
      {"<leader>fd", "<cmd> Telescope diagnostics <CR>",desc= "Find diagnostics"}
    },
    opts = function() return {
      defaults = {
        vimgrep_arguments = {
          "rg",
          "-L",
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
          "--smart-case",
        },
        prompt_prefix = "   ",
        selection_caret = "  ",
        entry_prefix = "  ",
        initial_mode = "insert",
        selection_strategy = "reset",
        sorting_strategy = "ascending",
        layout_strategy = "horizontal",
        layout_config = {
          horizontal = {
            prompt_position = "top",
            preview_width = 0.55,
            results_width = 0.8,
          },
          vertical = {
            mirror = false,
          },
          width = 0.87,
          height = 0.80,
          preview_cutoff = 120,
        },
        file_sorter = require("telescope.sorters").get_fuzzy_file,
        file_ignore_patterns = { "node_modules" },
        generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
        path_display = { "truncate" },
        winblend = 0,
        border = {},
        borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
        color_devicons = true,
        set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
        file_previewer = require("telescope.previewers").vim_buffer_cat.new,
        grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
        qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
        -- Developer configurations: Not meant for general override
        buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
        mappings = {
          n = {
            ["q"] = require("telescope.actions").close,

          },
          i={
            ["<TAB>"]= require("telescope.actions").move_selection_next,
            ["<C-j>"] = require("telescope.actions").move_selection_next,
            ["<C-k>"] = require("telescope.actions").move_selection_previous,
            ["<S-TAB>"] = require("telescope.actions").move_selection_previous,

          }
        },
      },

      extensions_list = { "themes", "terms" },
    } end,


  },
}

local is_inside_work_tree = {}
return {
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      { "g/",         require("telescope.builtin").live_grep,  desc = "Grep current working directory" },
      { "<leader>ff", require("telescope.builtin").find_files, desc = "Find files" },
      {
        "<leader>fg",
        function()
          local opts = {}

          local cwd = vim.fn.getcwd()
          if is_inside_work_tree[cwd] == nil then
            vim.fn.system("git rev-parse --is-inside-work-tree")
            is_inside_work_tree[cwd] = vim.v.shell_error == 0
          end

          if is_inside_work_tree[cwd] then
            require("telescope.builtin").git_files(opts)
          else
            require("telescope.builtin").find_files(opts)
          end
        end,
        desc = "Find (git) files"
      },
      { "<leader>fb", require("telescope.builtin").buffers,               desc = "Find buffers" },
      { "<leader>fs", require("telescope.builtin").lsp_workspace_symbols, desc = "Find symbols" },
      { "<leader>fd", require("telescope.builtin").diagnostics,           desc = "Find diagnostics" }
    },
    opts = function()
      return {
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
          file_ignore_patterns = { "node_modules", "Cargo.lock" },
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
            i = {
              ["<TAB>"] = require("telescope.actions").move_selection_next,
              ["<C-j>"] = require("telescope.actions").move_selection_next,
              ["<C-k>"] = require("telescope.actions").move_selection_previous,
              ["<S-TAB>"] = require("telescope.actions").move_selection_previous,

            }
          },
        },

        extensions_list = { "themes", "terms" },
      }
    end,


  },
}

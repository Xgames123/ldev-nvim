return {
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    branch = "master",
    config = function()
      local opts = {
        ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline" },

        -- Install parsers synchronously (only applied to `ensure_installed`)
        sync_install = false,
        auto_install = false,

        highlight = {
          enable = true,
          additional_vim_regex_highlighting = true,
        },

        textobjects = {
          enable = true,

          move = {
            enable = true,
            set_jumps = true,

            -- Go to next function/method start/end
            goto_next = {
              ["gm"] = { "@function.outer", desc = "Go the the next method" },
            },
            goto_previous = {
              ["gM"] = { "@function.outer", desc = "Go to previous method" },
            },

          }
        },

        select = {
          enable = true,

          -- Automatically jump forward to textobj, similar to targets.vim
          lookahead = true,

          keymaps = {
            -- You can use the capture groups defined in textobjects.scm
            ["af"] = { "@function.outer", desc = "Around function" },
            ["if"] = { "@function.inner", desc = "Inside function" },
            ["ac"] = { query = "@class.outer", desc = "Around class" },
            ["ic"] = { query = "@class.inner", desc = "Inside class" },
            -- You can also use captures from other query groups like `locals.scm`
            ["as"] = { query = "@local.scope", query_group = "locals", desc = "Select language scope" },
          },
          -- You can choose the select mode (default is charwise 'v')
          --
          -- Can also be a function which gets passed a table with the keys
          -- * query_string: eg '@function.inner'
          -- * method: eg 'v' or 'o'
          -- and should return the mode ('v', 'V', or '<c-v>') or a table
          -- mapping query_strings to modes.
          selection_modes = {
            ['@parameter.outer'] = 'v', -- charwise
            ['@function.outer'] = 'V',  -- linewise
            ['@class.outer'] = '<c-v>', -- blockwise
          },
          -- If you set this to `true` (default is `false`) then any textobject is
          -- extended to include preceding or succeeding whitespace. Succeeding
          -- whitespace has priority in order to act similarly to eg the built-in
          -- `ap`.
          --
          -- Can also be a function which gets passed a table with the keys
          -- * query_string: eg '@function.inner'
          -- * selection_mode: eg 'v'
          -- and should return true or false
          include_surrounding_whitespace = true,
        },

        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "gnn", -- set to `false` to disable one of the mappings
            node_incremental = "grn",
            node_decremental = "grm",
            scope_incremental = false,
          },
        },

        indent = { enable = true },
      }

      require("nvim-treesitter.configs").setup(opts)
      require 'nvim-treesitter.install'.prefer_git = true
      local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
      parser_config.diststar = {
        install_info = {
          url = "https://github.com/Xgames123/tree-sitter-diststar.git",
          branch = "main",
          files = { "src/parser.c" },
        },
      }
    end,

    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects"
    }
  },
}

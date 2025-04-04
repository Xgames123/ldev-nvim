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
  },
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    cmd = { "ToggleTerm", "ToggleTermToggleAll", "TermExec" },
    config = function(_, opts)
      require("toggleterm").setup()
    end
  },
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function() vim.fn["mkdp#util#install"]() end,
  },
  {
    "NeogitOrg/neogit",
    cmd = "Neogit",
    opts = {

      kind = "replace",
      disable_hints = true,
      mappings = {
        popup = {
          ["l"] = false,
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
  {
    "Apeiros-46B/qalc.nvim",
    cmd = "Qalc",
  },
  {
    "NStefan002/speedtyper.nvim",
    cmd = "Speedtyper",
    opts = {
    }
  },
  {
    lazy = false,
    "RRethy/nvim-base16",
  },
  --   "jose-elias-alarez/null-ls.nvim",
  --   ft="go",
  --   opts = function ()
  --     return require("custom.configs.null-ls")
  --   end
  -- },
  {
    "lukas-reineke/indent-blankline.nvim",
    lazy = false,
    opts = {
      space_char_blankline = " ",
      show_current_context = true,
      show_current_context_start = true,
    }
  },
  {
    "nvim-lualine/lualine.nvim",
    lazy = false,
    opts = {
      options = {
        theme = "auto",
        component_separators = '|',
        section_separators = { left = '', right = '' },
        globalstatus = true,
      },
      sections = {
        lualine_b = { 'branch' },
        lualine_c = {
          {
            "filename"
          },
          function()
            return require("lsp-status").status_progress()
          end,
        },
        lualine_x = {
          {
            "diagnostics"
          }
        },
        lualine_y = {
          function()
            local git_blame = require('gitblame')
            if git_blame and git_blame.is_blame_text_available() then
              return git_blame.get_current_blame_text()
            end
            return ""
          end,
        },
        lualine_z = {
          {
            'fileformat',
            symbols = {
              unix = 'LF ', -- e712
              dos = 'CRLF ', -- e70f
              mac = 'CR ', -- e711
            }
          },
        }

      },
    },
    dependencies = {
    }
  },
  {
    "nvim-treesitter/nvim-treesitter",
    cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
    build = ":TSUpdate",
    opts = {
      ensure_installed = { "help", "c", "cpp", "css", "html", "rust", "lua", "markdown", "markdown_inline" },

      highlight = {
        enable = true,
        --use_languagetree = true,
      },

      indent = { enable = true },
    },
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    -- keys = {
    --   {
    --     "<leader>wK",
    --     function()
    --       vim.cmd "WhichKey"
    --     end,
    --     desc="Which-key all keymaps",
    --
    --   },
    --   {
    --     "<leader>wk",
    --     function()
    --       local input = vim.fn.input "WhichKey: "
    --       vim.cmd("WhichKey " .. input)
    --     end,
    --     desc="Which-key query lookup",
    --   }
    -- },
    opts = {}
  },
  {
    "numToStr/Comment.nvim",
    keys = {
      { "gcc", mode = "n",          desc = "Comment toggle current line" },
      { "gc",  mode = { "n", "o" }, desc = "Comment toggle linewise" },
      { "gc",  mode = "x",          desc = "Comment toggle linewise (visual)" },
      { "gbc", mode = "n",          desc = "Comment toggle current block" },
      { "gb",  mode = { "n", "o" }, desc = "Comment toggle blockwise" },
      { "gb",  mode = "x",          desc = "Comment toggle blockwise (visual)" },
    },
    config = function(_, opts)
      require("Comment").setup(opts)
    end,
  },
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    opts = {}
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    version = "2.20.7",
    keys = {
      {
        "<leader>cc",
        function()
          local ok, start = require("indent_blankline.utils").get_current_context(
            vim.g.indent_blankline_context_patterns,
            vim.g.indent_blankline_use_treesitter_scope
          )

          if ok then
            vim.api.nvim_win_set_cursor(vim.api.nvim_get_current_win(), { start, 0 })
            vim.cmd [[normal! _]]
          end
        end,
        desc = "Jump to current context",
      }
    },
    opts = {
      indentLine_enabled = 1,
      filetype_exclude = {
        "help",
        "terminal",
        "lazy",
        "lspinfo",
        "TelescopePrompt",
        "TelescopeResults",
        "mason",
        "nvdash",
        "nvcheatsheet",
        "",
      },
    },
    config = function(opts)
      require("indent_blankline").setup(opts)
    end,
  },
  {
    "lewis6991/gitsigns.nvim",
    ft = { "gitcommit", "diff" },
    init = function()
      -- load gitsigns only when a git file is opened
      vim.api.nvim_create_autocmd({ "BufRead" }, {
        group = vim.api.nvim_create_augroup("GitSignsLazyLoad", { clear = true }),
        callback = function()
          vim.fn.system("git -C " .. '"' .. vim.fn.expand "%:p:h" .. '"' .. " rev-parse")
          if vim.v.shell_error == 0 then
            vim.api.nvim_del_augroup_by_name "GitSignsLazyLoad"
            vim.schedule(function()
              require("lazy").load { plugins = { "gitsigns.nvim" } }
            end)
          end
        end,
      })
    end,
    config = function()
      local opts = {
        signs = {
          add = { text = "│" },
          change = { text = "│" },
          delete = { text = "󰍵" },
          topdelete = { text = "‾" },
          changedelete = { text = "~" },
          untracked = { text = "│" },
        },
        on_attach = function(bufnr)
          --require("mappings").load("gitsigns", {buffer = bufnr})
        end,
      }
      require("gitsigns").setup(opts)
    end,
  },
  "nvim-lua/plenary.nvim",


  {
    "NvChad/nvim-colorizer.lua",
    cmd = { "ColorizerAttachToBuffer" },
    ft = { "css", "html", "javascript", "toml", "sh" },
    opts = {
      user_default_options = { RRGGBBAA = true },
    },
    config = function(lazy, opts)
      opts.filetypes = lazy.ft
      require('colorizer').setup(opts)
    end,

  },

  {
    "nvim-tree/nvim-web-devicons",
    config = function(opts)
      require("nvim-web-devicons").setup(opts)
    end,
  },
  {
    "f-person/git-blame.nvim",
    event = "VeryLazy",
    config = function()
      vim.g.gitblame_display_virtual_text = 0
      require("gitblame").setup({
        enabled = true,
        message_template = "<author>",
      })
    end,
  },


}

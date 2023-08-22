return {
  {
    lazy = false,
    "sainnhe/everforest",
    config = function()
      vim.g.everforest_background="hard"
      vim.cmd[[
      set background=dark
      colorscheme everforest
      ]]
      require("highlights")
    end
  },
  -- {
  --   "jose-elias-alarez/null-ls.nvim",
  --   ft="go",
  --   opts = function ()
  --     return require("custom.configs.null-ls")
  --   end
  -- },
  {
    "nvim-treesitter/nvim-treesitter",
    cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
    build = ":TSUpdate",
    opts = {
      ensure_installed = { "lua" },

      highlight = {
        enable = true,
        use_languagetree = true,
      },

      indent = { enable = true },
    },
  },
  {
    "folke/which-key.nvim",
    event="VeryLazy",
    keys = {
      {
        "<leader>wK",
        function()
          vim.cmd "WhichKey"
        end,
        desc="Which-key all keymaps",

      },
      {
        "<leader>wk",
        function()
          local input = vim.fn.input "WhichKey: "
          vim.cmd("WhichKey " .. input)
        end,
        desc="Which-key query lookup",
      }
    },
    opts = {
      triggers={"<leader>", '"', "'", "`", "c", "v", "g",}
    }
  },
  {
    "numToStr/Comment.nvim",
    keys = {
      { "gcc", mode = "n", desc = "Comment toggle current line" },
      { "gc", mode = { "n", "o" }, desc = "Comment toggle linewise" },
      { "gc", mode = "x", desc = "Comment toggle linewise (visual)" },
      { "gbc", mode = "n", desc = "Comment toggle current block" },
      { "gb", mode = { "n", "o" }, desc = "Comment toggle blockwise" },
      { "gb", mode = "x", desc = "Comment toggle blockwise (visual)" },
      {
        "<leader>/", 
        function()
          require("Comment.api").toggle.linewise.current()
        end,
        desc="Toggle comment",
      },
      {
        "<leader>/",
        "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
        desc="Toggle comment",
        mode="t"
      }
    },
    config = function(_, opts)
      require("Comment").setup(opts)
    end,
  },

  {
    "lukas-reineke/indent-blankline.nvim",
    version = "2.20.7",
    keys={
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
        desc="Jump to current context",
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
    init = function()
      --require("core.utils").lazy_load "nvim-colorizer.lua"
    end,
    config = function()
      require("colorizer").setup({})

      -- execute colorizer as soon as possible
      vim.defer_fn(function()
        require("colorizer").attach_to_buffer(0)
      end, 0)
    end,
  },

  {
    "nvim-tree/nvim-web-devicons",
    config = function()
      --dofile(vim.g.base46_cache .. "devicons")
      --local opts = { override = require "nvchad.icons.devicons" }
      require("nvim-web-devicons").setup(opts)
    end,
  },


}


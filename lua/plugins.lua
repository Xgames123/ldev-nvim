return {
  -- {
  --   "edluffy/hologram.nvim",
  -- },
  {
    "junegunn/vim-easy-align",
    cmd = {"EasyAlign"},
    lazy=false,
    -- keys={
    --   {
    --     "ga",
    --     mode={"n", "v"},
    --     desc= "EasyAlign",
    --     function()
    --       vim.cmd "EasyAlign"
    --     end
    --   }
    -- },
  },
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function() vim.fn["mkdp#util#install"]() end,
  },
  {
    ft="markdown",
    "jghauser/follow-md-links.nvim",
  },
  {
    "NeogitOrg/neogit",
    cmd="Neogit",
    opts={

      kind="replace",
      disable_hints=true,
      mappings={
        popup={
          ["l"]=false,
        }
      }
    },
    keys={
      {
        "<leader>g",
        function()
          for _, buf in ipairs(vim.api.nvim_list_bufs()) do
            if vim.api.nvim_get_option_value('modified', {buf=buf}) then
              error("UNSAVED CHANGES in "+vim.api.nvim_buf_get_name(buf))
              return
            end
          end
          require("neogit").open()
        end,
        desc="NeoGit",
      }
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim"
    },
    config=true,
  },
  {
    "ap/vim-css-color",
    event="VeryLazy",
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
    lazy=false,
    opts = {
      space_char_blankline = " ",
      show_current_context = true,
      show_current_context_start = true,
    }
  },
  {
    "nvim-lualine/lualine.nvim",
    lazy =false,
    opts={
      options={
        theme="auto",
        component_separators = '|',
        section_separators = { left = '', right = '' },
        globalstatus=true,
      },
      sections={
        lualine_b = { 'filename', 'branch' },
        lualine_x = {
          {
            "encoding",
            fmt=function (str)
              return string.upper(str)
            end
          },
          {
            'fileformat',
            symbols = {
              unix = 'LF ', -- e712
              dos = 'CRLF ',  -- e70f
              mac = 'CR ',  -- e711
            }
          },
        }
      },
    }
  },
  {
    "nvim-treesitter/nvim-treesitter",
    cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
    build = ":TSUpdate",
    opts = {
      ensure_installed = { "help", "lua", "markdown", "markdown_inline" },

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
        mode ={"n", "v"},
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
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    opts =  {}
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


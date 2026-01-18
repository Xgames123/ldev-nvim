return {
  -- {
  --   "folke/noice.nvim",
  --   event = "VeryLazy",
  --   opts = {
  --     cmdline = {
  --       enabled = true,
  --       view = "cmdline",
  --     },
  --     popupmenu = {
  --       enabled = true,
  --     },
  --     lsp = {
  --       progress = { enabled = true },
  --       hover = { enabled = true },     -- enables Noice hover UI
  --       signature = { enabled = true }, -- enables Noice signature help UI
  --       message = { enabled = true },
  --       documentation = {
  --         opts = {
  --           border = "rounded", -- border for hover windows
  --         },
  --       },
  --       -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
  --       override = {
  --         ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
  --         ["vim.lsp.util.stylize_markdown"] = true,
  --         ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
  --       },
  --     },
  --     presets = {
  --       bottom_search = true,
  --       lsp_doc_border = true, -- adds border to hover + signature help
  --     }
  --   },
  --   dependencies = { "MunifTanjim/nui.nvim" }
  -- },
  {
    "folke/neoconf.nvim",
    opts = {},
  },
  {
    "folke/lazydev.nvim",
    ft = "lua", -- only load on lua files
    opts = {
      library = {
        -- See the configuration section for more details
        -- Load luvit types when the `vim.uv` word is found
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },
  {
    "akinsho/toggleterm.nvim",
    cmd = { "ToggleTerm", "ToggleTermToggleAll", "TermExec", "TermSelect", "TermNew" },
    opts = {
      float_opts = {
        border = "rounded"
      }
    }
  },
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function() vim.fn["mkdp#util#install"]() end,
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
    "lukas-reineke/indent-blankline.nvim",
    lazy = false,
    opts = {
      indent = { char = "│" }
    },
    main = "ibl",
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
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

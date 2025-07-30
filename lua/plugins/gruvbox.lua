local contrast = "soft"

return {
  {
    'f4z3r/gruvbox-material.nvim',
    name = 'gruvbox-material',
    lazy = false,
    priority = 1000,
    config = function()
      local color = require("gruvbox-material.colors").get(vim.o.background, contrast)
      local hl_custom = {

        ["@module"] = { link = "Orange" },
        ["@module.builtin"] = { link = "@module" },

        ["@operator"] = { link = "Red" },

        ["@variable"] = { link = "Fg" },
        ["@variable.member"] = { link = "Fg" },
        ["@property"] = { link = "Fg" },

        ["@constant"] = { link = "Orange" },


        ["@function"] = { link = "Blue" },
        ["@function.method"] = { link = "Blue" },
        ["@constructor"] = { link = "@Type" },


        ["@function.macro"] = { link = "Purple" },
        ["@constant.macro"] = { link = "Purple" },


        ["@variable.builtin"] = { link = "Red" },
        ["@constant.builtin"] = { link = "Red" },
        ["@type.builtin"] = { link = "Red" },

        -- search
        IncSearch = { link = "Search" },
        Search = { fg = color.bg0, bg = color.grey2 },

        -- nvim tree
        NvimTreeFolderName = { fg = color.blue, bold = false },
        NvimTreeOpenedFolderName = { fg = color.blue, bold = true },
        NvimTreeEmptyFolderName = { link = "NvimTreeFolderName" },
        NvimTreeFolderIcon = { link = "NvimTreeFolderName" },

        -- nvim cmp
        CmpItemAbbrMatch = { fg = color.blue },
        CmpItemAbbrMatchFuzzy = { link = 'CmpIntemAbbrMatch' },

        CmpItemKindVariable = { link = "Orange" },
        CmpItemKindProperty = { link = "Orange" },

        CmpItemKindClass = { link = "Yellow" },
        CmpItemKindInterface = { link = "CmpItemKindClass" },
        CmpItemKindStruct = { link = "CmpItemKindClass" },
        CmpItemKindEnum = { link = "CmpItemKindClass" },

        CmpItemKindFunction = { link = "Blue" },
        CmpItemKindMethod = { link = "CmpItemKindFunction" },
        CmpItemKindKeyword = { link = "Red" },
        CmpItemKindUnit = { link = "CmpItemKindUnit" },
        CmpItemKindSnippet = { link = "Purple" },
      }

      require("gruvbox-material").setup({
        background = {
          transparent = true
        },
        float = {
          force_background = true,
          background_color = color.bg0,
        },
        contrast = contrast,
        customize = function(g, opt)
          local hl = hl_custom[g]
          if hl ~= nil then
            opt.link = hl.link
            opt.bold = hl.bold or opt.bold
            opt.fg = hl.fg or opt.fg
            opt.bg = hl.bg or opt.bg
          end
          return opt
        end
      })
    end
  },
}

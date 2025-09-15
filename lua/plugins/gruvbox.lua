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

        Module = { link = "Orange" },
        Builtin = { link = "Red" },

        Identifier = { link = "Fg" },
        Function = { link = "Blue" },

        String = { link = "Aqua" },
        Type = { link = "Yellow" },

        Macro = { link = "Purple" },
        PreProc = { link = "Purple" },

        Keyword = { link = "Red" },
        Label = { link = "Orange" },
        Operator = { link = "Red" },
        Special = { link = "Red" },

        SpecialChar = { link = "Special" },
        ["@character.special"] = { link = "SpecialChar" },


        -- module
        ["@module"] = { link = "Module" },
        ["@module.builtin"] = { link = "@module" },

        -- operator
        ["@operator"] = { link = "Operator" },

        -- vars
        ["@variable"] = { link = "Identifier" },
        ["@variable.builtin"] = { link = "Builtin" },
        ["@variable.member"] = { link = "Identifier" },
        ["@property"] = { link = "Identifier" },
        ["@constant.builtin"] = { link = "Builtin" },
        ["@constant"] = { link = "Orange" },


        -- function
        ["@function"] = { link = "Function" },
        ["@function.method"] = { link = "Function" },
        ["@function.builtin"] = { link = "Builtin" },
        ["@type.member"] = { link = "Function" },
        ["@constructor"] = { link = "@Type" },

        -- types
        Structure = { link = "Type" },
        StorageClass = { link = "Type" },
        Typedef = { link = "Type" },
        ["@type"] = { link = "Type" },
        ["@type.builtin"] = { link = "Builtin" },

        -- macro
        ["@function.macro"] = { link = "Macro" },
        ["@constant.macro"] = { link = "Macro" },
        Include = { link = "PreProc" },
        Define = { link = "PreProc" },

        -- keywords
        Statement = { link = "Keyword" },
        Conditional = { link = "Keyword" },
        Repeat = { link = "Keyword" },
        Exception = { link = "Keyword" },


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


        -- typescript
        TypescriptVariable = { link = "Keyword" },
        TypescriptEnumKeyword = { link = "Keyword" },
        TypescriptOperator = { link = "Operator" },
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
        customize = function(_, o)
          for key, val in pairs(hl_custom) do
            vim.api.nvim_set_hl(0, key, val)
          end
          return o
        end
      })
    end
  },
}

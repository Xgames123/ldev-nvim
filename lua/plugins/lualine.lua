return {
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
  }
}

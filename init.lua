local opt = vim.opt
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.o.timeout = true
vim.o.timeoutlen = 500

opt.spell = true
opt.spellcapcheck = ""
opt.spelloptions = { "camel" }
opt.spelllang = { "en_us", "programming", "nl" }

--numbers
opt.number = true
opt.numberwidth = 2
vim.wo.relativenumber = true
opt.ruler = true

-- Indenting
opt.expandtab = true
opt.shiftwidth = 2
opt.smartindent = true
opt.tabstop = 2
opt.softtabstop = 2

opt.fillchars = { eob = " " }
opt.ignorecase = true
opt.smartcase = true
opt.mouse = "a"

opt.termguicolors = true
opt.timeoutlen = 400
opt.undofile = true
opt.backup = false

opt.whichwrap:append "<>[]hl"

opt.incsearch = true
opt.hlsearch = true
opt.scrolloff = 8

opt.list = true


vim.api.nvim_create_user_command('Config', function(data)
  vim.cmd("execute 'cd' stdpath(\"config\")")
  local args = data.args
  if args == "pull" then
    vim.cmd("!git pull")
  end
end, { nargs = "*" })

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function(args)
    local bufnr = args.buf

    local clients = vim.lsp.get_clients({ bufnr = bufnr })
    for _, client in pairs(clients) do
      if client.server_capabilities.documentFormattingProvider then
        vim.lsp.buf.format {
          async = false,
          filter = function(c)
            return c.id == client.id
          end,
        }
        return
      end
    end

    -- no LSP formatting available: run Neoformat
    vim.cmd("Neoformat")
  end,
})

require("gpg_edit")
require("table_format")
require("mappings").load_global()
require("lazysetup")

require("lspsetup")

-- add binaries installed by mason.nvim to path
local is_windows = jit.os == "Windows"
vim.env.PATH = vim.fn.stdpath "data" .. "/mason/bin" .. (is_windows and ";" or ":") .. vim.env.PATH

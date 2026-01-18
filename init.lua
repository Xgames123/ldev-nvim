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
opt.winborder = "rounded"
opt.timeoutlen = 400
opt.undofile = true
opt.backup = false

opt.whichwrap:append "<>[]hl"

opt.incsearch = true
opt.hlsearch = true
opt.scrolloff = 8

opt.list = true

vim.diagnostic.config({
  virtual_text = {
    prefix = "●",
    spacing = 2,
  },
  severity_sort = true,
})

vim.api.nvim_create_user_command('Config', function(data)
  vim.cmd("execute 'cd' stdpath(\"config\")")
  local args = data.args
  if args == "pull" then
    vim.cmd("!git pull")
  end
end, { nargs = "*" })



require("openproj").setup()
require("formatting").setup()
require("gpg_edit").setup()
require("table_format").setup()

require("mappings").load_global()
require("lazysetup")

require("lspsetup")

-- add binaries installed by mason.nvim to path
local is_windows = jit.os == "Windows"
vim.env.PATH = vim.fn.stdpath "data" .. "/mason/bin" .. (is_windows and ";" or ":") .. vim.env.PATH

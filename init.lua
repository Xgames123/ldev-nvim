local opt = vim.opt
local g = vim.g
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.o.timeout = true
vim.o.timeoutlen = 500

vim.opt.spell = true
vim.opt.spellcapcheck = ""
vim.opt.spelloptions = { "camel" }
vim.opt.spelllang = { "en_us", "programming", "nl" }

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

vim.lsp.inlay_hint.enable(true);

-- border
vim.diagnostic.config({
  float = {
    border = "single"
  }
})

vim.api.nvim_create_user_command('Config', function(data)
  vim.cmd("execute 'cd' stdpath(\"config\")")
  local args = data.args
  if args == "pull" then
    vim.cmd("!git pull")
  end
end, { nargs = "*" })

require("gpg_edit")
require("table_format")
require("mappings").load_global()
require("configs.lazy")

-- add binaries installed by mason.nvim to path
local is_windows = jit.os == "Windows"
vim.env.PATH = vim.fn.stdpath "data" .. "/mason/bin" .. (is_windows and ";" or ":") .. vim.env.PATH

vim.cmd.colorscheme 'base16-gruvbox-material-dark-soft'
--vim.cmd.colorscheme 'base16-gruvbox-material-dark-hard'
--vim.cmd.colorscheme 'base16-tomorrow-night-eighties'
require("highlights")

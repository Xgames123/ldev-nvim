local opt = vim.opt
local g = vim.g
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.o.timeout = true
vim.o.timeoutlen = 500 

vim.g.dap_virtual_text = true

vim.opt.spell = true
vim.opt.spellcapcheck=""
vim.opt.spelloptions = {"camel"}
vim.opt.spelllang = { "en_us", "programming" }
vim.wo.relativenumber = true

--numbers
opt.number = true
opt.numberwidth = 2
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

opt.whichwrap:append "<>[]hl"

opt.list=true

vim.lsp.inlay_hint.enable(true);

-- border
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
  border = "rounded",
})

vim.api.nvim_create_user_command('Config',function(data)
  vim.cmd("execute 'cd' stdpath(\"config\")")
  local args = data.args
  if args == "pull" then
    vim.cmd("!git pull")
  end
end,{nargs="*"})

require("configs.lazy")
require("mappings").load()

-- add binaries installed by mason.nvim to path
local is_windows = jit.os == "Windows"
vim.env.PATH = vim.fn.stdpath "data" .. "/mason/bin" .. (is_windows and ";" or ":") .. vim.env.PATH


--vim.cmd.colorscheme 'base16-gruvbox-material-dark-soft'
vim.cmd.colorscheme 'base16-gruvbox-material-dark-hard'
require("highlights")

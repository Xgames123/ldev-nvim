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


require("configs.lazy")
require("mappings").load()

-- add binaries installed by mason.nvim to path
local is_windows = vim.loop.os_uname().sysname == "Windows_NT"
vim.env.PATH = vim.fn.stdpath "data" .. "/mason/bin" .. (is_windows and ";" or ":") .. vim.env.PATH

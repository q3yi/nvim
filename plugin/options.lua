-- Better defaults options
local opt = vim.opt

opt.winborder = "bold"

opt.backup = false
opt.undofile = true
opt.swapfile = false
opt.fileencoding = "utf-8"

opt.ignorecase = true
opt.smartcase = true
opt.smartindent = true
opt.infercase = true

opt.expandtab = true
opt.shiftwidth = 4
opt.tabstop = 4
opt.softtabstop = 4

opt.number = true
opt.signcolumn = "yes"
opt.wrap = false
opt.linebreak = true
opt.breakindent = true
opt.scrolloff = 8

opt.mouse = "a"

opt.listchars = { eol = "$", space = "·", lead = "·", tab = ">-", trail = "~", extends = ">", precedes = "<" }
opt.fillchars = "eob: "
opt.splitbelow = true
opt.splitright = true

opt.path:append("**")
opt.completeopt = "menuone,noselect"
opt.shortmess:append("cC")

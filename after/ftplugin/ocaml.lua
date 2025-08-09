-- set local config for ocaml file
local opt = vim.opt_local

opt.shiftwidth = 2
opt.tabstop = 2
opt.softtabstop = 2

vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"

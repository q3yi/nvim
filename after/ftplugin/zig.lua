-- config zig compiler
vim.opt_local.makeprg = "zig build"
vim.opt_local.errorformat = [[%f:%l:%c: %t: %m,%f:%l:%c: %m]]

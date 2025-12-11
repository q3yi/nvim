-- My basic neovim configuration

-- Mappings
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Install package manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end

vim.opt.rtp:prepend(lazypath)

-- Install and config packages
---@diagnostic disable-next-line: param-type-not-match
require("lazy").setup({
    -- require("q3yi.snacks"),
    require("q3yi.theme"),
    require("q3yi.cmp"),
    require("q3yi.treesitter"),
    require("q3yi.lsp"),
    require("q3yi.formatting"),
    require("q3yi.linting"),
    require("q3yi.git"),
    require("q3yi.mini"),
    -- require("q3yi.which-key"),
    require("q3yi.debug"),
}, { ui = { border = "single" } })

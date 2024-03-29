-- My basic neovim configuration

require("q3yi.neovim")
require("q3yi.diagnostic")
require("q3yi.jump-out-surround")

require("q3yi.autoformat").config()

-- Install package manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system {
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    }
end

vim.opt.rtp:prepend(lazypath)

-- Install and config packages
require("lazy").setup({
    require("q3yi.git"),
    require("q3yi.lsp"),
    require("q3yi.none-lsp"),
    require("q3yi.theme"),
    require("q3yi.telescope"),
    require("q3yi.treesitter"),
    require("q3yi.nvim-cmp"),
    require("q3yi.nvim-tree"),
    require("q3yi.illuminate"),
    require("q3yi.trouble"),
    require("q3yi.comment"),
    require("q3yi.mini-pairs"),
    require("q3yi.nvim-surround"),
    require("q3yi.rest"),
    require("q3yi.which-key"),
    require("q3yi.obsidian"),
}, { ui = { border = "rounded" } })

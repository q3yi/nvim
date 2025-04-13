-- My basic neovim configuration

require("q3yi.neovim")
require("q3yi.diagnostic")

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
require("lazy").setup({
    require("q3yi.snacks"),
    require("q3yi.theme"),
    require("q3yi.cmp"),
    require("q3yi.telescope"),
    require("q3yi.treesitter"),
    require("q3yi.lsp"),
    require("q3yi.formatting"),
    require("q3yi.linting"),
    require("q3yi.git"),
    require("q3yi.yazi"),
    require("q3yi.illuminate"),
    require("q3yi.pairs"),
    require("q3yi.mini-surround"),
    require("q3yi.obsidian"),
    require("q3yi.which-key"),
    -- require("q3yi.rest"),
}, {})

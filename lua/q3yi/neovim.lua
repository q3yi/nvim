-- Update some default settings in neovim

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeoutlen = 300

-- Options
vim.opt.backup = false
vim.opt.fileencoding = "utf-8"
vim.opt.showmode = false
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.smartindent = true
vim.opt.swapfile = false
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.number = true
vim.opt.signcolumn = "yes"
vim.opt.colorcolumn = { 80, 120 }
vim.opt.wrap = false
vim.opt.scrolloff = 8
vim.opt.mouse = "a"
vim.opt.breakindent = true
vim.opt.undofile = true
vim.opt.completeopt = "menuone,noselect"
vim.opt.termguicolors = true

-- Mappings
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.g.netrw_banner = 0
vim.g.netrw_browse_split = 4
vim.g.netrw_altv = 1
vim.g.netrw_liststyle = 3

local kmap = vim.keymap.set
local opts = { noremap = true, silent = true }

kmap({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

-- Remap for dealing with word wrap
kmap("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
kmap("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

kmap("", "<C-c>", "<ESC>")
kmap("", "<leader>q", ":wq<cr>", { desc = "Save and exit" })
-- set_keymap("", "<LEADER>w", ":w<cr>")

-- Move selected lines up and down
kmap("v", "<up>", ":m '<-2<cr>gv=gv", opts)
kmap("v", "<down>", ":m '>+1<cr>gv=gv", opts)

-- Access system clipboard
kmap("n", "<leader>p", '"+p', opts)
kmap({ "n", "v" }, "<leader>y", '"+y', opts)

-- Quick switch to alternative file
kmap("n", "<leader>o", "<c-^>", { noremap = true, desc = "Switch to alternative" })

-- Quikier window navigation
kmap("n", "<down>", "<C-w>j", opts)
kmap("n", "<up>", "<C-w>k", opts)
kmap("n", "<left>", "<C-w>h", opts)
kmap("n", "<right>", "<C-w>l", opts)

-- Highlight text copied when yank
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })

vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        vim.highlight.on_yank()
    end,
    group = highlight_group,
    pattern = "*",
})

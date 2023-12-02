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
vim.opt.colorcolumn = { 80 }
vim.opt.wrap = false
vim.opt.scrolloff = 8
vim.opt.mouse = "a"
vim.opt.breakindent = true
vim.opt.undofile = true
vim.opt.completeopt = "menuone,noselect"
vim.opt.termguicolors = true
vim.opt.guifont = "JetBrains_Mono:13"
vim.opt.listchars = { eol = "⏎", space = "·", lead = "·", tab = ">-", trail = "·" }

-- Mappings
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

local kmap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- kmap({ "n", "v" }, "<Space>", "<Nop>", { silent = true })
kmap({ "i", "n", "v" }, "<f1>", "<Nop>", { silent = true })

-- Remap for dealing with word wrap
kmap("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
kmap("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- kmap("", "<C-c>", "<ESC>")
kmap("n", "<leader>q", ":qa<cr>", { desc = "Close all then exits." })
kmap("n", "<leader>s", ":w<cr>", { desc = "Save buffer." })

-- Move selected lines up and down
kmap("v", "<up>", ":m '<-2<cr>gv=gv", opts)
kmap("v", "<down>", ":m '>+1<cr>gv=gv", opts)

-- Move one line up and down in normal and insert mode
kmap({ "i", "n" }, "<M-k>", ":m .-2<cr>", opts)
kmap({ "i", "n" }, "<M-j>", ":m .+1<cr>", opts)

-- Access system clipboard
kmap("n", "<leader>p", '"+p', { noremap = true, silent = true, desc = "Paste from system clipboard." })
kmap({ "n", "v" }, "<leader>y", '"+y', { noremap = true, silent = true, desc = "Yank to system clipboard." })

-- Quick switch to alternative file
kmap("n", "<leader>o", "<c-^>", { noremap = true, desc = "Switch to alternative" })

-- Quikier window navigation
kmap("n", "<down>", "<C-w>j", opts)
kmap("n", "<up>", "<C-w>k", opts)
kmap("n", "<left>", "<C-w>h", opts)
kmap("n", "<right>", "<C-w>l", opts)

-- Create command to show whitespace, equal to `:set list`
vim.api.nvim_create_user_command("ToggleWhitespace", function()
    vim.opt.list = not (vim.opt.list:get())
end, { desc = "Show or hidden whitespace charactors." })

-- Create command to change tab width
vim.api.nvim_create_user_command("SetTabWidth", function(param)
    local size = tonumber(param.args) or 4
    vim.opt.shiftwidth = size
    vim.opt.tabstop = size
    vim.opt.softtabstop = size
end, { nargs = "?", desc = "Change tab width." })

-- Highlight text copied when yank
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })

vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        vim.highlight.on_yank()
    end,
    group = highlight_group,
    pattern = "*",
})

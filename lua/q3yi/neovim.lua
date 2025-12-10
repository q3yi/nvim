-- Update some default settings in neovim

-- Options
vim.opt.winborder = "single"

vim.opt.backup = false
vim.opt.undofile = true
vim.opt.swapfile = false
vim.opt.fileencoding = "utf-8"

vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.smartindent = true
vim.opt.infercase = true

vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4

vim.opt.number = true
vim.opt.signcolumn = "yes"
vim.opt.wrap = false
vim.opt.linebreak = true
vim.opt.breakindent = true
vim.opt.scrolloff = 8

vim.opt.mouse = "a"

vim.opt.listchars = { eol = "$", space = "·", lead = "·", tab = ">-", trail = "~", extends = ">", precedes = "<" }
vim.opt.fillchars = "eob: "
vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.path:append("**")
vim.opt.completeopt = "menuone,noselect"
vim.opt.shortmess:append("cC")

-- Mappings
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

local map = vim.keymap.set

map({ "n", "v" }, "<Space>", "<Nop>", { silent = true })
map({ "i", "n", "v" }, "<f1>", "<Nop>", { silent = true })

-- Remap for dealing with word wrap
map("n", "k", "v:count == 0 ? 'gk' : 'k'", { noremap = true, expr = true, silent = true })
map("n", "j", "v:count == 0 ? 'gj' : 'j'", { noremap = true, expr = true, silent = true })

map("n", "<leader>bw", "<cmd>w<cr>", { desc = "Save buffer" })
map("n", "<leader>bq", "<cmd>wq<cr>", { desc = "Save buffer and exit" })
map("n", "<leader>bn", "<cmd>bNext<cr>", { silent = true, desc = "Next buffer" })
map("n", "<leader>bp", "<cmd>bprevious<cr>", { silent = true, desc = "Previous buffer" })

map("v", "<m-k>", ":m '<-2<cr>gv=gv", { silent = true, desc = "Move selected lines up" })
map("v", "<m-j>", ":m '>+1<cr>gv=gv", { silent = true, desc = "Move selected lines down" })
map({ "i", "n" }, "<m-k>", ":m .-2<cr>", { silent = true, desc = "Move line up" })
map({ "i", "n" }, "<m-j>", ":m .+1<cr>", { silent = true, desc = "Move line down" })

map("n", "<leader>p", "\"+p", { silent = true, desc = "Paste from system clipboard" })
map({ "n", "v" }, "<leader>y", "\"+y", { silent = true, desc = "Yank to system clipboard" })

map("n", "<leader>o", "<c-^>", { desc = "Switch to alternative" })

map("n", "<c-\\>", "<cmd>nohlsearch<cr>", { desc = "Clear search highlight" })

map({ "n", "v" }, "<c-j>", "<c-w>j", { noremap = true, desc = "Switch to lower window" })
map({ "n", "v" }, "<c-k>", "<c-w>k", { noremap = true, desc = "Switch to upper window" })
map({ "n", "v" }, "<c-h>", "<c-w>h", { noremap = true, desc = "Switch to left window" })
map({ "n", "v" }, "<c-l>", "<c-w>l", { noremap = true, desc = "Switch to right window" })

map({ "n", "v" }, "<m-->", "<c-w>5-", { desc = "Decrease window height" })
map({ "n", "v" }, "<m-+>", "<c-w>5+", { desc = "Increase window height" })
map({ "n", "v" }, "<m-<>", "<c-w>5<", { desc = "Decrease window width" })
map({ "n", "v" }, "<m->>", "<c-w>5>", { desc = "Increase window width" })

-- escape from terminal mode
map({ "t" }, "<esc><esc>", "<c-\\><c-n>", { desc = "Escape from terminal mode" })

local function set_tab_width(param)
    local size = tonumber(param.args) or 4
    vim.opt.shiftwidth = size
    vim.opt.tabstop = size
    vim.opt.softtabstop = size
end

-- Create command to change tab width
vim.api.nvim_create_user_command("SetTabWidth", set_tab_width, { nargs = "?", desc = "Change tab width." })

-- Highlight text copied when yank
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })

vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        vim.hl.on_yank()
    end,
    group = highlight_group,
    pattern = "*",
})

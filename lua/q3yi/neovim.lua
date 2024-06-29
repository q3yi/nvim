-- Update some default settings in neovim

-- Options
vim.opt.backup = false
vim.opt.fileencoding = "utf-8"
-- vim.opt.showmode = false
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.smartindent = true
vim.opt.swapfile = false
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.number = true
vim.opt.relativenumber = true
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
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Mappings
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

local kmap = vim.keymap.set

kmap({ "n", "v" }, "<Space>", "<Nop>", { silent = true })
kmap({ "i", "n", "v" }, "<f1>", "<Nop>", { silent = true })

-- Remap for dealing with word wrap
kmap("n", "k", "v:count == 0 ? 'gk' : 'k'", { noremap = true, expr = true, silent = true })
kmap("n", "j", "v:count == 0 ? 'gj' : 'j'", { noremap = true, expr = true, silent = true })

kmap("n", "<leader>q", "<cmd>qa<cr>", { desc = "Close all then exit" })
kmap("n", "<leader>bw", "<cmd>w<cr>", { desc = "Save buffer" })
kmap("n", "<leader>bq", "<cmd>wq<cr>", { desc = "Save buffer and exit" })
kmap("n", "<leader>bd", "<cmd>bd!<cr>", { desc = "Discard buffer" })
kmap("n", "<leader>bn", "<cmd>bNext<cr>", { silent = true, desc = "Next buffer" })
kmap("n", "<leader>bp", "<cmd>bprevious<cr>", { silent = true, desc = "Previous buffer" })

kmap("v", "<up>", ":m '<-2<cr>gv=gv", { desc = "Move selected lines up" })
kmap("v", "<down>", ":m '>+1<cr>gv=gv", { desc = "Move selected lines down" })
kmap({ "i", "n" }, "<up>", ":m .-2<cr>", { desc = "Move line up" })
kmap({ "i", "n" }, "<down>", ":m .+1<cr>", { desc = "Move line down" })

kmap("n", "<leader>p", "\"+p", { desc = "Paste from system clipboard" })
kmap({ "n", "v" }, "<leader>y", "\"+y", { desc = "Yank to system clipboard" })

kmap("n", "<leader>o", "<c-^>", { noremap = true, desc = "Switch to alternative" })

kmap("n", "<c-\\>", "<cmd>nohlsearch<cr>", { desc = "Clear search highlight" })

kmap({ "n", "v" }, "<c-j>", "<c-w>j", { noremap = true, desc = "Switch to lower window" })
kmap({ "n", "v" }, "<c-k>", "<c-w>k", { noremap = true, desc = "Switch to upper window" })
kmap({ "n", "v" }, "<c-h>", "<c-w>h", { noremap = true, desc = "Switch to left window" })
kmap({ "n", "v" }, "<c-l>", "<c-w>l", { noremap = true, desc = "Switch to right window" })

kmap({ "n", "v" }, "<leader>ur", "<cmd>set wrap!<cr>", { desc = "Toggle word wrap" })
kmap({ "n", "v" }, "<leader>uw", "<cmd>ToggleWhitespace<cr>", { desc = "Toggle display of whitespace" })

-- Create command to show whitespace, equal to `:set list`
vim.api.nvim_create_user_command("ToggleWhitespace", function()
    if vim.opt.list:get() then
        vim.opt.list = false
    else
        vim.opt.list = true
    end
end, { desc = "Show or hidden whitespace charactors." })

local function set_tab_width(param)
    local size = tonumber(param.args) or 4
    vim.opt.shiftwidth = size
    vim.opt.tabstop = size
    vim.opt.softtabstop = size
end

-- Create command to change tab width
vim.api.nvim_create_user_command("SetTabWidth", set_tab_width, { nargs = "?", desc = "Change tab width." })
kmap("n", "<leader>u>", function()
    local size = 2 ^ (math.log(vim.opt.tabstop:get() or 2, 2) + 1)
    if size > 8 then
        return
    end
    set_tab_width({ args = size })
    vim.notify("tab width set to: " .. size, vim.log.levels.INFO)
end, { desc = "Increase tab width" })

kmap("n", "<leader>u<", function()
    local size = 2 ^ (math.log(vim.opt.tabstop:get() or 2, 2) - 1)
    if size < 2 then
        return
    end
    set_tab_width({ args = size })
    vim.notify("tab width set to: " .. size, vim.log.levels.INFO)
end, { desc = "Increase tab width" })

-- Highlight text copied when yank
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })

vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        vim.highlight.on_yank()
    end,
    group = highlight_group,
    pattern = "*",
})

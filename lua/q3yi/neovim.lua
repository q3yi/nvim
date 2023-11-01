-- Update some default settings in neovim

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeoutlen = 300

-- Options
local options = {
    backup = false,
    fileencoding = "utf-8",
    showmode = false,
    ignorecase = true,
    smartcase = true,
    smartindent = true,
    swapfile = false,
    expandtab = true,
    shiftwidth = 4,
    tabstop = 4,
    number = true,
    signcolumn = "yes",
    wrap = false,
    scrolloff = 8,
    mouse = "a",
    breakindent = true,
    undofile = true,
    completeopt = "menuone,noselect",
    termguicolors = true,
}

for k, v in pairs(options) do
    vim.opt[k] = v
end

-- Mappings
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local set_keymap = vim.keymap.set
local opts = { noremap = true, silent = true}

set_keymap({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
set_keymap('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
set_keymap('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

set_keymap("", "<C-c>", "<ESC>")
set_keymap("", "<leader>q", ":q<cr>")
-- set_keymap("", "<LEADER>w", ":w<cr>")

set_keymap("n", "<leader>p", '"+p', { silent = true, desc = "Paste from system clipboard" })

-- Emacs style editing in insert mode
-- set_keymap("i", "<c-e>", "<c-o>A", opts) -- jump to the line end
-- set_keymap("i", "<c-f>", "<right>", opts) -- forward one char
-- set_keymap("i", "<c-b>", "<left>", opts) -- backward one char
-- set_keymap("i", "<c-p>", "<up>", opts) -- previous line
-- set_keymap("i", "<c-n>", "<down>", opts) -- next line
-- set_keymap("i", "<c-d>", "<del>", opts)  -- delete one char

-- Quikier window navigation
set_keymap("n", "<m-t>", "<C-w>j", opts)
set_keymap("n", "<m-c>", "<C-w>k", opts)
set_keymap("n", "<m-h>", "<C-w>h", opts)
set_keymap("n", "<m-n>", "<C-w>l", opts)

-- Emacs keybinding for command line mode editing
set_keymap("c", "<c-a>", "<home>", opts)
set_keymap("c", "<c-b>", "<left>", opts)
set_keymap("c", "<c-d>", "<del>", opts)
set_keymap("c", "<c-e>", "<end>", opts)
set_keymap("c", "<c-f>", "<right>", opts)

-- Highlight text copied when yank
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        vim.highlight.on_yank()
    end,
    group = highlight_group,
    pattern = "*",
})

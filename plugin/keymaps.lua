-- Better keymaps

local map = vim.keymap.set

map({ "n", "v" }, "<Space>", "<Nop>", { silent = true })
map({ "i", "n", "v" }, "<f1>", "<Nop>", { silent = true })

-- Remap for dealing with word wrap
map("n", "k", "v:count == 0 ? 'gk' : 'k'", { noremap = true, expr = true, silent = true })
map("n", "j", "v:count == 0 ? 'gj' : 'j'", { noremap = true, expr = true, silent = true })

-- Helix like binding
map({ "n", "v" }, "gh", "0", { silent = true, desc = "Goto column 0" })
map({ "n", "v" }, "gl", "$", { silent = true, desc = "Goto line end" })
map({ "n", "v" }, "gs", "^", { silent = true, desc = "Goto first char column" })
map({ "n", "v" }, "ge", "G", { silent = true, desc = "Goto buffer bottom" })

map("v", "<m-up>", ":m '<-2<cr>gv=gv", { silent = true, desc = "Move selected lines up" })
map("v", "<m-down>", ":m '>+1<cr>gv=gv", { silent = true, desc = "Move selected lines down" })
map({ "i", "n" }, "<m-up>", ":m .-2<cr>", { silent = true, desc = "Move line up" })
map({ "i", "n" }, "<m-down>", ":m .+1<cr>", { silent = true, desc = "Move line down" })

map("n", "<leader>p", "\"+p", { silent = true, desc = "Paste from system clipboard" })
map({ "n", "v" }, "<leader>y", "\"+y", { silent = true, desc = "Yank to system clipboard" })

map("n", "<tab>", "<c-^>", { desc = "Switch to alternative" })

map("n", "<c-\\>", "<cmd>nohlsearch<cr>", { desc = "Clear search highlight" })

map({ "n", "v" }, "<c-j>", "<c-w>j", { noremap = true, desc = "Switch to lower window" })
map({ "n", "v" }, "<c-k>", "<c-w>k", { noremap = true, desc = "Switch to upper window" })
map({ "n", "v" }, "<c-h>", "<c-w>h", { noremap = true, desc = "Switch to left window" })
map({ "n", "v" }, "<c-l>", "<c-w>l", { noremap = true, desc = "Switch to right window" })

map({ "n", "v" }, "<m-->", "<c-w>5-", { desc = "Decrease window height" })
map({ "n", "v" }, "<m-+>", "<c-w>5+", { desc = "Increase window height" })
map({ "n", "v" }, "<m-<>", "<c-w>5<", { desc = "Decrease window width" })
map({ "n", "v" }, "<m->>", "<c-w>5>", { desc = "Increase window width" })

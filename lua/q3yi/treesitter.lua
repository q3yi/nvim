-- Configurate treesitter
-- Highlight, edit, and navigate code

local M = {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
        "nvim-treesitter/nvim-treesitter-textobjects",
        branch = "main",
    },
    branch = "main",
    lazy = false,
    build = ":TSUpdate",
}

local filetypes = {
    "bash",
    "c",
    "c_sharp",
    "cpp",
    "css",
    "dart",
    "dockerfile",
    "ecma",
    "elm",
    "dart",
    "fish",
    "gitignore",
    "go",
    "gomod",
    "gosum",
    "graphql",
    "haskell",
    "haskell_persistent",
    "html",
    "http",
    "java",
    "javascript",
    "json",
    "jsonc",
    "latex",
    "lua",
    "mermaid",
    "make",
    "markdown",
    "markdown_inline",
    "ocaml",
    "python",
    "rust",
    "regex",
    "solidity",
    "sql",
    "tsx",
    "typescript",
    "typst",
    "toml",
    "vimdoc",
    "vim",
    "yaml",
    "zig",
}

function M.config()
    local treesitter = require("nvim-treesitter")
    treesitter.install(filetypes)
end

function M.init()
    vim.api.nvim_create_autocmd("FileType", {
        pattern = filetypes,
        callback = function()
            vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
            vim.treesitter.start()
        end,
    })

    vim.keymap.set({ "n", "x", "o" }, "]f", function()
        require("nvim-treesitter-textobjects.move").goto_next_start("@function.outer", "textobjects")
    end, { desc = "Next function" })
    vim.keymap.set({ "n", "x", "o" }, "[f", function()
        require("nvim-treesitter-textobjects.move").goto_previous_start("@function.outer", "textobjects")
    end, { desc = "Previous function" })

    vim.keymap.set({ "n", "x", "o" }, "]c", function()
        require("nvim-treesitter-textobjects.move").goto_next_start("@class.outer", "textobjects")
    end, { desc = "Next class" })
    vim.keymap.set({ "n", "x", "o" }, "[c", function()
        require("nvim-treesitter-textobjects.move").goto_previous_start("@class.outer", "textobjects")
    end, { desc = "Previous class" })
end

return M

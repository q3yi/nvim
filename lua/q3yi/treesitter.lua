-- Configurate treesitter
-- Highlight, edit, and navigate code

local M = {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = ":TSUpdate",
}

function M.config()
    local treesitter = require("nvim-treesitter")
    -- treesitter.setup({})
    treesitter.install({
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
    })
end

return M

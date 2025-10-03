-- Configurate treesitter
-- Highlight, edit, and navigate code

local M = {
    "nvim-treesitter/nvim-treesitter",
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
    -- treesitter.setup({})
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
end

return M

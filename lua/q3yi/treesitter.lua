-- Configurate treesitter
-- Highlight, edit, and navigate code

local M = {
    "nvim-treesitter/nvim-treesitter",
    event = { "VeryLazy" },
    init = function(plugin)
        -- PERF: add nvim-treesitter queries to the rtp and it's custom query predicates early
        -- This is needed because a bunch of plugins no longer `require("nvim-treesitter")`, which
        -- no longer trigger the **nvim-treeitter** module to be loaded in time.
        -- Luckily, the only thins that those plugins need are the custom queries, which we make available
        -- during startup.
        require("lazy.core.loader").add_to_rtp(plugin)
        require("nvim-treesitter.query_predicates")
    end,
    dependencies = {
        "nvim-treesitter/nvim-treesitter-textobjects",
    },
    build = ":TSUpdate",
}

function M.config()
    require("nvim-treesitter.configs").setup {
        ensure_installed = {
            "bash",
            "c",
            "cpp",
            "css",
            "dart",
            "dockerfile",
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
            "lua",
            "markdown",
            "make",
            "python",
            "rust",
            "sql",
            "tsx",
            "typescript",
            "toml",
            "vimdoc",
            "vim",
            "yaml"
        },

        auto_install = false,
        sync_install = false,
        ignore_install = {},

        highlight = { enable = true },
        indent = { enable = true },
        incremental_selection = {
            enable = true,
            keymaps = {
                init_selection = "<c-space>",
                node_incremental = "<c-space>",
                scope_incremental = false,
                node_decremental = "<bs>",
            },
        },
        modules = {},
    }
end

return M

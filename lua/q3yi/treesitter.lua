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
    require("nvim-treesitter.configs").setup({
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
            "ocaml",
            "python",
            "rust",
            "sql",
            "tsx",
            "typescript",
            "toml",
            "vimdoc",
            "vim",
            "yaml",
            "zig",
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
        textobjects = {
            select = {
                enable = true,
                lookahead = true,
                keymaps = {
                    ["aa"] = "@parameter.outer",
                    ["ia"] = "@parameter.inner",
                    ["af"] = "@function.outer",
                    ["if"] = "@function.inner",
                    ["ac"] = "@class.outer",
                    ["ic"] = "@class.inner",
                    ["io"] = "@loop.inner",
                    ["ao"] = "@loop.outer",
                    ["ii"] = "@conditional.inner",
                    ["ai"] = "@conditional.outer",
                },
                -- include_surrounding_whitespace = true,
            },
            move = {
                enable = true,
                goto_next_start = {
                    ["]f"] = "@function.outer",
                    ["]c"] = "@class.outer",
                },
                goto_next_end = {
                    ["]F"] = "@function.outer",
                    ["]C"] = "@class.outer",
                },
                goto_previous_start = {
                    ["[f"] = "@function.outer",
                    ["[c"] = "@class.outer",
                },
                goto_previous_end = {
                    ["[F"] = "@function.outer",
                    ["[C"] = "@class.outer",
                },
                goto_next = {
                    ["]a"] = "@parameter.outer",
                    ["]o"] = "@loop.inner",
                    ["]i"] = "@conditional.inner",
                },
                goto_previous = {
                    ["[a"] = "@parameter.outer",
                    ["[o"] = "@loop.inner",
                    ["[i"] = "@conditional.inner",
                },
            },
            swap = {
                enable = true,
                swap_next = {
                    ["<leader>sa"] = "@parameter.inner",
                    ["<leader>sf"] = "@function.outer",
                },
                swap_previous = {
                    ["<leader>sA"] = "@parameter.inner",
                    ["<leader>sF"] = "@function.outer",
                },
            },
        },
    })
end

return M

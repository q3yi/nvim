-- Configurate auto completion framework
---@diagnostic disable: missing-fields

vim.opt.completeopt = { "menu", "menuone", "noselect" }
vim.opt.shortmess:append("c")

local M = {
    "saghen/blink.cmp",
    event = { "InsertEnter" },
    dependencies = { "rafamadriz/friendly-snippets" },
    version = "1.*",

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
        keymap = {
            preset = "none",
            ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
            ["<C-e>"] = { "hide" },
            ["<C-y>"] = { "select_and_accept" },

            ["<C-p>"] = { "select_prev", "fallback_to_mappings" },
            ["<C-n>"] = { "select_next", "fallback_to_mappings" },

            ["<C-b>"] = { "scroll_documentation_up", "fallback" },
            ["<C-f>"] = { "scroll_documentation_down", "fallback" },

            ["<C-k>"] = { "show_signature", "hide_signature", "fallback" },

            ["<M-]>"] = { "snippet_forward" },
            ["<M-[>"] = { "snippet_backward" },
        },
        appearance = {
            nerd_font_variant = "mono",
        },

        completion = { documentation = { auto_show = false } },

        sources = {
            default = { "lsp", "path", "snippets", "buffer" },
        },

        fuzzy = { implementation = "prefer_rust_with_warning" },

        signature = {
            enabled = true,
            window = {
                show_documentation = false,
            },
        },
    },
    opts_extend = { "sources.default" },
}

return M

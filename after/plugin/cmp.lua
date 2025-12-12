-- Configurate auto completion framework
---@diagnostic disable: missing-fields

function init()
    require("blink.cmp").setup {
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

        completion = {
            menu = { border = "none" },
            documentation = {
                window = { border = "none" },
                auto_show = false,
            },
        },

        sources = {
            default = { "lsp", "path", "snippets", "buffer" },
        },

        fuzzy = { implementation = "prefer_rust_with_warning" },

        signature = {
            enabled = true,
            window = {
                border = "none",
                show_documentation = false,
            },
        },
    } ---@as blink.cmp.Config
end

local cmp_init_augroup = vim.api.nvim_create_augroup("init.cmp", {})
vim.api.nvim_create_autocmd("InsertEnter", {
    group = cmp_init_augroup,
    once = true,
    callback = init
})

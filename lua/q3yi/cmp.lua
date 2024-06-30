-- Configurate auto completion framework
---@diagnostic disable: missing-fields

vim.opt.completeopt = { "menu", "menuone", "noselect" }
vim.opt.shortmess:append("c")

local M = {
    "hrsh7th/nvim-cmp",
    event = { "InsertEnter" },
    dependencies = {
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",

        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
        "rafamadriz/friendly-snippets",
    },
}

function M.config()
    local cmp = require("cmp")
    local luasnip = require("luasnip")
    -- load friendly snippets
    require("luasnip.loaders.from_vscode").lazy_load()
    -- load personal snippets
    require("luasnip.loaders.from_lua").lazy_load({ paths = { "./lua-snippets/" } })

    luasnip.config.setup({
        update_events = { "TextChanged", "TextChangedI" },
    })

    vim.keymap.set({ "i", "s" }, "<M-]>", function()
        if luasnip.expand_or_locally_jumpable() then
            luasnip.expand_or_jump()
        end
    end, { noremap = true, silent = true })

    vim.keymap.set({ "i", "s" }, "<M-[>", function()
        luasnip.jump(-1)
    end, { noremap = true, silent = true })

    cmp.setup({
        snippet = {
            expand = function(args)
                luasnip.lsp_expand(args.body)
            end,
        },
        mapping = cmp.mapping.preset.insert({
            ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
            ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
            ["<C-y>"] = cmp.mapping.confirm({ behavior = cmp.SelectBehavior.Insert, select = true }),
            ["<C-u>"] = cmp.mapping.scroll_docs(-4),
            ["<C-d>"] = cmp.mapping.scroll_docs(4),
        }),
        sources = {
            { name = "nvim_lsp" },
            { name = "luasnip" },
            { name = "buffer", keyword_length = 3 },
            { name = "path" },
        },
    })
end

return M

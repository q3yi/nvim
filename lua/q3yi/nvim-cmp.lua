-- Configurate auto completion framework
---@diagnostic disable: missing-fields

local NvimCmp = {
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

local cmp_sources = {
    nvim_lsp = "[LSP]",
    luasnip = "[Snip]",
    buffer = "[Buf]",
    path = "[Path]",
}

function NvimCmp.config()
    local cmp = require("cmp")
    local luasnip = require("luasnip")
    -- load friendly snippets
    require("luasnip.loaders.from_vscode").lazy_load()
    -- load personal snippets
    require("luasnip.loaders.from_lua").lazy_load({ paths = { "./lua-snippets/" } })

    luasnip.config.setup {
        update_events = { "TextChanged", "TextChangedI" }
    }

    vim.keymap.set({ "i", "s" }, "<M-]>", function()
        if luasnip.expand_or_locally_jumpable() then
            luasnip.expand_or_jump()
        end
    end, { noremap = true, silent = true })

    vim.keymap.set({ "i", "s" }, "<M-[>", function()
        luasnip.jump(-1)
    end, { noremap = true, silent = true })

    cmp.setup {
        snippet = {
            expand = function(args)
                luasnip.lsp_expand(args.body)
            end,
        },
        window = {
            -- completion = cmp.config.window.bordered({ border = "single" }),
            -- documentation = cmp.config.window.bordered({ border = "single"}),
        },
        mapping = cmp.mapping.preset.insert {
            ["<C-n>"] = cmp.mapping.select_next_item(),
            ["<C-p>"] = cmp.mapping.select_prev_item(),
            ["<C-u>"] = cmp.mapping.scroll_docs(-4),
            ["<C-d>"] = cmp.mapping.scroll_docs(4),
            ["<C-e>"] = cmp.mapping.abort(),
            ["<CR>"] = cmp.mapping.confirm { select = true },
            ["<Tab>"] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    if #cmp.get_entries() == 1 then
                        cmp.confirm({ select = true })
                    else
                        cmp.select_next_item()
                    end
                elseif luasnip.expandable() then
                    luasnip.expand()
                else
                    fallback()
                end
            end, { "i", "s" }),
            ["<S-Tab>"] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_prev_item()
                else
                    fallback()
                end
            end, { "i", "s" }),
        },
        formatting = {
            expandable_indicator = true,
            fields = { "abbr", "kind", "menu" },
            format = function(entry, vim_item)
                vim_item.menu = cmp_sources[entry.source.name]
                return vim_item
            end,
        },
        sources = {
            { name = "nvim_lsp" },
            { name = "luasnip" },
            { name = "buffer",  keyword_length = 3 },
            { name = "path" }
        },
    }
end

return NvimCmp

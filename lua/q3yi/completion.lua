-- Configurate auto completion framework

local NvimCmp = {
    "hrsh7th/nvim-cmp",
    event = { "InsertEnter", "CmdlineEnter" },
    dependencies = {
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",

        -- Snippet Engine & its associated nvim-cmp source
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",

        "rafamadriz/friendly-snippets",
    },
}

--[[ local kind_icons = {
    Text = "󰀬",
    Method = "󰆧",
    Function = "󰊕",
    Constructor = "",
    Field = "",
    Variable = "",
    Class = "",
    Interface = "",
    Module = "󰅩",
    Property = "",
    Unit = "",
    Value = "󰎠",
    Enum = "",
    Keyword = "",
    Snippet = "",
    Color = "",
    File = "",
    Reference = "",
    Folder = "",
    EnumMember = "",
    Constant = "󰏿",
    Struct = "",
    Event = "",
    Operator = "󰆕",
    TypeParameter = "",
    Misc = "",
} ]]

local cmp_sources = {
    nvim_lsp = "[LSP]",
    luasnip = "[Snip]",
    buffer = "[Buf]",
    path = "[Path]",
}

function NvimCmp.config()
    -- See `:help cmp`
    local cmp = require("cmp")
    local luasnip = require("luasnip")
    require("luasnip.loaders.from_vscode").lazy_load()
    luasnip.config.setup {}

    cmp.setup {
        snippet = {
            expand = function(args)
                luasnip.lsp_expand(args.body)
            end,
        },
        window = {
            completion = cmp.config.window.bordered(),
            documentation = cmp.config.window.bordered(),
        },
        mapping = cmp.mapping.preset.insert {
            ["<C-n>"] = cmp.mapping.select_next_item(),
            ["<C-p>"] = cmp.mapping.select_prev_item(),
            ["<C-d>"] = cmp.mapping.scroll_docs(-4),
            ["<C-f>"] = cmp.mapping.scroll_docs(4),
            ["<C-e>"] = cmp.mapping.abort(),
            ["<CR>"] = cmp.mapping.confirm {
                behavior = cmp.ConfirmBehavior.Replace,
                select = true,
            },
            ["<Tab>"] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    if #cmp.get_entries() == 1 then
                        cmp.confirm({ select = true })
                    else
                        cmp.select_next_item()
                    end
                elseif luasnip.expandable() then
                    luasnip.expand()
                elseif luasnip.expand_or_jumpable() then
                    luasnip.expand_or_jump()
                else
                    fallback()
                end
            end, { "i", "s" }),
            ["<S-Tab>"] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_prev_item()
                elseif luasnip.jumpable(-1) then
                    luasnip.jump(-1)
                else
                    fallback()
                end
            end, { "i", "s" }),
        },
        formatting = {
            expandable_indicator = true,
            fields = { "abbr", "kind", "menu" },
            format = function(entry, vim_item)
                -- vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
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

-- Add linter and formattor for some language that does not have lsp

local M = {
    "nvimtools/none-ls.nvim",
    event = { "VeryLazy" },
}

function M.config()
    local none_ls = require("null-ls")

    none_ls.setup({
        sources = {
            -- diagnostics
            none_ls.builtins.diagnostics.fish,
            none_ls.builtins.diagnostics.markdownlint_cli2,
        },
        on_attach = function(client, _)
            if not client.supports_method("textDocument/formatting") then
                return
            end

            vim.keymap.set({ "n" }, "<leader>lf", function()
                vim.lsp.buf.format({ async = true })
            end, {
                noremap = true,
                silent = true,
                desc = "Null-ls: Format current buffer",
            })
        end,
    })
end

return M

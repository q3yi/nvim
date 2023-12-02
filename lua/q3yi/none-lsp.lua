-- Add linter and formattor for some language that does not have lsp

local M = {
    "nvimtools/none-ls.nvim",
    event = { "VeryLazy" },
}

function M.config()
    local none_ls = require("null-ls")

    none_ls.setup {
        sources = {
            -- diagnostics
            none_ls.builtins.diagnostics.fish,
            none_ls.builtins.diagnostics.markdownlint_cli2,
            -- formattor
            none_ls.builtins.formatting.fish_indent,
            none_ls.builtins.formatting.forge_fmt,
            none_ls.builtins.formatting.yamlfmt,
            none_ls.builtins.formatting.prettier,
        },
        on_attach = function(client, _)
            if client.supports_method("textDocument/formatting") then
                vim.keymap.set("n", "<leader>lf", function()
                        vim.lsp.buf.format { async = true }
                    end,
                    { noremap = true, silent = true, desc = "Null-ls: Format current buffer" })
            end
        end
    }
end

return M

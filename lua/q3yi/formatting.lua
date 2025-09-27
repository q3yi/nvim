-- config formatter

local M = {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    opts = {
        formatters_by_ft = {
            lua = { "stylua" },
            javascript = { "biome" },
            javascriptreact = { "biome" },
            typescript = { "biome" },
            typescriptreact = { "biome" },
            css = { "biome" },
            html = { "biome" },
            json = { "biome" },
            jsonc = { "biome" },
            yaml = { "yq" },
            fish = { "fish_indent" },
            ocaml = { "ocamlformat" },
            toml = { "tombi" },
            solidity = { "forge_fmt" },
            markdown = { "markdownlint-cli2" },
        },
        format_on_save = function(buf)
            if vim.g.disable_autoformat or vim.b[buf].disable_autoformat then
                return
            end
            return { timeout_ms = 500, lsp_format = "fallback" }
        end,
    },
}

M.init = function()
    vim.keymap.set({ "n", "v" }, "<leader>bf", function()
        require("conform").format({
            timeout_ms = 500,
            lsp_format = "fallback",
        }, function(err)
            if err then
                vim.notify("format error: " .. err, vim.log.levels.WARN)
                return
            end
        end)
    end, { desc = "Format current buffer" })
end

return M

-- config formatter

local M = {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ToggleAutoFormat", "ConformInfo" },
}

M.config = function()
    require("conform").setup({
        formatters_by_ft = {
            lua = { "stylua" },
            javascript = { "prettier" },
            javascriptreact = { "prettier" },
            typescript = { "prettier" },
            typescriptreact = { "prettier" },
            css = { "prettier" },
            html = { "prettier" },
            json = { "prettier" },
            yaml = { "prettier" },
            fish = { "fish_ident" },
            ocaml = { "ocamlformat" },
            toml = { "taplo" },
            solidity = { "forge_fmt" },
            markdown = { "markdownlint-cli2" },
        },
        format_on_save = function(buf)
            if vim.g.disable_autoformat or vim.b[buf].disable_autoformat then
                return
            end
            return { timeout_ms = 500, lsp_format = "fallback" }
        end,
    })
end

M.init = function()
    vim.api.nvim_create_user_command("ToggleAutoFormat", function(args)
        if vim.g.disable_autoformat or vim.b.disable_autoformat then
            vim.g.disable_autoformat = false
            vim.b.disable_autoformat = false
            vim.notify("auto format enabled.", vim.log.levels.INFO)
        elseif args.bang then
            vim.b.disable_autoformat = true
            vim.notify("auto format disabled in this buffer.", vim.log.levels.INFO)
        else
            vim.g.disable_autoformat = true
            vim.notify("auto format disabled globally.", vim.log.levels.INFO)
        end
    end, {
        desc = "Toggle auto format on save.",
        bang = true,
    })

    vim.keymap.set({ "n", "v" }, "<leader>uf", "<cmd>ToggleAutoFormat<cr>", { desc = "Toggle auto format" })

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

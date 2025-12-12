-- config formatter

local state = {
    format_on_save = true,
    initialized = false,
}

local function conform()
    local pkg = require("conform")

    if state.initialized then
        return pkg
    end

    pkg.setup {
        formatters_by_ft = {
            css = { "dprint" },
            fish = { "fish_indent" },
            html = { "dprint" },
            javascript = { "dprint" },
            javascriptreact = { "dprint" },
            jsonc = { "dprint" },
            json = { "dprint" },
            markdown = { "dprint" },
            ocaml = { "ocamlformat" },
            python = { "dprint" },
            solidity = { "forge_fmt" },
            toml = { "dprint" },
            typescript = { "dprint" },
            typescriptreact = { "dprint" },
            xml = { "yq_xml" },
            yaml = { "dprint" },
        },
        formatters = {
            yq_xml = {
                command = "yq",
                args = { "-p=xml", "-o=xml" },
                stdin = true,
            },
        },
        format_on_save = function(_buf)
            if not state.format_on_save then
                return
            end
            return { timeout_ms = 500, lsp_format = "fallback" }
        end,
    } ---@as conform.setupOpts

    state.initialized = true
    return pkg
end

local conform_init_augroup = vim.api.nvim_create_augroup("init.conform", {})

vim.api.nvim_create_autocmd("InsertEnter", {
    group = conform_init_augroup,
    once = true,
    callback = function() _ = conform() end,
})

vim.api.nvim_create_user_command("AutoFormat", function(param)
    state.format_on_save = not param.bang
    if state.format_on_save then
        vim.notify("Format on save enabled", vim.log.levels.INFO)
    else
        vim.notify("Format on save disabled", vim.log.levels.WARN)
    end
end, { desc = "Format on save", bang = true })

vim.api.nvim_create_user_command("Format", function()
    local formatter = conform()
    formatter.format({
        timeout_ms = 500,
        lsp_format = "fallback",
    }, function(err)
        if err then
            vim.notify("format error: " .. err, vim.log.levels.WARN)
            return
        end
    end)
end, { desc = "Format current buffer" })

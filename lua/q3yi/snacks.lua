-- config snacks

local M = {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
        notifier = { enabled = true },
        toggle = { icon = { enabled = "✓", disabled = "✗" } },
        styles = {
            notification = { border = "single" },
            notification_history = { border = "single" },
        },
    },
}

---@param toggle snacks.toggle
local function register_toggles(toggle)
    toggle.indent():map("<leader>ug")
    toggle.diagnostics():map("<leader>ud")

    toggle.option("background", { off = "light", on = "dark", name = "dark background" }):map("<leader>ub")
    toggle.option("list", { name = "whitespace chars" }):map("<leader>uw")
    toggle.option("wrap", { name = "line wrap" }):map("<leader>ur")
    toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>uL")
    toggle.line_number():map("<leader>ul")
    toggle({
        id = "colorcolumn",
        name = "color column",
        get = function()
            local col = vim.opt.colorcolumn:get()
            if #col > 0 then
                return true
            else
                return false
            end
        end,
        set = function(state)
            if state then
                vim.opt.colorcolumn = { 80, 120 }
            else
                vim.opt.colorcolumn = {}
            end
        end,
    }, nil):map("<leader>uc")

    toggle({
        id = "diagnostic_virtual_text",
        name = "diagnostic virtual text",
        get = function()
            return vim.g.diagnostic_show_virtual_text
        end,
        set = function(state)
            vim.g.diagnostic_show_virtual_text = state
        end,
    }):map("<leader>uD")
end

M.config = function()
    local snacks = require("snacks")
    snacks.setup(M.opts)

    vim.keymap.set("n", "<leader>gs", function()
        snacks.lazygit.open()
    end, { desc = "Open lazygit" })

    vim.keymap.set("n", "<leader>gL", function()
        snacks.picker.git_log_line()
    end, { desc = "Git Log Line" })

    vim.keymap.set({ "n", "v" }, "<leader>t", function()
        snacks.terminal.toggle()
    end, { desc = "Open terminal" })

    vim.keymap.set({ "n", "v" }, "<leader>br", function()
        snacks.rename.rename_file()
    end, { desc = "Rename buffer file" })

    register_toggles(snacks.toggle)

    vim.api.nvim_create_user_command("NotifyHistory", function()
        snacks.notifier.show_history()
    end, { desc = "Show notification history" })
end

M.init = function()
    -- create lsp progress
    vim.api.nvim_create_autocmd("LspProgress", {
        ---@param ev {data: {client_id: integer, params: lsp.ProgressParams}}
        callback = function(ev)
            local spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
            vim.notify(vim.lsp.status(), "info", {
                id = "lsp_progress",
                title = "LSP Progress",
                opts = function(notif)
                    notif.icon = ev.data.params.value.kind == "end" and " "
                        or spinner[math.floor(vim.uv.hrtime() / (1e6 * 80)) % #spinner + 1]
                end,
            })
        end,
    })
end

return M

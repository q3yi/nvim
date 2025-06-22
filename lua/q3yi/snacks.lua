-- config snacks

local M = {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
        notifier = { enabled = true },
        toggle = { icon = { enabled = "✓", disabled = "✗" } },
        zen = {},
        scope = { enabled = true },
        styles = {
            notification = { border = "single" },
            notification_history = { border = "single" },
        },
    },
    keys = {
        { "<leader>gs", "<cmd>Snacks git<cr>", desc = "Open lazy git" },
        { "<leader>gL", "<cmd>Snacks git_log<cr>", desc = "Open lazy git log" },
        { "<f12>", "<cmd>Snacks terminal<cr>", desc = "Toggle floating terminal", mode = { "n", "v", "t" } },
        { "<c-`>", "<cmd>Snacks terminal<cr>", desc = "Toggle floating terminal", mode = { "n", "v", "t" } },
        { "<leader>br", "<cmd>Snacks rename_file<cr>", desc = "Rename buffer file" },
    },
}

---@param toggle snacks.toggle
local function register_toggles(toggle)
    toggle.indent():map("<leader>ug")
    toggle.diagnostics():map("<leader>ud")
    toggle.zen():map("<leader>uz")
    toggle.zoom():map("<leader>uZ")

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

    register_toggles(snacks.toggle)
end

local cmds = {
    git = function()
        require("snacks").lazygit.open()
    end,
    git_log = function()
        require("snacks").lazygit.log()
    end,
    terminal = function()
        require("snacks").terminal.toggle(nil, {
            win = {
                border = "single",
                position = "float",
                wo = { winhighlight = "FloatBorder:NormalFloat" },
            },
        })
    end,
    rename_file = function()
        require("snacks").rename.rename_file()
    end,
    notify_history = function()
        require("snacks").notifier.show_history()
    end,
    notify_hide = function()
        require("snacks").notifier.hide()
    end,
    undo = function()
        require("snacks").picker.undo()
    end,
}

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

    vim.api.nvim_create_user_command("Snacks", function(args)
        if #args.fargs < 1 then
            return
        end

        local f = cmds[args.fargs[1]]
        if f ~= nil then
            f()
        end
    end, {
        nargs = "*",
        complete = function(_, line)
            local commands = vim.tbl_keys(cmds)
            local l = vim.split(line, "%s+")
            table.sort(commands)
            return vim.tbl_filter(function(val)
                return vim.startswith(val, l[2])
            end, commands)
        end,
    })
end

return M

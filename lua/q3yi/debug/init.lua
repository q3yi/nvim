-- Config debugger

local M = {
    ui_opened = false,
    already_setup = false,
}

function M.setup()
    local dap = require("dap")
    dap.adapters = require("q3yi.debug.adapters")
    dap.configurations = require("q3yi.debug.configurations")

    local sign_define = vim.fn.sign_define
    sign_define("DapBreakpoint", { text = "●", texthl = "DapBreak", numhl = "DapBreak" })
    sign_define("DapBreakpointCondition", { text = "⊜", texthl = "DapBreak", numhl = "DapBreak" })
    sign_define("DapBreakpointRejected", { text = "⊘", texthl = "DapBreak", numhl = "DapBreak" })
    sign_define("DapLogPoint", { text = "◆", texthl = "DapBreak", numhl = "DapBreak" })
    sign_define("DapStopped", { text = "⭔", texthl = "DapStop", numhl = "DapStop" })

    require("dapui").setup()

    M.already_setup = true
end

function M.open_debugger_ui()
    local dap = require("dap")

    vim.keymap.set("n", "<F3>", dap.continue, { desc = "Debugger: Start/Continue" })
    vim.keymap.set("n", "<F4>", dap.run_to_cursor, { desc = "Debugger: Run to cursor" })
    vim.keymap.set("n", "<F5>", dap.step_over, { desc = "Debugger: Step over" })
    vim.keymap.set("n", "<F6>", dap.step_into, { desc = "Debugger: Step into" })
    vim.keymap.set("n", "<F7>", dap.step_out, { desc = "Debugger: Step out" })
    vim.keymap.set("n", "<F11>", dap.restart, { desc = "Debugger: Restart" })

    require("dapui").open()

    M.ui_opened = true
end

function M.close_debugger_ui()
    M.ui_opened = false

    vim.keymap.del("n", "<F3>")
    vim.keymap.del("n", "<F4>")
    vim.keymap.del("n", "<F5>")
    vim.keymap.del("n", "<F6>")
    vim.keymap.del("n", "<F7>")
    vim.keymap.del("n", "<F11>")

    require("dapui").close()
end

function M.toggle_debugger()
    if M.ui_opened then
        M.close_debugger_ui()
        return
    end

    if not M.already_setup then
        M.setup()
    end

    local dap = require("dap")
    local filetype = vim.bo.filetype
    if dap.configurations[filetype] == nil then
        vim.notify("No debugger for filetype: " .. filetype, vim.log.levels.WARN)
        return
    end

    M.open_debugger_ui()
end

function M.add_debug_profile()
    local filetype = vim.bo.filetype
    local providers = require("q3yi.debug.providers")

    if providers[filetype] == nil then
        vim.notify("No provider found for filetype: " .. filetype, vim.log.levels.WARN)
        return
    end

    local configuration = providers[filetype]()
    if configuration == nil then
        vim.notify("Empty configuration, ignored", vim.log.levels.WARN)
        return
    end

    local dap = require("dap")
    if dap.configurations[filetype] ~= nil then
        table.insert(dap.configurations[filetype], configuration)
    else
        dap.configurations[filetype] = { configuration }
    end

    vim.notify("New debug configuration added.", vim.log.levels.INFO)
end

function M.init()
    vim.api.nvim_create_user_command("Debugger", function() M.toggle_debugger() end, { desc = "Toggle debugger" })

    vim.keymap.set("n", "<Leader>dd", M.toggle_debugger, { desc = "Toggle debugger " })
    vim.keymap.set("n", "<Leader>db", function() require("dap").toggle_breakpoint() end, { desc = "Toggle breakpoint" })
    vim.keymap.set("n", "<Leader>dB", function()
        require("dap").toggle_breakpoint(vim.fn.input("Breakpoint condition: "))
    end, { desc = "Toggle condtional breakpoint" })
    vim.keymap.set("n", "<Leader>dp", M.add_debug_profile, { desc = "Add debug profile" })
end

return M

-- Config debugger

local M = {
    "mfussenegger/nvim-dap",
    dependencies = {
        "rcarriga/nvim-dap-ui",
        "nvim-neotest/nvim-nio",
    },
}

function M.config()
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
end

local function enableDebugger()
    vim.g.debug_ui_enabled = true

    local dap = require("dap")
    local dapui = require("dapui")

    vim.keymap.set("n", "<F3>", dap.continue, { desc = "Debugger: Start/Continue" })
    vim.keymap.set("n", "<F4>", dap.run_to_cursor, { desc = "Debugger: Run to cursor" })
    vim.keymap.set("n", "<F5>", dap.step_over, { desc = "Debugger: Step over" })
    vim.keymap.set("n", "<F6>", dap.step_into, { desc = "Debugger: Step into" })
    vim.keymap.set("n", "<F7>", dap.step_out, { desc = "Debugger: Step out" })
    vim.keymap.set("n", "<F11>", dap.restart, { desc = "Debugger: Restart" })

    dapui.open()
end

local function disableDebugger()
    vim.g.debug_ui_enabled = false

    vim.keymap.del("n", "<F3>")
    vim.keymap.del("n", "<F4>")
    vim.keymap.del("n", "<F5>")
    vim.keymap.del("n", "<F6>")
    vim.keymap.del("n", "<F7>")
    vim.keymap.del("n", "<F11>")

    require("dapui").close()
end

local function toggleDebugger()
    if vim.g.debug_ui_enabled then
        disableDebugger()
        return
    end

    local dap = require("dap")
    local filetype = vim.bo.filetype
    if dap.configurations[filetype] == nil then
        vim.notify("No debugger for filetype: " .. filetype, vim.log.levels.WARN)
        return
    end

    enableDebugger()
end

local function addDebugConfiguration()
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
    vim.keymap.set("n", "<Leader>dd", toggleDebugger, { desc = "Toggle debugger " })
    vim.keymap.set("n", "<Leader>db", "<cmd>DapToggleBreakpoint<cr>", { desc = "Toggle breakpoint" })
    vim.keymap.set("n", "<Leader>dB", function()
        require("dap").toggle_breakpoint(vim.fn.input("Breakpoint condition: "))
    end, { desc = "Toggle condtional breakpoint" })
    vim.keymap.set("n", "<Leader>dp", addDebugConfiguration, { desc = "Add debug profile" })
end

return M

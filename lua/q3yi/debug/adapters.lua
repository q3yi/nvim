-- Dap adapters

---@type []dap.Adapter
return {
    -- golang
    delve = function(callback, config)
        if config.mode == "remote" and config.request == "attach" then
            callback({
                type = "server",
                host = config.host or "127.0.0.1",
                port = config.port or "38697",
            })
        else
            callback({
                type = "server",
                port = "${port}",
                executable = {
                    command = "dlv",
                    args = { "dap", "-l", "127.0.0.1:${port}", "--log", "--log-output=dap" },
                    detached = vim.fn.has("win32") == 0,
                },
            })
        end
    end,

    -- c, c++, rust, zig
    gdb = {
        type = "executable",
        command = "gdb",
        args = { "--quiet", "--interpreter=dap", "--eval-command", "set print pretty on" },
    },

    lldb = {
        type = "executable",
        command = "lldb-dap", -- adjust as needed, must be absolute path
        name = "lldb",
    },
}

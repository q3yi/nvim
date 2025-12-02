-- set local config for go file
vim.opt_local.expandtab = false

-- config debugger
if package.loaded["q3yi.dap"] ~= nil then
    local dap_cfg = require("q3yi.dap")
    if not dap_cfg.alreadyConfigurated("delve") then
        dap_cfg.setAdapter("delve", function(callback, config)
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
        end)
    end

    if not dap_cfg.alreadyConfigurated("go") then
        dap_cfg.addConfigurations("go", {
            {
                type = "delve",
                name = "Debug",
                request = "launch",
                program = "${file}",
            },
            {
                type = "delve",
                name = "Debug with args",
                request = "launch",
                program = "${file}",
                args = function()
                    return vim.split(vim.fn.input("Arguments: "), " +")
                end,
            },
            {
                type = "delve",
                name = "Debug test", -- configuration for debugging test files
                request = "launch",
                mode = "test",
                program = "${file}",
            },
            {
                type = "delve",
                name = "Debug test (go.mod)",
                request = "launch",
                mode = "test",
                program = "./${relativeFileDirname}",
            },
        })

        dap_cfg.setDebugProfileCreator("go", function()
            local input_args = vim.split(vim.fn.input("Program: ", vim.fn.getcwd(), "file"), " +")
            local cmd = input_args[1]
            local args = {}
            if #input_args ~= 1 then
                args = { unpack(input_args, 2, #input_args) }
            end

            return {
                type = "delve",
                name = "Debug " .. vim.fs.basename(cmd),
                request = "launch",
                program = cmd,
                args = args,
            }
        end)
    end
end

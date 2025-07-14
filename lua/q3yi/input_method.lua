-- Switch to english keyboard when leave inert mode

local FcitxStatus = {
    CLOSE = 0,
    INACTIVE = 1,
    ACTIVE = 2,
}

local Fcitx = {
    status = FcitxStatus.CLOSE,
    notify = false,
}

function Fcitx.enter_insert()
    if Fcitx.status ~= FcitxStatus.ACTIVE then
        return
    end

    vim.system({ "fcitx5-remote", "-o" }, { text = true }, function()
        if not Fcitx.notify then
            return
        end
        vim.notify("Enable Chinese input method.")
    end)
end

function Fcitx.leave_insert()
    vim.system({ "fcitx5-remote" }, { text = true }, function(obj)
        Fcitx.status = tonumber(obj.stdout)
        if Fcitx.status ~= FcitxStatus.ACTIVE then
            return
        end

        vim.system({ "fcitx5-remote", "-c" }, { text = true }, function()
            if not Fcitx.notify then
                return
            end
            vim.notify("Disable Chinese input method.")
        end)
    end)
end

function Fcitx.setup(opt)
    if opt.enable_notify then
        Fcitx.notify = true
    end

    local group = vim.api.nvim_create_augroup("fcitx_augroup", { clear = true })
    vim.api.nvim_create_autocmd("InsertEnter", { callback = Fcitx.enter_insert, group = group })
    vim.api.nvim_create_autocmd("InsertLeave", { callback = Fcitx.leave_insert, group = group })
end

local sysname = vim.uv.os_uname().sysname

if sysname == "Linux" then
    Fcitx.setup({ enable_notify = false })
end

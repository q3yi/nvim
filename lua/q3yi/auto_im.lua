-- Auto toggle chinese input method when enter and leave inert mode
vim.g.auto_im_enabled = true

local AutoIM = {
    active = false,
    notify = false,

    current_im_cmd = nil,
    enable_im_cmd = nil,
    disable_im_cmd = nil,
    is_active = nil,
}

function AutoIM.leave_insert()
    if not vim.g.auto_im_enabled then
        return
    end

    vim.system(AutoIM.current_im_cmd, { text = true }, function(obj)
        AutoIM.active = AutoIM.is_active(obj)
        if not AutoIM.active then
            return
        end

        vim.system(AutoIM.disable_im_cmd, { text = true }, function()
            if not AutoIM.notify then
                return
            end
            vim.notify("Disable Chinese input method.")
        end)
    end)
end

function AutoIM.enter_insert()
    if not vim.g.auto_im_enabled or not AutoIM.active then
        return
    end

    vim.system(AutoIM.enable_im_cmd, { text = true }, function()
        if not AutoIM.notify then
            return
        end
        vim.notify("Enable Chinese input method.")
    end)
end

function AutoIM.setup(opts)
    AutoIM.notify = opts.enable_notify or false
    AutoIM.current_im_cmd = opts.current_im_cmd
    AutoIM.enable_im_cmd = opts.enable_im_cmd
    AutoIM.disable_im_cmd = opts.disable_im_cmd
    AutoIM.is_active = opts.is_active

    if
        AutoIM.current_im_cmd == nil
        or AutoIM.disable_im_cmd == nil
        or AutoIM.enable_im_cmd == nil
        or AutoIM.is_active == nil
    then
        vim.notify("Setup auto IM fail. missing option.", vim.log.levels.ERROR)
        return
    end

    local group = vim.api.nvim_create_augroup("im_augroup", { clear = true })
    vim.api.nvim_create_autocmd("InsertEnter", { callback = AutoIM.enter_insert, group = group })
    vim.api.nvim_create_autocmd("InsertLeave", { callback = AutoIM.leave_insert, group = group })
end

local sysname = vim.uv.os_uname().sysname

if sysname == "Linux" then
    local opts = {
        enable_notify = false,
        current_im_cmd = { "fcitx5-remote" },
        enable_im_cmd = { "fcitx5-remote", "-o" },
        disable_im_cmd = { "fcitx5-remote", "-c" },
        is_active = function(obj)
            return tonumber(obj.stdout) == 2 -- 0:Close, 1:Inactive, 2:Active
        end,
    }
    AutoIM.setup(opts)
end

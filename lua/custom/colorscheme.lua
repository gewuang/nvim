-- vim.cmd [[colorscheme nightfox]]

local colorscheme = "nightfox"

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)

if not status_ok then
    -- 发送消息通知
    vim.notify("colorscheme " .. colorscheme .. " not found!")
    return
end

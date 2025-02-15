game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "通知",
    Text = "加入这个云脚本QQ群！\n感谢您的支持！🎉",
    Duration = 20,
    Button1Text = "复制QQ群号",
    Button2Text = "关闭通知",
    Callback = function(Button)
        if Button == "Button1" then
            setclipboard("444161131")
        end
    end
})
game.StarterGui:SetCore("SendNotification", {
    Title = "通知",
    Text = "正在加载，稍等",
    Icon = "rbxassetid://6031302918",
    Duration = 14.4
})
loadstring(game:HttpGet("https://raw.githubusercontent.com/XiaoYunCN/VIP/6fd47d2716b6a6eade78d80063401c7cfd300b39/%E4%BA%91%E8%84%9A%E6%9C%AC/UNIVERSAL%20VERSION.LUA", true))()
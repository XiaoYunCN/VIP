    local OrionLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/XiaoYunCN/LOL/main/Orion.lua", true))()
    
    local function Notification()
    OrionLib:MakeNotification({
    	Name = "云脚本",
    	Content = "点击成功，请稍候..."",
    	Image = "rbxassetid://4483345998",
    	Time = 5
    })
    end

    local Window = OrionLib:MakeWindow({
        Name = "云脚本", 
        HidePremium = false, 
        SaveConfig = false, 
        ConfigFolder = "rbxassetid://6015897843", 
        IntroEnabled = false
    })

    local KookTab = Window:MakeTab({
        Name = "内容",
        Icon = "rbxassetid://4483345998",
        PremiumOnly = false
    })

    KookTab:AddParagraph("公告", "云脚本已移除验证群组，每个人不会加入群组💀")
    KookTab:AddButton({
        Name = "云脚本-通用|超功能多",
        Callback = function()
            Notification()
            loadstring(game:HttpGet("https://github.com/XiaoYunUwU/XiaoYunUwU/raw/main/Yun%20Script%2FPaid%20edition.lua", true))()
        end    
    })

    KookTab:AddButton({
        Name = "云脚本|吃掉世界",
        Callback = function()
            Notification()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/XiaoYunCN/VIP/refs/heads/main/Eat%20the%20World.lua", true))()
        end    
    })

    KookTab:AddButton({
        Name = "云脚本|力量传奇",
        Callback = function()
            Notification()
            loadstring(game:HttpGet("https://github.com/XiaoYunCN/VIP/raw/main/%E5%8A%9B%E9%87%8F%E4%BC%A0%E5%A5%87.lua", true))()
        end    
    })

    KookTab:AddButton({
        Name = "云脚本|极速传奇",
        Callback = function()
            Notification()
            loadstring(game:HttpGet("https://github.com/XiaoYunCN/VIP/raw/main/%E6%9E%81%E9%80%9F%E4%BC%A0%E5%A5%87.lua", true))()
        end    
    })

    KookTab:AddParagraph("内容", "如有问题，请加入↓\n请加入云脚本交流③QQ群号1014408755\n加入这个Discord云脚本频道！ 需要VPN打开！感谢您的支持！🎉")
    KookTab:AddButton({
        Name = "复制云脚本Discord链接",
        Callback = function()
            setclipboard("https://discord.gg/BuZwECkFCR")
        end    
    })
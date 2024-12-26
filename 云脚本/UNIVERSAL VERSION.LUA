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

    local Tab = Window:MakeTab({
        Name = "内容",
        Icon = "rbxassetid://4483345998",
        PremiumOnly = false
    })

    Tab:AddLabel("一点击就好，请勿重复点击云脚本")
    Tab:AddButton({
        Name = "云脚本-通用|超功能多",
        Callback = function()
            Notification()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/XiaoYunCN/VIP/6fd47d2716b6a6eade78d80063401c7cfd300b39/%E4%BA%91%E8%84%9A%E6%9C%AC/UNIVERSAL%20VERSION.LUA", true))()
        end    
    })

    Tab:AddButton({
        Name = "云脚本|吃掉世界",
        Callback = function()
            Notification()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/XiaoYunCN/VIP/refs/heads/main/Eat%20the%20World.lua", true))()
        end    
    })

    Tab:AddButton({
        Name = "云脚本|力量传奇",
        Callback = function()
            Notification()
            loadstring(game:HttpGet("https://github.com/XiaoYunCN/VIP/raw/main/%E5%8A%9B%E9%87%8F%E4%BC%A0%E5%A5%87.lua", true))()
        end    
    })

    Tab:AddButton({
        Name = "云脚本|极速传奇",
        Callback = function()
            Notification()
            loadstring(game:HttpGet("https://github.com/XiaoYunCN/VIP/raw/main/%E6%9E%81%E9%80%9F%E4%BC%A0%E5%A5%87.lua", true))()
        end    
    })

    Tab:AddParagraph("公告", "云脚本已移除验证群组，每个人不会加入群组💀")
    Tab:AddParagraph("内容", "如有问题，请加入↓\n请加入云脚本交流③QQ群号1014408755\n加入这个Discord云脚本频道！ 需要VPN打开！感谢您的支持！🎉")
    Tab:AddButton({
        Name = "复制云脚本Discord链接",
        Callback = function()
            setclipboard("https://discord.gg/BuZwECkFCR")
        end    
    })
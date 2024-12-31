    local OrionLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/XiaoYunCN/LOL/main/Orion.lua", true))()
    
    function Notification()
    OrionLib:MakeNotification({
    	Name = "云脚本",
    	Content = "点击成功，请稍候...",
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
    
    local FuckTab = Window:MakeTab({
        Name = "出生",
        Icon = "rbxassetid://4483345998",
        PremiumOnly = false
    })
    FuckTab:AddParagraph("黑名单人员", "QQ3589992404\n\n原因：发截图（被封禁6个月），他说‘新年喜提6个月，都别用忍者了兄弟们，再用忍者把你们坤坤打烂’，并提到封禁原因是外挂😂，没说黑r。我说了一句😂，然后他开始骂我，最后活该被踢😂。")
    KookTab:AddParagraph("公告", "云脚本已移除验证群组，每个人不会加入群组💀。\n\n云脚本全部通用无BUG，没问题")
    KookTab:AddParagraph("更新内容", "12月28日\n修复：瞄准部位\n增加：🦌管脚本【FE脚本】\n已换通知ui")
    KookTab:AddParagraph("联系", "QQ大号：168777105（\nQQ老号：3065560594\nDC小号：athenalol_5212\nDC大号：hahadlongat")
    KookTab:AddButton({
        Name = "云脚本-通用|超功能多",
        Callback = function()
            Notification()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/XiaoYunCN/VIP/6fd47d2716b6a6eade78d80063401c7cfd300b39/%E4%BA%91%E8%84%9A%E6%9C%AC/UNIVERSAL%20VERSION.LUA", true))()
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

    KookTab:AddParagraph("内容", "如有问题，请加入↓\n请加入云脚本交流①QQ群号296846962\n加入这个Discord云脚本频道！ 需要VPN打开！感谢您的支持！🎉")
    KookTab:AddButton({
        Name = "复制云脚本Discord链接",
        Callback = function()
            setclipboard("https://discord.gg/BuZwECkFCR")
        end    
    })
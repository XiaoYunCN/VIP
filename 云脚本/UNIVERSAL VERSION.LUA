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
        Name = "死畜生",
        Icon = "rbxassetid://4483345998",
        PremiumOnly = false
    })
    
    
    FuckTab:AddLabel("这个小学生装逼骂死我，QQ3589992404，都给我去骂他😡永久黑名单")
    FuckTab:AddParagraph("原因", "发截图（被封禁6个月），他说‘新年喜提6个月，都别用忍者了兄弟们，再用忍者把你们坤坤打烂’，并提到封禁原因是外挂😂，没说黑r。我说了一句😂，然后他开始骂我，最后活该被踢😂。")
    FuckTab:AddParagraph("信息", "QQ号：3589992404\nQQ邮箱：3589992404@qq.com\nQQ名称：東山紅.")
    KookTab:AddParagraph("公告", "云脚本已移除验证群组，每个人不会加入群组💀。\n\n云脚本全部通用无BUG，没问题")
    KookTab:AddParagraph("更新内容", "云脚本通用新增：相机模式、遮挡效果、相机类型\n已更新！！")
    KookTab:AddButton({
        Name = "云脚本-通用|超多功能",
        Callback = function()
            Notification()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/XiaoYunCN/VIP/6fd47d2716b6a6eade78d80063401c7cfd300b39/%E4%BA%91%E8%84%9A%E6%9C%AC/UNIVERSAL%20VERSION.LUA", true))()
        end    
    })
    KookTab:AddParagraph("点了云脚本通用没反应是什么原因", "1.等几分钟就好了\n2.你这个加速器和VPN有点慢\n3.你有没有ping高，换个加速器\n4.自己问题")
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
    
    KookTab:AddButton({
        Name = "忍者传奇超多功能（不是云脚本）",
        Callback = function()
            Notification()
            loadstring(game:HttpGet("https://github.com/CloudX-ScriptsWane/ScriptsDache/raw/main/hope%20earnestly%2FNinja%20Legend.lua", true))()
        end    
    })

    KookTab:AddParagraph("内容", "如有问题，请加入↓\n请加入云脚本交流③QQ群号1014408755\n加入这个Discord云脚本频道！ 需要VPN打开！感谢您的支持！🎉")
    KookTab:AddButton({
        Name = "复制云脚本Discord链接",
        Callback = function()
            setclipboard("https://discord.gg/BuZwECkFCR")
        end    
    })
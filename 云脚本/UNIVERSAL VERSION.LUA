    local OrionLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/XiaoYunCN/LOL/main/Orion.lua", true))()

    local Window = OrionLib:MakeWindow({
        Name = "云脚本", 
        HidePremium = false, 
        SaveConfig = false, 
        ConfigFolder = "rbxassetid://6015897843", 
        IntroEnabled = false
    })
    
    local Tab = Window:MakeTab({
        Name = "云脚本",
        Icon = "rbxassetid://4483345998",
        PremiumOnly = false
    })
    
    Tab:AddButton({
        Name = "云脚本",
        Callback = function()
            loadstring(game:HttpGet("https://github.com/XiaoYunUwU/XiaoYunUwU/raw/main/Yun%20Script%2FPaid%20edition.lua", true))()
        end    
    })

    Tab:AddButton({
        Name = "云脚本-吃掉世界",
        Callback = function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/XiaoYunCN/VIP/refs/heads/main/Eat%20the%20World.lua", true))()
        end    
    })

    Tab:AddButton({
        Name = "云脚本-力量传奇",
        Callback = function()
            loadstring(game:HttpGet("https://github.com/XiaoYunCN/VIP/raw/main/%E5%8A%9B%E9%87%8F%E4%BC%A0%E5%A5%87.lua", true))()
        end    
    })

    local Name_MXC = loadstring(game:HttpGet("https://github.com/XiaoYunCN/VIP/raw/main/Name", true))()

    Tab:AddParagraph("公告", MXC["云脚本内容"]["公告内容"])
    Tab:AddParagraph("内容", MXC["云脚本内容"]["显示内容"])
    Tab:AddButton({
        Name = "复制云脚本Discord链接",
        Callback = function()
            setclipboard(MXC["云脚本内容"]["Discord"])
        end    
    })
local Players = game:GetService("Players")
local XA = Players.LocalPlayer
local Language = game:GetService("LocalizationService"):GetLanguageForPlayerAsync(XA)

if Language == Enum.Language.ChineseSimplified then
    loadstring(game:HttpGet("https://raw.githubusercontent.com/XiaoYunCN/VIP/6fd47d2716b6a6eade78d80063401c7cfd300b39/%E4%BA%91%E8%84%9A%E6%9C%AC/UNIVERSAL%20VERSION.LUA", true))()
else
    loadstring(game:HttpGet("https://github.com/XiaoYunCN/VIP/raw/main/en-us.lua", true))()
end

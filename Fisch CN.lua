--老外做的
local repo = 'https://raw.githubusercontent.com/KINGHUB01/Gui/main/'

local Library = loadstring(game:HttpGet(repo ..'Gui%20Lib%20%5BLibrary%5D'))()
local ThemeManager = loadstring(game:HttpGet(repo ..'Gui%20Lib%20%5BThemeManager%5D'))()
local SaveManager = loadstring(game:HttpGet(repo ..'Gui%20Lib%20%5BSaveManager%5D'))()

local Window = Library:CreateWindow({
    Title = 'Fisch V1.2.3 (BETA)',
    Center = true,
    AutoShow = true,
    TabPadding = 8,
    MenuFadeTime = 0.2
})

local FrameTimer = tick()
local FrameCounter = 0;
local FPS = 60;

local WatermarkConnection = game:GetService('RunService').RenderStepped:Connect(function()
    FrameCounter += 1;

    if (tick() - FrameTimer) >= 1 then
        FPS = FrameCounter;
        FrameTimer = tick();
        FrameCounter = 0;
    end;

    Library:SetWatermark(('Rinns Hub V1.2.3 | %s fps | %s ms'):format(
        math.floor(FPS),
        math.floor(game:GetService('Stats').Network.ServerStatsItem['Data Ping']:GetValue())
    ));
end);

-- Tabs

local Tabs = {
    Main = Window:AddTab('主要'),
    Teleports = Window:AddTab('传送'),
    LocalPlayer = Window:AddTab('本地玩家'),
    Settings = Window:AddTab('设置')
}

-- Tables

local teleportSpots = {}

local racistPeople = { --[[ all racist people abandoned :pensive: ]] }

local itemSpots = {
    Bait_Crate = CFrame.new(384.57513427734375, 135.3519287109375, 337.5340270996094),
    Carbon_Rod = CFrame.new(454.083618, 150.590073, 225.328827, 0.985374212, -0.170404434, 1.41561031e-07, 1.41561031e-07, 1.7285347e-06, 1, -0.170404434, -0.985374212, 1.7285347e-06),
    Crab_Cage = CFrame.new(474.803589, 149.664566, 229.49469, -0.721874595, 0, 0.692023814, 0, 1, 0, -0.692023814, 0, -0.721874595),
    Fast_Rod = CFrame.new(447.183563, 148.225739, 220.187454, 0.981104493, 1.26492232e-05, 0.193478703, -0.0522461236, 0.962867677, 0.264870107, -0.186291039, -0.269973755, 0.944674432),
    Flimsy_Rod = CFrame.new(471.107697, 148.36171, 229.642441, 0.841614008, 0.0774728209, -0.534493923, 0.00678436086, 0.988063335, 0.153898612, 0.540036798, -0.13314943, 0.831042409),
    GPS = CFrame.new(517.896729, 149.217636, 284.856842, 7.39097595e-06, -0.719539165, -0.694451928, -1, -7.39097595e-06, -3.01003456e-06, -3.01003456e-06, 0.694451928, -0.719539165),
    Long_Rod = CFrame.new(485.695038, 171.656326, 145.746109, -0.630167365, -0.776459217, -5.33461571e-06, 5.33461571e-06, -1.12056732e-05, 1, -0.776459217, 0.630167365, 1.12056732e-05),
    Lucky_Rod = CFrame.new(446.085999, 148.253006, 222.160004, 0.974526405, -0.22305499, 0.0233404674, 0.196993902, 0.901088715, 0.386306256, -0.107199371, -0.371867687, 0.922075212),
    Plastic_Rod = CFrame.new(454.425385, 148.169739, 229.172424, 0.951755166, 0.0709736273, -0.298537821, -3.42726707e-07, 0.972884834, 0.231290117, 0.306858391, -0.220131472, 0.925948203),
    Training_Rod = CFrame.new(457.693848, 148.357529, 230.414307, 1, -0, 0, 0, 0.975410998, 0.220393807, -0, -0.220393807, 0.975410998)
}

local fisktable = {}

-- Services

local VirtualInputManager = game:GetService("VirtualInputManager")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VirtualUser = game:GetService("VirtualUser")
local HttpService = game:GetService("HttpService")
local GuiService = game:GetService("GuiService")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")

-- Locals

local LocalPlayer = Players.LocalPlayer
local LocalCharacter = LocalPlayer.Character
local HumanoidRootPart = LocalCharacter:FindFirstChild("HumanoidRootPart")
local ActiveFolder = Workspace:FindFirstChild("active")
local FishingZonesFolder = Workspace:FindFirstChild("zones"):WaitForChild("fishing")
local TpSpotsFolder = Workspace:FindFirstChild("world"):WaitForChild("spawns"):WaitForChild("TpSpots")
local NpcFolder = Workspace:FindFirstChild("world"):WaitForChild("npcs")
local PlayerGUI = LocalPlayer:FindFirstChildOfClass("PlayerGui")
local RenderStepped = RunService.RenderStepped
local WaitForSomeone = RenderStepped.Wait
local Debug = function()
    print(debug.info(2, "l"))
end

-- Varbiables

local autoShake = false
local autoShakeDelay = 0.1
local autoShakeMethod = "KeyCodeEvent"
local autoShakeClickOffsetX = 0
local autoShakeClickOffsetY = 0
local autoReel = false
local autoReelDelay = 2
local autoCast = false
local autoCastMode = "Legit"
local autoCastDelay = 2
local ZoneCast = false
local Zone = "Brine Pool"
local Noclip = false
local AntiDrown = false
local CollarPlayer = false
local Target
local FreezeChar = false

-- Rest

autoreelandshakeConnection = PlayerGUI.ChildAdded:Connect(function(GUI)
    if GUI:IsA("ScreenGui") and GUI.Name == "shakeui" then
        if GUI:FindFirstChild("safezone") ~= nil then
            GUI.safezone.ChildAdded:Connect(function(child)
                if child:IsA("ImageButton") and child.Name == "button" then
                    if autoShake == true then
                        task.wait(autoShakeDelay)
                        if child.Visible == true then
                            if autoShakeMethod == "ClickEvent" then
                                local pos = child.AbsolutePosition
                                local size = child.AbsoluteSize
                                VirtualInputManager:SendMouseButtonEvent(pos.X + size.X / 2, pos.Y + size.Y / 2, 0, true, LocalPlayer, 0)
                                VirtualInputManager:SendMouseButtonEvent(pos.X + size.X / 2, pos.Y + size.Y / 2, 0, false, LocalPlayer, 0)
                            --[[elseif autoShakeMethod == "firesignal" then
                                firesignal(child.MouseButton1Click)]]
                            elseif autoShakeMethod == "KeyCodeEvent" then
                                while WaitForSomeone(RenderStepped) do
                                    if autoShake and GUI.safezone:FindFirstChild(child.Name) ~= nil then
                                        task.wait()
                                        pcall(function()
                                            GuiService.SelectedObject = child
                                            if GuiService.SelectedObject == child then
                                                VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.Return, false, game)
                                                VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.Return, false, game)
                                            end
                                        end)
                                    else
                                        GuiService.SelectedObject = nil
                                        break
                                    end
                                end
                            end
                        end
                    end
                end
            end)
        end
    end
    if GUI:IsA("ScreenGui") and GUI.Name == "reel" then
        if autoReel and ReplicatedStorage:WaitForChild("events"):WaitForChild("reelfinished") ~= nil then
            repeat task.wait(autoReelDelay) ReplicatedStorage.events.reelfinished:FireServer(100, false) until GUI == nil
        end
    end
end)

autoCastConnection = LocalCharacter.ChildAdded:Connect(function(child)
    if child:IsA("Tool") and child:FindFirstChild("events"):WaitForChild("cast") ~= nil and autoCast then
        task.wait(autoCastDelay)
        if autoCastMode == "Legit" then
            VirtualInputManager:SendMouseButtonEvent(0, 0, 0, true, LocalPlayer, 0)
            HumanoidRootPart.ChildAdded:Connect(function()
                if HumanoidRootPart:FindFirstChild("power") ~= nil and HumanoidRootPart.power.powerbar.bar ~= nil then
                    HumanoidRootPart.power.powerbar.bar.Changed:Connect(function(property)
                        if property == "Size" then
                            if HumanoidRootPart.power.powerbar.bar.Size == UDim2.new(1, 0, 1, 0) then
                                VirtualInputManager:SendMouseButtonEvent(0, 0, 0, false, LocalPlayer, 0)
                            end
                        end
                    end)
                end
            end)
        elseif autoCastMode == "Rage" then
            child.events.cast:FireServer(100)
        end
    end
end)

autoCastConnection2 = PlayerGUI.ChildRemoved:Connect(function(GUI)
    local Tool = LocalCharacter:FindFirstChildOfClass("Tool")
    if GUI.Name == "reel" and autoCast == true and Tool ~= nil and Tool:FindFirstChild("events"):WaitForChild("cast") ~= nil then
        task.wait(autoCastDelay)
        if autoCastMode == "Legit" then
            VirtualInputManager:SendMouseButtonEvent(0, 0, 0, true, LocalPlayer, 0)
            HumanoidRootPart.ChildAdded:Connect(function()
                if HumanoidRootPart:FindFirstChild("power") ~= nil and HumanoidRootPart.power.powerbar.bar ~= nil then
                    HumanoidRootPart.power.powerbar.bar.Changed:Connect(function(property)
                        if property == "Size" then
                            if HumanoidRootPart.power.powerbar.bar.Size == UDim2.new(1, 0, 1, 0) then
                                VirtualInputManager:SendMouseButtonEvent(0, 0, 0, false, LocalPlayer, 0)
                            end
                        end
                    end)
                end
            end)
        elseif autoCastMode == "Rage" then
            Tool.events.cast:FireServer(100)
        end
    end
end)

ZoneConnection = LocalCharacter.ChildAdded:Connect(function(child)
    if ZoneCast and child:IsA("Tool") and FishingZonesFolder:FindFirstChild(Zone) ~= nil then
        child.ChildAdded:Connect(function(blehh)
            if blehh.Name == "bobber" then
                local RopeConstraint = blehh:FindFirstChildOfClass("RopeConstraint")
                if ZoneCast and RopeConstraint ~= nil then
                    RopeConstraint.Changed:Connect(function(property)
                        if property == "Length" then
                            RopeConstraint.Length = math.huge
                        end
                    end)
                    RopeConstraint.Length = math.huge
                end
                task.wait(1)
                while WaitForSomeone(RenderStepped) do
                    if ZoneCast and blehh.Parent ~= nil then
                        task.wait()
                        blehh.CFrame = FishingZonesFolder[Zone].CFrame
                    else
                        break
                    end
                end
            end
        end)
    end
end)

CollarConnection = LocalCharacter.ChildAdded:Connect(function(child)
    if CollarPlayer and child:IsA("Tool") and Players:FindFirstChild(Target).Character:FindFirstChild("Head") ~= nil then
        child.ChildAdded:Connect(function(blehh)
            if blehh.Name == "bobber" then
                local RopeConstraint = blehh:FindFirstChildOfClass("RopeConstraint")
                if CollarPlayer and RopeConstraint ~= nil then
                    RopeConstraint.Changed:Connect(function(property)
                        if property == "Length" then
                            RopeConstraint.Length = math.huge
                        end
                    end)
                    RopeConstraint.Length = math.huge
                end
                task.wait(1)
                while WaitForSomeone(RenderStepped) do
                    if CollarPlayer and blehh.Parent ~= nil then
                        task.wait()
                        blehh.CFrame = Players:FindFirstChild(Target).Character:FindFirstChild("Head").CFrame + Vector3.new(0, -1, 0)
                    else
                        break
                    end
                end
            end
        end)
    end
end)

NoclipConnection = RunService.Stepped:Connect(function()
    if Noclip == true then
        if LocalCharacter ~= nil then
            for i, v in pairs(LocalCharacter:GetDescendants()) do
                if v:IsA("BasePart") and v.CanCollide == true then
                    v.CanCollide = false
                end
            end
        end
    end
end)

local SafeZone = Instance.new("Part")
SafeZone.Parent = Workspace
SafeZone.Size = Vector3.new(50, 2, 50)
SafeZone.CFrame = CFrame.new(9999, 9999, 9999)
SafeZone.Anchored = true

for i, v in pairs(FishingZonesFolder:GetChildren()) do
    if table.find(fisktable, v.Name) == nil then
        table.insert(fisktable, v.Name)
    end
end

FishingZonesFolder.ChildAdded:Connect(function(child)
    if table.find(fisktable, child.Name) == nil then
        table.insert(fisktable, child.Name)
    end
end)

for i, v in pairs(TpSpotsFolder:GetChildren()) do
    if table.find(teleportSpots, v.Name) == nil then
        table.insert(teleportSpots, v.Name)
    end
end

for i, v in pairs(NpcFolder:GetChildren()) do
    if table.find(racistPeople, v.Name) == nil and v.Name ~= "mirror Area" then
        table.insert(racistPeople, v.Name)
    end
end

NpcFolder.ChildAdded:Connect(function(child)
    if table.find(racistPeople, child.Name) == nil and child.Name ~= "mirror Area" then
        table.insert(racistPeople, child.Name)
    end
end)

-- 主菜单

local AutoShakeGroup = Tabs.Main:AddLeftGroupbox('自动摇动')
local AutoReelGroup = Tabs.Main:AddLeftGroupbox('自动收线')
local AutoCastGroup = Tabs.Main:AddLeftGroupbox('自动抛竿')
local FishUtilitiesGroup = Tabs.Main:AddRightGroupbox('钓鱼（🐟）工具')
--local EventGroup = Tabs.Main:AddRightGroupbox('活动')
local ZoneCastGroup = Tabs.Main:AddRightGroupbox('区域抛竿')
local CollarPlayerGroup = Tabs.Main:AddRightGroupbox('追踪玩家')

AutoShakeGroup:AddToggle('AutoShake', {
    Text = '启用',
    Default = false,
    Tooltip = '自动帮你点击摇动按钮',
    Callback = function(Value)
        autoShake = Value
    end
})

local AutoShakeSettings = AutoShakeGroup:AddDependencyBox()

AutoShakeSettings:AddDropdown('AutoShakeMode', {
    Text = '自动摇动方式',
    Tooltip = '选择点击摇动按钮的方法',
    Values = {'事件点击', --[['信号触发',]] '按键事件'},
    Default = autoShakeMethod,

    Callback = function(Value)
        autoShakeMethod = Value
    end
})

local AutoShakeKeyCodeEventText = AutoShakeSettings:AddDependencyBox()

AutoShakeKeyCodeEventText:AddLabel('灵感来自 rblxscripts.net！')
AutoShakeKeyCodeEventText:AddLabel('特别感谢他们。')

AutoShakeKeyCodeEventText:SetupDependencies({
    { Options.AutoShakeMode, "按键事件" }
})

AutoShakeSettings:AddSlider('AutoShakeDelay', {
    Text = '自动摇动延迟',
    Default = 0.1,
    Min = 0,
    Max = 10,
    Rounding = 1,

    Callback = function(Value)
        autoShakeDelay = Value
    end
})

AutoShakeSettings:SetupDependencies({
    { Toggles.AutoShake, true }
})

--[[
local AutoShakeXYOffset = AutoShakeGroup:AddDependencyBox()

AutoShakeXYOffset:AddSlider('AutoShakeXOffset', {
    Text = 'AutoShake X Offset',
    Default = 0,
    Min = -10,
    Max = 10,
    Rounding = 1,

    Callback = function(Value)
        autoShakeClickOffsetX = Value
    end
})

AutoShakeXYOffset:AddSlider('AutoShakeXOffset', {
    Text = 'AutoShake Y Offset',
    Default = 0,
    Min = -10,
    Max = 10,
    Rounding = 1,

    Callback = function(Value)
        autoShakeClickOffsetY = Value
    end
})

AutoShakeXYOffset:SetupDependencies({
    { Options.AutoShakeMode, "ClickEvent" }
})
]]

AutoReelGroup:AddToggle('AutoReel', {
    Text = '启用',
    Default = false,
    Tooltip = '自动收回钓竿',
    Callback = function(Value)
        autoReel = Value
    end
})

local AutoReelSettings = AutoReelGroup:AddDependencyBox()

AutoReelSettings:AddSlider('AutoReelDelay', {
    Text = '自动收线延迟',
    Default = 2,
    Min = 0,
    Max = 10,
    Rounding = 1,

    Callback = function(Value)
        autoReelDelay = Value
    end
})

AutoReelSettings:SetupDependencies({
    { Toggles.AutoReel, true }
})

AutoCastGroup:AddToggle('AutoCast', {
    Text = '启用',
    Default = false,
    Tooltip = '自动抛竿',
    Callback = function(Value)
        autoCast = Value
        local Tool = LocalCharacter:FindFirstChildOfClass("Tool")
        if Tool ~= nil and Tool:FindFirstChild("events"):WaitForChild("cast") ~= nil and Value == true then
            task.wait(autoCastDelay)
            if autoCastMode == "Legit" then
                VirtualInputManager:SendMouseButtonEvent(0, 0, 0, true, LocalPlayer, 0)
                HumanoidRootPart.ChildAdded:Connect(function()
                    if HumanoidRootPart:FindFirstChild("power") ~= nil and HumanoidRootPart.power.powerbar.bar ~= nil then
                        HumanoidRootPart.power.powerbar.bar.Changed:Connect(function(property)
                            if property == "Size" then
                                if HumanoidRootPart.power.powerbar.bar.Size == UDim2.new(1, 0, 1, 0) then
                                    VirtualInputManager:SendMouseButtonEvent(0, 0, 0, false, LocalPlayer, 0)
                                end
                            end
                        end)
                    end
                end)
            elseif autoCastMode == "Rage" then
                Tool.events.cast:FireServer(100)
            end
        end
    end
})

local AutoCastSettings = AutoCastGroup:AddDependencyBox()

AutoCastSettings:AddSlider('AutoCastDelay', {
    Text = '自动抛竿延迟',
    Default = 2,
    Min = 0,
    Max = 10,
    Rounding = 1,

    Callback = function(Value)
        autoCastDelay = Value
    end
})

AutoCastSettings:AddDropdown('AutoCastMode', {
    Text = '自动抛竿模式',
    Tooltip = '选择自动抛竿的模式',
    Values = {'Legit', 'Rage'},
    Default = autoCastMode,

    Callback = function(Value)
        autoCastMode = Value
    end
})

AutoCastSettings:SetupDependencies({
    { Toggles.AutoCast, true }
})

local SellButton = FishUtilitiesGroup:AddButton({
    Text = '出售一条鱼',
    Func = function()
        Workspace:WaitForChild("world"):WaitForChild("npcs"):WaitForChild("Marc Merchant"):WaitForChild("merchant"):WaitForChild("sell"):InvokeServer()
    end,
    DoubleClick = false,
    Tooltip = '出售你手中的鱼'
})


local SellAllButton = FishUtilitiesGroup:AddButton({
    Text = '出售所有鱼',
    Func = function()
        Workspace:WaitForChild("world"):WaitForChild("npcs"):WaitForChild("Marc Merchant"):WaitForChild("merchant"):WaitForChild("sellall"):InvokeServer()
    end,
    DoubleClick = false,
    Tooltip = '出售你所有的鱼'
})

local AppraiseButton = FishUtilitiesGroup:AddButton({
    Text = '评估鱼 🐟 (450C$)',
    Func = function()
        Workspace:WaitForChild("world"):WaitForChild("npcs"):WaitForChild("Appraiser"):WaitForChild("appraiser"):WaitForChild("appraise"):InvokeServer()
    end,
    DoubleClick = false,
    Tooltip = '评估你手中的鱼'
})


--[[
EventGroup:AddDropdown('Event', {
    Text = 'Item Grabber',
    Tooltip = 'Grabs the Event Item',
    Values = {'Gaint Mushroom', 'Spiders Eye', 'Strange Root', 'Candy Corn', 'Dark Art Skull'},
    Default = '',

    Callback = function(Value)
        if HumanoidRootPart ~= nil and ActiveFolder ~= nil then
            local oldpos = HumanoidRootPart.CFrame
            local EventItem = ActiveFolder:FindFirstChild(Value)

            if EventItem ~= nil and EventItem:FindFirstChild("PickupPrompt") ~= nil then
                HumanoidRootPart.CFrame = EventItem:FindFirstChildOfClass("MeshPart").CFrame + Vector3.new(3, 2, 0)
                Noclip = true
                task.wait(0.05)
                HumanoidRootPart.Anchored = true
                task.wait(0.5)
                fireproximityprompt(EventItem.PickupPrompt)
                task.wait(1)
                if Toggles.Noclip.Value == false then
                    Noclip = false
                else
                    Noclip = true
                end
                HumanoidRootPart.Anchored = false
                HumanoidRootPart.CFrame = oldpos
            else
                Library:Notify(string.format('There is no "%s" in workspace', Value))
            end
        end
    end
})

EventGroup:AddLabel("Might be buggy!")
]]

ZoneCastGroup:AddToggle('ZoneCast', {
    Text = '启用',
    Default = false,
    Tooltip = '将钓竿抛到另一个区域',
    Callback = function(Value)
        ZoneCast = Value
    end
})

local ZoneCastDropdowns = ZoneCastGroup:AddDependencyBox()

ZoneCastDropdowns:AddDropdown('ZoneCastValue', {
    Text = '区域',
    Tooltip = nil,
    Values = fisktable,
    Default = Zone,

    Callback = function(Value)
        Zone = Value
    end
})

ZoneCastDropdowns:SetupDependencies({
    { Toggles.ZoneCast, true }
})

CollarPlayerGroup:AddToggle('CollarPlayer', {
    Text = '启用',
    Default = false,
    Tooltip = "将玩家戴上项圈，使他们看起来像你的宠物 :3",
    Callback = function(Value)
        CollarPlayer = Value
    end
})

local CollarPlayerDropdown = CollarPlayerGroup:AddDependencyBox()

CollarPlayerDropdown:AddDropdown('CollarTarget', {
    SpecialType = '玩家',
    Text = '玩家',
    Tooltip = '选择你要为其戴上项圈的玩家',

    Callback = function(Value)
        Target = Value
    end
})

CollarPlayerDropdown:SetupDependencies({
    { Toggles.CollarPlayer, true }
})

-- 传送

local TeleportsGroup = Tabs.Teleports:AddLeftGroupbox('传送')

TeleportsGroup:AddDropdown('PlaceTeleport', {
    Text = '传送到地点',
    Tooltip = '传送到一个地点',
    Values = teleportSpots,
    Default = '',

    Callback = function(Value)
        if teleportSpots ~= nil and HumanoidRootPart ~= nil then
            HumanoidRootPart.CFrame = TpSpotsFolder:FindFirstChild(Value).CFrame + Vector3.new(0, 5, 0)
        end
    end
})

TeleportsGroup:AddDropdown('NPCTeleport', {
    Text = '传送到NPC',
    Tooltip = '传送到一个钓竿',
    Values = racistPeople,
    Default = '',

    Callback = function(Value)
        if racistPeople ~= nil and HumanoidRootPart ~= nil then
            HumanoidRootPart.CFrame = NpcFolder:FindFirstChild(Value):WaitForChild("HumanoidRootPart").CFrame + Vector3.new(0, 1, 0)
        end
    end
})

TeleportsGroup:AddDropdown('ItemTeleport', {
    Text = '传送到物品',
    Tooltip = '传送到一个钓竿',
    Values = {"Bait_Crate", "Carbon_Rod", "Crab_Cage", "Fast_Rod", "Flimsy_Rod", "GPS", "Long_Rod", "Lucky_Rod", "Plastic_Rod", "Training_Rod"},
    Default = '',

    Callback = function(Value)
        if itemSpots ~= nil and HumanoidRootPart ~= nil then
            HumanoidRootPart.CFrame = itemSpots[Value]
        end
    end
})

local TeleportToSafeZoneGroup = Tabs.Teleports:AddRightGroupbox('安全区')

local TeleportToSafeZoneButton = TeleportToSafeZoneGroup:AddButton({
    Text = '传送到安全区',
    Func = function()
        HumanoidRootPart.CFrame = SafeZone.CFrame + Vector3.new(0, 2, 0)
    end,
    DoubleClick = false,
    Tooltip = '将你传送到安全区'
})

-- 本地玩家

local LocalPlayerGroup = Tabs.LocalPlayer:AddLeftGroupbox('本地玩家')

LocalPlayerGroup:AddToggle('Noclip', {
    Text = '穿墙',
    Default = false,
    Tooltip = '允许你穿过墙壁',
    Callback = function(Value)
        Noclip = Value
    end
})

LocalPlayerGroup:AddToggle('AntiDrown', {
    Text = '禁用氧气',
    Default = false,
    Tooltip = '允许你在水中无限时间停留',
    Callback = function(Value)
        AntiDrown = Value
        if Value == true then
            if LocalCharacter ~= nil and LocalCharacter:FindFirstChild("client"):WaitForChild("oxygen") ~= nil and LocalCharacter:FindFirstChild("client"):WaitForChild("oxygen").Enabled == true then        
                LocalCharacter.client.oxygen.Enabled = false        
            end        
            CharAddedAntiDrownCon = LocalPlayer.CharacterAdded:Connect(function()        
                if LocalCharacter ~= nil and LocalCharacter:FindFirstChild("client"):WaitForChild("oxygen") ~= nil and LocalCharacter:FindFirstChild("client"):WaitForChild("oxygen").Enabled == true and AntiDrown == true then        
                    LocalCharacter.client.oxygen.Enabled = false        
                end        
            end)
        else        
            if LocalCharacter ~= nil and LocalCharacter:FindFirstChild("client"):WaitForChild("oxygen") ~= nil and LocalCharacter:FindFirstChild("client"):WaitForChild("oxygen").Enabled == false then        
                LocalCharacter.client.oxygen.Enabled = true        
            end        
        end
    end
})

local ResetRodGroup = Tabs.LocalPlayer:AddRightGroupbox('重置')

local ResetRodButton = ResetRodGroup:AddButton({
    Text = '重置钓竿',
    Func = function()
        local tool = LocalCharacter:FindFirstChildOfClass("Tool")

        if tool:FindFirstChild("events"):WaitForChild("reset") ~= nil then
            tool.events.reset:FireServer()
        end
    end,
    DoubleClick = false,
    Tooltip = '重置你的钓竿'
})


local AntiAfkGroup = Tabs.LocalPlayer:AddRightGroupbox('防AFK')

local AntiAFKButton = AntiAfkGroup:AddButton({
    Text = '防AFK',
    Func = function()
        Library:Notify("防AFK已启动！")
        LocalPlayer.Idled:Connect(function()
            VirtualUser:CaptureController()
            VirtualUser:ClickButton2(Vector2.new())
        end)
    end,
    DoubleClick = false,
    Tooltip = '禁用空闲踢出'
})

local FreezeCharacterGroup = Tabs.LocalPlayer:AddLeftGroupbox('冻结角色')

FreezeCharacterGroup:AddToggle('FreezeCharacter', {
    Text = '启用',
    Default = false,
    Tooltip = "冻结你的角色在当前位置",
    Callback = function(Value)
        local oldpos = HumanoidRootPart.CFrame
        FreezeChar = Value
        task.wait()
        while WaitForSomeone(RenderStepped) do
            if FreezeChar and HumanoidRootPart ~= nil then
                task.wait()
                HumanoidRootPart.CFrame = oldpos
            else
                break
            end
        end
    end
})

-- 设置

local SettingsGroup = Tabs.Settings:AddLeftGroupbox('设置')
local CreditsGroup = Tabs.Settings:AddRightGroupbox('鸣谢')

CreditsGroup:AddLabel('由 kylosilly 和 netpa 制作！')
CreditsGroup:AddLabel('充满爱与恨制作 :3')

local DiscordButton = CreditsGroup:AddButton({
    Text = '复制 Fisch Discord 链接',
    Func = function()
        setclipboard('https://discord.gg/DEkfE99JFh')
    end,
    DoubleClick = false,
    Tooltip = '加入我们的 Fisch Discord！'
})

local DiscordButton2 = CreditsGroup:AddButton({
    Text = '复制主 Discord 链接',
    Func = function()
        setclipboard('https://discord.gg/VudXCDCaBN')
    end,
    DoubleClick = false,
    Tooltip = '加入我们的主 Discord！'
})

CreditsGroup:AddLabel('البرود يا جماعه هو الحل')

SettingsGroup:AddButton('卸载ui', function() Library:Unload() end)


Library:OnUnload(function()
        Library.Unloaded = true
    if autoReel then
        autoReel = false
    end
    if autoShake then
        autoShake = false
    end
    if AntiDrown then
        if LocalCharacter ~= nil and LocalCharacter:FindFirstChild("client"):WaitForChild("oxygen") ~= nil and LocalCharacter:FindFirstChild("client"):WaitForChild("oxygen").Enabled == false then
            LocalCharacter.client.oxygen.Enabled = true
            CharAddedAntiDrownCon:Disconnect()
            AntiDrown = false
        end
    end
    if Noclip then
        Noclip = false
    end
    if autoCast then
        autoCast = false
    end
    if ZoneCast then
        ZoneCast = false
    end
    if CollarPlayer then
        CollarPlayer = false
    end
    WatermarkConnection:Disconnect()
    NoclipConnection:Disconnect()
    autoreelandshakeConnection:Disconnect()
    autoCastConnection:Disconnect()
    autoCastConnection2:Disconnect()
    ZoneConnection:Disconnect()
    CollarConnection:Disconnect()
end)

SettingsGroup:AddLabel('Menu bind'):AddKeyPicker('MenuKeybind', { Default = 'End', NoUI = true, Text = 'Menu keybind' })

Library.ToggleKeybind = Options.MenuKeybind

ThemeManager:SetLibrary(Library)

SaveManager:SetLibrary(Library)

SaveManager:IgnoreThemeSettings()

SaveManager:SetIgnoreIndexes({ 'MenuKeybind' })

ThemeManager:SetFolder('RinnsHub')

SaveManager:SetFolder('RinnsHub/Fisch')

SaveManager:BuildConfigSection(Tabs.Settings)

ThemeManager:ApplyToTab(Tabs.Settings)

SaveManager:LoadAutoloadConfig()

local Version = "1.2.3"
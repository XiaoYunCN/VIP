local httpService = game:GetService("HttpService")

local SaveManager = {} do
        SaveManager.Folder = "FluentSettings"
        SaveManager.Ignore = {}
        SaveManager.Parser = {
                Toggle = {
                        Save = function(idx, object) 
                                return { type = "Toggle", idx = idx, value = object.Value } 
                        end,
                        Load = function(idx, data)
                                if SaveManager.Options[idx] then 
                                        SaveManager.Options[idx]:SetValue(data.value)
                                end
                        end,
                },
                Slider = {
                        Save = function(idx, object)
                                return { type = "Slider", idx = idx, value = tostring(object.Value) }
                        end,
                        Load = function(idx, data)
                                if SaveManager.Options[idx] then 
                                        SaveManager.Options[idx]:SetValue(data.value)
                                end
                        end,
                },
                Dropdown = {
                        Save = function(idx, object)
                                return { type = "Dropdown", idx = idx, value = object.Value, mutli = object.Multi }
                        end,
                        Load = function(idx, data)
                                if SaveManager.Options[idx] then 
                                        SaveManager.Options[idx]:SetValue(data.value)
                                end
                        end,
                },
                Colorpicker = {
                        Save = function(idx, object)
                                return { type = "Colorpicker", idx = idx, value = object.Value:ToHex(), transparency = object.Transparency }
                        end,
                        Load = function(idx, data)
                                if SaveManager.Options[idx] then 
                                        SaveManager.Options[idx]:SetValueRGB(Color3.fromHex(data.value), data.transparency)
                                end
                        end,
                },
                Keybind = {
                        Save = function(idx, object)
                                return { type = "Keybind", idx = idx, mode = object.Mode, key = object.Value }
                        end,
                        Load = function(idx, data)
                                if SaveManager.Options[idx] then 
                                        SaveManager.Options[idx]:SetValue(data.key, data.mode)
                                end
                        end,
                },

                Input = {
                        Save = function(idx, object)
                                return { type = "Input", idx = idx, text = object.Value }
                        end,
                        Load = function(idx, data)
                                if SaveManager.Options[idx] and type(data.text) == "string" then
                                        SaveManager.Options[idx]:SetValue(data.text)
                                end
                        end,
                },
        }

        function SaveManager:SetIgnoreIndexes(list)
                for _, key in next, list do
                        self.Ignore[key] = true
                end
        end

        function SaveManager:SetFolder(folder)
                self.Folder = folder;
                self:BuildFolderTree()
        end

        function SaveManager:Save(name)
                if (not name) then
                        return false, "no config file is selected"
                end

                local fullPath = self.Folder .. "/settings/" .. name .. ".json"

                local data = {
                        objects = {}
                }

                for idx, option in next, SaveManager.Options do
                        if not self.Parser[option.Type] then continue end
                        if self.Ignore[idx] then continue end

                        table.insert(data.objects, self.Parser[option.Type].Save(idx, option))
                end        

                local success, encoded = pcall(httpService.JSONEncode, httpService, data)
                if not success then
                        return false, "failed to encode data"
                end

                writefile(fullPath, encoded)
                return true
        end

        function SaveManager:Load(name)
                if (not name) then
                        return false, "no config file is selected"
                end

                local file = self.Folder .. "/settings/" .. name .. ".json"
                if not isfile(file) then return false, "invalid file" end

                local success, decoded = pcall(httpService.JSONDecode, httpService, readfile(file))
                if not success then return false, "decode error" end

                for _, option in next, decoded.objects do
                        if self.Parser[option.type] then
                                task.spawn(function() self.Parser[option.type].Load(option.idx, option) end) -- task.spawn() so the config loading wont get stuck.
                        end
                end

                return true
        end

        function SaveManager:IgnoreThemeSettings()
                self:SetIgnoreIndexes({ 
                        "InterfaceTheme", "AcrylicToggle", "TransparentToggle", "MenuKeybind"
                })
        end

        function SaveManager:BuildFolderTree()
                local paths = {
                        self.Folder,
                        self.Folder .. "/settings"
                }

                for i = 1, #paths do
                        local str = paths[i]
                        if not isfolder(str) then
                                makefolder(str)
                        end
                end
        end

        function SaveManager:RefreshConfigList()
                local list = listfiles(self.Folder .. "/settings")

                local out = {}
                for i = 1, #list do
                        local file = list[i]
                        if file:sub(-5) == ".json" then
                                local pos = file:find(".json", 1, true)
                                local start = pos

                                local char = file:sub(pos, pos)
                                while char ~= "/" and char ~= "\\" and char ~= "" do
                                        pos = pos - 1
                                        char = file:sub(pos, pos)
                                end

                                if char == "/" or char == "\\" then
                                        local name = file:sub(pos + 1, start - 1)
                                        if name ~= "options" then
                                                table.insert(out, name)
                                        end
                                end
                        end
                end

                return out
        end

        function SaveManager:SetLibrary(library)
                self.Library = library
        self.Options = library.Options
        end

        function SaveManager:LoadAutoloadConfig()
                if isfile(self.Folder .. "/settings/autoload.txt") then
                        local name = readfile(self.Folder .. "/settings/autoload.txt")

                        local success, err = self:Load(name)
                        if not success then
                                return self.Library:Notify({
                                        Title = "连接",
                                        Content = "配置加载",
                                        SubContent = "无法加载自动加载配置: " .. err,
                                        Duration = 7
                                })
                        end

                        self.Library:Notify({
                                Title = "连接",
                                Content = "配置加载",
                                SubContent = string.format("自动加载的配置%q", name),
                                Duration = 7
                        })
                end
        end

        function SaveManager:BuildConfigSection(tab)
                assert(self.Library, "必须设置SaveManager。图书馆")

                local section = tab:AddSection("Configuration")

                section:AddInput("SaveManager_ConfigName",    { Title = "配置名称" })
                section:AddDropdown("SaveManager_ConfigList", { Title = "配置列表", Values = self:RefreshConfigList(), AllowNull = true })

                section:AddButton({
            Title = "创建配置",
            Callback = function()
                local name = SaveManager.Options.SaveManager_ConfigName.Value

                if name:gsub(" ", "") == "" then 
                    return self.Library:Notify({
                                                Title = "连接",
                                                Content = "配置加载",
                                                SubContent = "无效的配置名称(空)",
                                                Duration = 7
                                        })
                end

                local success, err = self:Save(name)
                if not success then
                    return self.Library:Notify({
                                                Title = "连接",
                                                Content = "配置加载",
                                                SubContent = "无法保存配置: " .. err,
                                                Duration = 7
                                        })
                end

                                self.Library:Notify({
                                        Title = "连接",
                                        Content = "配置加载",
                                        SubContent = string.format("创建的配置 %q", name),
                                        Duration = 7
                                })

                SaveManager.Options.SaveManager_ConfigList:SetValues(self:RefreshConfigList())
                SaveManager.Options.SaveManager_ConfigList:SetValue(nil)
            end
        })

        section:AddButton({Title = "加载配置", Callback = function()
                        local name = SaveManager.Options.SaveManager_ConfigList.Value

                        local success, err = self:Load(name)
                        if not success then
                                return self.Library:Notify({
                                        Title = "连接",
                                        Content = "配置加载",
                                        SubContent = "无法加载配置: " .. err,
                                        Duration = 7
                                })
                        end

                        self.Library:Notify({
                                Title = "连接",
                                Content = "配置加载",
                                SubContent = string.format("加载的配置%q", name),
                                Duration = 7
                        })
                end})

                section:AddButton({Title = "覆盖配置", Callback = function()
                        local name = SaveManager.Options.SaveManager_ConfigList.Value

                        local success, err = self:Save(name)
                        if not success then
                                return self.Library:Notify({
                                        Title = "连接",
                                        Content = "配置加载",
                                        SubContent = "无法覆盖配置: " .. err,
                                        Duration = 7
                                })
                        end

                        self.Library:Notify({
                                Title = "连接",
                                Content = "配置加载",
                                SubContent = string.format("Overwrote config %q", name),
                                Duration = 7
                        })
                end})

                section:AddButton({Title = "刷新列表", Callback = function()
                        SaveManager.Options.SaveManager_ConfigList:SetValues(self:RefreshConfigList())
                        SaveManager.Options.SaveManager_ConfigList:SetValue(nil)
                end})

                local AutoloadButton
                AutoloadButton = section:AddButton({Title = "设置为自动加载", Description = "当前自动加载配置:无", Callback = function()
                        local name = SaveManager.Options.SaveManager_ConfigList.Value
                        writefile(self.Folder .. "/settings/autoload.txt", name)
                        AutoloadButton:SetDesc("当前自动加载配置: " .. name)
                        self.Library:Notify({
                                Title = "连接",
                                Content = "配置加载",
                                SubContent = string.format("将%q设置为自动加载", name),
                                Duration = 7
                        })
                end})

                if isfile(self.Folder .. "/settings/autoload.txt") then
                        local name = readfile(self.Folder .. "/settings/autoload.txt")
                        AutoloadButton:SetDesc("当前自动加载配置: " .. name)
                end

                SaveManager:SetIgnoreIndexes({ "SaveManager_ConfigList", "SaveManager_ConfigName" })
        end

        SaveManager:BuildFolderTree()
end

return SaveManager
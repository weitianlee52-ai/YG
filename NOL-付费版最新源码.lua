--by神仇开源



local repo = 'https://raw.githubusercontent.com/deividcomsono/Obsidian/main/'

local Library = loadstring(game:HttpGet(repo .. 'Library.lua'))()
local ThemeManager = loadstring(game:HttpGet(repo .. 'addons/ThemeManager.lua'))()
local SaveManager = loadstring(game:HttpGet(repo .. 'addons/SaveManager.lua'))()
local Options = Library.Options
local Toggles = Library.Toggles
Library.ShowToggleFrameInKeybinds = true 
Library.ShowCustomCursor = true
Library.NotifySide = "Right"

local Window = Library:CreateWindow({
	Title = ' 被遗弃 | NOL',
	Footer = "MingWare - NOL Team",
    Icon = 134543491994706,
	Center = true,
	AutoShow = true,
	Resizable = true,
	ShowCustomCursor = true,
	NotifySide = "Right",
	TabPadding = 8,
	MenuFadeTime = 0
})



local Tabs = {
    new = Window:AddTab('公告', 'person-standing'),
	Main = Window:AddTab('主要','house'),
	Esp = Window:AddTab('绘制','eye'),
	zdg = Window:AddTab('格挡','user'),
	Sat = Window:AddTab('体力','zap'),
	zdx = Window:AddTab('电机','printer'),
	Aimbot = Window:AddTab('自瞄','crosshair'),
	tzq = Window:AddTab('通知','mails'),
	tfz = Window:AddTab('杀戮','skull'),
	ani = Window:AddTab('反效果','cpu'),
	yul = Window:AddTab('娱乐功能','cpu'),
   ["UI Settings"] = Window:AddTab('UI 调试', 'settings')
	
}


local _env = getgenv and getgenv() or {}
local _hrp = game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart")

local new = Tabs.new:AddRightGroupbox('群组💬')


new:AddButton({
	Text = "复制Discord频道链接",
	Func = function()
		setclipboard("https://discord.gg/WxZkHDTNC2")
	end,
	DoubleClick = false,

	Tooltip = "This is the main button",
	DisabledTooltip = "I am disabled!",

	Disabled = false, 
	Visible = true, 
	Risky = false, 
})

new:AddButton({
	Text = "复制QQ群号[主群]",
	Func = function()
		setclipboard("819518685")
	end,
	DoubleClick = false,

	Tooltip = "This is the main button",
	DisabledTooltip = "I am disabled!",

	Disabled = false, 
	Visible = true, 
	Risky = false, 
})

new:AddButton({
	Text = "复制QQ群号[二群]",
	Func = function()
		setclipboard("912837219")
	end,
	DoubleClick = false,

	Tooltip = "This is the main button",
	DisabledTooltip = "I am disabled!",

	Disabled = false, 
	Visible = true, 
	Risky = false, 
})


new:AddButton({
	Text = "复制QQ群号[三群]",
	Func = function()
		setclipboard("311797480")
	end,
	DoubleClick = false,

	Tooltip = "This is the main button",
	DisabledTooltip = "I am disabled!",

	Disabled = false, 
	Visible = true, 
	Risky = false, 
})




local new = Tabs.new:AddLeftGroupbox('新闻🚀')

new:AddLabel("[+]Dev 阿铭 / Yuxin")
new:AddLabel("支持是我们最大的动力😒")
new:AddLabel("订阅我们的YOUTUBE频道")







local MainTabbox = Tabs.Main:AddRightTabbox()
local Lighting = MainTabbox:AddTab("brightness")

Lighting:AddSlider("B",{
    Text = "亮度",
    Min = 0,
    Default = 0,
    Max = 3,
    Rounding = 1,
    Compact = true,
    Callback = function(v)
        _env.Brightness = v
    end
})

Lighting:AddToggle("无阴影",{
    Text = "无阴影",
    Default = false,
    Callback = function(v)
        _env.GlobalShadows = v
    end
})

Lighting:AddToggle("除雾",{
    Text = "无雾",
    Default = false,
    Callback = function(v)
        _env.NoFog = v
    end
})

Lighting:AddDivider()

Lighting:AddToggle("启用功能",{
    Text = "启用",
    Default = false,
    Callback = function(v)
        _env.Fullbright = v
        game:GetService("RunService").RenderStepped:Connect(function()
            if not game.Lighting:GetAttribute("FogStart") then 
                game.Lighting:SetAttribute("FogStart", game.Lighting.FogStart) 
            end
            if not game.Lighting:GetAttribute("FogEnd") then 
                game.Lighting:SetAttribute("FogEnd", game.Lighting.FogEnd) 
            end
            game.Lighting.FogStart = _env.NoFog and 0 or game.Lighting:GetAttribute("FogStart")
            game.Lighting.FogEnd = _env.NoFog and math.huge or game.Lighting:GetAttribute("FogEnd")
            
            local fog = game.Lighting:FindFirstChildOfClass("Atmosphere")
            if fog then
                if not fog:GetAttribute("Density") then 
                    fog:SetAttribute("Density", fog.Density) 
                end
                fog.Density = _env.NoFog and 0 or fog:GetAttribute("Density")
            end
            
            if _env.Fullbright then
                game.Lighting.OutdoorAmbient = Color3.new(1,1,1)
                game.Lighting.Brightness = _env.Brightness or 0
                game.Lighting.GlobalShadows = not _env.GlobalShadows
            else
                game.Lighting.OutdoorAmbient = Color3.fromRGB(55,55,55)
                game.Lighting.Brightness = 0
                game.Lighting.GlobalShadows = true
            end
        end)
    end
    
})

local KillerSurvival = Tabs.Main:AddLeftGroupbox("杂项")

KillerSurvival:AddToggle('MyToggle', {
    Text = '显示聊天框 | 一局一开',
    Default = false,
    Tooltip = 'Display chat box',
    Callback = function(state)
    if state then
    game.TextChatService.ChatWindowConfiguration.Enabled = true
    else
    game.TextChatService.ChatWindowConfiguration.Enabled = false    
    end
    end
})

local AntiBanSection = Tabs.Main:AddRightGroupbox("Anti Cheat")

do
    local Players = game:GetService("Players")
    local LocalPlayer = Players.LocalPlayer
    local LocalizationService = game:GetService("LocalizationService")
    local RunService = game:GetService("RunService")

    shared.AntiBanSafe = shared.AntiBanSafe or {running = false, hooks = {}}
    local data = shared.AntiBanSafe

    local oldNamecall, oldIndex
    local protectionThread

    -- 初始化hooks表
    data.hooks = data.hooks or {
        requestHooked = false,
        findHooked = false,
        bypassHooked = false
    }

    local function safe(func, ...)
        local ok, res = pcall(func, ...)
        if ok then return res end
        return nil
    end

    local function disableReportFlags()
        if type(setfflag) == "function" then
            pcall(function()
                setfflag("AbuseReportScreenshot", "False")
                setfflag("AbuseReportScreenshotPercentage", "0")
                setfflag("AbuseReportEnabled", "False")
                setfflag("ReportAbuseMenu", "False")
                setfflag("EnableAbuseReportScreenshot", "False")
                setfflag("AbuseReportVideo", "False")
                setfflag("AbuseReportVideoPercentage", "0")
                setfflag("VideoCaptureEnabled", "False")
                setfflag("RecordVideo", "False")
            end)
        end
    end

    local function hookRequests()
        if data.hooks.requestHooked then return true end
        
        local oldRequest = (syn and syn.request) or (request and request) or (http_request and http_request)
        if type(oldRequest) == "function" and type(hookfunction) == "function" then
            local success = pcall(function()
                hookfunction(oldRequest, function(req)
                    if req and req.Url and tostring(req.Url):lower():find("abuse") then
                        return {StatusCode = 200, Body = "Blocked"}
                    end
                    return oldRequest(req)
                end)
            end)
            
            if success then
                data.hooks.requestHooked = true
                return true
            end
        end
        return false
    end

    local function hookFindFirstChild()
        if data.hooks.findHooked then return true end
        
        local oldFind = workspace.FindFirstChild
        if type(oldFind) == "function" and type(hookfunction) == "function" then
            local success = pcall(function()
                hookfunction(oldFind, function(self, name, ...)
                    if checkcaller and checkcaller() then 
                        return oldFind(self, name, ...) 
                    end
                    if name and tostring(name):lower():find("screenshot") then 
                        return nil 
                    end
                    if name and tostring(name):lower():find("video") then 
                        return nil 
                    end
                    return oldFind(self, name, ...)
                end)
            end)
            
            if success then
                data.hooks.findHooked = true
                return true
            end
        end
        return false
    end

    local function setupMetatableHooks()
        if data.hooks.bypassHooked then return true end
        
        if getrawmetatable and hookmetamethod and newcclosure then
            local success = pcall(function()
                local mt = getrawmetatable(game)
                if not mt then return false end
                
                setreadonly(mt, false)
                
                -- 保存原始方法
                oldNamecall = oldNamecall or mt.__namecall
                oldIndex = oldIndex or mt.__index

                -- 设置namecall hook
                mt.__namecall = newcclosure(function(self, ...)
                    if checkcaller and checkcaller() then
                        return oldNamecall(self, ...)
                    end
                    
                    local method = getnamecallmethod()
                    local args = {...}

                    if (method == "Kick" or method == "Ban") and self == LocalPlayer then 
                        return nil 
                    end

                    if (method == "FireServer" or method == "InvokeServer") and args[1] then
                        local msg = tostring(args[1]):lower()
                        if msg:find("kick") or msg:find("ban") or msg:find("report") then 
                            return nil 
                        end
                    end

                    if self == LocalizationService and method == "GetCountryRegionForPlayerAsync" then
                        local success, result = pcall(function()
                            return LocalizationService:GetCountryRegionForPlayerAsync(LocalPlayer)
                        end)
                        if success then return result else return "US" end
                    end

                    return oldNamecall(self, ...)
                end)

                -- 设置index hook
                mt.__index = newcclosure(function(t, k)
                    if checkcaller and checkcaller() then
                        return oldIndex(t, k)
                    end
                    
                    local key = tostring(k):lower()
                    if key:find("kick") or key:find("ban") or key:find("report") then 
                        return function() return nil end 
                    end
                    return oldIndex(t, k)
                end)

                setreadonly(mt, true)
            end)
            
            if success then
                data.hooks.bypassHooked = true
                return true
            end
        end
        return false
    end

    local function restoreMetatableHooks()
        if getrawmetatable and oldNamecall and oldIndex then
            pcall(function()
                local mt = getrawmetatable(game)
                if mt then
                    setreadonly(mt, false)
                    mt.__namecall = oldNamecall
                    mt.__index = oldIndex
                    setreadonly(mt, true)
                end
            end)
        end
    end

    local function startProtectionLoop()
        if protectionThread then
            task.cancel(protectionThread)
        end
        
        protectionThread = task.spawn(function()
            local lastCheck = os.clock()
            local checkCount = 0
            
            while data.running do
                local currentTime = os.clock()
                
                -- 每2秒执行一次完整的flag检查
                if currentTime - lastCheck >= 2 then
                    disableReportFlags()
                    lastCheck = currentTime
                    checkCount = checkCount + 1
                    
                    -- 每10次检查（20秒）输出一次调试信息
                    if checkCount % 10 == 0 then
                        print(string.format("[AntiCheat] Protection loop running - Check #%d", checkCount))
                    end
                end
                
                -- 使用小延迟避免占用过多CPU
                task.wait(0.1)
            end
            print("[AntiCheat] Protection loop stopped")
        end)
    end

    local function startAntiBanSafe()
        if data.running then 
            Library:Notify("Anti Cheat | Info\n反作弊绕过已在运行中")
            return true
        end
        
        -- 检查必要的exploit函数
        if not (getrawmetatable and hookmetamethod and newcclosure) then
            Library:Notify("Exploit不支持必要的函数")
            return false
        end

        data.running = true

        -- 异步执行避免卡顿
        task.spawn(function()
            local hooksApplied = 0
            local totalHooks = 3
            
            -- 应用hooks
            if hookRequests() then hooksApplied = hooksApplied + 1 end
            if hookFindFirstChild() then hooksApplied = hooksApplied + 1 end
            if setupMetatableHooks() then hooksApplied = hooksApplied + 1 end
            
            -- 启动保护循环
            startProtectionLoop()

            if hooksApplied > 0 then
                Library:Notify(string.format("Anti Cheat | Success\n绕过反作弊已开启！(%d/%d hooks)", hooksApplied, totalHooks))
                print("[AntiCheat] Anti-ban protection activated successfully")
            else
                Library:Notify("Anti Cheat | Warning\n部分hook应用失败")
            end
        end)
        
        return true
    end

    local function stopAntiBanSafe()
        if not data.running then return end
        
        print("[AntiCheat] Stopping anti-ban protection...")
        data.running = false
        
        -- 停止保护线程
        if protectionThread then
            task.cancel(protectionThread)
            protectionThread = nil
        end
        
        -- 异步恢复hooks
        task.spawn(function()
            restoreMetatableHooks()
            
            -- 重置hook状态
            data.hooks.requestHooked = false
            data.hooks.findHooked = false
            data.hooks.bypassHooked = false
            oldNamecall = nil
            oldIndex = nil
            
            Library:Notify("Anti Cheat | Info\n反作弊绕过已关闭")
            print("[AntiCheat] Anti-ban protection fully stopped")
        end)
    end

    local function toggleAntiBan(enabled)
        if enabled then
            return startAntiBanSafe()
        else
            stopAntiBanSafe()
            return true
        end
    end

    
    AntiBanSection:AddToggle("AntiBanToggle", {
        Text = "绕过AC",
        Default = data.running or false,
        Callback = function(enabled)
            local success = toggleAntiBan(enabled)
            if not success and enabled then
           
                task.spawn(function()
                    wait(0.1)
                    if AntiBanSection:GetToggle("AntiBanToggle") then
                        AntiBanSection:GetToggle("AntiBanToggle"):SetValue(false)
                    end
                end)
            end
        end
    })

   
    if data.running then
        task.spawn(function()
            wait(1)
            if AntiBanSection:GetToggle("AntiBanToggle") then
                AntiBanSection:GetToggle("AntiBanToggle"):SetValue(true)
                print("[AntiCheat] Restored previous anti-ban protection state")
            end
        end)
    end

  
    print(string.format("[AntiCheat] Initialized - Running: %s", tostring(data.running)))
end




do
    local Players = game:GetService("Players")
    local LocalPlayer = Players.LocalPlayer
    local LocalizationService = game:GetService("LocalizationService")

    shared.AntiBanSafe = shared.AntiBanSafe or {running = false, hooks = {}}
    local data = shared.AntiBanSafe

    local oldNamecall, oldIndex
    local protectionThread

    local function safe(func, ...)
        local ok, res = pcall(func, ...)
        if ok then return res end
    end

    local function disableReportFlags()
        if typeof(setfflag) == "function" then
            pcall(function()
                setfflag("AbuseReportScreenshot", "False")
                setfflag("AbuseReportScreenshotPercentage", "0")
                setfflag("AbuseReportEnabled", "False")
                setfflag("ReportAbuseMenu", "False")
                setfflag("EnableAbuseReportScreenshot", "False")
                setfflag("AbuseReportVideo", "False")
                setfflag("AbuseReportVideoPercentage", "0")
                setfflag("VideoCaptureEnabled", "False")
                setfflag("RecordVideo", "False")
            end)
        end
    end

    local function setFlagsOn()
        if typeof(setfflag) == "function" then
            pcall(function()
                setfflag("AbuseReportScreenshot", "True")
                setfflag("AbuseReportScreenshotPercentage", "100")
            end)
        end
    end

    local function hookRequests()
        if data.hooks.requestHooked then return end
        local oldRequest = (syn and syn.request) or request or http_request
        if typeof(oldRequest) == "function" and typeof(hookfunction) == "function" then
            hookfunction(oldRequest, function(req)
                if req and req.Url and tostring(req.Url):lower():find("abuse") then
                    return {StatusCode = 200, Body = "Blocked"}
                end
                return oldRequest(req)
            end)
            data.hooks.requestHooked = true
        end
    end

    local function hookFindFirstChild()
        if data.hooks.findHooked then return end
        local oldFind = workspace.FindFirstChild
        if typeof(oldFind) == "function" and typeof(hookfunction) == "function" then
            hookfunction(oldFind, function(self, name, ...)
                if name and tostring(name):lower():find("screenshot") then return nil end
                if name and tostring(name):lower():find("video") then return nil end
                return oldFind(self, name, ...)
            end)
            data.hooks.findHooked = true
        end
    end

    local function safeBypass()
        if getrawmetatable and hookmetamethod and newcclosure then
            local mt = getrawmetatable(game)
            setreadonly(mt, false)
            oldNamecall = oldNamecall or mt.__namecall
            oldIndex = oldIndex or mt.__index

            mt.__namecall = newcclosure(function(self, ...)
                local method = getnamecallmethod()
                local args = {...}

                if (method == "Kick" or method == "Ban") and self == LocalPlayer then return nil end

                if (method == "FireServer" or method == "InvokeServer") and args[1] then
                    local msg = tostring(args[1]):lower()
                    if msg:find("kick") or msg:find("ban") then return nil end
                end

                if self == LocalizationService and method == "GetCountryRegionForPlayerAsync" then
                    local success, result = pcall(function()
                        return LocalizationService:GetCountryRegionForPlayerAsync(LocalPlayer)
                    end)
                    if success then return result else return "US" end
                end

                return oldNamecall(self, ...)
            end)

            mt.__index = newcclosure(function(t, k)
                local key = tostring(k):lower()
                if key:find("kick") or key:find("ban") then return function() return nil end end
                return oldIndex(t, k)
            end)

            setreadonly(mt, true)
        end
    end

    local function restoreHooks()
        if getrawmetatable then
            local mt = getrawmetatable(game)
            setreadonly(mt, false)
            if oldNamecall then mt.__namecall = oldNamecall end
            if oldIndex then mt.__index = oldIndex end
            setreadonly(mt, true)
            oldNamecall, oldIndex = nil, nil
        end
    end

    local function startAntiBanSafe()
        if data.running then return end
        data.running = true

        safe(hookRequests)
        safe(hookFindFirstChild)
        safe(safeBypass)

        protectionThread = task.spawn(function()
            while data.running do
                safe(disableReportFlags)
                task.wait(0.2)
            end
        end)
    end

    local function stopAntiBanSafe()
        data.running = false
        protectionThread = nil
        restoreHooks()
        setFlagsOn()
    end

    AntiBanSection:AddToggle("AntiBanV3", {
        Text = "绕过反作弊V2",
        Description = "保护您免受封禁和举报",
        Default = false,
        Callback = function(state)
            if state then
                startAntiBanSafe()
            else
                stopAntiBanSafe()
            end
        end
    })
end

local ZZ = Tabs.Main:AddLeftGroupbox('自动狂暴[Jason]')

local Players = game:GetService("Players")
local lp = Players.LocalPlayer
local savedRange = lp:FindFirstChild("RagingPaceRange")
if not savedRange then
    savedRange = Instance.new("NumberValue")
    savedRange.Name = "RagingPaceRange"
    savedRange.Value = 19
    savedRange.Parent = lp
end

ZZ:AddSlider("RagingPaceRange", {
    Text = "狂暴触发距离",
    Default = savedRange.Value,
    Min = 1,
    Max = 50,
    Rounding = 0,
    Compact = true,
    Callback = function(value)
        savedRange.Value = value
    end
})

ZZ:AddToggle("RagingPace", {
    Text = "自动狂暴",
    Default = false,
    Callback = function(enabled)
        local threadId = tostring(math.random(1, 99999))
        _G.RagingPaceThreadId = threadId
        
        local function shouldContinue()
            return _G.RagingPaceThreadId == threadId and enabled
        end
        
        local RunService = game:GetService("RunService")
        local ReplicatedStorage = game:GetService("ReplicatedStorage")
        local RANGE = savedRange.Value
        local SPAM_DURATION = 3
        local COOLDOWN_TIME = 5
        local activeCooldowns = {}

        local animsToDetect = {
            ["116618003477002"] = true,
            ["119462383658044"] = true,
            ["131696603025265"] = true,
            ["121255898612475"] = true,
            ["133491532453922"] = true,
            ["103601716322988"] = true,
            ["86371356500204"] = true,
            ["72722244508749"] = true,
            ["87259391926321"] = true,
            ["96959123077498"] = true,
        }

        local function fireRagingPace()
            local args = {
                "UseActorAbility",
                {
                    buffer.fromstring("\"RagingPace\"")
                }
            }
            ReplicatedStorage:WaitForChild("Modules")
                :WaitForChild("Network")
                :WaitForChild("RemoteEvent")
                :FireServer(unpack(args))
        end

        local function isAnimationMatching(anim)
            local id = tostring(anim.Animation and anim.Animation.AnimationId or "")
            local numId = id:match("%d+")
            return animsToDetect[numId] or false
        end

        local function runDetection()
            local connection
            connection = RunService.Heartbeat:Connect(function()
                if not shouldContinue() then
                    connection:Disconnect()
                    return
                end
                
                for _, player in ipairs(Players:GetPlayers()) do
                    if not shouldContinue() then break end
                    
                    if player ~= lp and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                        local targetHRP = player.Character.HumanoidRootPart
                        local myChar = lp.Character
                        if myChar and myChar:FindFirstChild("HumanoidRootPart") then
                            local dist = (targetHRP.Position - myChar.HumanoidRootPart.Position).Magnitude
                            if dist <= RANGE and (not activeCooldowns[player] or tick() - activeCooldowns[player] >= COOLDOWN_TIME) then
                                local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
                                if humanoid then
                                    for _, track in pairs(humanoid:GetPlayingAnimationTracks()) do
                                        if not shouldContinue() then break end
                                        
                                        if isAnimationMatching(track) then
                                            activeCooldowns[player] = tick()
                                            task.spawn(function()
                                                local startTime = tick()
                                                while shouldContinue() and tick() - startTime < SPAM_DURATION do
                                                    fireRagingPace()
                                                    task.wait(0.05)
                                                end
                                            end)
                                            break
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end)
            
            return connection
        end

        if enabled then
            if _G.RagingPaceConnection then
                _G.RagingPaceConnection:Disconnect()
                _G.RagingPaceConnection = nil
            end
            
            _G.RagingPaceConnection = runDetection()
        else
            if _G.RagingPaceConnection then
                _G.RagingPaceConnection:Disconnect()
                _G.RagingPaceConnection = nil
            end
        end
    end
})



local ZZ = Tabs.Main:AddLeftGroupbox('自动使用404错误[John doe]')

ZZ:AddToggle("AntiAnimations", {
    Text = "自动404错误[势无可挡]",
    Default = false,
    Callback = function(enabled)
        local threadId = tostring(math.random(1, 99999))
        _G.AntiAnimThreadId = threadId
        
        local function shouldContinue()
            return _G.AntiAnimThreadId == threadId and enabled
        end
        
        local Players = game:GetService("Players")
        local RunService = game:GetService("RunService")
        local ReplicatedStorage = game:GetService("ReplicatedStorage")
        local lp = Players.LocalPlayer
        local RANGE = 19
        local SPAM_DURATION = 3
        local COOLDOWN_TIME = 5
        local activeCooldowns = {}

        local animsToDetect = {
            ["116618003477002"] = true,
            ["119462383658044"] = true,
            ["131696603025265"] = true,
            ["121255898612475"] = true,
            ["133491532453922"] = true,
            ["103601716322988"] = true,
            ["86371356500204"] = true,
            ["72722244508749"] = false,
            ["87259391926321"] = true,
            ["96959123077498"] = false,
            ["86709774283672"] = true,
            ["77448521277146"] = true,
        }

        local function fire404Error()
            local args = {
                "UseActorAbility",
                {
                    buffer.fromstring("\"404Error\"")
                }
            }
            ReplicatedStorage:WaitForChild("Modules")
                :WaitForChild("Network")
                :WaitForChild("RemoteEvent")
                :FireServer(unpack(args))
        end

        local function isAnimationMatching(anim)
            local id = tostring(anim.Animation and anim.Animation.AnimationId or "")
            local numId = id:match("%d+")
            return animsToDetect[numId] or false
        end

        local function runDetection()
            local connection
            connection = RunService.Heartbeat:Connect(function()
                if not shouldContinue() then
                    connection:Disconnect()
                    return
                end
                
                for _, player in ipairs(Players:GetPlayers()) do
                    if not shouldContinue() then break end
                    
                    if player ~= lp and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                        local targetHRP = player.Character.HumanoidRootPart
                        local myChar = lp.Character
                        if myChar and myChar:FindFirstChild("HumanoidRootPart") then
                            local dist = (targetHRP.Position - myChar.HumanoidRootPart.Position).Magnitude
                            if dist <= RANGE and (not activeCooldowns[player] or tick() - activeCooldowns[player] >= COOLDOWN_TIME) then
                                local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
                                if humanoid then
                                    for _, track in pairs(humanoid:GetPlayingAnimationTracks()) do
                                        if not shouldContinue() then break end
                                        
                                        if isAnimationMatching(track) then
                                            activeCooldowns[player] = tick()
                                            task.spawn(function()
                                                local startTime = tick()
                                                while shouldContinue() and tick() - startTime < SPAM_DURATION do
                                                    fire404Error()
                                                    task.wait(0.05)
                                                end
                                            end)
                                            break
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end)
            
            return connection
        end

        if enabled then
            if _G.AntiAnimConnection then
                _G.AntiAnimConnection:Disconnect()
                _G.AntiAnimConnection = nil
            end
            
            _G.AntiAnimConnection = runDetection()
        else
            if _G.AntiAnimConnection then
                _G.AntiAnimConnection:Disconnect()
                _G.AntiAnimConnection = nil
            end
        end
    end
})

local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local MVP = Tabs.Sat:AddLeftGroupbox("体力设置")

local StaminaSettings = {
    MaxStamina = 100,
    StaminaGain = 25,
    StaminaLoss = 10,
    SprintSpeed = 28,
    InfiniteGain = 9999
}

local SettingToggles = {
    MaxStamina = false,
    StaminaGain = false,
    StaminaLoss = false,
    SprintSpeed = false
}

local SprintingModule = ReplicatedStorage:WaitForChild("Systems"):WaitForChild("Character"):WaitForChild("Game"):WaitForChild("Sprinting")
local GetModule = function() return require(SprintingModule) end

task.spawn(function()
    while true do
        local m = GetModule()
        for key, value in pairs(StaminaSettings) do
            if SettingToggles[key] then
                m[key] = value
            end
        end
        task.wait(0.5)
    end
end)

local bai = {Spr = false}
local connection

MVP:AddToggle('MyToggle', {
    Text = '无限体力',
    Default = false,
    Tooltip = '无限体力',
    Callback = function(state)
        bai.Spr = state
        local Sprinting = GetModule()

        if state then
            Sprinting.StaminaLoss = 0
            Sprinting.StaminaGain = StaminaSettings.InfiniteGain

            if connection then connection:Disconnect() end
            connection = RunService.Heartbeat:Connect(function()
                if not bai.Spr then return end
                Sprinting.StaminaLoss = 0
                Sprinting.StaminaGain = StaminaSettings.InfiniteGain
            end)
        else
            Sprinting.StaminaLoss = 10
            Sprinting.StaminaGain = 25

            if connection then
                connection:Disconnect()
                connection = nil
            end
        end
    end
})

MVP:AddToggle('MaxStaminaToggle', {
    Text = '启用体力调整',
    Default = false,
    Callback = function(Value)
        SettingToggles.MaxStamina = Value
    end
})

MVP:AddToggle('StaminaGainToggle', {
    Text = '启用体力恢复调整',
    Default = false,
    Callback = function(Value)
        SettingToggles.StaminaGain = Value
    end
})

MVP:AddToggle('StaminaLossToggle', {
    Text = '启用体力消耗调整',
    Default = false,
    Callback = function(Value)
        SettingToggles.StaminaLoss = Value
    end
})

MVP:AddToggle('SprintSpeedToggle', {
    Text = '启用奔跑速度调整',
    Default = false,
    Callback = function(Value)
        SettingToggles.SprintSpeed = Value
    end
})

local MVP2 = Tabs.Sat:AddRightGroupbox("调试设置")

MVP2:AddSlider('InfStaminaGainSlider', {
    Text = '无限体力恢复速度',
    Default = 9999,
    Min = 0,
    Max = 10000,
    Rounding = 0,
    Callback = function(Value)
        StaminaSettings.InfiniteGain = Value
        if bai.Spr then
            local Sprinting = GetModule()
            Sprinting.StaminaGain = Value
        end
    end
})

MVP2:AddSlider('MySlider1', {
    Text = '最大体力值',
    Default = 100,
    Min = 0,
    Max = 9999,
    Rounding = 0,
    Callback = function(Value)
        StaminaSettings.MaxStamina = Value
        if SettingToggles.MaxStamina then
            local Sprinting = GetModule()
            Sprinting.MaxStamina = Value
        end
    end
})

MVP2:AddSlider('MySlider2', {
    Text = '体力恢复速度',
    Default = 25,
    Min = 0,
    Max = 500,
    Rounding = 0,
    Callback = function(Value)
        StaminaSettings.StaminaGain = Value
        if SettingToggles.StaminaGain and not bai.Spr then
            local Sprinting = GetModule()
            Sprinting.StaminaGain = Value
        end
    end
})

MVP2:AddSlider('MySlider3', {
    Text = '体力消耗速度',
    Default = 10,
    Min = 0,
    Max = 800,
    Rounding = 0,
    Callback = function(Value)
        StaminaSettings.StaminaLoss = Value
        if SettingToggles.StaminaLoss and not bai.Spr then
            local Sprinting = GetModule()
            Sprinting.StaminaLoss = Value
        end
    end
})

MVP2:AddSlider('MySlider4', {
    Text = '奔跑速度',
    Default = 28,
    Min = 0,
    Max = 200,
    Rounding = 0,
    Callback = function(Value)
        StaminaSettings.SprintSpeed = Value
        if SettingToggles.SprintSpeed then
            local Sprinting = GetModule()
            Sprinting.SprintSpeed = Value
        end
    end
})






getgenv().RS = game:GetService("ReplicatedStorage")
getgenv().TS = game:GetService("TweenService")
getgenv().RSvc = game:GetService("RunService")
getgenv().Plrs = game:GetService("Players")
getgenv().LocalP = Plrs.LocalPlayer
getgenv().LocalGui = LocalP:WaitForChild("PlayerGui")
getgenv().LocalHum, getgenv().LocalAnim = nil, nil

-- 确保 buffer 库可用
getgenv().buffer = buffer or require(game:GetService("ReplicatedStorage").Buffer)

getgenv().AutoBlockSounds = {
    ["102228729296384"] = true,
    ["140242176732868"] = true,
    ["112809109188560"] = true,
    ["136323728355613"] = true,
    ["115026634746636"] = true,
    ["84116622032112"] = true,
    ["108907358619313"] = true,
    ["127793641088496"] = true,
    ["86174610237192"] = true,
    ["95079963655241"] = true,
    ["101199185291628"] = true,
    ["119942598489800"] = true,
    ["84307400688050"] = true,
    ["113037804008732"] = true,
    ["105200830849301"] = true,
    ["75330693422988"] = true,
    ["82221759983649"] = true,
    ["81702359653578"] = true,
    ["108610718831698"] = true,
    ["112395455254818"] = true,
    ["136323728355613"] = true,
    ["81702359653578"] = true,
    ["86174610237192"] = true,
    ["95079963655241"] = true,
    ["101199185291628"] = true,
    ["109431876587852"] = true,
    ["115026634746636"] = true,
    ["119942598489800"] = true,
    ["109348678063422"] = true,
    ["85853080745515"] = true
}

getgenv().AutoBlockAnims = {
    ["126830014841198"] = true,
    ["126355327951215"] = true,
    ["121086746534252"] = true,
    ["18885909645"] = true,
    ["98456918873918"] = true,
    ["105458270463374"] = true,
    ["83829782357897"] = true,
    ["125403313786645"] = true,
    ["118298475669935"] = true,
    ["82113744478546"] = true,
    ["70371667919898"] = true,
    ["99135633258223"] = true,
    ["97167027849946"] = true,
    ["109230267448394"] = true,
    ["139835501033932"] = true,
    ["126896426760253"] = true,
    ["109667959938617"] = true,
    ["126681776859538"] = true,
    ["129976080405072"] = true,
    ["121293883585738"] = true,
    ["81639435858902"] = true,
    ["137314737492715"] = true,
    ["92173139187970"] = true
}

getgenv().LastAimTime = {}   
getgenv().AimDuration = 0.5      
getgenv().AimCooldown = 0.6    

getgenv().AutoBlockEnabled = false
getgenv().LooseFacingCheck = true
getgenv().SenseRange = 18

getgenv().KnownKillers = {"c00lkidd", "Jason", "JohnDoe", "1x1x1x1", "Noli", "Slasher"}
getgenv().KillersFolder = workspace:WaitForChild("Players"):WaitForChild("Killers")

getgenv().SenseRangeSq = SenseRange * SenseRange

getgenv().KillerCircles = {}
getgenv().CirclesVisible = false

getgenv().AddKillerCircle = function(killer)
    if not killer:FindFirstChild("HumanoidRootPart") then return end
    if KillerCircles[killer] then return end

    local circ = Instance.new("CylinderHandleAdornment")
    circ.Name = "KillerDetectionCircle"
    circ.Adornee = killer.HumanoidRootPart
    circ.Color3 = Color3.fromRGB(255, 0, 0)
    circ.AlwaysOnTop = true
    circ.ZIndex = 0
    circ.Transparency = 0.7
    circ.Radius = SenseRange / 1.5
    circ.Height = 0.1
    circ.CFrame = CFrame.Angles(math.rad(90), 0, 0)
    circ.Parent = killer.HumanoidRootPart

    KillerCircles[killer] = circ
end

getgenv().RemoveKillerCircle = function(killer)
    if KillerCircles[killer] then
        KillerCircles[killer]:Destroy()
        KillerCircles[killer] = nil
    end
end

getgenv().RefreshKillerCircles = function()
    for _, killer in ipairs(KillersFolder:GetChildren()) do
        if CirclesVisible then
            AddKillerCircle(killer)
        else
            RemoveKillerCircle(killer)
        end
    end
end

getgenv().FacingCheckEnabled = true

getgenv().FireBlockRemote = function()
    if not AutoBlockEnabled then return end
    
    local args = {
        "UseActorAbility",
        {
            buffer.fromstring("\"Block\"")
        }
    }
    game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("Network"):WaitForChild("RemoteEvent"):FireServer(unpack(args))
end

getgenv().IsFacingTarget = function(myRoot, targetRoot)
    if not FacingCheckEnabled then return true end
    local dir = (myRoot.Position - targetRoot.Position).Unit
    local dot = targetRoot.CFrame.LookVector:Dot(dir)
    return LooseFacingCheck and dot > -0.3 or dot > 0
end

getgenv().GetAnimIdNumeric = function(anim)
    if not anim or not anim.AnimationId then return nil end
    local aid = tostring(anim.AnimationId)
    local num = aid:match("%d+")
    if num then return num end
    return nil
end

getgenv().AnimationHooks = {}
getgenv().AnimationBlockedUntil = {}

getgenv().AttemptBlockAnimation = function(track)
    if not AutoBlockEnabled then return end
    if not track or not track.Animation then return end
    if not track.IsPlaying then return end

    local id = GetAnimIdNumeric(track.Animation)
    if not id or not AutoBlockAnims[id] then return end

    local now = tick()
    if AnimationBlockedUntil[track] and now < AnimationBlockedUntil[track] then return end

    local char = track.Parent and track.Parent.Parent
    if not char then return end

    local myRoot = LocalP.Character and LocalP.Character:FindFirstChild("HumanoidRootPart")
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not myRoot or not hrp then return end

    local dvec = hrp.Position - myRoot.Position
    local distSq = dvec.X^2 + dvec.Y^2 + dvec.Z^2
    if distSq > SenseRangeSq then return end

    if FacingCheckEnabled and not IsFacingTarget(myRoot, hrp) then return end

    FireBlockRemote()
    AnimationBlockedUntil[track] = now + 1.2
end

getgenv().HookAnimation = function(track)
    if not track or not track:IsA("AnimationTrack") then return end
    if AnimationHooks[track] then return end

    local playConn = track:GetPropertyChangedSignal("IsPlaying"):Connect(function()
        if track.IsPlaying then pcall(AttemptBlockAnimation, track) end
    end)
    local destroyConn
    destroyConn = track.Destroying:Connect(function()
        if playConn.Connected then playConn:Disconnect() end
        if destroyConn.Connected then destroyConn:Disconnect() end
        AnimationHooks[track] = nil
        AnimationBlockedUntil[track] = nil
    end)

    AnimationHooks[track] = {playConn, destroyConn}
    if track.IsPlaying then
        task.spawn(function() pcall(AttemptBlockAnimation, track) end)
    end
end

getgenv().HookAnimator = function(animator)
    if not animator then return end
    for _, track in pairs(animator:GetPlayingAnimationTracks()) do
        pcall(HookAnimation, track)
    end
    
    animator.AnimationPlayed:Connect(function(track)
        pcall(HookAnimation, track)
    end)
end

getgenv().SoundHooks = {}
getgenv().SoundBlockedUntil = {}

getgenv().GetNearestKillerRoot = function(maxDist)
    local kFolder = workspace:FindFirstChild("Players") and workspace.Players:FindFirstChild("Killers")
    if not kFolder then return nil end
    local myRoot = LocalP.Character and LocalP.Character:FindFirstChild("HumanoidRootPart")
    if not myRoot then return nil end

    local closest, minDist = nil, maxDist or math.huge
    for _, k in ipairs(kFolder:GetChildren()) do
        local hrp = k:FindFirstChild("HumanoidRootPart")
        if hrp then
            local d = (hrp.Position - myRoot.Position).Magnitude
            if d < minDist then
                closest, minDist = hrp, d
            end
        end
    end
    return closest
end

getgenv().GetSoundIdNumeric = function(snd)
    if not snd or not snd.SoundId then return nil end
    local sid = tostring(snd.SoundId)
    local num = sid:match("%d+")
    if num then return num end
    return nil
end

getgenv().GetSoundPosition = function(snd)
    if not snd then return nil end
    if snd.Parent and snd.Parent:IsA("BasePart") then
        return snd.Parent.Position, snd.Parent
    end
    if snd.Parent and snd.Parent:IsA("Attachment") and snd.Parent.Parent and snd.Parent.Parent:IsA("BasePart") then
        return snd.Parent.Parent.Position, snd.Parent.Parent
    end
    local found = snd.Parent and snd.Parent:FindFirstChildWhichIsA("BasePart", true)
    return found and found.Position, found or nil, nil
end

getgenv().GetCharFromDescendant = function(inst)
    if not inst then return nil end
    local mdl = inst:FindFirstAncestorOfClass("Model")
    return mdl and mdl:FindFirstChildOfClass("Humanoid") and mdl or nil
end

getgenv().AttemptBlockSound = function(snd)
    if not AutoBlockEnabled then return end
    if not snd or not snd:IsA("Sound") then return end
    if not snd.IsPlaying then return end

    local id = GetSoundIdNumeric(snd)
    if not id or not AutoBlockSounds[id] then return end

    local now = tick()
    if SoundBlockedUntil[snd] and now < SoundBlockedUntil[snd] then return end

    local myRoot = LocalP.Character and LocalP.Character:FindFirstChild("HumanoidRootPart")
    if not myRoot then return end

    local pos, part = GetSoundPosition(snd)
    if not pos or not part then return end

    local char = GetCharFromDescendant(part)
    local plr = char and Plrs:GetPlayerFromCharacter(char)
    if not plr or plr == LocalP then return end

    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end

    local dvec = hrp.Position - myRoot.Position
    local distSq = dvec.X^2 + dvec.Y^2 + dvec.Z^2
    if distSq > SenseRangeSq then return end

    if FacingCheckEnabled and not IsFacingTarget(myRoot, hrp) then return end

    FireBlockRemote()
    SoundBlockedUntil[snd] = now + 1.2
end

getgenv().HookSound = function(snd)
    if not snd or not snd:IsA("Sound") then return end
    if SoundHooks[snd] then return end

    local playConn = snd.Played:Connect(function()
        pcall(AttemptBlockSound, snd)
    end)
    local propConn = snd:GetPropertyChangedSignal("IsPlaying"):Connect(function()
        if snd.IsPlaying then pcall(AttemptBlockSound, snd) end
    end)
    local destroyConn
    destroyConn = snd.Destroying:Connect(function()
        if playConn.Connected then playConn:Disconnect() end
        if propConn.Connected then propConn:Disconnect() end
        if destroyConn.Connected then destroyConn:Disconnect() end
        SoundHooks[snd] = nil
        SoundBlockedUntil[snd] = nil
    end)

    SoundHooks[snd] = {playConn, propConn, destroyConn}
    if snd.IsPlaying then
        task.spawn(function() pcall(AttemptBlockSound, snd) end)
    end
end

for _, d in ipairs(game:GetDescendants()) do
    if d:IsA("Sound") then
        pcall(HookSound, d)
    end
    if d:IsA("Animator") then
        pcall(HookAnimator, d)
    end
end

game.DescendantAdded:Connect(function(d)
    if d:IsA("Sound") then pcall(HookSound, d) end
    if d:IsA("Animator") then pcall(HookAnimator, d) end
end)

LocalP.CharacterAdded:Connect(function(char)
    task.wait(0.5)
    local humanoid = char:FindFirstChildOfClass("Humanoid")
    if humanoid then
        local animator = humanoid:FindFirstChildOfClass("Animator")
        if animator then
            pcall(HookAnimator, animator)
        end
    end
end)

RSvc.RenderStepped:Connect(function()
    for killer, circ in pairs(KillerCircles) do
        if circ and circ.Parent then
            circ.Radius = SenseRange / 1.5
        end
    end
end)

KillersFolder.ChildAdded:Connect(function(killer)
    if CirclesVisible then
        task.spawn(function()
            local hrp = killer:WaitForChild("HumanoidRootPart", 5)
            if hrp then
                AddKillerCircle(killer)
            end
        end)
    end
end)

KillersFolder.ChildRemoved:Connect(function(killer)
    RemoveKillerCircle(killer)
end)

local ZZ = Tabs.zdg:AddLeftGroupbox('Guest 1337自动格挡V2')

ZZ:AddToggle("AutoBlockToggle", {
    Text = "自动格挡",
    Default = false,
    Callback = function(state)
        AutoBlockEnabled = state
    end
})

ZZ:AddSlider("SenseRangeSlider", {
    Text = "检测范围",
    Default = 18,
    Min = 5,
    Max = 30,
    Rounding = 1,
    Callback = function(value)
        SenseRange = value
        SenseRangeSq = SenseRange * SenseRange
    end
})

ZZ:AddToggle("CircleToggle", {
    Text = "显示范围",
    Default = false,
    Callback = function(state)
        CirclesVisible = state
        RefreshKillerCircles()
    end
})

ZZ:AddToggle("FacingToggle", {
    Text = "方向检测",
    Default = true,
    Callback = function(Value)
        FacingCheckEnabled = Value
    end
})

ZZ:AddDropdown("FacingMode", {
    Values = {"宽松", "严格"},
    Default = "宽松",
    Multi = false,
    Callback = function(opt)
        LooseFacingCheck = opt == "宽松"
    end
})


local ZZ = Tabs.zdg:AddLeftGroupbox('自动格挡[Guest 1337]')

local config_114514 = {
    Enabled = false,
    BaseDistance = 16,
    ScanInterval = 0.0005,
    BlockCooldown = 0.06,
    MoveCompBase = 1.8,
    MoveCompFactor = 0.3,
    SpeedThreshold = 6,
    PredictBase = 5,
    PredictMax = 15,
    PredictFactor = 0.45,
    TargetAngle = 50,
    MinAttackSpeed = 10,
    ShowVisualization = false,
    EnablePrediction = false,
    PingCompensation = 0.15,
    FastKillerAdjust = 1.5,
    ReactionBoost = 1.2,
    TargetSoundIds = {
        "102228729296384", "140242176732868", "112809109188560", "136323728355613",
        "115026634746636", "84116622032112", "108907358619313", "127793641088496",
        "86174610237192", "95079963655241", "101199185291628", "119942598489800",
        "84307400688050", "113037804008732", "105200830849301", "75330693422988",
        "82221759983649", "81702359653578", "108610718831698", "112395455254818",
        "109431876587852", "109348678063422", "85853080745515", "12222216"
    },
    TargetAnimIds = {
        "126830014841198", "126355327951215", "121086746534252", "18885909645",
        "98456918873918", "105458270463374", "83829782357897", "125403313786645",
        "118298475669935", "82113744478546", "70371667919898", "99135633258223",
        "97167027849946", "109230267448394", "139835501033932", "126896426760253",
        "109667959938617", "126681776859538", "129976080405072", "121293883585738",
        "81639435858902", "137314737492715", "92173139187970"
    }
}

pcall(function()
    local Players = game:GetService("Players")
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local RunService = game:GetService("RunService")
    local Stats = game:GetService("Stats")
    
    local soundLookup = {}
    for _, id in ipairs(config_114514.TargetSoundIds) do
        soundLookup[id] = true
        soundLookup["rbxassetid://" .. id] = true
    end
    
    local animLookup = {}
    for _, id in ipairs(config_114514.TargetAnimIds) do
        animLookup[id] = true
        animLookup["rbxassetid://" .. id] = true
    end
    
    local LocalPlayer = Players.LocalPlayer
    local lastBlockTime = 0
    local combatConnection = nil
    local lastScanTime = 0
    local visualizationParts = {}
    local soundCache = {}
    local animCache = {}
    local lastSoundCheck = 0
    local lastAnimCheck = 0
    local lastPingCheck = 0
    local currentPing = 0
    local threatCache = {}
    local lastThreatUpdate = 0
    
    local function GetPing()
        local currentTime = os.clock()
        if currentTime - lastPingCheck < 0.3 then
            return currentPing
        end
        lastPingCheck = currentTime
        
        local stats = Stats and Stats.Network and Stats.Network:FindFirstChild("ServerStatsItem")
        if stats then
            local pingStat = stats:FindFirstChild("Data Ping")
            if pingStat then
                currentPing = pingStat.Value
                return currentPing
            end
        end
        
        return 0
    end
    
    local function GetPingCompensation()
        local ping = GetPing()
        return math.min(0.4, ping / 1000 * config_114514.PingCompensation * 12)
    end
    
    local function CreateVisualization()
        if not LocalPlayer.Character then return end
        local rootPart = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if not rootPart then return end
        
        for _, part in ipairs(visualizationParts) do
            part:Destroy()
        end
        visualizationParts = {}
        
        local center = rootPart.Position
        local distance = config_114514.BaseDistance
        local angle = math.rad(config_114514.TargetAngle)
        local segments = 36
        
        -- 创建中心球体表示玩家位置
        local centerSphere = Instance.new("Part")
        centerSphere.Size = Vector3.new(1, 1, 1)
        centerSphere.Position = center + Vector3.new(0, 0.5, 0)
        centerSphere.Shape = Enum.PartType.Ball
        centerSphere.BrickColor = BrickColor.new("Bright blue")
        centerSphere.Material = Enum.Material.Neon
        centerSphere.Transparency = 0.3
        centerSphere.Anchored = true
        centerSphere.CanCollide = false
        centerSphere.Parent = workspace
        table.insert(visualizationParts, centerSphere)
        
        -- 创建扇形区域表示格挡范围
        for i = 1, segments do
            local part = Instance.new("Part")
            part.Size = Vector3.new(0.3, 0.1, 0.3)
            part.BrickColor = BrickColor.new("Bright green")
            part.Material = Enum.Material.Neon
            part.Transparency = 0.7
            part.Anchored = true
            part.CanCollide = false
            part.Parent = workspace
            table.insert(visualizationParts, part)
        end
        
        local function UpdateVisualization()
            if not config_114514.ShowVisualization then return end
            if not LocalPlayer.Character then return end
            local root = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            if not root then return end
            
            local center = root.Position + Vector3.new(0, 0.5, 0)
            local lookVector = root.CFrame.LookVector
            local distance = config_114514.BaseDistance
            local angle = math.rad(config_114514.TargetAngle)
            
            -- 更新中心球体位置
            centerSphere.Position = center
            
            -- 更新扇形区域
            for i = 1, #visualizationParts - 1 do
                local part = visualizationParts[i + 1]
                local segmentAngle = (i - 1) * (2 * angle) / (#visualizationParts - 2) - angle
                local rotCFrame = CFrame.fromAxisAngle(Vector3.new(0, 1, 0), segmentAngle)
                local dir = rotCFrame:VectorToWorldSpace(lookVector)
                local pos = center + dir * distance
                part.Position = pos
                
                -- 设置扇形区域的朝向
                local lookAtCenter = CFrame.lookAt(pos, center)
                part.CFrame = lookAtCenter
            end
        end
        
        local visConnection
        visConnection = RunService.Heartbeat:Connect(function()
            if not config_114514.ShowVisualization then
                for _, part in ipairs(visualizationParts) do
                    part:Destroy()
                end
                visualizationParts = {}
                visConnection:Disconnect()
                return
            end
            pcall(UpdateVisualization)
        end)
    end
    
    local function HasTargetSound(character)
        if not character then return false end
        local rootPart = character:FindFirstChild("HumanoidRootPart")
        if not rootPart then return false end
        
        local currentTime = os.clock()
        if currentTime - lastSoundCheck < 0.0003 then
            return soundCache[character] or false
        end
        lastSoundCheck = currentTime
        
        local found = false
        for _, child in ipairs(rootPart:GetChildren()) do
            if child:IsA("Sound") then
                local soundId = tostring(child.SoundId)
                local numericId = string.match(soundId, "(%d+)$")
                if numericId and soundLookup[numericId] then
                    found = true
                    break
                end
            end
        end
        
        soundCache[character] = found
        return found
    end
    
    local function HasTargetAnimation(character)
        if not character then return false end
        local humanoid = character:FindFirstChildOfClass("Humanoid")
        if not humanoid then return false end
        
        local currentTime = os.clock()
        if currentTime - lastAnimCheck < 0.0003 then
            return animCache[character] or false
        end
        lastAnimCheck = currentTime
        
        local found = false
        local animator = humanoid:FindFirstChildOfClass("Animator")
        if animator then
            for _, track in pairs(animator:GetPlayingAnimationTracks()) do
                if track.Animation then
                    local animId = tostring(track.Animation.AnimationId)
                    local numericId = string.match(animId, "(%d+)$")
                    if numericId and animLookup[numericId] then
                        found = true
                        break
                    end
                end
            end
        end
        
        animCache[character] = found
        return found
    end
    
    local function GetMoveCompensation()
        if not LocalPlayer.Character then return 0 end
        local rootPart = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if not rootPart then return 0 end
        
        local velocity = rootPart.Velocity
        local speed = math.sqrt(velocity.X^2 + velocity.Y^2 + velocity.Z^2)
        return config_114514.MoveCompBase + (speed * config_114514.MoveCompFactor)
    end
    
    local function IsFastKiller(killer)
        if not killer then return false end
        local killerRoot = killer:FindFirstChild("HumanoidRootPart")
        if not killerRoot then return false end
        
        local killerVel = killerRoot.Velocity
        local killerSpeed = math.sqrt(killerVel.X^2 + killerVel.Y^2 + killerVel.Z^2)
        return killerSpeed > config_114514.MinAttackSpeed
    end
    
    local function GetTotalDetectionRange(killer)
        local base = config_114514.BaseDistance
        local moveBonus = GetMoveCompensation()
        local predict = 0
        local pingBonus = GetPingCompensation() * 8
        local reactionBoost = config_114514.ReactionBoost

        if config_114514.EnablePrediction and killer and killer:FindFirstChild("HumanoidRootPart") then
            local killerVel = killer.HumanoidRootPart.Velocity
            local killerSpeed = math.sqrt(killerVel.X^2 + killerVel.Y^2 + killerVel.Z^2)
            
            if killerSpeed > config_114514.SpeedThreshold then
                predict = math.min(
                    config_114514.PredictMax, 
                    config_114514.PredictBase + (killerSpeed * config_114514.PredictFactor)
                )
            end
            
            if IsFastKiller(killer) then
                predict = predict * config_114514.FastKillerAdjust
            end
        end
        
        return (base + moveBonus + predict + pingBonus) * reactionBoost
    end
    
    local function IsTargetingMe(killer)
        local myCharacter = LocalPlayer.Character
        if not myCharacter then return false end
        
        local myRoot = myCharacter:FindFirstChild("HumanoidRootPart")
        local killerRoot = killer and killer:FindFirstChild("HumanoidRootPart")
        if not myRoot or not killerRoot then return false end
        
        local directionToMe = (myRoot.Position - killerRoot.Position).Unit
        local killerLook = killerRoot.CFrame.LookVector
        
        local dot = directionToMe:Dot(killerLook)
        local angle = math.deg(math.acos(math.clamp(dot, -1, 1)))
        
        return angle <= config_114514.TargetAngle
    end
    
    local function IsKillerInRange(killer)
        local myCharacter = LocalPlayer.Character
        if not myCharacter then return false end
        
        local myRoot = myCharacter:FindFirstChild("HumanoidRootPart")
        local killerRoot = killer and killer:FindFirstChild("HumanoidRootPart")
        if not myRoot or not killerRoot then return false end
        
        -- 计算杀手与玩家的实际距离
        local distance = (myRoot.Position - killerRoot.Position).Magnitude
        local detectionRange = GetTotalDetectionRange(killer)
        
        -- 只有当杀手在检测范围内时才返回true
        return distance <= detectionRange
    end
    
    local function UpdateThreatCache()
        local currentTime = os.clock()
        if currentTime - lastThreatUpdate < 0.1 then
            return threatCache
        end
        lastThreatUpdate = currentTime
        
        threatCache = {}
        local killersFolder = workspace:FindFirstChild("Killers") or (workspace:FindFirstChild("Players") and workspace.Players:FindFirstChild("Killers"))
        if not killersFolder then return threatCache end
        
        local myCharacter = LocalPlayer.Character
        if not myCharacter then return threatCache end
        
        local myRoot = myCharacter:FindFirstChild("HumanoidRootPart")
        if not myRoot then return threatCache end
        
        for _, killer in ipairs(killersFolder:GetChildren()) do
            if killer:IsA("Model") and killer:FindFirstChild("HumanoidRootPart") then
                local killerRoot = killer.HumanoidRootPart
                
                -- 首先检查杀手是否在范围内
                if IsKillerInRange(killer) and IsTargetingMe(killer) then
                    local hasSound = HasTargetSound(killer)
                    local hasAnim = HasTargetAnimation(killer)
                    
                    if hasSound or hasAnim then
                        local distance = (myRoot.Position - killerRoot.Position).Magnitude
                        local detectionRange = GetTotalDetectionRange(killer)
                        
                        threatCache[killer] = {
                            distance = distance,
                            detectionRange = detectionRange,
                            timestamp = currentTime,
                            hasSound = hasSound,
                            hasAnim = hasAnim
                        }
                    end
                end
            end
        end
        
        return threatCache
    end
    
    local function GetThreateningKillers()
        local cache = UpdateThreatCache()
        local killers = {}
        local currentTime = os.clock()
        
        for killer, data in pairs(cache) do
            if currentTime - data.timestamp < 0.2 then
                table.insert(killers, killer)
            end
        end
        
        return killers
    end
    
    local function GetAdjustedCooldown()
        local ping = GetPing()
        return math.max(0.04, config_114514.BlockCooldown - (ping / 1000 * 0.7))
    end
    
    local function PerformBlock()
        local now = os.clock()
        if now - lastBlockTime >= GetAdjustedCooldown() then
            pcall(function()
                local args = {
                    "UseActorAbility",
                    {
                        buffer.fromstring("\"Block\"")
                    }
                }
                game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("Network"):WaitForChild("RemoteEvent"):FireServer(unpack(args))
                lastBlockTime = now
            end)
        end
    end
    
    local function CombatLoop()
        local currentTime = os.clock()
        if currentTime - lastScanTime >= config_114514.ScanInterval then
            lastScanTime = currentTime
            
            if not LocalPlayer.Character then return end
            local myRoot = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            if not myRoot then return end
            
            local killers = GetThreateningKillers()
            if #killers > 0 then
                PerformBlock()
            end
        end
    end
    
    ZZ:AddToggle("AutoBlockToggle", {
        Text = "Auto Block",
        Default = false,
        Callback = function(enabled)
            config_114514.Enabled = enabled
            if enabled then
                if combatConnection then
                    combatConnection:Disconnect()
                end
                combatConnection = RunService.Stepped:Connect(function()
                    pcall(CombatLoop)
                end)
            elseif combatConnection then
                combatConnection:Disconnect()
                combatConnection = nil
            end
        end
    })
    
    ZZ:AddSlider("BaseDistance", {
        Text = "距离",
        Default = 16,
        Min = 5,
        Max = 30,
        Rounding = 1,
        Callback = function(value)
            config_114514.BaseDistance = value
        end
    })
    
    ZZ:AddSlider("TargetAngleSlider", {
        Text = "角度",
        Default = 70,
        Min = 10,
        Max = 180,
        Rounding = 1,
        Callback = function(value)
            config_114514.TargetAngle = value
        end
    })
    
    ZZ:AddToggle("VisualizationToggle", {
        Text = "可视化",
        Default = false,
        Callback = function(enabled)
            config_114514.ShowVisualization = enabled
            if enabled then
                CreateVisualization()
            else
                for _, part in ipairs(visualizationParts) do
                    part:Destroy()
                end
                visualizationParts = {}
            end
        end
    })

    LocalPlayer.CharacterAdded:Connect(function()
        if config_114514.Enabled and combatConnection then
            combatConnection:Disconnect()
            combatConnection = RunService.Stepped:Connect(CombatLoop)
        end
        if config_114514.ShowVisualization then
            CreateVisualization()
        end
    end)
end)

local NOL = Tabs.zdg:AddLeftGroupbox('自动拳击')

NOL:AddToggle("AutoPunch", {
    Text = "自动拳击",
    Default = false,
    Callback = function(Value)
        -- Define variables outside the callback to maintain state
        if not _G.AutoPunchVars then
            _G.AutoPunchVars = {
                ReplicatedStorage = game:GetService("ReplicatedStorage"),
                remoteEvent = nil,
                isRunning = false,
                connection = nil
            }
        end
        
        local vars = _G.AutoPunchVars
        
        -- Function to safely get the RemoteEvent
        local function getRemoteEvent()
            local success, result = pcall(function()
                return vars.ReplicatedStorage:WaitForChild("Modules"):WaitForChild("Network"):WaitForChild("RemoteEvent")
            end)
            
            if not success or not result then
                warn("无法找到 RemoteEvent！请检查路径：ReplicatedStorage.Modules.Network.RemoteEvent")
                return nil
            end
            return result
        end
        
        -- Function to start sending punch events
        local function startAutoPunch()
            if vars.isRunning then return end
            vars.isRunning = true
            
            -- Get the RemoteEvent if we don't have it yet
            if not vars.remoteEvent then
                vars.remoteEvent = getRemoteEvent()
                if not vars.remoteEvent then
                    warn("RemoteEvent 未初始化，无法发送事件。")
                    vars.isRunning = false
                    return
                end
            end
            
            -- Create the loop connection
            vars.connection = task.spawn(function()
                while vars.isRunning and Value do  -- Added Value check here
local args = {
	"UseActorAbility",
	{
		buffer.fromstring("\"Punch\"")
	}
}
                    vars.remoteEvent:FireServer(unpack(args))
                    task.wait(0.5)  -- Wait 0.5 seconds between punches
                end
                vars.isRunning = false
            end)
        end
        
        -- Function to stop sending punch events
        local function stopAutoPunch()
            if not vars.isRunning then return end
            vars.isRunning = false
            
            -- Cancel the loop if it exists
            if vars.connection then
                task.cancel(vars.connection)
                vars.connection = nil
            end
        end
        
        -- Handle the toggle state
        if Value then
            startAutoPunch()
        else
            stopAutoPunch()
        end
    end
})






local ZZ = Tabs.zdg:AddRightGroupbox('007n7自动分身格挡')

local config_007n7 = {
    Enabled = false,
    BaseDistance = 18,
    ScanInterval = 0.001,
    BlockCooldown = 0.08,
    MoveCompBase = 1.5,
    MoveCompFactor = 0.25,
    SpeedThreshold = 8,
    PredictBase = 4,
    PredictMax = 12,
    PredictFactor = 0.35,
    TargetAngle = 50,
    MinAttackSpeed = 12,
    ShowVisualization = false,
    EnablePrediction = false,
    PingCompensation = 0.1,
    FastKillerAdjust = 1.3,
    TargetSoundIds = {
        "102228729296384", "140242176732868", "112809109188560", "136323728355613",
        "115026634746636", "84116622032112", "108907358619313", "127793641088496",
        "86174610237192", "95079963655241", "101199185291628", "119942598489800",
        "84307400688050", "113037804008732", "105200830849301", "75330693422988",
        "82221759983649", "81702359653578", "108610718831698", "112395455254818",
        "109431876587852", "109348678063422", "85853080745515", "12222216"
    }
}

pcall(function()
    local Players = game:GetService("Players")
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local RunService = game:GetService("RunService")
    local Stats = game:GetService("Stats")
    
    local soundLookup = {}
    for _, id in ipairs(config_007n7.TargetSoundIds) do
        soundLookup[id] = true
        soundLookup["rbxassetid://" .. id] = true
    end
    
    local LocalPlayer = Players.LocalPlayer
    local lastBlockTime = 0
    local combatConnection = nil
    local lastScanTime = 0
    local visualizationParts = {}
    local soundCache = {}
    local lastSoundCheck = 0
    local lastPingCheck = 0
    local currentPing = 0
    
    local function SafeCall(func, ...)
        local success, result = pcall(func, ...)
        if not success then
            return nil
        end
        return result
    end
    
    local function GetPing()
        local currentTime = os.clock()
        if currentTime - lastPingCheck < 0.5 then
            return currentPing
        end
        lastPingCheck = currentTime
        
        local stats = SafeCall(function()
            return Stats and Stats.Network and Stats.Network:FindFirstChild("ServerStatsItem")
        end)
        if stats then
            local pingStat = stats:FindFirstChild("Data Ping")
            if pingStat then
                currentPing = pingStat.Value
                return currentPing
            end
        end
        
        return 0
    end
    
    local function GetPingCompensation()
        local ping = GetPing()
        return math.min(0.3, ping / 1000 * config_007n7.PingCompensation * 10)
    end
    
    local function CreateVisualization()
        if not LocalPlayer.Character then return end
        local rootPart = SafeCall(function() return LocalPlayer.Character:FindFirstChild("HumanoidRootPart") end)
        if not rootPart then return end
        
        for _, part in ipairs(visualizationParts) do
            SafeCall(function() part:Destroy() end)
        end
        visualizationParts = {}
        
        local center = rootPart.Position
        local distance = config_007n7.BaseDistance
        local angle = math.rad(config_007n7.TargetAngle)
        local segments = 36
        
        local basePart = Instance.new("Part")
        basePart.Size = Vector3.new(0.1, 0.1, 0.1)
        basePart.Position = center + Vector3.new(0, 0.1, 0)
        basePart.Anchored = true
        basePart.CanCollide = false
        basePart.Transparency = 1
        basePart.Parent = workspace
        table.insert(visualizationParts, basePart)
        
        for i = 1, segments do
            local part = Instance.new("Part")
            part.Size = Vector3.new(0.5, 0.1, 0.5)
            part.BrickColor = BrickColor.new("Bright green")
            part.Material = Enum.Material.Neon
            part.Transparency = 0.7
            part.Anchored = true
            part.CanCollide = false
            part.Parent = workspace
            table.insert(visualizationParts, part)
        end
        
        local function UpdateVisualization()
            if not config_007n7.ShowVisualization then return end
            if not LocalPlayer.Character then return end
            local root = SafeCall(function() return LocalPlayer.Character:FindFirstChild("HumanoidRootPart") end)
            if not root then return end
            
            local center = root.Position + Vector3.new(0, 0.1, 0)
            local lookVector = root.CFrame.LookVector
            local distance = config_007n7.BaseDistance
            local angle = math.rad(config_007n7.TargetAngle)
            
            basePart.Position = center
            
            for i = 1, #visualizationParts - 1 do
                local part = visualizationParts[i + 1]
                local segmentAngle = (i - 1) * (2 * angle) / (#visualizationParts - 2) - angle
                local rotCFrame = CFrame.fromAxisAngle(Vector3.new(0, 1, 0), segmentAngle)
                local dir = rotCFrame:VectorToWorldSpace(lookVector)
                local pos = center + dir * distance
                part.Position = pos
                part.Size = Vector3.new(0.5, 0.1, 0.5)
            end
        end
        
        local visConnection
        visConnection = RunService.Heartbeat:Connect(function()
            if not config_007n7.ShowVisualization then
                for _, part in ipairs(visualizationParts) do
                    SafeCall(function() part:Destroy() end)
                end
                visualizationParts = {}
                SafeCall(function() visConnection:Disconnect() end)
                return
            end
            SafeCall(UpdateVisualization)
        end)
    end
    
    local function HasTargetSound(character)
        if not character then return false end
        local rootPart = SafeCall(function() return character:FindFirstChild("HumanoidRootPart") end)
        if not rootPart then return false end
        
        local currentTime = os.clock()
        if currentTime - lastSoundCheck < 0.0005 then
            return soundCache[character] or false
        end
        lastSoundCheck = currentTime
        
        local found = false
        for _, child in ipairs(rootPart:GetChildren()) do
            if child:IsA("Sound") and child.IsPlaying then
                local soundId = SafeCall(function() return tostring(child.SoundId) end)
                if soundId then
                    local numericId = string.match(soundId, "(%d+)$")
                    if numericId and soundLookup[numericId] then
                        found = true
                        break
                    end
                end
            end
        end
        
        soundCache[character] = found
        return found
    end
    
    local function GetMoveCompensation()
        if not LocalPlayer.Character then return 0 end
        local rootPart = SafeCall(function() return LocalPlayer.Character:FindFirstChild("HumanoidRootPart") end)
        if not rootPart then return 0 end
        
        local velocity = rootPart.Velocity
        local speed = math.sqrt(velocity.X^2 + velocity.Y^2 + velocity.Z^2)
        return config_007n7.MoveCompBase + (speed * config_007n7.MoveCompFactor)
    end
    
    local function IsFastKiller(killer)
        if not killer then return false end
        local killerRoot = SafeCall(function() return killer:FindFirstChild("HumanoidRootPart") end)
        if not killerRoot then return false end
        
        local killerVel = killerRoot.Velocity
        local killerSpeed = math.sqrt(killerVel.X^2 + killerVel.Y^2 + killerVel.Z^2)
        return killerSpeed > config_007n7.MinAttackSpeed
    end
    
    local function GetTotalDetectionRange(killer)
        local base = config_007n7.BaseDistance
        local moveBonus = GetMoveCompensation()
        local predict = 0
        local pingBonus = GetPingCompensation() * 5
        
        if config_007n7.EnablePrediction and killer then
            local killerRoot = SafeCall(function() return killer:FindFirstChild("HumanoidRootPart") end)
            if killerRoot then
                local killerVel = killerRoot.Velocity
                local killerSpeed = math.sqrt(killerVel.X^2 + killerVel.Y^2 + killerVel.Z^2)
                
                if killerSpeed > config_007n7.SpeedThreshold then
                    predict = math.min(
                        config_007n7.PredictMax, 
                        config_007n7.PredictBase + (killerSpeed * config_007n7.PredictFactor)
                    )
                end
                
                if IsFastKiller(killer) then
                    predict = predict * config_007n7.FastKillerAdjust
                end
            end
        end
        
        return base + moveBonus + predict + pingBonus
    end
    
    local function IsTargetingMe(killer)
        local myCharacter = LocalPlayer.Character
        if not myCharacter then return false end
        
        local myRoot = SafeCall(function() return myCharacter:FindFirstChild("HumanoidRootPart") end)
        local killerRoot = SafeCall(function() return killer and killer:FindFirstChild("HumanoidRootPart") end)
        if not myRoot or not killerRoot then return false end
        
        local directionToMe = (myRoot.Position - killerRoot.Position).Unit
        local killerLook = killerRoot.CFrame.LookVector
        
        local dot = directionToMe:Dot(killerLook)
        local angle = math.deg(math.acos(math.clamp(dot, -1, 1)))
        
        return angle <= config_007n7.TargetAngle
    end
    
    local function GetThreateningKillers()
        local killers = {}
        local killersFolder = SafeCall(function() 
            return workspace:FindFirstChild("Killers") or (workspace:FindFirstChild("Players") and workspace.Players:FindFirstChild("Killers"))
        end)
        if not killersFolder then return killers end
        
        local myCharacter = LocalPlayer.Character
        if not myCharacter then return killers end
        
        local myRoot = SafeCall(function() return myCharacter:FindFirstChild("HumanoidRootPart") end)
        if not myRoot then return killers end
        
        for _, killer in ipairs(killersFolder:GetChildren()) do
            if SafeCall(function() return killer:IsA("Model") and killer:FindFirstChild("HumanoidRootPart") end) then
                local killerRoot = killer.HumanoidRootPart
                local distance = (myRoot.Position - killerRoot.Position).Magnitude
                local detectionRange = GetTotalDetectionRange(killer)
                
                local isThreatening = false
                
                if distance <= detectionRange then
                    if HasTargetSound(killer) then
                        isThreatening = true
                    elseif distance <= 8 then
                        isThreatening = IsTargetingMe(killer)
                    end
                end
                
                if isThreatening then
                    table.insert(killers, killer)
                end
            end
        end
        
        return killers
    end
    
    local function GetAdjustedCooldown()
        local ping = GetPing()
        return math.max(0.05, config_007n7.BlockCooldown - (ping / 1000 * 0.5))
    end
    
    local function PerformBlock()
        local now = os.clock()
        if now - lastBlockTime >= GetAdjustedCooldown() then
            SafeCall(function()
                local args = {
                    "UseActorAbility",
                    {
                        buffer.fromstring("\"Clone\"")
                    }
                }
                game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("Network"):WaitForChild("RemoteEvent"):FireServer(unpack(args))
                lastBlockTime = now
            end)
        end
    end
    
    local function CombatLoop()
        local currentTime = os.clock()
        if currentTime - lastScanTime >= config_007n7.ScanInterval then
            lastScanTime = currentTime
            local killers = GetThreateningKillers()
            if #killers > 0 then
                PerformBlock()
            end
        end
    end
    
    ZZ:AddToggle("AutoBlockToggle", {
        Text = "自动分身",
        Default = false,
        Callback = function(enabled)
            config_007n7.Enabled = enabled
            if enabled then
                if combatConnection then
                    SafeCall(function() combatConnection:Disconnect() end)
                end
                combatConnection = RunService.Stepped:Connect(function()
                    SafeCall(CombatLoop)
                end)
            elseif combatConnection then
                SafeCall(function() combatConnection:Disconnect() end)
                combatConnection = nil
            end
        end
    })
    
    ZZ:AddSlider("BaseDistance", {
        Text = "格挡距离",
        Default = 18,
        Min = 5,
        Max = 30,
        Rounding = 1,
        Callback = function(value)
            config_007n7.BaseDistance = value
        end
    })
    
    ZZ:AddSlider("TargetAngleSlider", {
        Text = "格挡角度",
        Default = 70,
        Min = 10,
        Max = 180,
        Rounding = 1,
        Callback = function(value)
            config_007n7.TargetAngle = value
        end
    })
    
    ZZ:AddToggle("VisualizationToggle", {
        Text = "可视化",
        Default = false,
        Callback = function(enabled)
            config_007n7.ShowVisualization = enabled
            if enabled then
                CreateVisualization()
            else
                for _, part in ipairs(visualizationParts) do
                    SafeCall(function() part:Destroy() end)
                end
                visualizationParts = {}
            end
        end
    })
    
    LocalPlayer.CharacterAdded:Connect(function()
        if config_007n7.Enabled and combatConnection then
            SafeCall(function() combatConnection:Disconnect() end)
            combatConnection = RunService.Stepped:Connect(CombatLoop)
        end
        if config_007n7.ShowVisualization then
            CreateVisualization()
        end
    end)
end)





local Generator = Tabs.zdx:AddLeftGroupbox("自动修机")

Generator:AddSlider("RepairSpeed", {
    Text = "修机速度 (s)",
    Default = 4,
    Min = 1,
    Max = 5,
    Rounding = 1,
    Compact = false,
    Callback = function(v)
        _G.CustomSpeed = v
    end
})

Generator:AddToggle("AutoGenerator",{
    Text = "自动修机",
    Default = false,
    Callback = function(v)
        _G.AutoGen = v
        task.spawn(function()
            while _G.AutoGen do
                if game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("PuzzleUI") then
                    local delayTime = _G.CustomSpeed or 4
                    
                    wait(delayTime)
                    
                    for _,v in ipairs(workspace["Map"]["Ingame"]["Map"]:GetChildren()) do
                        if v.Name == "Generator" then
                            v["Remotes"]["RE"]:FireServer()
                        end
                    end
                end
                wait()
            end
        end)
    end
})

Generator:AddToggle("InstantRepair", {
    Text = "秒修机",
    Default = false,
    Callback = function(v)
        _G.InstantRepair = v
        task.spawn(function()
            while _G.InstantRepair do
                if game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("PuzzleUI") then
                    -- 等待1秒后执行前两次事件
                    wait(1)
                    for i = 1, 2 do
                        for _,v in ipairs(workspace["Map"]["Ingame"]["Map"]:GetChildren()) do
                            if v.Name == "Generator" then
                                v["Remotes"]["RE"]:FireServer()
                            end
                        end
                    end
                    
                    -- 再等待2秒后执行后两次事件
                    wait(2)
                    for i = 1, 2 do
                        for _,v in ipairs(workspace["Map"]["Ingame"]["Map"]:GetChildren()) do
                            if v.Name == "Generator" then
                                v["Remotes"]["RE"]:FireServer()
                            end
                        end
                    end
                end
                wait()
            end
        end)
    end
})



local KillerSurvival = Tabs.zdx:AddRightGroupbox('传送修机[危险]')

KillerSurvival:AddButton({
    Text = '传送到发电机',
    Func = function()
        local player = game.Players.LocalPlayer
        local character = player.Character
        if not character or not character:FindFirstChild("HumanoidRootPart") then return end
        
        local generators = workspace.Map.Ingame.Map:GetChildren()
        for _, generator in ipairs(generators) do
            if generator.Name == "Generator" and 
               generator:FindFirstChild("Progress") and 
               generator.Progress.Value < 100 then
                
                local generatorPart = generator:FindFirstChild("Main") or  
                                     generator:FindFirstChild("Model") or
                                     generator:FindFirstChild("Base")
                
                if generatorPart then
                    character.HumanoidRootPart.CFrame = generatorPart.CFrame + Vector3.new(0, 3, 0)
                    return  
                end
            end
        end
        warn("没有找到可修理的发电机")
    end
})

KillerSurvival:AddToggle("AutoFix", {
    Text = "自动发电机农场",
    Default = false,
    Callback = function(enabled)
        local threadId = tostring(math.random(1, 99999))
        _G.AutoFixThreadId = threadId
        
        local function shouldContinue()
            return _G.AutoFixThreadId == threadId and enabled
        end
        
        local function allGeneratorsFixed()
            for _, v in ipairs(workspace.Map.Ingame.Map:GetChildren()) do
                if v.Name == "Generator" and v:FindFirstChild("Progress") and v.Progress.Value < 100 then
                    return false
                end
            end
            return true
        end
        
        local function fastInteract(generator, action)
            local args = {[1] = action}
            pcall(function()
                generator.Remotes.RF:InvokeServer(unpack(args))
            end)
        end

        local function fastRepair(generator)
            pcall(function()
                generator.Remotes.RE:FireServer()
            end)
        end
        
        local function runGenerator()
            while shouldContinue() and not allGeneratorsFixed() do
                local generators = {}
                for _, v in ipairs(workspace.Map.Ingame.Map:GetChildren()) do
                    if v.Name == "Generator" and v:FindFirstChild("Progress") and v.Progress.Value < 100 then
                        table.insert(generators, v)
                    end
                end
                
                for _, generator in ipairs(generators) do
                    if not shouldContinue() then break end
                    
                    local char = game.Players.LocalPlayer.Character
                    if char and char:FindFirstChild("HumanoidRootPart") then
                        -- 传送(0.5秒)
                        local startTP = tick()
                        
                        -- 寻找传送点
                        local bestPos, minDist = nil, math.huge
                        if generator:FindFirstChild("Positions") then
                            for _, pos in ipairs(generator.Positions:GetChildren()) do
                                local dist = (char.HumanoidRootPart.Position - pos.Position).Magnitude
                                if dist < minDist then
                                    bestPos = pos
                                    minDist = dist
                                end
                            end
                            
                            if bestPos then
                                char.HumanoidRootPart.CFrame = bestPos.CFrame * CFrame.new(0, 0, -1.2) -- 传送位置
                            end
                        end
                        
                        -- 精确控制传送时间
                        local elapsed = tick() - startTP
                        if elapsed < 0.17 then
                            task.wait(0.17 - elapsed)
                        end
                        
                        -- 交互流程
                        fastInteract(generator, "enter")
                        task.wait(0.00001) -- 最小必要等待
                        
                        -- 单次修理
                        fastRepair(generator)
                        task.wait(0.1) -- 修理确认时间
                        
                        -- 立即离开
                        fastInteract(generator, "leave")
                        
                        -- 循环等待
                        task.wait(0.000000000000001) -- 电机间间隔
                    end
                end
                
                if shouldContinue() then
                    task.wait(0.000000000000000001) -- 循环缓冲
                end
            end
        end

        if enabled then
            if _G.AutoFixThread then
                _G.AutoFixThreadId = tostring(math.random(1, 99999))
                task.cancel(_G.AutoFixThread)
            end
            _G.AutoFixThread = task.spawn(runGenerator)
        else
            _G.AutoFixThreadId = tostring(math.random(1, 99999))
            if _G.AutoFixThread then
                task.cancel(_G.AutoFixThread)
                _G.AutoFixThread = nil
            end
        end
    end
})





local ZZ = Tabs.zdx:AddRightGroupbox('切换服务器')

ZZ:AddButton({
    Text = "Switching server", 
    Func = function()
        local TeleportService = game:GetService("TeleportService")
        local Players = game:GetService("Players")
        local HttpService = game:GetService("HttpService")
        
        local requestFunc = http_request or syn.request or request
        if not requestFunc then return end
            
        local url = "https://games.roblox.com/v1/games/"..game.PlaceId.."/servers/Public?sortOrder=Asc&limit=100"
        local response = requestFunc({Url = url, Method = "GET"})
        
        if response.StatusCode == 200 then
            local data = HttpService:JSONDecode(response.Body)
            if data and data.data and #data.data > 0 then
                TeleportService:TeleportToPlaceInstance(game.PlaceId, data.data[math.random(1, #data.data)].id, Players.LocalPlayer)
            end
        end
    end
})





local Visual = Tabs.Esp:AddRightGroupbox("高亮绘制")


local HighlightSystem = {
    Enabled = false,
    Settings = {
        ShowSurvivors = true,
        ShowKillers = true,
        Colors = {
            Survivor = Color3.fromRGB(0, 255, 255), -- 青色
            Killer = Color3.fromRGB(204, 0, 0)      -- 暗红色
        },
        Transparency = {
            Fill = 0.9,
            Outline = 0
        }
    },
    Cache = {
        Highlights = {},
        Connections = {}
    }
}

-- ► 高亮核心功能 -----------------------------------
local function CreateHighlight(char, isKiller)
    local highlight = Instance.new("Highlight")
    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    highlight.FillColor = isKiller and HighlightSystem.Settings.Colors.Killer 
                                     or HighlightSystem.Settings.Colors.Survivor
    highlight.OutlineColor = highlight.FillColor
    highlight.FillTransparency = HighlightSystem.Settings.Transparency.Fill
    highlight.OutlineTransparency = HighlightSystem.Settings.Transparency.Outline
    highlight.Parent = char
    
    -- 血量变化监听
    local conn = char.Humanoid.HealthChanged:Connect(function()
        if not char:FindFirstChild("Humanoid") then conn:Disconnect() end
    end)
    
    char.Humanoid.Died:Connect(function()
        highlight.OutlineTransparency = 1
        conn:Disconnect()
    end)
    
    return highlight
end

local function UpdateHighlights()
    -- 清理无效高亮
    for char, highlight in pairs(HighlightSystem.Cache.Highlights) do
        if not char.Parent then
            highlight:Destroy()
            HighlightSystem.Cache.Highlights[char] = nil
        end
    end
    
    -- 更新幸存者
    if HighlightSystem.Settings.ShowSurvivors then
        for _, char in ipairs(workspace.Players.Survivors:GetDescendants()) do
            if char:IsA("Model") and char:FindFirstChild("Humanoid") then
                if not HighlightSystem.Cache.Highlights[char] then
                    HighlightSystem.Cache.Highlights[char] = CreateHighlight(char, false)
                end
            end
        end
    end
    
    -- 更新杀手
    if HighlightSystem.Settings.ShowKillers then
        for _, char in ipairs(workspace.Players.Killers:GetDescendants()) do
            if char:IsA("Model") and char:FindFirstChild("Humanoid") then
                if not HighlightSystem.Cache.Highlights[char] then
                    HighlightSystem.Cache.Highlights[char] = CreateHighlight(char, true)
                end
            end
        end
    end
end

-- ► UI控制按钮 -------------------------------------
-- 主开关
Visual:AddToggle("HL_MainToggle", {
    Text = "启用高亮绘制",
    Default = false,
    Callback = function(state)
        HighlightSystem.Enabled = state
        if state then
            HighlightSystem.Cache.Connections["Main"] = game:GetService("RunService").Heartbeat:Connect(UpdateHighlights)
            UpdateHighlights()
        else
            if HighlightSystem.Cache.Connections["Main"] then
                HighlightSystem.Cache.Connections["Main"]:Disconnect()
            end
            for _, h in pairs(HighlightSystem.Cache.Highlights) do h:Destroy() end
            HighlightSystem.Cache.Highlights = {}
        end
    end
})

-- 幸存者开关
Visual:AddToggle("HL_SurvivorToggle", {
    Text = "绘制幸存者",
    Default = true,
    Callback = function(state)
        HighlightSystem.Settings.ShowSurvivors = state
        UpdateHighlights()
    end
})

-- 杀手开关
Visual:AddToggle("HL_KillerToggle", {
    Text = "绘制杀手", 
    Default = true,
    Callback = function(state)
        HighlightSystem.Settings.ShowKillers = state
        UpdateHighlights()
    end
})

-- 透明度控制
Visual:AddSlider("HL_FillTransparency", {
    Text = "填充透明度",
    Min = 0,
    Max = 1,
    Default = 0.9,
    Rounding = 1,
    Callback = function(value)
        HighlightSystem.Settings.Transparency.Fill = value
        for _, h in pairs(HighlightSystem.Cache.Highlights) do
            h.FillTransparency = value
        end
    end
})

Visual:AddSlider("HL_OutlineTransparency", {
    Text = "边缘透明度",
    Min = 0,
    Max = 1,
    Default = 0,
    Rounding = 1,
    Callback = function(value)
        HighlightSystem.Settings.Transparency.Outline = value
        for _, h in pairs(HighlightSystem.Cache.Highlights) do
            h.OutlineTransparency = value
        end
    end
})

local Visual = Tabs.Esp:AddLeftGroupbox("血条绘制")


-- 血量条设置
local HealthBarSettings = {
    ShowSurvivorBars = true,
    ShowKillerBars = true,
    BarWidth = 100,      -- 固定宽度
    BarHeight = 5,       -- 固定高度
    TextSize = 14,       -- 固定文字大小
    BarOffset = Vector2.new(0, -50), -- 基础偏移（头顶）
    TextOffset = Vector2.new(0, -60)  -- 文字偏移
}

-- 预设颜色方案
local ColorPresets = {
    Survivor = {
        FullHealth = Color3.fromRGB(0, 255, 255),    -- 青色(满血)
        HalfHealth = Color3.fromRGB(0, 255, 0),      -- 绿色(半血)
        LowHealth = Color3.fromRGB(255, 165, 0)      -- 橙色(低血)
    },
    Killer = {
        FullHealth = Color3.fromRGB(255, 0, 0),      -- 红色(满血)
        HalfHealth = Color3.fromRGB(255, 165, 0),    -- 橙色(半血)
        LowHealth = Color3.fromRGB(255, 255, 0)      -- 黄色(低血)
    },
    Common = {
        Background = Color3.fromRGB(50, 50, 50),
        Outline = Color3.fromRGB(0, 0, 0),
        Text = Color3.fromRGB(255, 255, 255)        -- 白色文字
    }
}

-- 存储所有绘制对象
local HealthBarDrawings = {}

-- 创建血量条绘制对象
local function createHealthBarDrawing()
    local drawing = {
        background = Drawing.new("Square"),
        bar = Drawing.new("Square"),
        outline = Drawing.new("Square"),
        text = Drawing.new("Text")
    }
    
    -- 背景设置
    drawing.background.Thickness = 1
    drawing.background.Filled = true
    drawing.background.Color = ColorPresets.Common.Background
    
    -- 血量条设置
    drawing.bar.Thickness = 1
    drawing.bar.Filled = true
    
    -- 边框设置
    drawing.outline.Thickness = 2
    drawing.outline.Filled = false
    drawing.outline.Color = ColorPresets.Common.Outline
    
    -- 文字设置
    drawing.text.Center = true
    drawing.text.Outline = true
    drawing.text.Font = 2
    drawing.text.Color = ColorPresets.Common.Text
    
    return drawing
end

-- 根据血量获取颜色
local function getHealthColor(humanoid, isKiller)
    local healthPercent = (humanoid.Health / humanoid.MaxHealth) * 100
    
    if isKiller then
        if healthPercent > 50 then
            return ColorPresets.Killer.FullHealth
        elseif healthPercent > 25 then
            return ColorPresets.Killer.HalfHealth
        else
            return ColorPresets.Killer.LowHealth
        end
    else
        if healthPercent > 75 then
            return ColorPresets.Survivor.FullHealth
        elseif healthPercent > 35 then
            return ColorPresets.Survivor.HalfHealth
        else
            return ColorPresets.Survivor.LowHealth
        end
    end
end

-- 获取角色头顶位置
local function get_head_position(character)
    local head = character:FindFirstChild("Head")
    if head then
        return head.Position + Vector3.new(0, 1.5, 0) -- 稍微高于头部
    end
    return character:GetModelCFrame().Position
end

-- 更新血量条
local function updateHealthBars()
    local camera = workspace.CurrentCamera
    local localPlayer = Players.LocalPlayer
    
    -- 处理幸存者
    if HealthBarSettings.ShowSurvivorBars then
        local survivors = workspace.Players:FindFirstChild("Survivors") or workspace:FindFirstChild("Survivors")
        if survivors then
            for _, survivor in ipairs(survivors:GetChildren()) do
                if survivor:IsA("Model") and survivor ~= localPlayer.Character then -- 不显示自身血条
                    local humanoid = survivor:FindFirstChildOfClass("Humanoid")
                    
                    if humanoid then
                        -- 获取或创建绘制对象
                        if not HealthBarDrawings[survivor] then
                            HealthBarDrawings[survivor] = createHealthBarDrawing()
                        end
                        
                        local drawing = HealthBarDrawings[survivor]
                        local headPos = get_head_position(survivor)
                        local screenPos, onScreen = camera:WorldToViewportPoint(headPos)
                        
                        if onScreen then
                            -- 计算血量百分比
                            local healthPercent = math.floor((humanoid.Health / humanoid.MaxHealth) * 100)
                            local healthBarWidth = HealthBarSettings.BarWidth * (healthPercent / 100)
                            
                            -- 水平条位置（头顶）
                            local barPos = Vector2.new(
                                screenPos.X + HealthBarSettings.BarOffset.X - (HealthBarSettings.BarWidth / 2),
                                screenPos.Y + HealthBarSettings.BarOffset.Y
                            )
                            
                            -- 背景和边框
                            drawing.background.Size = Vector2.new(HealthBarSettings.BarWidth, HealthBarSettings.BarHeight)
                            drawing.background.Position = barPos
                            drawing.background.Visible = true
                            
                            drawing.outline.Size = Vector2.new(HealthBarSettings.BarWidth, HealthBarSettings.BarHeight)
                            drawing.outline.Position = barPos
                            drawing.outline.Visible = true
                            
                            -- 血量条
                            drawing.bar.Color = getHealthColor(humanoid, false)
                            drawing.bar.Size = Vector2.new(healthBarWidth, HealthBarSettings.BarHeight)
                            drawing.bar.Position = barPos
                            drawing.bar.Visible = true
                            
                            -- 文字
                            drawing.text.Text = tostring(healthPercent) .. "%"
                            drawing.text.Size = HealthBarSettings.TextSize
                            drawing.text.Position = Vector2.new(
                                screenPos.X + HealthBarSettings.TextOffset.X,
                                screenPos.Y + HealthBarSettings.TextOffset.Y
                            )
                            drawing.text.Visible = true
                        else
                            -- 不在屏幕内则隐藏
                            for _, obj in pairs(drawing) do
                                obj.Visible = false
                            end
                        end
                    end
                end
            end
        end
    end
    
    -- 处理杀手
    if HealthBarSettings.ShowKillerBars then
        local killers = workspace.Players:FindFirstChild("Killers") or workspace:FindFirstChild("Killers")
        if killers then
            for _, killer in ipairs(killers:GetChildren()) do
                if killer:IsA("Model") and killer ~= localPlayer.Character then -- 不显示自身血条
                    local humanoid = killer:FindFirstChildOfClass("Humanoid")
                    
                    if humanoid then
                        -- 获取或创建绘制对象
                        if not HealthBarDrawings[killer] then
                            HealthBarDrawings[killer] = createHealthBarDrawing()
                        end
                        
                        local drawing = HealthBarDrawings[killer]
                        local headPos = get_head_position(killer)
                        local screenPos, onScreen = camera:WorldToViewportPoint(headPos)
                        
                        if onScreen then
                            -- 计算血量百分比
                            local healthPercent = math.floor((humanoid.Health / humanoid.MaxHealth) * 100)
                            local healthBarWidth = HealthBarSettings.BarWidth * (healthPercent / 100)
                            
                            -- 水平条位置（头顶）
                            local barPos = Vector2.new(
                                screenPos.X + HealthBarSettings.BarOffset.X - (HealthBarSettings.BarWidth / 2),
                                screenPos.Y + HealthBarSettings.BarOffset.Y
                            )
                            
                            -- 背景和边框
                            drawing.background.Size = Vector2.new(HealthBarSettings.BarWidth, HealthBarSettings.BarHeight)
                            drawing.background.Position = barPos
                            drawing.background.Visible = true
                            
                            drawing.outline.Size = Vector2.new(HealthBarSettings.BarWidth, HealthBarSettings.BarHeight)
                            drawing.outline.Position = barPos
                            drawing.outline.Visible = true
                            
                            -- 血量条
                            drawing.bar.Color = getHealthColor(humanoid, true)
                            drawing.bar.Size = Vector2.new(healthBarWidth, HealthBarSettings.BarHeight)
                            drawing.bar.Position = barPos
                            drawing.bar.Visible = true
                            
                            -- 文字
                            drawing.text.Text = tostring(healthPercent) .. "%"
                            drawing.text.Size = HealthBarSettings.TextSize
                            drawing.text.Position = Vector2.new(
                                screenPos.X + HealthBarSettings.TextOffset.X,
                                screenPos.Y + HealthBarSettings.TextOffset.Y
                            )
                            drawing.text.Visible = true
                        else
                            -- 不在屏幕内则隐藏
                            for _, obj in pairs(drawing) do
                                obj.Visible = false
                            end
                        end
                    end
                end
            end
        end
    end
end

-- 清理血量条
local function cleanupHealthBars()
    for _, drawing in pairs(HealthBarDrawings) do
        for _, obj in pairs(drawing) do
            if obj then
                obj:Remove()
            end
        end
    end
    HealthBarDrawings = {}
end

-- 主开关
Visual:AddToggle("HealthBarsToggle", {
    Text = "启用血量绘制",
    Default = false,
    Callback = function(enabled)
        if enabled then
            -- 初始化连接
            if not HealthBarSettings.connection then
                HealthBarSettings.connection = game:GetService("RunService").RenderStepped:Connect(updateHealthBars)
            end
            
            -- 监听角色移除
            if not HealthBarSettings.removedConnection then
                HealthBarSettings.removedConnection = workspace.DescendantRemoving:Connect(function(descendant)
                    if HealthBarDrawings[descendant] then
                        for _, obj in pairs(HealthBarDrawings[descendant]) do
                            obj:Remove()
                        end
                        HealthBarDrawings[descendant] = nil
                    end
                end)
            end
        else
            -- 关闭连接
            if HealthBarSettings.connection then
                HealthBarSettings.connection:Disconnect()
                HealthBarSettings.connection = nil
            end
            
            if HealthBarSettings.removedConnection then
                HealthBarSettings.removedConnection:Disconnect()
                HealthBarSettings.removedConnection = nil
            end
            
            -- 清理绘制对象
            cleanupHealthBars()
        end
    end
})

-- 幸存者开关
Visual:AddToggle("ShowSurvivorBars", {
    Text = "绘制幸存者血量",
    Default = true,
    Callback = function(enabled)
        HealthBarSettings.ShowSurvivorBars = enabled
    end
})

-- 杀手开关
Visual:AddToggle("ShowKillerBars", {
    Text = "绘制杀手血量",
    Default = true,
    Callback = function(enabled)
        HealthBarSettings.ShowKillerBars = enabled
    end
})

local Visual = Tabs.Esp:AddLeftGroupbox("名字绘制")

local NameTagSettings = {
    ShowSurvivorNames = true,
    ShowKillerNames = true,
    BaseTextSize = 14,
    MinTextSize = 10,
    MaxTextSize = 20,
    TextOffset = Vector3.new(0, 3, 0),
    DistanceScale = {
        MinDistance = 10,
        MaxDistance = 50
    },
    SurvivorColor = Color3.fromRGB(0, 191, 255),
    KillerColor = Color3.fromRGB(255, 0, 0),
    OutlineColor = Color3.fromRGB(0, 0, 0),
    ShowDistance = true
}

local NameTagDrawings = {}

local function createNameTagDrawing()
    local drawing = Drawing.new("Text")
    drawing.Size = NameTagSettings.BaseTextSize
    drawing.Center = true
    drawing.Outline = true
    drawing.OutlineColor = NameTagSettings.OutlineColor
    drawing.Font = 2
    return drawing
end

local function getHeadPosition(character)
    local head = character:FindFirstChild("Head")
    if head then
        local headHeight = head.Size.Y
        return head.Position + Vector3.new(0, headHeight + 0.5, 0)
    end
    return character:GetPivot().Position
end

local function cleanupInvalidDrawings()
    local survivors = workspace.Players:FindFirstChild("Survivors")
    local killers = workspace.Players:FindFirstChild("Killers")
    
    local validCharacters = {}
    if survivors then
        for _, survivor in ipairs(survivors:GetChildren()) do
            if survivor:IsA("Model") then
                validCharacters[survivor] = true
            end
        end
    end
    if killers then
        for _, killer in ipairs(killers:GetChildren()) do
            if killer:IsA("Model") then
                validCharacters[killer] = true
            end
        end
    end
    
    for model, drawing in pairs(NameTagDrawings) do
        if not validCharacters[model] then
            drawing:Remove()
            NameTagDrawings[model] = nil
        end
    end
end

local function cleanupSpecificNameTags()
    local survivors = workspace.Players:FindFirstChild("Survivors")
    local killers = workspace.Players:FindFirstChild("Killers")
    
    if not NameTagSettings.ShowSurvivorNames and survivors then
        for _, survivor in ipairs(survivors:GetChildren()) do
            if survivor:IsA("Model") and NameTagDrawings[survivor] then
                NameTagDrawings[survivor].Visible = false
            end
        end
    end
    
    if not NameTagSettings.ShowKillerNames and killers then
        for _, killer in ipairs(killers:GetChildren()) do
            if killer:IsA("Model") and NameTagDrawings[killer] then
                NameTagDrawings[killer].Visible = false
            end
        end
    end
end

local function updateNameTags()
    local camera = workspace.CurrentCamera
    local localPlayer = Players.LocalPlayer
    local localCharacter = localPlayer.Character
    local localRoot = localCharacter and localCharacter:FindFirstChild("HumanoidRootPart")

    if not localRoot then return end
    
    cleanupInvalidDrawings()

    if NameTagSettings.ShowSurvivorNames then
        local survivors = workspace.Players:FindFirstChild("Survivors")
        if survivors then
            for _, survivor in ipairs(survivors:GetChildren()) do
                if survivor:IsA("Model") and survivor ~= localCharacter then
                    local humanoid = survivor:FindFirstChildOfClass("Humanoid")
                    
                    if not NameTagDrawings[survivor] then
                        NameTagDrawings[survivor] = createNameTagDrawing()
                    end
                    
                    local drawing = NameTagDrawings[survivor]
                    
                    if not humanoid or humanoid.Health <= 0 then
                        drawing.Visible = false
                        continue
                    end
                    
                    local headPos = getHeadPosition(survivor)
                    local screenPos, onScreen = camera:WorldToViewportPoint(headPos + NameTagSettings.TextOffset)
                    
                    if onScreen then
                        local distance = (headPos - localRoot.Position).Magnitude
                        local scale = math.clamp(
                            1 - (distance - NameTagSettings.DistanceScale.MinDistance) / 
                            (NameTagSettings.DistanceScale.MaxDistance - NameTagSettings.DistanceScale.MinDistance), 
                            0.3, 1
                        )
                        
                        local textSize = math.floor(NameTagSettings.BaseTextSize * scale)
                        textSize = math.clamp(textSize, NameTagSettings.MinTextSize, NameTagSettings.MaxTextSize)
                        
                        local displayText = survivor.Name
                        if NameTagSettings.ShowDistance then
                            displayText = string.format("%s [%d米]", survivor.Name, math.floor(distance))
                        end
                        
                        drawing.Text = displayText
                        drawing.Color = NameTagSettings.SurvivorColor
                        drawing.Size = textSize
                        drawing.Position = Vector2.new(screenPos.X, screenPos.Y)
                        drawing.Visible = true
                    else
                        drawing.Visible = false
                    end
                end
            end
        end
    else
        local survivors = workspace.Players:FindFirstChild("Survivors")
        if survivors then
            for _, survivor in ipairs(survivors:GetChildren()) do
                if survivor:IsA("Model") and NameTagDrawings[survivor] then
                    NameTagDrawings[survivor].Visible = false
                end
            end
        end
    end

    if NameTagSettings.ShowKillerNames then
        local killers = workspace.Players:FindFirstChild("Killers")
        if killers then
            for _, killer in ipairs(killers:GetChildren()) do
                if killer:IsA("Model") then
                    local humanoid = killer:FindFirstChildOfClass("Humanoid")
                    
                    if not NameTagDrawings[killer] then
                        NameTagDrawings[killer] = createNameTagDrawing()
                    end
                    
                    local drawing = NameTagDrawings[killer]
                    
                    if not humanoid or humanoid.Health <= 0 then
                        drawing.Visible = false
                        continue
                    end
                    
                    local headPos = getHeadPosition(killer)
                    local screenPos, onScreen = camera:WorldToViewportPoint(headPos + NameTagSettings.TextOffset)
                    
                    if onScreen then
                        local distance = (headPos - localRoot.Position).Magnitude
                        local scale = math.clamp(
                            1 - (distance - NameTagSettings.DistanceScale.MinDistance) / 
                            (NameTagSettings.DistanceScale.MaxDistance - NameTagSettings.DistanceScale.MinDistance), 
                            0.3, 1
                        )
                        
                        local textSize = math.floor(NameTagSettings.BaseTextSize * scale)
                        textSize = math.clamp(textSize, NameTagSettings.MinTextSize, NameTagSettings.MaxTextSize)
                        
                        local displayText = killer.Name
                        if NameTagSettings.ShowDistance then
                            displayText = string.format("%s [%dm]", killer.Name, math.floor(distance))
                        end
                        
                        drawing.Text = displayText
                        drawing.Color = NameTagSettings.KillerColor
                        drawing.Size = textSize
                        drawing.Position = Vector2.new(screenPos.X, screenPos.Y)
                        drawing.Visible = true
                    else
                        drawing.Visible = false
                    end
                end
            end
        end
    else
        local killers = workspace.Players:FindFirstChild("Killers")
        if killers then
            for _, killer in ipairs(killers:GetChildren()) do
                if killer:IsA("Model") and NameTagDrawings[killer] then
                    NameTagDrawings[killer].Visible = false
                end
            end
        end
    end
end

local function cleanupNameTags()
    for _, drawing in pairs(NameTagDrawings) do
        if drawing then
            drawing:Remove()
        end
    end
    NameTagDrawings = {}
end

Visual:AddToggle("NameTagsToggle", {
    Text = "启用名称绘制",
    Default = false,
    Callback = function(enabled)
        if enabled then
            if not NameTagSettings.connection then
                NameTagSettings.connection = game:GetService("RunService").RenderStepped:Connect(updateNameTags)
            end
            
            if not NameTagSettings.removedConnection then
                NameTagSettings.removedConnection = game:GetService("Players").PlayerRemoving:Connect(function(player)
                    for model, drawing in pairs(NameTagDrawings) do
                        if model.Name == player.Name then
                            drawing:Remove()
                            NameTagDrawings[model] = nil
                        end
                    end
                end)
            end
        else
            if NameTagSettings.connection then
                NameTagSettings.connection:Disconnect()
                NameTagSettings.connection = nil
            end
            
            if NameTagSettings.removedConnection then
                NameTagSettings.removedConnection:Disconnect()
                NameTagSettings.removedConnection = nil
            end
            
            cleanupNameTags()
        end
    end
})

Visual:AddToggle("ShowSurvivorNames", {
    Text = "绘制幸存者名称",
    Default = true,
    Callback = function(enabled)
        NameTagSettings.ShowSurvivorNames = enabled
        cleanupSpecificNameTags()
    end
})

Visual:AddToggle("ShowKillerNames", {
    Text = "绘制杀手名称",
    Default = true,
    Callback = function(enabled)
        NameTagSettings.ShowKillerNames = enabled
        cleanupSpecificNameTags()
    end
})

Visual:AddToggle("ShowDistance", {
    Text = "绘制距离",
    Default = true,
    Callback = function(enabled)
        NameTagSettings.ShowDistance = enabled
    end
})


local Visual = Tabs.Esp:AddLeftGroupbox("绘制血量［文字］")


local camera = workspace.CurrentCamera
local localPlayer = game:GetService("Players").LocalPlayer

Visual:AddToggle("SurvivorHealth", {
    Text = "绘制幸存者血量",
    Default = false,
    Callback = function(v)
        if v then
            local sur = workspace.Players.Survivors
            
            local function survivoresp(char)
                local billboard = Instance.new("BillboardGui")
                billboard.Size = UDim2.new(3, 0, 1, 0)
                billboard.StudsOffset = Vector3.new(0, 1.5, 0)
                billboard.Adornee = char.Head
                billboard.Parent = char.Head
                billboard.AlwaysOnTop = true
                
                local textLabel = Instance.new("TextLabel")
                textLabel.Size = UDim2.new(1, 0, 1, 0)
                textLabel.Position = UDim2.new(0, 0, 0, 0)
                textLabel.BackgroundTransparency = 1
                textLabel.TextScaled = false
                textLabel.Text = "血量: "..char.Humanoid.Health.."/"..char.Humanoid.MaxHealth
                textLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
                textLabel.Font = Enum.Font.Arcade
                textLabel.Parent = billboard

              
                local distanceUpdate
                distanceUpdate = game:GetService("RunService").RenderStepped:Connect(function()
                    if char:FindFirstChild("Head") and localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart") then
                        local distance = (char.Head.Position - localPlayer.Character.HumanoidRootPart.Position).Magnitude
                        
                        local textSize = math.clamp(30 - (distance / 2), 12, 20)
                        textLabel.TextSize = textSize
                    end
                end)

                local healthUpdate = char:FindFirstChild("Humanoid").HealthChanged:Connect(function()
                    textLabel.Text = "血量: "..char:FindFirstChild("Humanoid").Health.."/"..char:FindFirstChild("Humanoid").MaxHealth
                end)

                char:FindFirstChild("Humanoid").Died:Connect(function()
                    distanceUpdate:Disconnect()
                    healthUpdate:Disconnect()
                    textLabel.Text = ""
                end)

                return {billboard = billboard, connections = {distanceUpdate, healthUpdate}}
            end

            getgenv().SurvivorHealthConnections = {
                Added = sur.DescendantAdded:Connect(function(v)
                    if v:IsA("Model") and v:FindFirstChild("Humanoid") then
                        repeat wait() until v:FindFirstChild("Humanoid")
                        survivoresp(v)
                    end
                end)
            }

            for _,v in pairs(sur:GetDescendants()) do
                if v:IsA("Model") and v:FindFirstChild("Humanoid") then
                    repeat wait() until v:FindFirstChild("Humanoid")
                    survivoresp(v)
                end
            end
        else
            if getgenv().SurvivorHealthConnections then
                getgenv().SurvivorHealthConnections.Added:Disconnect()
            end
            
            for _,v in pairs(workspace.Players.Survivors:GetDescendants()) do
                if v:IsA("Model") and v:FindFirstChild("Head") then
                    for _,child in pairs(v.Head:GetChildren()) do
                        if child:IsA("BillboardGui") then
                            child:Destroy()
                        end
                    end
                end
            end
        end
    end
})

Visual:AddToggle("KillerHealth", {
    Text = "绘制杀手血量",
    Default = false,
    Callback = function(v)
        if v then
            local kil = workspace.Players.Killers
            
            local function killeresp(char)
                local billboard = Instance.new("BillboardGui")
                billboard.Size = UDim2.new(3, 0, 1, 0)
                billboard.StudsOffset = Vector3.new(0, 1.5, 0)
                billboard.Adornee = char.Head
                billboard.Parent = char.Head
                billboard.AlwaysOnTop = true
                
                local textLabel = Instance.new("TextLabel")
                textLabel.Size = UDim2.new(1, 0, 1, 0)
                textLabel.Position = UDim2.new(0, 0, 0, 0)
                textLabel.BackgroundTransparency = 1
                textLabel.TextScaled = false
                textLabel.Text = "血量: "..char.Humanoid.Health.."/"..char.Humanoid.MaxHealth
                textLabel.TextColor3 = Color3.fromRGB(255, 255, 0)
                textLabel.Font = Enum.Font.Arcade
                textLabel.Parent = billboard

                -- 添加距离检测更新
                local distanceUpdate
                distanceUpdate = game:GetService("RunService").RenderStepped:Connect(function()
                    if char:FindFirstChild("Head") and localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart") then
                        local distance = (char.Head.Position - localPlayer.Character.HumanoidRootPart.Position).Magnitude
                        -- 根据距离动态调整文字大小 (10-30米范围内变化)
                        local textSize = math.clamp(30 - (distance / 2), 12, 20)
                        textLabel.TextSize = textSize
                    end
                end)

                local healthUpdate = char:FindFirstChild("Humanoid").HealthChanged:Connect(function()
                    textLabel.Text = "blood volume: "..char:FindFirstChild("Humanoid").Health.."/"..char:FindFirstChild("Humanoid").MaxHealth
                end)

                char:FindFirstChild("Humanoid").Died:Connect(function()
                    distanceUpdate:Disconnect()
                    healthUpdate:Disconnect()
                    textLabel.Text = ""
                end)

                return {billboard = billboard, connections = {distanceUpdate, healthUpdate}}
            end

            getgenv().KillerHealthConnections = {
                Added = kil.DescendantAdded:Connect(function(v)
                    if v:IsA("Model") and v:FindFirstChild("Humanoid") then
                        repeat wait() until v:FindFirstChild("Humanoid")
                        killeresp(v)
                    end
                end)
            }

            for _,v in pairs(kil:GetDescendants()) do
                if v:IsA("Model") and v:FindFirstChild("Humanoid") then
                    repeat wait() until v:FindFirstChild("Humanoid")
                    killeresp(v)
                end
            end
        else
            if getgenv().KillerHealthConnections then
                getgenv().KillerHealthConnections.Added:Disconnect()
            end
            
            for _,v in pairs(workspace.Players.Killers:GetDescendants()) do
                if v:IsA("Model") and v:FindFirstChild("Head") then
                    for _,child in pairs(v.Head:GetChildren()) do
                        if child:IsA("BillboardGui") then
                            child:Destroy()
                        end
                    end
                end
            end
        end
    end
})





local Visual   = Tabs.Esp:AddRightGroupbox('电机绘制')

Visual:AddToggle("RealGeneratorESP", {
    Text = "绘制电机",
    Default = false,
    Callback = function(enabled)
        if not _G.RealGeneratorESP then
            _G.RealGeneratorESP = {
                Active = false,
                Data = {},
                Connections = {}
            }
        end
        
        if not enabled then
            if _G.RealGeneratorESP.Active then
                for _, connection in pairs(_G.RealGeneratorESP.Connections) do
                    if connection and connection.Connected then
                        connection:Disconnect()
                    end
                end
                
                for gen, data in pairs(_G.RealGeneratorESP.Data) do
                    if type(data) == "table" then
                        if data.Billboard and data.Billboard.Parent then
                            data.Billboard:Destroy()
                        end
                        if data.DistanceBillboard and data.DistanceBillboard.Parent then
                            data.DistanceBillboard:Destroy()
                        end
                        if data.Highlight and data.Highlight.Parent then
                            data.Highlight:Destroy()
                        end
                    end
                end
                
                _G.RealGeneratorESP.Data = {}
                _G.RealGeneratorESP.Connections = {}
                _G.RealGeneratorESP.Active = false
            end
            return
        end
        
        if _G.RealGeneratorESP.Active then
            return
        end
        
        _G.RealGeneratorESP.Active = true
        
        local scanInterval = 1.0
        local lastScanTime = 0
        local maxGenerators = 20
        
        local distanceSettings = {
            MinDistance = 5,
            MaxDistance = 500,
            MinScale = 0.8,
            MaxScale = 1.5,
            MinTextSize = 8,
            MaxTextSize = 10
        }
        
        local function updateGeneratorESP(gen, data)
            if not gen or not gen.Parent or not gen:FindFirstChild("Main") then
                return false
            end
            
            if table.getn(_G.RealGeneratorESP.Data) > maxGenerators then
                return false
            end
            
            if gen:FindFirstChild("Progress") then
                local progress = gen.Progress.Value
                if progress >= 99 then
                    return false
                end
                
                if data.TextLabel then
                    data.TextLabel.Text = string.format("修机进度: %d%%", progress)
                end
                
                local character = game:GetService("Players").LocalPlayer.Character
                local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")
                
                if humanoidRootPart and data.DistanceLabel then
                    local distance = (gen.Main.Position - humanoidRootPart.Position).Magnitude
                    
                    data.DistanceLabel.Text = string.format("距离: %dm", math.floor(distance))
                    
                    local distanceRatio = math.clamp(
                        (distance - distanceSettings.MinDistance) / 
                        (distanceSettings.MaxDistance - distanceSettings.MinDistance),
                        0, 1
                    )
                    
                    local scale = distanceSettings.MinScale + 
                        distanceRatio * (distanceSettings.MaxScale - distanceSettings.MinScale)
                    
                    local textSize = distanceSettings.MinTextSize + 
                        distanceRatio * (distanceSettings.MaxTextSize - distanceSettings.MinTextSize)
                    
                    if data.Billboard then 
                        data.Billboard.Size = UDim2.new(4 * scale, 0, 1 * scale, 0)
                        data.Billboard.Enabled = true
                    end
                    
                    if data.DistanceBillboard then 
                        data.DistanceBillboard.Size = UDim2.new(4 * scale, 0, 1 * scale, 0)
                        data.DistanceBillboard.Enabled = true
                    end
                    
                    if data.TextLabel then 
                        data.TextLabel.TextSize = textSize
                        data.TextLabel.Visible = true
                    end
                    
                    if data.DistanceLabel then 
                        data.DistanceLabel.TextSize = textSize
                        data.DistanceLabel.Visible = true
                    end
                    
                    if data.Highlight then
                        data.Highlight.Enabled = true
                        local transparency = math.clamp((distance - 50) / 100, 0, 0.4)
                        data.Highlight.FillTransparency = 0.85 + (transparency * 0.5)
                        data.Highlight.OutlineColor = Color3.fromRGB(0, 255, 0) -- 绿色
                        data.Highlight.FillColor = Color3.fromRGB(0, 255, 0)
                    end
                end
            end
            
            return true
        end
        
        local function createGeneratorESP(gen)
            if not gen or not gen:FindFirstChild("Main") or _G.RealGeneratorESP.Data[gen] then 
                return 
            end
            
            if table.getn(_G.RealGeneratorESP.Data) >= maxGenerators then
                return
            end
            
            local billboard = Instance.new("BillboardGui")
            billboard.Name = "RealGeneratorESP"
            billboard.Size = UDim2.new(4, 0, 1, 0)
            billboard.StudsOffset = Vector3.new(0, 2.5, 0)
            billboard.Adornee = gen.Main
            billboard.Parent = gen.Main
            billboard.AlwaysOnTop = true
            billboard.Enabled = true
            
            local textLabel = Instance.new("TextLabel")
            textLabel.Size = UDim2.new(1, 0, 0.5, 0)
            textLabel.BackgroundTransparency = 1
            textLabel.TextScaled = false
            textLabel.Text = "真电机加载中..."
            textLabel.TextColor3 = Color3.fromRGB(0, 255, 0) -- 绿色
            textLabel.Font = Enum.Font.Arcade
            textLabel.TextStrokeTransparency = 0
            textLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
            textLabel.TextSize = 8
            textLabel.Parent = billboard
            
            local distanceBillboard = Instance.new("BillboardGui")
            distanceBillboard.Name = "RealGeneratorDistanceESP"
            distanceBillboard.Size = UDim2.new(4, 0, 1, 0)
            distanceBillboard.StudsOffset = Vector3.new(0, 3.5, 0)
            distanceBillboard.Adornee = gen.Main
            distanceBillboard.Parent = gen.Main
            distanceBillboard.AlwaysOnTop = true
            distanceBillboard.Enabled = true
            
            local distanceLabel = Instance.new("TextLabel")
            distanceLabel.Size = UDim2.new(1, 0, 0.5, 0)
            distanceLabel.BackgroundTransparency = 1
            distanceLabel.TextScaled = false
            distanceLabel.Text = "计算距离中..."
            distanceLabel.TextColor3 = Color3.fromRGB(255, 255, 0)
            distanceLabel.Font = Enum.Font.Arcade
            distanceLabel.TextStrokeTransparency = 0
            distanceLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
            distanceLabel.TextSize = 8
            distanceLabel.Parent = distanceBillboard
            
            local highlight = Instance.new("Highlight")
            highlight.Name = "RealGeneratorHighlight"
            highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
            highlight.Enabled = true
            highlight.OutlineColor = Color3.fromRGB(0, 255, 0) -- 绿色
            highlight.FillColor = Color3.fromRGB(0, 255, 0)
            highlight.FillTransparency = 0.9
            highlight.OutlineTransparency = 0
            highlight.Parent = gen
            
            _G.RealGeneratorESP.Data[gen] = {
                Billboard = billboard,
                DistanceBillboard = distanceBillboard,
                TextLabel = textLabel,
                DistanceLabel = distanceLabel,
                Highlight = highlight
            }
            
            local destroyConnection
            destroyConnection = gen.Destroying:Connect(function()
                if _G.RealGeneratorESP.Data[gen] then
                    if _G.RealGeneratorESP.Data[gen].Billboard then 
                        _G.RealGeneratorESP.Data[gen].Billboard:Destroy() 
                    end
                    if _G.RealGeneratorESP.Data[gen].DistanceBillboard then 
                        _G.RealGeneratorESP.Data[gen].DistanceBillboard:Destroy() 
                    end
                    if _G.RealGeneratorESP.Data[gen].Highlight then 
                        _G.RealGeneratorESP.Data[gen].Highlight:Destroy() 
                    end
                    _G.RealGeneratorESP.Data[gen] = nil
                end
                if destroyConnection then
                    destroyConnection:Disconnect()
                end
            end)
            
            table.insert(_G.RealGeneratorESP.Connections, destroyConnection)
        end
        
        local function scanGenerators()
            local mapFolder = workspace:FindFirstChild("Map")
            if mapFolder then
                local ingameFolder = mapFolder:FindFirstChild("Ingame")
                if ingameFolder then
                    local mapSubFolder = ingameFolder:FindFirstChild("Map")
                    if mapSubFolder then
                        local generators = mapSubFolder:GetDescendants()
                        for _, gen in pairs(generators) do
                            if gen:IsA("Model") and gen:FindFirstChild("Main") and gen.Name == "Generator" then
                                createGeneratorESP(gen)
                            end
                        end
                    end
                end
            end
        end
        
        local mainConnection
        local mapFolder = workspace:FindFirstChild("Map")
        if mapFolder then
            local ingameFolder = mapFolder:FindFirstChild("Ingame")
            if ingameFolder then
                local mapSubFolder = ingameFolder:FindFirstChild("Map")
                if mapSubFolder then
                    mainConnection = mapSubFolder.DescendantAdded:Connect(function(v)
                        if v:IsA("Model") and v:FindFirstChild("Main") and v.Name == "Generator" then
                            createGeneratorESP(v)
                        end
                    end)
                end
            end
        end
        
        if mainConnection then
            table.insert(_G.RealGeneratorESP.Connections, mainConnection)
        end
        
        local heartbeatConnection = game:GetService("RunService").Heartbeat:Connect(function(deltaTime)
            lastScanTime = lastScanTime + deltaTime
            if lastScanTime >= scanInterval then
                lastScanTime = 0
                scanGenerators()
            end
            
            local gensToRemove = {}
            for gen, data in pairs(_G.RealGeneratorESP.Data) do
                if not gen or not gen.Parent then
                    table.insert(gensToRemove, gen)
                else
                    if not updateGeneratorESP(gen, data) then
                        table.insert(gensToRemove, gen)
                    end
                end
            end
            
            for _, gen in ipairs(gensToRemove) do
                if _G.RealGeneratorESP.Data[gen] then
                    if _G.RealGeneratorESP.Data[gen].Billboard then 
                        _G.RealGeneratorESP.Data[gen].Billboard:Destroy() 
                    end
                    if _G.RealGeneratorESP.Data[gen].DistanceBillboard then 
                        _G.RealGeneratorESP.Data[gen].DistanceBillboard:Destroy() 
                    end
                    if _G.RealGeneratorESP.Data[gen].Highlight then 
                        _G.RealGeneratorESP.Data[gen].Highlight:Destroy() 
                    end
                    _G.RealGeneratorESP.Data[gen] = nil
                end
            end
        end)
        
        table.insert(_G.RealGeneratorESP.Connections, heartbeatConnection)
        
        scanGenerators()
    end
})

-- 假电机ESP
Visual:AddToggle("FakeGeneratorESP", {
    Text = "绘制假电机",
    Default = false,
    Callback = function(enabled)
        if not _G.FakeGeneratorESP then
            _G.FakeGeneratorESP = {
                Active = false,
                Data = {},
                Connections = {}
            }
        end
        
        if not enabled then
            if _G.FakeGeneratorESP.Active then
                for _, connection in pairs(_G.FakeGeneratorESP.Connections) do
                    if connection and connection.Connected then
                        connection:Disconnect()
                    end
                end
                
                for gen, data in pairs(_G.FakeGeneratorESP.Data) do
                    if type(data) == "table" then
                        if data.Highlight and data.Highlight.Parent then
                            data.Highlight:Destroy()
                        end
                        if data.NameLabel and data.NameLabel.Parent then
                            data.NameLabel:Destroy()
                        end
                    end
                end
                
                _G.FakeGeneratorESP.Data = {}
                _G.FakeGeneratorESP.Connections = {}
                _G.FakeGeneratorESP.Active = false
            end
            return
        end
        
        if _G.FakeGeneratorESP.Active then
            _G.FakeGeneratorESP.Callback(false)
        end
        
        _G.FakeGeneratorESP.Active = true
        
        local scanInterval = 1.0
        local lastScanTime = 0
        
        local function createFakeGeneratorESP(gen)
            if not gen or not gen:FindFirstChild("Main") or _G.FakeGeneratorESP.Data[gen] then 
                return 
            end
            
            local highlight = Instance.new("Highlight")
            highlight.Name = "FakeGeneratorHighlight"
            highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
            highlight.Enabled = true
            highlight.OutlineColor = Color3.fromRGB(255, 0, 0)
            highlight.FillColor = Color3.fromRGB(255, 0, 0)
            highlight.FillTransparency = 0.9
            highlight.OutlineTransparency = 0
            highlight.Parent = gen
            
            local nameBillboard = Instance.new("BillboardGui")
            nameBillboard.Name = "FakeGeneratorNameESP"
            nameBillboard.Size = UDim2.new(4, 0, 1, 0)
            nameBillboard.StudsOffset = Vector3.new(0, 2.5, 0)
            nameBillboard.Adornee = gen.Main
            nameBillboard.Parent = gen.Main
            nameBillboard.AlwaysOnTop = true
            nameBillboard.Enabled = true
            
            local nameLabel = Instance.new("TextLabel")
            nameLabel.Size = UDim2.new(1, 0, 1, 0)
            nameLabel.BackgroundTransparency = 1
            nameLabel.TextScaled = false
            nameLabel.Text = "假电机"
            nameLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
            nameLabel.Font = Enum.Font.Arcade
            nameLabel.TextStrokeTransparency = 0
            nameLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
            nameLabel.TextSize = 12
            nameLabel.Parent = nameBillboard
            
            _G.FakeGeneratorESP.Data[gen] = {
                Highlight = highlight,
                NameLabel = nameLabel,
                NameBillboard = nameBillboard
            }
            
            local destroyConnection
            destroyConnection = gen.Destroying:Connect(function()
                if _G.FakeGeneratorESP.Data[gen] then
                    if _G.FakeGeneratorESP.Data[gen].Highlight then 
                        _G.FakeGeneratorESP.Data[gen].Highlight:Destroy() 
                    end
                    if _G.FakeGeneratorESP.Data[gen].NameLabel then 
                        _G.FakeGeneratorESP.Data[gen].NameLabel:Destroy() 
                    end
                    if _G.FakeGeneratorESP.Data[gen].NameBillboard then 
                        _G.FakeGeneratorESP.Data[gen].NameBillboard:Destroy() 
                    end
                    _G.FakeGeneratorESP.Data[gen] = nil
                end
                if destroyConnection then
                    destroyConnection:Disconnect()
                end
            end)
            
            table.insert(_G.FakeGeneratorESP.Connections, destroyConnection)
        end
        
        local function scanGenerators()
            local mapFolder = workspace:FindFirstChild("Map")
            if mapFolder then
                local ingameFolder = mapFolder:FindFirstChild("Ingame")
                if ingameFolder then
                    local mapSubFolder = ingameFolder:FindFirstChild("Map")
                    if mapSubFolder then
                        local generators = mapSubFolder:GetDescendants()
                        for _, gen in pairs(generators) do
                            if gen:IsA("Model") and gen:FindFirstChild("Main") and gen.Name == "FakeGenerator" then
                                createFakeGeneratorESP(gen)
                            end
                        end
                    end
                end
            end
        end
        
        local mainConnection
        local mapFolder = workspace:FindFirstChild("Map")
        if mapFolder then
            local ingameFolder = mapFolder:FindFirstChild("Ingame")
            if ingameFolder then
                local mapSubFolder = ingameFolder:FindFirstChild("Map")
                if mapSubFolder then
                    mainConnection = mapSubFolder.DescendantAdded:Connect(function(v)
                        if v:IsA("Model") and v:FindFirstChild("Main") and v.Name == "FakeGenerator" then
                            createFakeGeneratorESP(v)
                        end
                    end)
                end
            end
        end
        
        if mainConnection then
            table.insert(_G.FakeGeneratorESP.Connections, mainConnection)
        end
        
        local heartbeatConnection = game:GetService("RunService").Heartbeat:Connect(function(deltaTime)
            lastScanTime = lastScanTime + deltaTime
            if lastScanTime >= scanInterval then
                lastScanTime = 0
                scanGenerators()
            end
            
            local gensToRemove = {}
            for gen, data in pairs(_G.FakeGeneratorESP.Data) do
                if not gen or not gen.Parent then
                    table.insert(gensToRemove, gen)
                end
            end
            
            for _, gen in ipairs(gensToRemove) do
                if _G.FakeGeneratorESP.Data[gen] then
                    if _G.FakeGeneratorESP.Data[gen].Highlight then 
                        _G.FakeGeneratorESP.Data[gen].Highlight:Destroy() 
                    end
                    if _G.FakeGeneratorESP.Data[gen].NameLabel then 
                        _G.FakeGeneratorESP.Data[gen].NameLabel:Destroy() 
                    end
                    if _G.FakeGeneratorESP.Data[gen].NameBillboard then 
                        _G.FakeGeneratorESP.Data[gen].NameBillboard:Destroy() 
                    end
                    _G.FakeGeneratorESP.Data[gen] = nil
                end
            end
        end)
        
        table.insert(_G.FakeGeneratorESP.Connections, heartbeatConnection)
        
        scanGenerators()
    end
})

-- 特殊电机ESP
Visual:AddToggle("NoliWarningESP", {
    Text = "Noli即将传送的电机",
    Default = false,
    Callback = function(enabled)
        if not _G.NoliWarningESP then
            _G.NoliWarningESP = {
                Active = false,
                Data = {},
                Connections = {}
            }
        end
        
        if not enabled then
            if _G.NoliWarningESP.Active then
                for _, connection in pairs(_G.NoliWarningESP.Connections) do
                    if connection and connection.Connected then
                        connection:Disconnect()
                    end
                end
                
                for gen, data in pairs(_G.NoliWarningESP.Data) do
                    if type(data) == "table" then
                        if data.Highlight and data.Highlight.Parent then
                            data.Highlight:Destroy()
                        end
                        if data.Label and data.Label.Parent then
                            data.Label:Destroy()
                        end
                    end
                end
                
                _G.NoliWarningESP.Data = {}
                _G.NoliWarningESP.Connections = {}
                _G.NoliWarningESP.Active = false
            end
            return
        end
        
        if _G.NoliWarningESP.Active then
            return
        end
        
        _G.NoliWarningESP.Active = true
        
        local scanInterval = 1.0
        local lastScanTime = 0
        
        local function hasNoliWarning(gen)
            if string.find(gen.Name, "NoliWarningIncoming") then
                return true
            end
            
            for _, child in pairs(gen:GetDescendants()) do
                if (child:IsA("StringValue") or child:IsA("ObjectValue")) and 
                   string.find(tostring(child.Value), "NoliWarningIncoming") then
                    return true
                elseif child:IsA("BasePart") and string.find(child.Name, "NoliWarningIncoming") then
                    return true
                end
            end
            
            return false
        end
        
        local function createNoliWarningESP(gen)
            if not gen or not gen:FindFirstChild("Main") or _G.NoliWarningESP.Data[gen] then 
                return 
            end
            
            if not hasNoliWarning(gen) then
                return
            end
            
            local highlight = Instance.new("Highlight")
            highlight.Name = "NoliWarningHighlight"
            highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
            highlight.Enabled = true
            highlight.OutlineColor = Color3.fromRGB(255, 0, 255)
            highlight.FillColor = Color3.fromRGB(255, 0, 255)
            highlight.FillTransparency = 0.7
            highlight.OutlineTransparency = 0
            highlight.Parent = gen
            
            local billboard = Instance.new("BillboardGui")
            billboard.Name = "NoliWarningBillboard"
            billboard.Size = UDim2.new(6, 0, 2, 0)
            billboard.StudsOffset = Vector3.new(0, 3, 0)
            billboard.Adornee = gen.Main
            billboard.Parent = gen.Main
            billboard.AlwaysOnTop = true
            
            local label = Instance.new("TextLabel")
            label.Size = UDim2.new(1, 0, 1, 0)
            label.BackgroundTransparency = 1
            label.Text = "[Noli Will Tp]"
            label.TextColor3 = Color3.fromRGB(255, 0, 255)
            label.Font = Enum.Font.Arcade
            label.TextSize = 14
            label.TextStrokeTransparency = 0
            label.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
            label.Parent = billboard
            
            _G.NoliWarningESP.Data[gen] = {
                Highlight = highlight,
                Label = label,
                Billboard = billboard,
                LastCheck = os.time()
            }
            
            local destroyConnection
            destroyConnection = gen.Destroying:Connect(function()
                if _G.NoliWarningESP.Data[gen] then
                    if _G.NoliWarningESP.Data[gen].Highlight then 
                        _G.NoliWarningESP.Data[gen].Highlight:Destroy() 
                    end
                    if _G.NoliWarningESP.Data[gen].Label then 
                        _G.NoliWarningESP.Data[gen].Label:Destroy() 
                    end
                    if _G.NoliWarningESP.Data[gen].Billboard then 
                        _G.NoliWarningESP.Data[gen].Billboard:Destroy() 
                    end
                    _G.NoliWarningESP.Data[gen] = nil
                end
                if destroyConnection then
                    destroyConnection:Disconnect()
                end
            end)
            
            table.insert(_G.NoliWarningESP.Connections, destroyConnection)
        end
        
        local function scanGenerators()
            local generators = workspace:GetDescendants()
            for _, gen in pairs(generators) do
                if gen:IsA("Model") and gen:FindFirstChild("Main") and 
                   (gen.Name == "Generator" or gen.Name == "FakeGenerator") then
                    createNoliWarningESP(gen)
                end
            end
        end
        
        local function updateExistingGenerators()
            local gensToRemove = {}
            for gen, data in pairs(_G.NoliWarningESP.Data) do
                if not gen or not gen.Parent then
                    table.insert(gensToRemove, gen)
                else
                    if os.time() - data.LastCheck > 5 then
                        if not hasNoliWarning(gen) then
                            table.insert(gensToRemove, gen)
                        else
                            data.LastCheck = os.time()
                        end
                    end
                end
            end
            
            for _, gen in ipairs(gensToRemove) do
                if _G.NoliWarningESP.Data[gen] then
                    if _G.NoliWarningESP.Data[gen].Highlight then 
                        _G.NoliWarningESP.Data[gen].Highlight:Destroy() 
                    end
                    if _G.NoliWarningESP.Data[gen].Label then 
                        _G.NoliWarningESP.Data[gen].Label:Destroy() 
                    end
                    if _G.NoliWarningESP.Data[gen].Billboard then 
                        _G.NoliWarningESP.Data[gen].Billboard:Destroy() 
                    end
                    _G.NoliWarningESP.Data[gen] = nil
                end
            end
        end
        
        local mainConnection = workspace.DescendantAdded:Connect(function(v)
            if v:IsA("Model") and v:FindFirstChild("Main") and 
               (v.Name == "Generator" or v.Name == "FakeGenerator") then
                createNoliWarningESP(v)
            end
        end)
        
        table.insert(_G.NoliWarningESP.Connections, mainConnection)
        
        local heartbeatConnection = game:GetService("RunService").Heartbeat:Connect(function(deltaTime)
            lastScanTime = lastScanTime + deltaTime
            if lastScanTime >= scanInterval then
                lastScanTime = 0
                scanGenerators()
                updateExistingGenerators()
            end
        end)
        
        table.insert(_G.NoliWarningESP.Connections, heartbeatConnection)
        
        scanGenerators()
    end
})








local Visual = Tabs.Esp:AddLeftGroupbox("物品绘制")

local LibESP = loadstring(game:HttpGet("https://raw.githubusercontent.com/ImamGV/Script/main/ESP"))()

Visual:AddToggle("EKE",{
    Text = "杀手召唤物绘制",
    Callback = function(v)
        if v then
            for _, v in ipairs(workspace:GetDescendants()) do
                if v:IsA("Model") and v.Name == "DeliveryRig" or v.Name == "Bunny" or v.Name == "Mafia1" or v.Name == "Mafia2" or v.Name == "Mafia3" or v.Name == "Mafia4" then
                    LibESP:AddESP(v, "pizza deliveryman", Color3.fromRGB(255, 52, 179), 14, "Other_ESP")
                elseif v:IsA("Model") and v.Name == "1x1x1x1Zombie" then
                    LibESP:AddESP(v, "1x1x1x1 (zombie)", Color3.fromRGB(224, 102, 255), 14, "Other_ESP")
                end
            end
            OtherESP = workspace.DescendantAdded:Connect(function(v)
                if v:IsA("Model") and v.Name == "PizzaDeliveryRig" or v.Name == "Bunny" or v.Name == "Mafia1" or v.Name == "Mafia2" or v.Name == "Mafia3" or v.Name == "Mafia4" then
                    LibESP:AddESP(v, "pizza deliveryman", Color3.fromRGB(255, 52, 179), 14, "Other_ESP")
                elseif v:IsA("Model") and v.Name == "1x1x1x1Zombie" then
                    LibESP:AddESP(v, "1x1x1x1 (zombie)", Color3.fromRGB(224, 102, 255), 14, "Other_ESP")
                end
            end)
        else
            OtherESP:Disconnect()
            LibESP:Delete("Other_ESP")
        end
    end
})



Visual:AddToggle("TWE", {
    Text = "塔夫绊线绘制",
    Default = false,
    Callback = function(state)
        if state then
            -- 存储所有高亮对象的连接
            _G.TWE_HighlightedObjects = _G.TWE_HighlightedObjects or {}
            
            -- 高亮现有绊线
            for _, obj in ipairs(workspace:GetDescendants()) do
                if obj.Name:match("TaphTripwire") and not obj:FindFirstChild("TWE_Highlight") then
                    local highlight = Instance.new("Highlight")
                    highlight.Name = "TWE_Highlight"
                    highlight.FillColor = Color3.fromRGB(102, 0, 153) -- 深紫色
                    highlight.OutlineColor = Color3.fromRGB(102, 0, 153)
                    highlight.FillTransparency = 0.5
                    highlight.OutlineTransparency = 0
                    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                    highlight.Parent = obj
                    
                    -- 监听对象移除
                    _G.TWE_HighlightedObjects[obj] = obj.AncestryChanged:Connect(function(_, parent)
                        if not parent and highlight and highlight.Parent then
                            highlight:Destroy()
                            if _G.TWE_HighlightedObjects[obj] then
                                _G.TWE_HighlightedObjects[obj]:Disconnect()
                                _G.TWE_HighlightedObjects[obj] = nil
                            end
                        end
                    end)
                end
            end

            -- 监听新增绊线
            _G.TWE_Connection = workspace.DescendantAdded:Connect(function(obj)
                if obj.Name:match("TaphTripwire") and not obj:FindFirstChild("TWE_Highlight") then
                    local highlight = Instance.new("Highlight")
                    highlight.Name = "TWE_Highlight"
                    highlight.FillColor = Color3.fromRGB(102, 0, 153)
                    highlight.OutlineColor = Color3.fromRGB(102, 0, 153)
                    highlight.FillTransparency = 0.5
                    highlight.OutlineTransparency = 0
                    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                    highlight.Parent = obj
                    
                    -- 监听对象移除
                    _G.TWE_HighlightedObjects[obj] = obj.AncestryChanged:Connect(function(_, parent)
                        if not parent and highlight and highlight.Parent then
                            highlight:Destroy()
                            if _G.TWE_HighlightedObjects[obj] then
                                _G.TWE_HighlightedObjects[obj]:Disconnect()
                                _G.TWE_HighlightedObjects[obj] = nil
                            end
                        end
                    end)
                end
            end)
        else
            -- 禁用时清除所有高亮和连接
            if _G.TWE_Connection then
                _G.TWE_Connection:Disconnect()
            end
            
            -- 清理所有高亮对象
            for obj, connection in pairs(_G.TWE_HighlightedObjects or {}) do
                if connection then
                    connection:Disconnect()
                end
                if obj:FindFirstChild("TWE_Highlight") then
                    obj.TWE_Highlight:Destroy()
                end
            end
            _G.TWE_HighlightedObjects = {}
        end
    end
})


Visual:AddToggle("ShadowDetector", {
    Text = "约翰多陷阱绘制",
    Default = false,
    Callback = function(Value)
        -- Define all variables and functions inside the callback to keep them contained
        local currentShadows = {}
        local checkingConnection = nil
        local isRunning = false
        local scriptConnection = nil

        -- Recursive function to find all Shadow objects
        local function findAllShadowsInFolder(folder)
            local shadows = {}
            for _, child in ipairs(folder:GetChildren()) do
                if child.Name == "Shadow" then
                    table.insert(shadows, child)
                elseif child:IsA("Folder") or child:IsA("Model") then
                    local foundShadows = findAllShadowsInFolder(child)
                    for _, foundShadow in ipairs(foundShadows) do
                        table.insert(shadows, foundShadow)
                    end
                end
            end
            return shadows
        end

        -- Create marker for a single Shadow
        local function createShadowMarker(shadow)
            local player = game.Players.LocalPlayer
            local character = player.Character or player.CharacterAdded:Wait()
            local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
            
            local function getObjectSize(obj)
                if obj:IsA("BasePart") then
                    return obj.Size
                elseif obj:IsA("Model") and obj.PrimaryPart then
                    local cf = obj:GetBoundingBox()
                    return (cf[2] - cf[1]).Magnitude
                else
                    return Vector3.new(5, 5, 5)
                end
            end
            
            local objectSize = getObjectSize(shadow)
            
            local highlight = Instance.new("Highlight")
            highlight.Name = "ShadowRangeIndicator"
            highlight.FillColor = Color3.fromRGB(255, 0, 0)
            highlight.FillTransparency = 0.8
            highlight.OutlineColor = Color3.fromRGB(255, 100, 100)
            highlight.OutlineTransparency = 0.5
            highlight.Parent = shadow
            
            local billboard = Instance.new("BillboardGui")
            billboard.Name = "ShadowNameDisplay"
            billboard.AlwaysOnTop = true
            billboard.Size = UDim2.new(0, 180, 0, 60)
            billboard.StudsOffset = Vector3.new(0, objectSize.Y/2 + 2, 0)
            billboard.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
            
            local textLabel = Instance.new("TextLabel")
            textLabel.Name = "TrapLabel"
            textLabel.Text = "TRAP"
            textLabel.Size = UDim2.new(1, 0, 0.5, 0)
            textLabel.Position = UDim2.new(0, 0, 0, 0)
            textLabel.Font = Enum.Font.Arcade
            textLabel.TextSize = 18
            textLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
            textLabel.BackgroundTransparency = 1
            textLabel.TextStrokeTransparency = 0
            textLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
            textLabel.TextXAlignment = Enum.TextXAlignment.Center
            textLabel.TextYAlignment = Enum.TextYAlignment.Center
            
            local distanceLabel = Instance.new("TextLabel")
            distanceLabel.Name = "DistanceLabel"
            distanceLabel.Text = "Distance: Calculating..."
            distanceLabel.Size = UDim2.new(1, 0, 0.5, 0)
            distanceLabel.Position = UDim2.new(0, 0, 0.5, 0)
            distanceLabel.Font = Enum.Font.Arcade
            distanceLabel.TextSize = 14
            distanceLabel.TextColor3 = Color3.fromRGB(0, 255, 255)
            distanceLabel.BackgroundTransparency = 1
            distanceLabel.TextStrokeTransparency = 0
            distanceLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
            distanceLabel.TextXAlignment = Enum.TextXAlignment.Center
            distanceLabel.TextYAlignment = Enum.TextYAlignment.Center
            
            textLabel.Parent = billboard
            distanceLabel.Parent = billboard
            billboard.Parent = shadow
            
            if shadow:IsA("BasePart") then
                local boxHandleAdornment = Instance.new("BoxHandleAdornment")
                boxHandleAdornment.Name = "SizeIndicator"
                boxHandleAdornment.Adornee = shadow
                boxHandleAdornment.AlwaysOnTop = true
                boxHandleAdornment.Size = shadow.Size
                boxHandleAdornment.Transparency = 0.7
                boxHandleAdornment.Color3 = Color3.fromRGB(255, 50, 50)
                boxHandleAdornment.ZIndex = 10
                boxHandleAdornment.Parent = shadow
            end
            
            local heartbeatConnection
            heartbeatConnection = game:GetService("RunService").Heartbeat:Connect(function()
                if not shadow or not shadow.Parent then 
                    if heartbeatConnection then
                        heartbeatConnection:Disconnect()
                        heartbeatConnection = nil
                    end
                    return 
                end
                if not humanoidRootPart or not humanoidRootPart.Parent then return end
                
                local distance = (humanoidRootPart.Position - shadow.Position).Magnitude
                distanceLabel.Text = string.format("Distance: %.1f m", distance)
                
                local baseScale = math.clamp(40 / math.max(1, distance), 0.4, 1.8)
                textLabel.TextSize = 18 * baseScale
                distanceLabel.TextSize = 14 * baseScale
                
                local overallTransparency = math.clamp(distance / 80, 0.1, 0.4)
                local strokeTransparency = overallTransparency * 0.1
                textLabel.TextStrokeTransparency = strokeTransparency
                distanceLabel.TextStrokeTransparency = strokeTransparency
                highlight.FillTransparency = math.clamp(distance/70, 0.3, 0.8)
            end)
            
            currentShadows[shadow] = {
                heartbeat = heartbeatConnection,
                marker = {
                    highlight = highlight,
                    billboard = billboard,
                    textLabel = textLabel,
                    distanceLabel = distanceLabel,
                    boxHandle = shadow:IsA("BasePart") and shadow:FindFirstChild("SizeIndicator")
                }
            }
        end

        -- Remove marker for a single Shadow
        local function removeShadowMarker(shadow)
            local markerData = currentShadows[shadow]
            if markerData then
                if markerData.heartbeat then
                    markerData.heartbeat:Disconnect()
                end
                
                if markerData.marker then
                    if markerData.marker.highlight and markerData.marker.highlight.Parent then
                        markerData.marker.highlight:Destroy()
                    end
                    if markerData.marker.billboard and markerData.marker.billboard.Parent then
                        markerData.marker.billboard:Destroy()
                    end
                    if markerData.marker.boxHandle and markerData.marker.boxHandle.Parent then
                        markerData.marker.boxHandle:Destroy()
                    end
                end
                
                currentShadows[shadow] = nil
            end
        end

        -- Check and update Shadow markers
        local function checkAndUpdateShadows()
            local allFolders = {workspace.Map.Ingame}
            local foundShadows = {}
            
            for _, folder in ipairs(allFolders) do
                if folder and (folder:IsA("Folder") or folder:IsA("Model")) then
                    local shadowsInFolder = findAllShadowsInFolder(folder)
                    for _, shadow in ipairs(shadowsInFolder) do
                        table.insert(foundShadows, shadow)
                    end
                end
            end
            
            for _, shadow in ipairs(foundShadows) do
                if not currentShadows[shadow] then
                    createShadowMarker(shadow)
                end
            end
            
            local shadowsToRemove = {}
            for shadow, _ in pairs(currentShadows) do
                local stillExists = false
                for _, foundShadow in ipairs(foundShadows) do
                    if shadow == foundShadow then
                        stillExists = true
                        break
                    end
                end
                
                if not stillExists then
                    table.insert(shadowsToRemove, shadow)
                end
            end
            
            for _, shadow in ipairs(shadowsToRemove) do
                removeShadowMarker(shadow)
            end
        end

        -- Start the detection system
        local function startShadowChecking()
            if isRunning then return end
            isRunning = true
            
            checkAndUpdateShadows()
            
            checkingConnection = game:GetService("RunService").Heartbeat:Connect(function()
                -- Empty connection just to keep the script alive
            end)
            
            scriptConnection = game:GetService("RunService").Stepped:Connect(function()
                local success, _ = pcall(function()
                    local test = script.Name
                end)
                
                if not success then
                    stopShadowChecking()
                    if scriptConnection then
                        scriptConnection:Disconnect()
                        scriptConnection = nil
                    end
                end
            end)
            
            task.spawn(function()
                while isRunning do
                    checkAndUpdateShadows()
                    task.wait(2)
                end
            end)
        end

        -- Stop the detection system
        local function stopShadowChecking()
            if not isRunning then return end
            isRunning = false
            
            if checkingConnection then
                checkingConnection:Disconnect()
                checkingConnection = nil
            end
            
            if scriptConnection then
                scriptConnection:Disconnect()
                scriptConnection = nil
            end
            
            for shadow, _ in pairs(currentShadows) do
                removeShadowMarker(shadow)
            end
            
            currentShadows = {}
        end

        -- Handle the toggle state
        if Value then
            startShadowChecking()
        else
            stopShadowChecking()
        end
    end
})

Visual:AddToggle("ST",{
Text = "塔夫空间炸弹绘制",
Callback = function(v)
if v then
for _, v in ipairs(workspace:GetDescendants()) do
if v:IsA("Model") and v.Name == "SubspaceTripmine" and not v:FindFirstChild("SubspaceTripmine_ESP") then
LibESP:AddESP(v, "", Color3.fromRGB(255, 0, 255), 14, "SubspaceTripmine_ESP")
end
end
SubspaceTripmineESP = workspace.DescendantAdded:Connect(function(v)
if v:IsA("Model") and v.Name == "SubspaceTripmine" and not v:FindFirstChild("SubspaceTripmine_ESP") then
LibESP:AddESP(v, "", Color3.fromRGB(255, 0, 255), 14, "SubspaceTripmine_ESP")
end
end)
else
SubspaceTripmineESP:Disconnect()
LibESP:Delete("SubspaceTripmine_ESP")
end
end})
Visual:AddToggle("ME",{
Text = "医疗包绘制",
Callback = function(v)
if v then
for _, v in ipairs(workspace:GetDescendants()) do
if v:IsA("Model") and v.Name == "Medkit" and not v:FindFirstChild("Medkit_ESP") then
LibESP:AddESP(v, "Medkit", Color3.fromRGB(187, 255, 255), 14, "Medkit_ESP")
end
end
MedkitESP = workspace.DescendantAdded:Connect(function(v)
if v:IsA("Model") and v.Name == "Medkit" and not v:FindFirstChild("Medkit_ESP") then
LibESP:AddESP(v, "Medkit", Color3.fromRGB(187, 255, 255), 14, "Medkit_ESP")
end
end)
else
Medkit:Disconnect()
LibESP:Delete("Medkit_ESP")
end
end})
Visual:AddToggle("BCE",{
Text = "可乐绘制",
Callback = function(v)
if v then
for _, v in ipairs(workspace:GetDescendants()) do
if v:IsA("Model") and v.Name == "BloxyCola" and not v:FindFirstChild("BloxyCola_ESP") then
LibESP:AddESP(v, "Bloxy Cola", Color3.fromRGB(131, 111, 255), 14, "BloxyCola_ESP")
end
end
ColaESP = workspace.DescendantAdded:Connect(function(v)
if v:IsA("Model") and v.Name == "BloxyCola" and not v:FindFirstChild("BloxyCola_ESP") then
LibESP:AddESP(v, "Bloxy Cola", Color3.fromRGB(131, 111, 255), 14, "BloxyCola_ESP")
end
end)
else
ColaESP:Disconnect()
LibESP:Delete("BloxyCola_ESP")
end
end})


local SM = Tabs.Aimbot:AddLeftGroupbox('静默平滑瞄准[杀手]')
local LocalPlayer = Players.LocalPlayer
local Workspace = game:GetService("Workspace")

local silentAimEnabled = false
local targetPlayer = nil
local maxDistance = 100
local silentAimConnection = nil
local smoothingFactor = 0.2 

-- 要检测的动画ID
local KILLER_ANIMATIONS = {
    -- Jason 动画
    ["126830014841198"] = true,
    ["126355327951215"] = true,
    ["121086746534252"] = true,
    -- Joe (1x1x1x1) 动画
    ["105458270463374"] = true,
    ["127172483138092"] = true,
    ["131430497821198"] = true,
    ["119181003138006"] = true,
    -- Coolkid 动画
    ["18885909645"] = true,
    ["98456918873918"] = true,
    ["106776364623742"] = true,
    ["18885906143"] = true,
    ["18885940850"] = true,
    ["18885903667"] = true,
    -- Noli 动画
    ["109230267448394"] = true,
    ["91758760621955"] = true,
    ["93841120533318"] = true,
    ["139835501033932"] = true,
    ["126896426760253"] = true,
    ["109700476007435"] = true,
    ["139321362207112"] = true,
    ["83465205704188"] = true,
}

local function isPlayingKillerAnimation()
    if not LocalPlayer.Character then return false end
    
    local humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
    if not humanoid then return false end
    
    local animator = humanoid:FindFirstChildOfClass("Animator")
    if not animator then return false end
    
    for _, track in pairs(animator:GetPlayingAnimationTracks()) do
        if track.Animation then
            local animId = tostring(track.Animation.AnimationId:match("%d+"))
            if KILLER_ANIMATIONS[animId] then
                return true
            end
        end
    end
    
    return false
end

local function isKiller()
    pcall(function()
        local killersFolder = Workspace:FindFirstChild("Players") and Workspace.Players:FindFirstChild("Killers")
        if killersFolder and LocalPlayer.Character and table.find(killersFolder:GetChildren(), LocalPlayer.Character) then
            return true
        end
    end)
    return false
end

local function getClosestSurvivor()
    pcall(function()
        local survivorsFolder = Workspace:FindFirstChild("Players") and Workspace.Players:FindFirstChild("Survivors")
        if not survivorsFolder then return nil end

        local myChar = LocalPlayer.Character
        if not myChar or not myChar:FindFirstChild("HumanoidRootPart") then return nil end
        local myPos = myChar.HumanoidRootPart.Position

        local closest = nil
        local shortest = math.huge

        for _, model in ipairs(survivorsFolder:GetChildren()) do
            if model:IsA("Model") and model:FindFirstChild("HumanoidRootPart") then
                local dist = (model.HumanoidRootPart.Position - myPos).Magnitude
                if dist < shortest and dist <= maxDistance then
                    shortest = dist
                    closest = model
                end
            end
        end

        return closest
    end)
    return nil
end

local function smoothFaceTarget(model)
    pcall(function()
        if not model or not model:FindFirstChild("HumanoidRootPart") then return end
        local char = LocalPlayer.Character
        if not char or not char:FindFirstChild("HumanoidRootPart") then return end

        local root = char.HumanoidRootPart
        local targetPos = model.HumanoidRootPart.Position
        
        -- 计算目标朝向
        local desiredLook = CFrame.new(root.Position, Vector3.new(targetPos.X, root.Position.Y, targetPos.Z))
        
        -- 平滑插值旋转
        root.CFrame = root.CFrame:Lerp(desiredLook, smoothingFactor)
    end)
end

getgenv().GetSilentAimTargetPosition = function()
    pcall(function()
        if silentAimEnabled and isKiller() and isPlayingKillerAnimation() then
            local target = getClosestSurvivor()
            if target and target:FindFirstChild("Head") then
                return target.Head.Position
            end
        end
    end)
    return nil
end

-- 添加静默瞄准开关
SM:AddToggle("静默瞄准", {
    Text = "Silent Aiming[静默瞄准]",
    Callback = function(state)
        silentAimEnabled = state
       
        if state then
            if not silentAimConnection then
                silentAimConnection = RunService.Heartbeat:Connect(function()
                    pcall(function()
                        if not isKiller() or not isPlayingKillerAnimation() then 
                            targetPlayer = nil
                            return 
                        end
                        
                        targetPlayer = getClosestSurvivor()
                        if targetPlayer then
                            smoothFaceTarget(targetPlayer)
                        end
                    end)
                end)
            end
        else
            if silentAimConnection then
                silentAimConnection:Disconnect()
                silentAimConnection = nil
            end
            targetPlayer = nil
        end
    end
})

SM:AddSlider("自瞄距离", {
    Text = "[自瞄距离]",
    Default = 30,
    Min = 1,
    Max = 500,
    Rounding = 0,
    Callback = function(value)
        maxDistance = value
    end
})

SM:AddSlider("瞄准平滑度", {
    Text = "Aim Smoothing[瞄准平滑度]",
    Default = 0.2,
    Min = 0.05,
    Max = 1,
    Rounding = 2,
    Callback = function(value)
        smoothingFactor = value
    end
})







local LeftGroupBox = Tabs.Aimbot:AddLeftGroupbox('TwoTime背刺')
local RunService = game:GetService("RunService")
local LocalPlayer = game:GetService("Players").LocalPlayer

do
	local Backstab = {
		Enabled = false,
		Mode = "Behind",
		Range = 4,
		Cooldown = false,
		LastTarget = nil,
		KillerNames = { "Jason", "c00lkidd", "JohnDoe", "1x1x1x1", "Noli", "Slasher" },
		DaggerRemote = game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("Network"):WaitForChild("RemoteEvent"),
		KillersFolder = workspace:WaitForChild("Players"):WaitForChild("Killers")
	}

	local function CreateUI()
		LeftGroupBox:AddToggle("BackstabToggle", {
			Text = "自动背刺[Two Time]",
			Default = false,
			Callback = function(Value)
				Backstab.Enabled = Value
			end,
		})

		LeftGroupBox:AddDropdown("BackstabModeDropdown", {
			Values = { "Behind", "Around" },
			Default = 1,
			Multi = false,
			Text = "模式",
			Callback = function(Value)
				if Value == "Behind" then
					Backstab.Mode = "Behind"
				elseif Value == "Around" then
					Backstab.Mode = "Around"
				end
			end,
		})

		LeftGroupBox:AddSlider("BackstabRangeSlider", {
			Text = "距离",
			Default = 4,
			Min = 1,
			Max = 20,
			Rounding = 0,
			Callback = function(Value)
				Backstab.Range = Value
			end,
		})
	end

	local function isBehindTarget(hrp, targetHRP)
		if not (hrp and targetHRP and hrp.Parent and targetHRP.Parent) then return false end
		local distance = (hrp.Position - targetHRP.Position).Magnitude
		if distance > Backstab.Range then return false end

		if Backstab.Mode == "Around" then
			return true
		else
			local direction = -targetHRP.CFrame.LookVector
			local toPlayer = (hrp.Position - targetHRP.Position)
			return toPlayer:Dot(direction) > 0.5
		end
	end

	local function OnHeartbeat()
		if not Backstab.Enabled or Backstab.Cooldown then return end
		local char = LocalPlayer.Character
		if not (char and char:FindFirstChild("HumanoidRootPart")) then return end
		local hrp = char.HumanoidRootPart

		for _, name in ipairs(Backstab.KillerNames) do
			local killer = Backstab.KillersFolder:FindFirstChild(name)
			if killer and killer:FindFirstChild("HumanoidRootPart") then
				local kHRP = killer.HumanoidRootPart
				if isBehindTarget(hrp, kHRP) and killer ~= Backstab.LastTarget then
					Backstab.Cooldown = true
					Backstab.LastTarget = killer
					hrp.CFrame = CFrame.new(kHRP.Position - kHRP.CFrame.LookVector, kHRP.Position)
					local args = {
						"UseActorAbility",
						{
							buffer.fromstring("\"Dagger\"")
						}
					}
					Backstab.DaggerRemote:FireServer(unpack(args))
					task.delay(1, function()
						Backstab.LastTarget = nil
						Backstab.Cooldown = false
					end)
					break
				end
			end
		end
	end

	CreateUI()
	RunService.Heartbeat:Connect(OnHeartbeat)
end

local ChanceGroup = Tabs.Aimbot:AddLeftGroupbox('机会预判自瞄')

do
	local PredictionAim = {
		Enabled = false,
		Prediction = 4,
		Duration = 1.7,
		Targets = { "Jason", "c00lkidd", "JohnDoe", "1x1x1x1", "Noli", "Slasher","Sixer" },
		TrackedAnimations = {
			["103601716322988"] = true, ["133491532453922"] = true, ["86371356500204"] = true,
			["76649505662612"] = true, ["81698196845041"] = true
		},
		Humanoid = nil,
		HRP = nil,
		LastTriggerTime = 0,
		IsAiming = false,
		OriginalState = nil
	}

	local function CreateUI()
		ChanceGroup:AddToggle("AimToggle", {
			Text = "预判瞄准[Chance]",
			Default = false,
			Callback = function(Value)
				PredictionAim.Enabled = Value
			end,
		})
		ChanceGroup:AddSlider("PredictionSlider", {
			Text = "预判系数",
			Default = 4,
			Min = 0,
			Max = 15,
			Rounding = 1,
			Callback = function(Value)
				PredictionAim.Prediction = Value
			end,
		})
	end

	local function getValidTarget()
		local killersFolder = workspace:FindFirstChild("Players") and workspace.Players:FindFirstChild("Killers")
		if killersFolder then
			for _, name in ipairs(PredictionAim.Targets) do
				local target = killersFolder:FindFirstChild(name)
				if target and target:FindFirstChild("HumanoidRootPart") then
					return target.HumanoidRootPart
				end
			end
		end
		return nil
	end

	local function getPlayingAnimationIds()
		local ids = {}
		if PredictionAim.Humanoid then
			for _, track in ipairs(PredictionAim.Humanoid:GetPlayingAnimationTracks()) do
				if track.Animation and track.Animation.AnimationId then
					local id = track.Animation.AnimationId:match("%d+")
					if id then ids[id] = true end
				end
			end
		end
		return ids
	end

	local function setupCharacter(char)
		PredictionAim.Humanoid = char:WaitForChild("Humanoid")
		PredictionAim.HRP = char:WaitForChild("HumanoidRootPart")
	end

	local function OnRenderStep()
		if not PredictionAim.Enabled or not PredictionAim.Humanoid or not PredictionAim.HRP then return end
		local playing = getPlayingAnimationIds()
		local triggered = false
		for id in pairs(PredictionAim.TrackedAnimations) do
			if playing[id] then triggered = true; break end
		end

		if triggered then
			PredictionAim.LastTriggerTime = tick()
			PredictionAim.IsAiming = true
		end

		if PredictionAim.IsAiming and tick() - PredictionAim.LastTriggerTime <= PredictionAim.Duration then
			if not PredictionAim.OriginalState then
				PredictionAim.OriginalState = {
					WalkSpeed = PredictionAim.Humanoid.WalkSpeed,
					JumpPower = PredictionAim.Humanoid.JumpPower,
					AutoRotate = PredictionAim.Humanoid.AutoRotate
				}
				PredictionAim.Humanoid.AutoRotate = false
				PredictionAim.HRP.AssemblyAngularVelocity = Vector3.zero
			end
			local targetHRP = getValidTarget()
			if targetHRP then
				local predictedPos = targetHRP.Position + (targetHRP.CFrame.LookVector * PredictionAim.Prediction)
				local direction = (predictedPos - PredictionAim.HRP.Position).Unit
				local yRot = math.atan2(-direction.X, -direction.Z)
				PredictionAim.HRP.CFrame = CFrame.new(PredictionAim.HRP.Position) * CFrame.Angles(0, yRot, 0)
			end
		elseif PredictionAim.IsAiming then
			PredictionAim.IsAiming = false
			if PredictionAim.OriginalState then
				PredictionAim.Humanoid.WalkSpeed = PredictionAim.OriginalState.WalkSpeed
				PredictionAim.Humanoid.JumpPower = PredictionAim.OriginalState.JumpPower
				PredictionAim.Humanoid.AutoRotate = PredictionAim.OriginalState.AutoRotate
				PredictionAim.OriginalState = nil
			end
		end
	end

	local function OnRemoteEvent(eventName, eventArg)
		if not PredictionAim.Enabled then return end
		if eventName == "UseActorAbility" and type(eventArg) == "table" and eventArg[1] and tostring(eventArg[1]) == buffer.fromstring("\"Shoot\"") then
			PredictionAim.LastTriggerTime = tick()
			PredictionAim.IsAiming = true
		end
	end

	if LocalPlayer.Character then setupCharacter(LocalPlayer.Character) end
	LocalPlayer.CharacterAdded:Connect(setupCharacter)
	CreateUI()
	RunService.RenderStepped:Connect(OnRenderStep)
	game:GetService("ReplicatedStorage").Modules.Network.RemoteEvent.OnClientEvent:Connect(OnRemoteEvent)
end

local Size = 5
local speed = 1
local player = game:GetService("Players").LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local rootPart = char:WaitForChild("HumanoidRootPart")
local humanoid = char:WaitForChild("Humanoid")


local twoTimeMaxDistance = 50
local shedletskyMaxDistance = 50
local johnMaxDistance = 50

-- 创建UI
local SB = Tabs.Aimbot:AddLeftGroupbox('幸存者自瞄[平滑]')



-- 两次自瞄距离滑块
SB:AddSlider('TwoTimeDistance', {
    Text = '两次自瞄距离',
    Default = 50,
    Min = 10,
    Max = 150,
    Rounding = 1,
    Compact = false,
    Callback = function(value)
        twoTimeMaxDistance = value
    end
})

-- 谢德利茨基自瞄距离滑块
SB:AddSlider('ShedletskyDistance', {
    Text = '谢德自瞄距离',
    Default = 50,
    Min = 10,
    Max = 150,
    Rounding = 1,
    Compact = false,
    Callback = function(value)
        shedletskyMaxDistance = value
    end
})


local function TWO(state)
    local TWOsounds = {
        "rbxassetid://86710781315432",
        "rbxassetid://99820161736138"
    }
    
    TWOTIME = state

    if game:GetService("Players").LocalPlayer.Character.Name ~= "TwoTime" and state then
        Library:Notify("Your role is not Two Time，invalid", nil, 4590657391)
        return 
    end

    if state then
        TWOloop = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.ChildAdded:Connect(function(child)
            if not TWOTIME then return end
            for _, v in pairs(TWOsounds) do
                if child.Name == v then
                    local survivors = {}
                    for _, player in pairs(game:GetService("Players"):GetPlayers()) do
                        if player ~= game:GetService("Players").LocalPlayer then
                            local character = player.Character
                            if character and character:FindFirstChild("HumanoidRootPart") then
                                table.insert(survivors, character)
                            end
                        end
                    end

                    local nearestSurvivor = nil
                    local shortestDistance = math.huge  
                    
                    for _, survivor in pairs(survivors) do
                        local survivorHRP = survivor.HumanoidRootPart
                        local playerHRP = game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                        
                        if playerHRP then
                            local distance = (survivorHRP.Position - playerHRP.Position).Magnitude
                            if distance < shortestDistance and distance <= twoTimeMaxDistance then
                                shortestDistance = distance
                                nearestSurvivor = survivor
                            end
                        end
                    end
                    
                    if nearestSurvivor then
                        local nearestHRP = nearestSurvivor.HumanoidRootPart
                        local playerHRP = game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                        
                        if playerHRP then
                            local direction = (nearestHRP.Position - playerHRP.Position).Unit
                            local num = 1
                            local maxIterations = 100 
                            
                            if child.Name == "rbxassetid://79782181585087" then
                                maxIterations = 220  
                            end

                            while num <= maxIterations do
                                task.wait(0.01)
                                num = num + 1
                                workspace.CurrentCamera.CFrame = CFrame.new(workspace.CurrentCamera.CFrame.Position, nearestHRP.Position)
                                playerHRP.CFrame = CFrame.lookAt(playerHRP.Position, Vector3.new(nearestHRP.Position.X, nearestHRP.Position.Y, nearestHRP.Position.Z))  
                            end
                        end
                    end
                end
            end
        end)
    else
        if TWOloop then
            TWOloop:Disconnect()
            TWOloop = nil
        end
    end
end

local function shedletskyAimbot(state)
    shedaim = state
    if state then
        if game:GetService("Players").LocalPlayer.Character.Name ~= "Shedletsky" then
            Library:Notify("I don't think the character you're playing is Shedlitsky.,invalid", nil, 4590657391)
            return
        end
        
        shedloop = game:GetService("Players").LocalPlayer.Character.Sword.ChildAdded:Connect(function(child)
            if not shedaim then return end
            if child:IsA("Sound") then 
                local FAN = child.Name
                if FAN == "rbxassetid://12222225" or FAN == "83851356262523" then 
                    local killersFolder = game.Workspace.Players:FindFirstChild("Killers")
                    if killersFolder then 
                        local killer = killersFolder:FindFirstChildOfClass("Model")
                        if killer and killer:FindFirstChild("HumanoidRootPart") then 
                            local killerHRP = killer.HumanoidRootPart
                            local playerHRP = game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                            if playerHRP then 
                                local distance = (killerHRP.Position - playerHRP.Position).Magnitude
                                if distance <= shedletskyMaxDistance then
                                    local num = 1
                                    local maxIterations = 100
                                    while num <= maxIterations do
                                        task.wait(0.01)
                                        num = num + 1
                                        workspace.CurrentCamera.CFrame = CFrame.new(workspace.CurrentCamera.CFrame.Position, killerHRP.Position)
                                        playerHRP.CFrame = CFrame.lookAt(playerHRP.Position, killerHRP.Position)
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end)
    else
        if shedloop then 
            shedloop:Disconnect()
            shedloop = nil
        end
    end
end



SB:AddToggle('MyToggle', {
    Text = '两次自瞄',
    Default = false,
    Tooltip = 'Aim',
    Callback = TWO
})

SB:AddToggle('MyToggle', {
    Text = '谢德自瞄',
    Default = false,
    Tooltip = 'Aim',
    Callback = shedletskyAimbot
})



local LeftGroupBox = Tabs.Aimbot:AddRightGroupbox('1x4远程预判')

local RunService = game:GetService("RunService")
local LocalPlayer = game:GetService("Players").LocalPlayer
	local PredictionAim = {
		Enabled = false,
		Prediction = 4,
		Duration = 1.7,
		Targets = { "Guest1337", "007n7", "Builderman", "Chance", "Dusekkar", "Elliot", "Noob", "Shedletsky", "Taph", "TwoTime" },
		TrackedAnimations = {
	["131430497821198"] = true,
    ["119181003138006"] = true,
    ["70447634862911"] = true,
    ["93491748129367"] = true
		},
		Humanoid = nil,
		HRP = nil,
		LastTriggerTime = 1,
		IsAiming = false,
		OriginalState = nil
	}

	local function CreateUI()
		LeftGroupBox:AddToggle("AimToggle", {
			Text = "预判瞄准",
			Default = false,
			Callback = function(Value)
				PredictionAim.Enabled = Value
			end,
		})
		LeftGroupBox:AddSlider("PredictionSlider", {
			Text = "预判强度",
			Default = 4,
			Min = 0,
			Max = 15,
			Rounding = 1,
			Callback = function(Value)
				PredictionAim.Prediction = Value
			end,
		})
	end

	local function getValidTarget()
		local killersFolder = workspace:FindFirstChild("Players") and workspace.Players:FindFirstChild("Survivors")
		if killersFolder then
			for _, name in ipairs(PredictionAim.Targets) do
				local target = killersFolder:FindFirstChild(name)
				if target and target:FindFirstChild("HumanoidRootPart") then
					return target.HumanoidRootPart
				end
			end
		end
		return nil
	end

	local function getPlayingAnimationIds()
		local ids = {}
		if PredictionAim.Humanoid then
			for _, track in ipairs(PredictionAim.Humanoid:GetPlayingAnimationTracks()) do
				if track.Animation and track.Animation.AnimationId then
					local id = track.Animation.AnimationId:match("%d+")
					if id then ids[id] = true end
				end
			end
		end
		return ids
	end

	local function setupCharacter(char)
		PredictionAim.Humanoid = char:WaitForChild("Humanoid")
		PredictionAim.HRP = char:WaitForChild("HumanoidRootPart")
	end

	local function OnRenderStep()
		if not PredictionAim.Enabled or not PredictionAim.Humanoid or not PredictionAim.HRP then return end
		local playing = getPlayingAnimationIds()
		local triggered = false
		for id in pairs(PredictionAim.TrackedAnimations) do
			if playing[id] then triggered = true; break end
		end

		if triggered then
			PredictionAim.LastTriggerTime = tick()
			PredictionAim.IsAiming = true
		end

		if PredictionAim.IsAiming and tick() - PredictionAim.LastTriggerTime <= PredictionAim.Duration then
			if not PredictionAim.OriginalState then
				PredictionAim.OriginalState = {
					WalkSpeed = PredictionAim.Humanoid.WalkSpeed,
					JumpPower = PredictionAim.Humanoid.JumpPower,
					AutoRotate = PredictionAim.Humanoid.AutoRotate
				}
				PredictionAim.Humanoid.AutoRotate = false
				PredictionAim.HRP.AssemblyAngularVelocity = Vector3.zero
			end
			local targetHRP = getValidTarget()
			if targetHRP then
				local predictedPos = targetHRP.Position + (targetHRP.CFrame.LookVector * PredictionAim.Prediction)
				local direction = (predictedPos - PredictionAim.HRP.Position).Unit
				local yRot = math.atan2(-direction.X, -direction.Z)
				PredictionAim.HRP.CFrame = CFrame.new(PredictionAim.HRP.Position) * CFrame.Angles(0, yRot, 0)
			end
		elseif PredictionAim.IsAiming then
			PredictionAim.IsAiming = false
			if PredictionAim.OriginalState then
				PredictionAim.Humanoid.WalkSpeed = PredictionAim.OriginalState.WalkSpeed
				PredictionAim.Humanoid.JumpPower = PredictionAim.OriginalState.JumpPower
				PredictionAim.Humanoid.AutoRotate = PredictionAim.OriginalState.AutoRotate
				PredictionAim.OriginalState = nil
			end
		end
	end

	if LocalPlayer.Character then setupCharacter(LocalPlayer.Character) end
	LocalPlayer.CharacterAdded:Connect(setupCharacter)
	CreateUI()
	RunService.RenderStepped:Connect(OnRenderStep)





local SpecialAimbot = Tabs.Aimbot:AddLeftGroupbox("幸存者自瞄(无声静默)")

-- 默认距离设置
local defaultAimDistance = 100
local aimDistanceSettings = {
    SSA = defaultAimDistance,
    GAA = defaultAimDistance
}

-- 平滑度和锁定时间设置
local aimSmoothnessSettings = {
    SSA = 50,
    GAA = 50
}

local aimDurationSettings = {
    SSA = 100,
    GAA = 100
}



SpecialAimbot:AddSlider("SSA_Distance", {
    Text = "谢德自瞄距离",
    Default = defaultAimDistance,
    Min = 10,
    Max = 500,
    Rounding = 1,
    Callback = function(value)
        aimDistanceSettings.SSA = value
    end
})

SpecialAimbot:AddSlider("GAA_Distance", {
    Text = "访客自瞄距离",
    Default = defaultAimDistance,
    Min = 10,
    Max = 500,
    Rounding = 1,
    Callback = function(value)
        aimDistanceSettings.GAA = value
    end
})




local function SmoothLookAt(currentCF, targetPos, smoothness)
    local currentLook = currentCF.LookVector
    local targetLook = (targetPos - currentCF.Position).Unit
    local newLook = currentLook:Lerp(targetLook, 1/smoothness)
    return CFrame.lookAt(currentCF.Position, currentCF.Position + newLook)
end



function AimSlashShedletsky(value)
    local aimslashsword = value
    if value then
        local shedaimbotsounds = {
            "rbxassetid://106397684977541",
            "rbxassetid://106397684977541"
        }
        aimslash = game.Players.LocalPlayer.Character.Sword.ChildAdded:Connect(function(child)
            if not aimslashsword then return end
            for _, v in ipairs(shedaimbotsounds) do
                if child.Name == v then
                    local targetkiller = game.Workspace.Players:FindFirstChild("Killers"):FindFirstChildOfClass("Model")
                    if targetkiller and targetkiller:FindFirstChild("HumanoidRootPart") then
                        if game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                            local distance = (targetkiller.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
                            if distance <= aimDistanceSettings.SSA then
                                local number = 1
                                local smoothness = aimSmoothnessSettings.SSA
                                local duration = aimDurationSettings.SSA
                                local connection
                                connection = game:GetService("RunService").RenderStepped:Connect(function()
                                    if number <= duration then
                                        task.wait(0.01)
                                        number = number + 1
                                        local currentCF = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
                                        local targetPos = targetkiller.HumanoidRootPart.Position
                                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = SmoothLookAt(currentCF, targetPos, smoothness)
                                    else
                                        connection:Disconnect()
                                    end
                                end)
                            end
                        end
                    end
                end
            end
        end)
    else
        if aimslash then
            aimslash:Disconnect()
        end
    end
end

function AimAttackGuest(value)
    local aimattackguest = value
    if value then
        aimguest = game:GetService("ReplicatedStorage").Modules.Network.RemoteEvent.OnClientEvent:Connect(function(eventName, eventArg)
            if not aimattackguest then return end
            if eventName == "UseActorAbility" and type(eventArg) == "table" and eventArg[1] and tostring(eventArg[1]) == buffer.fromstring("\"Punch\"") then
                local targetkiller = game.Workspace.Players:FindFirstChild("Killers"):FindFirstChildOfClass("Model")
                if targetkiller and targetkiller:FindFirstChild("HumanoidRootPart") then
                    if game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                        local distance = (targetkiller.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
                        if distance <= aimDistanceSettings.GAA then
                            local number = 1
                            local smoothness = aimSmoothnessSettings.GAA
                            local duration = aimDurationSettings.GAA
                            local connection
                            connection = game:GetService("RunService").RenderStepped:Connect(function()
                                if number <= duration then
                                    task.wait(0.01)
                                    number = number + 1
                                    local currentCF = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
                                    local targetPos = targetkiller.HumanoidRootPart.Position
                                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = SmoothLookAt(currentCF, targetPos, smoothness)
                                else
                                    connection:Disconnect()
                                end
                            end)
                        end
                    end
                end
            end
        end)
    else
        if aimguest then
            aimguest:Disconnect()
        end
    end
end

SpecialAimbot:AddToggle("SSA",{
    Text = "谢德自瞄",
    Callback = function(v)
        AimSlashShedletsky(v)
    end
})

SpecialAimbot:AddToggle("GAA",{
    Text = "访客自瞄",
    Callback = function(v)
        AimAttackGuest(v)
    end
})


local aimbotNoilsounds = {
    "rbxassetid://90768093259753"
}
local aimbotNoilsounds2 = {
    "rbxassetid://126318185932771"
}
local Noloop
local No2loop

-- Default settings
local aimSettings = {
    maxDistance = 50,  -- Default max aim distance
    lockTime = 3.3     -- Default lock time in seconds (330 iterations * 0.01)
}

-- Create Noli Aimbot groupbox
local g = Tabs.Aimbot:AddRightGroupbox('Noli自瞄')

-- Add sliders to the groupbox
g:AddSlider('AimDistance', {
    Text = '自瞄距离',
    Default = aimSettings.maxDistance,
    Min = 10,
    Max = 100,
    Rounding = 0,
    Compact = false,
    Callback = function(value)
        aimSettings.maxDistance = value
    end
})

g:AddSlider('LockTime', {
    Text = '自瞄锁定时长 (秒)',
    Default = aimSettings.lockTime,
    Min = 0.5,
    Max = 5,
    Rounding = 1,
    Compact = false,
    Callback = function(value)
        aimSettings.lockTime = value
    end
})

local function Noaimbot(state)
    johnaim = state
    if game:GetService("Players").LocalPlayer.Character.Name ~= "Noli" and state then
        Library:Notify("角色不对，可能出现错误", nil, 4590657391)
        return 
    end
    if state then
        Noloop = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.ChildAdded:Connect(function(child)
            if not johnaim then return end
            for _, v in pairs(aimbotNoilsounds) do
                if child.Name == v then
                   
                    local survivors = {}
                    for _, player in pairs(game:GetService("Players"):GetPlayers()) do
                        if player ~= game:GetService("Players").LocalPlayer then
                            local character = player.Character
                            if character and character:FindFirstChild("HumanoidRootPart") then
                                table.insert(survivors, character)
                            end
                        end
                    end
    
                   
                    local nearestSurvivor = nil
                    local shortestDistance = math.huge  
                    
                    for _, survivor in pairs(survivors) do
                        local survivorHRP = survivor.HumanoidRootPart
                        local playerHRP = game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                        
                        if playerHRP then
                            local distance = (survivorHRP.Position - playerHRP.Position).Magnitude
                            if distance < shortestDistance and distance <= aimSettings.maxDistance then
                                shortestDistance = distance
                                nearestSurvivor = survivor
                            end
                        end
                    end
                    
                  
                    if nearestSurvivor then
                        local nearestHRP = nearestSurvivor.HumanoidRootPart
                        local playerHRP = game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                        local maxIterations = math.floor(aimSettings.lockTime / 0.01)  -- Convert seconds to iterations
                        if playerHRP then
                            local direction = (nearestHRP.Position - playerHRP.Position).Unit
                            local num = 1
                           
                            while num <= maxIterations do
                                task.wait(0.01)
                                num = num + 1
                                workspace.CurrentCamera.CFrame = CFrame.new(workspace.CurrentCamera.CFrame.Position, nearestHRP.Position)
                                playerHRP.CFrame = CFrame.lookAt(playerHRP.Position, Vector3.new(nearestHRP.Position.X, nearestHRP.Position.Y, nearestHRP.Position.Z))
                            end
                        end
                    end
                end
            end
        end)
    else
        if Noloop then
            Noloop:Disconnect()
            Noloop = nil
        end
    end
end

local function No2aimbot(state)
    johnaim = state
    if game:GetService("Players").LocalPlayer.Character.Name ~= "Noli" and state then
        Library:Notify("角色不对，可能出现错误", nil, 4590657391)
        return 
    end
    if state then
        No2loop = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.ChildAdded:Connect(function(child)
            if not johnaim then return end
            for _, v in pairs(aimbotNoilsounds2) do
                if child.Name == v then
                   
                    local survivors = {}
                    for _, player in pairs(game:GetService("Players"):GetPlayers()) do
                        if player ~= game:GetService("Players").LocalPlayer then
                            local character = player.Character
                            if character and character:FindFirstChild("HumanoidRootPart") then
                                table.insert(survivors, character)
                            end
                        end
                    end
    
                   
                    local nearestSurvivor = nil
                    local shortestDistance = math.huge  
                    
                    for _, survivor in pairs(survivors) do
                        local survivorHRP = survivor.HumanoidRootPart
                        local playerHRP = game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                        
                        if playerHRP then
                            local distance = (survivorHRP.Position - playerHRP.Position).Magnitude
                            if distance < shortestDistance and distance <= aimSettings.maxDistance then
                                shortestDistance = distance
                                nearestSurvivor = survivor
                            end
                        end
                    end
                    
                  
                    if nearestSurvivor then
                        local nearestHRP = nearestSurvivor.HumanoidRootPart
                        local playerHRP = game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                        local maxIterations = math.floor(aimSettings.lockTime / 0.01)  -- Convert seconds to iterations
                        if playerHRP then
                            local direction = (nearestHRP.Position - playerHRP.Position).Unit
                            local num = 1
                           
                            while num <= maxIterations do
                                task.wait(0.01)
                                num = num + 1
                                workspace.CurrentCamera.CFrame = CFrame.new(workspace.CurrentCamera.CFrame.Position, nearestHRP.Position)
                                playerHRP.CFrame = CFrame.lookAt(playerHRP.Position, Vector3.new(nearestHRP.Position.X, nearestHRP.Position.Y, nearestHRP.Position.Z))
                            end
                        end
                    end
                end
            end
        end)
    else
        if No2loop then
            No2loop:Disconnect()
            No2loop = nil
        end
    end
end

-- Add toggles to the groupbox
g:AddToggle('NoilStarBomb', {
    Text = 'Noil星炸弹自瞄',
    Default = false,
    Callback = function(state)
        Noaimbot(state)
    end
})

g:AddToggle('NoilVoidRush', {
    Text = 'Noil冲刺自瞄',
    Default = false,
    Callback = function(state)
        No2aimbot(state)
    end
})






local Warning = Tabs.tzq:AddLeftGroupbox("杀手靠近警告")

-- 杀手靠近提示设置
local KillerWarningSettings = {
    Enabled = false,
    WarningDistance = 100, -- 警告距离(米)
    WarningColor = Color3.fromRGB(255, 0, 0), -- 警告颜色(红色)
    TextSize = 20, -- 文字大小
    BlinkInterval = 0.5, -- 闪烁间隔(秒)
    LastWarningTime = 0, -- 上次警告时间
    WarningCooldown = 5, -- 警告冷却时间(秒)
    WarningSoundId = "rbxassetid://6545327576", -- 警告音效ID
    SoundVolume = 0.5 -- 音效音量
}

-- 存储绘制对象
local warningLabel = Drawing.new("Text")
warningLabel.Visible = false
warningLabel.Center = true
warningLabel.Outline = true
warningLabel.Font = 2 -- 粗体字体
warningLabel.Color = KillerWarningSettings.WarningColor
warningLabel.Size = KillerWarningSettings.TextSize

-- 存储音效对象
local warningSound = Instance.new("Sound")
warningSound.SoundId = KillerWarningSettings.WarningSoundId
warningSound.Volume = KillerWarningSettings.SoundVolume
warningSound.Parent = game:GetService("SoundService")

-- 更新警告显示
local function updateKillerWarning()
    local player = game.Players.LocalPlayer
    local character = player.Character
    if not character or not character:FindFirstChild("HumanoidRootPart") then return end
    
    local killersFolder = workspace.Players:FindFirstChild("Killers")
    if not killersFolder then return end
    
    local closestDistance = math.huge
    local closestKiller = nil
    
    -- 寻找最近的杀手
    for _, killer in ipairs(killersFolder:GetChildren()) do
        if killer:IsA("Model") and killer:FindFirstChild("HumanoidRootPart") then
            local distance = (character.HumanoidRootPart.Position - killer.HumanoidRootPart.Position).Magnitude
            if distance < closestDistance then
                closestDistance = distance
                closestKiller = killer
            end
        end
    end
    
    -- 检查距离并显示警告
    if closestKiller and closestDistance <= KillerWarningSettings.WarningDistance then
        local currentTime = tick()
        
        -- 闪烁效果
        if currentTime - KillerWarningSettings.LastWarningTime >= KillerWarningSettings.BlinkInterval then
            warningLabel.Visible = not warningLabel.Visible
            KillerWarningSettings.LastWarningTime = currentTime
        end
        
        -- 设置警告文本
        warningLabel.Text = string.format("⚠️Warning! 杀手 %s 在 %d 米内!", closestKiller.Name, math.floor(closestDistance))
        warningLabel.Position = Vector2.new(
            workspace.CurrentCamera.ViewportSize.X / 2,
            workspace.CurrentCamera.ViewportSize.Y * 0.2
        )
        
        -- 播放警告音效(冷却时间内只播放一次)
        if currentTime - KillerWarningSettings.LastWarningTime >= KillerWarningSettings.WarningCooldown then
            warningSound:Play()
            KillerWarningSettings.LastWarningTime = currentTime
        end
    else
        warningLabel.Visible = false
    end
end

-- 主开关
Warning:AddToggle("KillerWarningToggle", {
    Text = "启用",
    Default = false,
    Callback = function(enabled)
        KillerWarningSettings.Enabled = enabled
        if enabled then
            -- 初始化连接
            if not KillerWarningSettings.connection then
                KillerWarningSettings.connection = game:GetService("RunService").RenderStepped:Connect(updateKillerWarning)
            end
        else
            -- 关闭连接
            if KillerWarningSettings.connection then
                KillerWarningSettings.connection:Disconnect()
                KillerWarningSettings.connection = nil
            end
            warningLabel.Visible = false
            warningSound:Stop()
        end
    end
})

-- 距离设置
Warning:AddSlider("WarningDistance", {
    Text = "警告距离(米)",
    Min = 10,
    Max = 200,
    Default = 100,
    Rounding = 0,
    Callback = function(value)
        KillerWarningSettings.WarningDistance = value
    end
})

-- 文字大小设置
Warning:AddSlider("WarningTextSize", {
    Text = "文字大小",
    Min = 10,
    Max = 30,
    Default = 20,
    Rounding = 0,
    Callback = function(value)
        KillerWarningSettings.TextSize = value
        warningLabel.Size = value
    end
})



-- 警告颜色选择
Warning:AddDropdown("WarningColor", {
    Values = {"red", "orange", "yellow", "pink", "purple"},
    Default = "red",
    Text = "文字颜色",
    Callback = function(value)
        local colorMap = {
            ["red"] = Color3.fromRGB(255, 0, 0),
            ["orange"] = Color3.fromRGB(255, 165, 0),
            ["yellow"] = Color3.fromRGB(255, 255, 0),
            ["pink"] = Color3.fromRGB(255, 192, 203),
            ["purple"] = Color3.fromRGB(128, 0, 128)
        }
        KillerWarningSettings.WarningColor = colorMap[value] or Color3.fromRGB(255, 0, 0)
        warningLabel.Color = KillerWarningSettings.WarningColor
    end
})


local Visual = Tabs.tzq:AddRightGroupbox("Noli能力监听")



Visual:AddToggle("NoliTeleportAlert", {
    Text = "Noli选择电机提示",
    Default = false,
    Callback = function(v)
        if v then
            local activeConnections = {}
            local lastNotifyTime = 0
            local COOLDOWN = 2
            local TARGET_SOUND_ID = "rbxassetid://125253972523701"

            local function safeNotify()
                local currentTime = tick()
                if currentTime - lastNotifyTime > COOLDOWN then
                    Library:Notify("warning\nNoli is transmitting")
                    lastNotifyTime = currentTime
                end
            end

            local function checkSoundPlaying(sound)
                return sound and sound.IsPlaying or false
            end

            local function monitorSound(sound)
                task.spawn(function()
                    while sound.Parent and checkSoundPlaying(sound) do
                        safeNotify()
                        task.wait(COOLDOWN)
                    end
                end)
            end

            local function setupKiller(killer)
                local humanoidRootPart = killer:WaitForChild("HumanoidRootPart", 5)
                if humanoidRootPart then
                   
                    for _, child in ipairs(humanoidRootPart:GetChildren()) do
                        if child:IsA("Sound") and child.SoundId == TARGET_SOUND_ID then
                            monitorSound(child)
                        end
                    end

                
                    local connection = humanoidRootPart.ChildAdded:Connect(function(child)
                        if child:IsA("Sound") and child.SoundId == TARGET_SOUND_ID then
                            monitorSound(child)
                        end
                    end)
                    
                    table.insert(activeConnections, connection)
                end
            end

        
            table.insert(activeConnections, workspace.Players.Killers.ChildAdded:Connect(setupKiller))

          
            for _, killer in ipairs(workspace.Players.Killers:GetChildren()) do
                task.spawn(setupKiller, killer)
            end
        else
           
            for _, conn in ipairs(activeConnections) do
                conn:Disconnect()
            end
            activeConnections = {}
        end
    end
})



Visual:AddToggle("NoliMotorSelect", {
    Text = "Noli传送电机提示",
    Default = false,
    Callback = function(v)
        local soundId = "rbxassetid://124468317999247"
        local notificationMessage = "⚠️Warning\nNoli Selecting Generator"
        local connections = {}
        local cooldown = 2 -- 通知冷却时间(秒)
        local lastNotifyTime = 0

        local function disconnectAll()
            for _, conn in pairs(connections) do
                conn:Disconnect()
            end
            connections = {}
        end

        local function safeNotify()
            local now = os.time()
            if now - lastNotifyTime >= cooldown then
                Library:Notify(notificationMessage)
                lastNotifyTime = now
            end
        end

        local function setupSoundListener(humanoidRootPart)
            local function onChildAdded(child)
                if child:IsA("Sound") and child.SoundId == soundId then
                    safeNotify()
                end
            end

            local conn = humanoidRootPart.ChildAdded:Connect(onChildAdded)
            table.insert(connections, conn)

            -- 检查已存在的音频
            for _, child in ipairs(humanoidRootPart:GetChildren()) do
                if child:IsA("Sound") and child.SoundId == soundId then
                    safeNotify()
                    break
                end
            end
        end

        local function onKillerAdded(killer)
            local humanoidRootPart = killer:FindFirstChild("HumanoidRootPart") or killer:WaitForChild("HumanoidRootPart", 3)
            if humanoidRootPart then
                setupSoundListener(humanoidRootPart)
            end
        end

        if v then
            -- 监听新杀手
            local mainConn = workspace.Players.Killers.ChildAdded:Connect(onKillerAdded)
            table.insert(connections, mainConn)

            -- 初始化现有杀手
            for _, killer in ipairs(workspace.Players.Killers:GetChildren()) do
                task.spawn(onKillerAdded, killer)
            end
        else
            disconnectAll()
        end
    end
})





Visual:AddToggle("NoliMotorSelect", {
    Text = "Noli冲刺提示",
    Default = false,
    Callback = function(v)
        local soundId = "rbxassetid://126318185932771"
        local notificationMessage = "Noli is sprinting"
        local endNotificationMessage = "Noli冲刺结束"
        local connections = {}
        local cooldown = 2
        local lastNotifyTime = 0

        local function disconnectAll()
            for _, conn in pairs(connections) do
                conn:Disconnect()
            end
            connections = {}
        end

        local function safeNotify(message)
            local now = os.time()
            if now - lastNotifyTime >= cooldown then
                Library:Notify(message)
                lastNotifyTime = now
            end
        end

        local function setupSoundListener(humanoidRootPart)
            local function onChildAdded(child)
                if child:IsA("Sound") and child.SoundId == soundId then
                    safeNotify(notificationMessage)
                    local endedConn = child.Ended:Connect(function()
                        safeNotify(endNotificationMessage)
                        endedConn:Disconnect()
                    end)
                    table.insert(connections, endedConn)
                end
            end

            local conn = humanoidRootPart.ChildAdded:Connect(onChildAdded)
            table.insert(connections, conn)

            for _, child in ipairs(humanoidRootPart:GetChildren()) do
                if child:IsA("Sound") and child.SoundId == soundId then
                    safeNotify(notificationMessage)
                    if child.IsPlaying then
                        local endedConn = child.Ended:Connect(function()
                            safeNotify(endNotificationMessage)
                            endedConn:Disconnect()
                        end)
                        table.insert(connections, endedConn)
                    end
                    break
                end
            end
        end

        local function onKillerAdded(killer)
            local humanoidRootPart = killer:FindFirstChild("HumanoidRootPart") or killer:WaitForChild("HumanoidRootPart", 3)
            if humanoidRootPart then
                setupSoundListener(humanoidRootPart)
            end
        end

        if v then
            local mainConn = workspace.Players.Killers.ChildAdded:Connect(onKillerAdded)
            table.insert(connections, mainConn)
            for _, killer in ipairs(workspace.Players.Killers:GetChildren()) do
                task.spawn(onKillerAdded, killer)
            end
        else
            disconnectAll()
        end
    end
})


















local Visual = Tabs.tzq:AddRightGroupbox('其他')



Visual:AddToggle("NST",{
Text = "地下空间炸弹生成提示",
Default = false,
Callback = function(v)
if v then
NotifySubspaceTripmine = workspace.Map.Ingame.DescendantAdded:Connect(function(v)
if v.Name == "SubspaceTripmine" then
Library:Notify("NOL | Warning\nBlock 'SubspaceTripmine generated！")
end
end)
else
NotifySubspaceTripmine:Disconnect()
end
end})
Visual:AddToggle("NEK",{
Text = "实体生成提示",
Default = false,
Callback = function(v)
if v then
NotifyEntityKillers = workspace.DescendantAdded:Connect(function(v)
if v:IsA("Model") and v.Name == "PizzaDeliveryRig" or v.Name == "Bunny" or v.Name == "Mafiaso1" or v.Name == "Mafiaso2" or v.Name == "Mafiaso3" then
Library:Notify("NOL | Warning\nEntity '" .. v.Name .. "' 生成了！")
elseif v:IsA("Model") and v.Name == "1x1x1x1Zombie" then
Library:Notify("NOL | Warning\nEntity '1x1x1x1 (zombies)' 生成了！")
end
end)
else
NotifyEntityKillers:Disconnect()
end
end})






local SM = Tabs.tfz:AddRightGroupbox('显示碰撞箱')




local Workspace = game:GetService("Workspace")

local player = Players.LocalPlayer
local playerName = player.Name
local hitbox = nil
local updateConnection = nil

local hitboxesFolder = Workspace:FindFirstChild("Hitboxes")
if not hitboxesFolder then
    hitboxesFolder = Instance.new("Folder")
    hitboxesFolder.Name = "Hitboxes"
    hitboxesFolder.Parent = Workspace
end

local function createHitbox()
    local part = Instance.new("Part")
    part.Name = playerName .. "_Hitbox"
    part.Size = Vector3.new(4, 7, 4)
    part.Anchored = true
    part.CanCollide = false
    part.Transparency = 0.5
    part.Material = Enum.Material.ForceField
    part.Color = Color3.fromRGB(255, 255, 200)
    part.Parent = hitboxesFolder
    return part
end

local function updateHitbox()
    local character = player.Character
    if character and character:FindFirstChild("HumanoidRootPart") and hitbox then
        local root = character.HumanoidRootPart
        local offset = root.CFrame.LookVector * 4
        hitbox.CFrame = CFrame.new(root.Position + offset, root.Position + root.CFrame.LookVector)
    end
end

SM:AddToggle("打人", {
    Text = "Show HitBox",
    Default = false,
    Callback = function(state)
        if state then
       
            hitbox = createHitbox()
            updateConnection = RunService.RenderStepped:Connect(updateHitbox)
         
            player.CharacterAdded:Connect(function(char)
                task.wait(1)
                if hitbox then
                    hitbox:Destroy()
                end
                hitbox = createHitbox()
            end)
        else
            
            if updateConnection then
                updateConnection:Disconnect()
                updateConnection = nil
            end
            if hitbox then
                hitbox:Destroy()
                hitbox = nil
            end
        end
    end
})







local MS = Tabs.tfz:AddRightGroupbox("静默碰撞箱调节")
local MovementEnabled = false
local ForwardSpeed = 0
local ForwardMultiplier = 10
local SideMultiplier = 12

local a = function(...)
    local g = buffer.fromstring(game:GetService("HttpService"):JSONEncode(table.pack(...)[1]))
    return {g}
end

local b = function(cf, v)
    local bd = buffer.create(30)
    local pos = cf.Position
    local view = cf.LookVector
    local of = 0
    for i, v in pairs(
        {
            pos.X,
            pos.Y,
            pos.Z,
            view.X,
            view.Y,
            view.Z,
            v.X,
            v.Y,
            v.Z
        }
    ) do
        if (i >= 4 and i <= 6) then
            buffer.writei16(bd, of, math.floor(v * 10000))
            of = of + 2
        else
            buffer.writef32(bd, of, tonumber(string.format("%.2f", v)))
            of = of + 4
        end
    end
    return bd
end

local c
for i,v in pairs(getgc(true)) do
 if type(v)=="table" then
  if rawget(v,"FireServerConnection") then
   c = hookfunction(rawget(v,"FireServerConnection"),function(_,code,name,...)
   if code == "UpdCF" and name=="UREMOTE_EVENT" then
     return
    end
    return c(_,code,name,...)
   end)
  end
 end
end

local d = require(game.ReplicatedStorage.Modules.Util)
local e = function()
    if not MovementEnabled then return end
    
    local lp = game.Players.LocalPlayer
    if not (lp and lp.Character and lp.Character.PrimaryPart) then return end
    if not d:IsAlive(lp.Character) then return end
    
    local n = lp.Character.PrimaryPart.CFrame
    local k = lp.Character.PrimaryPart.AssemblyLinearVelocity.Y
    
    local baseForward = n.LookVector.X * ForwardMultiplier
    local modifiedForward = baseForward + ForwardSpeed
    
    local m = Vector3.new(
        modifiedForward,
        k,
        n.LookVector.Z * SideMultiplier
    )
    
    local args = {
        "UpdCF",
        a(
            b(
                n,
                m
            )
        )
    }
    game:GetService("ReplicatedStorage")
        :WaitForChild("Modules")
        :WaitForChild("Network")
        :WaitForChild("UnreliableRemoteEvent")
        :FireServer(unpack(args))
end

local heartbeatConnection
local function startMovement()
    if heartbeatConnection then
        heartbeatConnection:Disconnect()
    end
    heartbeatConnection = game:GetService("RunService").Heartbeat:Connect(function()
        task.spawn(function()
            e()
        end)
    end)
end

local function stopMovement()
    if heartbeatConnection then
        heartbeatConnection:Disconnect()
        heartbeatConnection = nil
    end
end

MS:AddToggle("MovementToggle", {
    Text = "向前移动修改",
    Default = false,
    Callback = function(state)
        MovementEnabled = state
        if state then
            startMovement()
        else
            stopMovement()
        end
    end
})

MS:AddSlider("ForwardSpeed", {
    Text = "向前速度",
    Default = 0,
    Min = 0,
    Max = 90,
    Rounding = 0,
    Callback = function(value)
        if not MovementEnabled then return end
        ForwardSpeed = value
    end
})

MS:AddSlider("ForwardMultiplier", {
    Text = "前向乘数",
    Default = 40,
    Min = 0,
    Max = 90,
    Rounding = 0,
    Callback = function(value)
        if not MovementEnabled then return end
        ForwardMultiplier = value
    end
})

MS:AddSlider("SideMultiplier", {
    Text = "侧向乘数",
    Default = 50,
    Min = 0,
    Max = 90,
    Rounding = 0,
    Callback = function(value)
        if not MovementEnabled then return end
        SideMultiplier = value
    end
})

MS:AddLabel("想要使用隐身灵魂出窍请看说明")

MS:AddLabel("隐身灵魂出窍使用说明：\n\n想要使用先开启一下然后再关闭，进入局内后如果你是关闭状态就会出窍，重新开启即可恢复让实体回到玩家", true)

local ZZ = Tabs.ani:AddLeftGroupbox('Noli反效果')

local noliDeleterActive = false
local deletionConnection = nil
local allowedNoli = nil
local isVoidRushCrashed = false
local characterCheckLoop = nil
local voidRushOverrideActive = false
local voidRushState = {}
local RunService = game:GetService("RunService")

local function deleteNewNoli()
    local killersFolder = workspace:WaitForChild("Players")
    local killers = killersFolder:WaitForChild("Killers")
    
    allowedNoli = killers:FindFirstChild("Noli")
    if not allowedNoli then
        return
    end
    
    if deletionConnection then
        deletionConnection:Disconnect()
        deletionConnection = nil
    end
    
    deletionConnection = RunService.Heartbeat:Connect(function()
        allowedNoli = killers:FindFirstChild("Noli")
        
        if not allowedNoli then
            if deletionConnection then
                deletionConnection:Disconnect()
                deletionConnection = nil
            end
            return
        end
        
        for _, child in killers:GetChildren() do
            if child.Name == "Noli" and child ~= allowedNoli then
                child:Destroy()
            end
        end
    end)
end

ZZ:AddToggle("NoliDeleter", {
    Text = "反假Noli",
    Default = false,
    Callback = function(enabled)
        noliDeleterActive = enabled
        
        if enabled then
            if deletionConnection then
                deletionConnection:Disconnect()
                deletionConnection = nil
            end
            
            local success, err = pcall(function()
                deleteNewNoli()
            end)
            
            if not success then
                noliDeleterActive = false
            end
        else
            if deletionConnection then
                deletionConnection:Disconnect()
                deletionConnection = nil
            end
            allowedNoli = nil
        end
    end
})


ZZ:AddToggle("VoidRushOverride", {
    Text = "Noli自由冲刺[需要锁定视角]",
    Default = false,
    Callback = function(enabled)
        voidRushOverrideActive = enabled
        
        if voidRushState.monitorTask then
            task.cancel(voidRushState.monitorTask)
            voidRushState.monitorTask = nil
        end
        
        if voidRushState.overrideConnection then
            voidRushState.overrideConnection:Disconnect()
            voidRushState.overrideConnection = nil
        end
        
        if voidRushState.characterAddedConnection then
            voidRushState.characterAddedConnection:Disconnect()
            voidRushState.characterAddedConnection = nil
        end
        
        if enabled then
            local LocalPlayer = game:GetService("Players").LocalPlayer
            local ORIGINAL_DASH_SPEED = 60
            local DEFAULT_WALK_SPEED = 16
            
            local function setupCharacter()
                if LocalPlayer.Character then
                    local Character = LocalPlayer.Character
                    local Humanoid = Character:FindFirstChildOfClass("Humanoid")
                    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")
                    
                    if Humanoid then
                        Humanoid.WalkSpeed = DEFAULT_WALK_SPEED
                        Humanoid.AutoRotate = true
                    end
                    
                    return Character, Humanoid, HumanoidRootPart
                end
                return nil, nil, nil
            end
            
            local function startOverride(Humanoid, HumanoidRootPart)
                if voidRushState.overrideConnection then return end
                
                voidRushState.overrideConnection = RunService.RenderStepped:Connect(function()
                    if not Humanoid or not HumanoidRootPart or not voidRushOverrideActive then
                        return
                    end
                    
                    Humanoid.WalkSpeed = ORIGINAL_DASH_SPEED
                    Humanoid.AutoRotate = false
                    
                    local direction = HumanoidRootPart.CFrame.LookVector
                    local horizontalDirection = Vector3.new(direction.X, 0, direction.Z).Unit
                    Humanoid:Move(horizontalDirection)
                end)
            end
            
            local function stopOverride()
                if voidRushState.overrideConnection then
                    voidRushState.overrideConnection:Disconnect()
                    voidRushState.overrideConnection = nil
                end
                
                local Character, Humanoid = setupCharacter()
                if Humanoid then
                    Humanoid.WalkSpeed = DEFAULT_WALK_SPEED
                    Humanoid.AutoRotate = true
                    Humanoid:Move(Vector3.new(0, 0, 0))
                end
            end
            
            local function monitorVoidRush()
                while voidRushOverrideActive do
                    local Character, Humanoid, HumanoidRootPart = setupCharacter()
                    
                    if Character and Humanoid and HumanoidRootPart then
                        local voidRushStateAttr = Character:GetAttribute("VoidRushState")
                        if voidRushStateAttr == "Dashing" then
                            startOverride(Humanoid, HumanoidRootPart)
                        else
                            stopOverride()
                        end
                    end
                    
                    task.wait()
                end
                stopOverride()
            end
            
            voidRushState.monitorTask = task.spawn(monitorVoidRush)
            
            voidRushState.characterAddedConnection = LocalPlayer.CharacterAdded:Connect(function(newChar)
                if voidRushOverrideActive then
                    local Humanoid = newChar:WaitForChildOfClass("Humanoid")
                    local HumanoidRootPart = newChar:WaitForChild("HumanoidRootPart")
                    Humanoid.WalkSpeed = DEFAULT_WALK_SPEED
                    Humanoid.AutoRotate = true
                end
            end)
        end
    end
})

local ZZ = Tabs.ani:AddRightGroupbox('1x4反效果')local ReplicatedStorage = game:GetService("ReplicatedStorage")

local LocalPlayer = Players.LocalPlayer
local RemoteEvent = ReplicatedStorage.Modules.Network.RemoteEvent

local AutoPopup = {
    Enabled = false,
    Task = nil,
    Connections = {},
    Interval = 0.5
}

local function deletePopups()
    if not LocalPlayer or not LocalPlayer:FindFirstChild("PlayerGui") then
        return false
    end
    
    local tempUI = LocalPlayer.PlayerGui:FindFirstChild("TemporaryUI")
    if not tempUI then
        return false
    end
    
    local deleted = false
    for _, popup in ipairs(tempUI:GetChildren()) do
        if popup.Name == "1x1x1x1Popup" then
            popup:Destroy()
            deleted = true
        end
    end
    return deleted
end

local function triggerEntangled()
    pcall(function()
        RemoteEvent:FireServer(
            "Entangled",
            {}
        )
    end)
end

local function setupPopupListener()
    if not LocalPlayer or not LocalPlayer:FindFirstChild("PlayerGui") then return end
    
    local tempUI = LocalPlayer.PlayerGui:FindFirstChild("TemporaryUI")
    if not tempUI then
        tempUI = Instance.new("Folder")
        tempUI.Name = "TemporaryUI"
        tempUI.Parent = LocalPlayer.PlayerGui
    end
    
    if AutoPopup.Connections.ChildAdded then
        AutoPopup.Connections.ChildAdded:Disconnect()
    end
    
    AutoPopup.Connections.ChildAdded = tempUI.ChildAdded:Connect(function(child)
        if AutoPopup.Enabled and child.Name == "1x1x1x1Popup" then
            task.defer(function()
                child:Destroy()
                triggerEntangled()
            end)
        end
    end)
end

local function runMainTask()
    while AutoPopup.Enabled do
        deletePopups()
        task.wait(AutoPopup.Interval)
    end
end

local function startAutoPopup()
    if AutoPopup.Enabled then return end
    
    AutoPopup.Enabled = true
    setupPopupListener()
    
    if AutoPopup.Task then
        task.cancel(AutoPopup.Task)
    end
    AutoPopup.Task = task.spawn(runMainTask)
end

local function stopAutoPopup()
    if not AutoPopup.Enabled then return end
    
    AutoPopup.Enabled = false
    
    if AutoPopup.Task then
        task.cancel(AutoPopup.Task)
        AutoPopup.Task = nil
    end
    
    for _, connection in pairs(AutoPopup.Connections) do
        connection:Disconnect()
    end
    AutoPopup.Connections = {}
end

ZZ:AddSlider('AutoPopupInterval', {
    Text = '执行间隔(s)',
    Default = 0.5,
    Min = 0.5,
    Max = 2,
    Rounding = 0,
    Tooltip = '设置自动执行的间隔时间(1-5秒)',
    Callback = function(value)
        AutoPopup.Interval = value
    end
})

ZZ:AddToggle('AutoPopupToggle', {
    Text = '反弹窗',
    Default = false,
    Tooltip = '去除弹窗和懒惰效果',
    Callback = function(state)
        if state then
            startAutoPopup()
        else
            stopAutoPopup()
        end
    end
})

if LocalPlayer then
    LocalPlayer:GetPropertyChangedSignal("Parent"):Connect(function()
        if not LocalPlayer.Parent then
            stopAutoPopup()
        end
    end)
end


ZZ:AddToggle("RemoveUnstableEye", {
    Text = "Anti Unstable Eye Can't walk", 
    Default = false,
    Callback = function(v)
        if not _G.UnstableEyeCleanup then _G.UnstableEyeCleanup = {} end
        local connections = _G.UnstableEyeCleanup

        for _, conn in pairs(connections) do
            if typeof(conn) == "RBXScriptConnection" then
                conn:Disconnect()
            end
        end
        _G.UnstableEyeCleanup = {}

        if not v then return end

        local function CleanUnstableEyeEffects()
            local killersFolder = workspace:FindFirstChild("Players") and workspace.Players:FindFirstChild("Killers")
            if not killersFolder then return end
            
            for _, killer in ipairs(killersFolder:GetDescendants()) do
                if killer.Name == "UnstableEye" then
                    killer:Destroy()
                end
            end
        end

        task.spawn(CleanUnstableEyeEffects)

        connections.heartbeat = game:GetService("RunService").Heartbeat:Connect(function()
            task.wait(1.5)
            CleanUnstableEyeEffects()
        end)

        local killersFolder = workspace:FindFirstChild("Players") and workspace.Players:FindFirstChild("Killers")
        if killersFolder then
            connections.descendantAdded = killersFolder.DescendantAdded:Connect(function(descendant)
                if descendant.Name == "UnstableEye" then
                    descendant:Destroy()
                end
            end)
        end
    end
})

ZZ:AddToggle("RemoveBlindness", {
    Text = "反失明", 
    Default = false,
    Callback = function(v)
        if not _G.BlindnessCleanup then _G.BlindnessCleanup = {} end
        local connections = _G.BlindnessCleanup

        for _, conn in pairs(connections) do
            if typeof(conn) == "RBXScriptConnection" then
                conn:Disconnect()
            end
        end
        _G.BlindnessCleanup = {}

        if not v then return end

        local ReplicatedStorage = game:GetService("ReplicatedStorage")
        local modulesFolder = ReplicatedStorage:FindFirstChild("Modules")
        local statusEffects = modulesFolder and modulesFolder:FindFirstChild("StatusEffects")
        
        if not statusEffects then
            warn("未找到 ReplicatedStorage.Modules.StatusEffects 路径")
            return
        end
        
        local function RemoveBlindness()
            local blindness = statusEffects:FindFirstChild("Blindness")
            if blindness then
                blindness:Destroy()
            end
        end

        task.spawn(RemoveBlindness)

        connections.heartbeat = game:GetService("RunService").Heartbeat:Connect(function()
            task.wait(1.5)
            RemoveBlindness()
        end)

        connections.descendantAdded = statusEffects.DescendantAdded:Connect(function(descendant)
            if descendant.Name == "Blindness" then
                task.wait(0.1)
                descendant:Destroy()
            end
        end)
    end
})

local ZZ = Tabs.ani:AddRightGroupbox('谢德反效果')

ZZ:AddToggle("RemoveStunningKiller", {
    Text = "反谢德挥剑速度", 
    Default = false,
    Callback = function(v)
        if not _G.StunningKillerCleanup then _G.StunningKillerCleanup = {} end
        local connections = _G.StunningKillerCleanup

        for _, conn in pairs(connections) do
            if typeof(conn) == "RBXScriptConnection" then
                conn:Disconnect()
            end
        end
        _G.StunningKillerCleanup = {}

        if not v then return end

        local function CleanStunningKillers()
            local survivorsFolder = workspace:FindFirstChild("Players") and workspace.Players:FindFirstChild("Survivors")
            if not survivorsFolder then return end
            
            local survivorList = survivorsFolder:GetChildren()
            for i = 1, #survivorList, 5 do
                task.spawn(function()
                    for j = i, math.min(i + 4, #survivorList) do
                        local survivor = survivorList[j]
                        local stunningKiller = survivor:FindFirstChild("StunningKiller")
                        if stunningKiller then
                            stunningKiller:Destroy()
                        end
                    end
                end)
            end
        end

        task.spawn(CleanStunningKillers)

        connections.heartbeat = game:GetService("RunService").Heartbeat:Connect(function()
            task.wait(2)
            CleanStunningKillers()
        end)

        local survivorsFolder = workspace:FindFirstChild("Players") and workspace.Players:FindFirstChild("Survivors")
        if survivorsFolder then
            connections.descendantAdded = survivorsFolder.DescendantAdded:Connect(function(descendant)
                if descendant.Name == "StunningKiller" then
                    descendant:Destroy()
                end
            end)
        end
    end
})

local ZZ2 = Tabs.ani:AddRightGroupbox('NOOB 反效果')

ZZ2:AddToggle("RemoveSlateskin", {
    Text = "反Noob石板速度", 
    Default = false,
    Callback = function(v)
        if not _G.SlateskinCleanup then _G.SlateskinCleanup = {} end
        local connections = _G.SlateskinCleanup

        for _, conn in pairs(connections) do
            if typeof(conn) == "RBXScriptConnection" then
                conn:Disconnect()
            end
        end
        _G.SlateskinCleanup = {}

        if not v then return end

        local function CleanSlateskins()
            local survivorsFolder = workspace:FindFirstChild("Players") and workspace.Players:FindFirstChild("Survivors")
            if not survivorsFolder then return end
            
            local survivorList = survivorsFolder:GetChildren()
            for i = 1, #survivorList, 5 do
                task.spawn(function()
                    for j = i, math.min(i + 4, #survivorList) do
                        local survivor = survivorList[j]
                        local slateskin = survivor:FindFirstChild("SlateskinStatus")
                        if slateskin then
                            slateskin:Destroy()
                        end
                    end
                end)
            end
        end

        task.spawn(CleanSlateskins)

        connections.heartbeat = game:GetService("RunService").Heartbeat:Connect(function()
            task.wait(2)
            CleanSlateskins()
        end)

        local survivorsFolder = workspace:FindFirstChild("Players") and workspace.Players:FindFirstChild("Survivors")
        if survivorsFolder then
            connections.descendantAdded = survivorsFolder.DescendantAdded:Connect(function(descendant)
                if descendant.Name == "SlateskinStatus" then
                    descendant:Destroy()
                end
            end)
        end
    end
})




local Disabled = Tabs.ani:AddLeftGroupbox('访客反效果')

Disabled:AddToggle("RemoveSlowed", {
    Text = "反缓慢", 
    Default = false,
    Callback = function(v)
        if not _G.SlowedCleanup then _G.SlowedCleanup = {} end
        local connections = _G.SlowedCleanup

        for _, conn in pairs(connections) do
            if typeof(conn) == "RBXScriptConnection" then
                conn:Disconnect()
            end
        end
        _G.SlowedCleanup = {}

        if not v then return end

        local function CleanSlowedStatuses()
            local survivorsFolder = workspace:FindFirstChild("Players") and workspace.Players:FindFirstChild("Survivors")
            if not survivorsFolder then return end
            
            for _, survivor in ipairs(survivorsFolder:GetDescendants()) do
                if survivor.Name == "SlowedStatus" then
                    survivor:Destroy()
                end
            end
        end

        task.spawn(CleanSlowedStatuses)

        connections.heartbeat = game:GetService("RunService").Heartbeat:Connect(function()
            task.wait(1.5)
            CleanSlowedStatuses()
        end)

        local survivorsFolder = workspace:FindFirstChild("Players") and workspace.Players:FindFirstChild("Survivors")
        if survivorsFolder then
            connections.descendantAdded = survivorsFolder.DescendantAdded:Connect(function(descendant)
                if descendant.Name == "SlowedStatus" then
                    descendant:Destroy()
                end
            end)
        end
    end
})

Disabled:AddToggle("RemoveBlockingSlow", {
    Text = "反格挡速度", 
    Default = false,
    Callback = function(v)
        if not _G.BlockingCleanup then _G.BlockingCleanup = {} end
        local connections = _G.BlockingCleanup

        for _, conn in pairs(connections) do
            if typeof(conn) == "RBXScriptConnection" then
                conn:Disconnect()
            end
        end
        _G.BlockingCleanup = {}

        if not v then return end

        local function CleanStatuses()
            local survivorsFolder = workspace:FindFirstChild("Players") and workspace.Players:FindFirstChild("Survivors")
            if not survivorsFolder then return end
            
            for _, survivor in ipairs(survivorsFolder:GetDescendants()) do
                if survivor.Name == "ResistanceStatus" or survivor.Name == "GuestBlocking" then
                    survivor:Destroy()
                end
            end
        end

        task.spawn(CleanStatuses)

        connections.heartbeat = game:GetService("RunService").Heartbeat:Connect(function()
            task.wait(1.5)
            CleanStatuses()
        end)

        local survivorsFolder = workspace:FindFirstChild("Players") and workspace.Players:FindFirstChild("Survivors")
        if survivorsFolder then
            connections.descendantAdded = survivorsFolder.DescendantAdded:Connect(function(descendant)
                if descendant.Name == "ResistanceStatus" or descendant.Name == "GuestBlocking" then
                    descendant:Destroy()
                end
            end)
        end
    end
})

Disabled:AddToggle("RemovePunchSlow", {
    Text = "反拳击速度", 
    Default = false,
    Callback = function(v)
        if not _G.PunchCleanup then _G.PunchCleanup = {} end
        local connections = _G.PunchCleanup

        for _, conn in pairs(connections) do
            if typeof(conn) == "RBXScriptConnection" then
                conn:Disconnect()
            end
        end
        _G.PunchCleanup = {}

        if not v then return end

        local function CleanStatuses()
            local survivorsFolder = workspace:FindFirstChild("Players") and workspace.Players:FindFirstChild("Survivors")
            if not survivorsFolder then return end
            
            for _, survivor in ipairs(survivorsFolder:GetDescendants()) do
                if survivor.Name == "ResistanceStatus" or survivor.Name == "PunchAbility" then
                    survivor:Destroy()
                end
            end
        end

        task.spawn(CleanStatuses)

        connections.heartbeat = game:GetService("RunService").Heartbeat:Connect(function()
            task.wait(1.5)
            CleanStatuses()
        end)

        local survivorsFolder = workspace:FindFirstChild("Players") and workspace.Players:FindFirstChild("Survivors")
        if survivorsFolder then
            connections.descendantAdded = survivorsFolder.DescendantAdded:Connect(function(descendant)
                if descendant.Name == "ResistanceStatus" or descendant.Name == "PunchAbility" then
                    descendant:Destroy()
                end
            end)
        end
    end
})

Disabled:AddToggle("RemoveChargeEnded", {
    Text = "反冲刺结束后效果", 
    Default = false,
    Callback = function(v)
        if not _G.ChargeEndedCleanup then _G.ChargeEndedCleanup = {} end
        local connections = _G.ChargeEndedCleanup

        for _, conn in pairs(connections) do
            if typeof(conn) == "RBXScriptConnection" then
                conn:Disconnect()
            end
        end
        _G.ChargeEndedCleanup = {}

        if not v then return end

        local function CleanChargeEndedEffects()
            local survivorsFolder = workspace:FindFirstChild("Players") and workspace.Players:FindFirstChild("Survivors")
            if not survivorsFolder then return end
            
            for _, survivor in ipairs(survivorsFolder:GetDescendants()) do
                if survivor.Name == "GuestChargeEnded" then
                    survivor:Destroy()
                end
            end
        end

        task.spawn(CleanChargeEndedEffects)

        connections.heartbeat = game:GetService("RunService").Heartbeat:Connect(function()
            task.wait(1.5)
            CleanChargeEndedEffects()
        end)

        local survivorsFolder = workspace:FindFirstChild("Players") and workspace.Players:FindFirstChild("Survivors")
        if survivorsFolder then
            connections.descendantAdded = survivorsFolder.DescendantAdded:Connect(function(descendant)
                if descendant.Name == "GuestChargeEnded" then
                    descendant:Destroy()
                end
            end)
        end
    end
})












local ZZ = Tabs.yul:AddLeftGroupbox('绕过飞行')

local CFSpeed = 50
local CFLoop = nil

local function StartCFly()
    local speaker = game.Players.LocalPlayer
    local character = speaker.Character
    if not character then return end
    
    local humanoid = character:FindFirstChildOfClass('Humanoid')
    local head = character:WaitForChild("Head")
    
    if not humanoid or not head then return end
    
    humanoid.PlatformStand = true
    head.Anchored = true
    
    if CFLoop then 
        CFLoop:Disconnect() 
        CFLoop = nil
    end
    
    CFLoop = RunService.Heartbeat:Connect(function(deltaTime)
        if not character or not humanoid or not head then 
            if CFLoop then 
                CFLoop:Disconnect() 
                CFLoop = nil
            end
            return 
        end
        
        local moveDirection = humanoid.MoveDirection * (CFSpeed * deltaTime)
        local headCFrame = head.CFrame
        local camera = workspace.CurrentCamera
        local cameraCFrame = camera.CFrame
        local cameraOffset = headCFrame:ToObjectSpace(cameraCFrame).Position
        cameraCFrame = cameraCFrame * CFrame.new(-cameraOffset.X, -cameraOffset.Y, -cameraOffset.Z + 1)
        local cameraPosition = cameraCFrame.Position
        local headPosition = headCFrame.Position

        local objectSpaceVelocity = CFrame.new(cameraPosition, Vector3.new(headPosition.X, cameraPosition.Y, headPosition.Z)):VectorToObjectSpace(moveDirection)
        head.CFrame = CFrame.new(headPosition) * (cameraCFrame - cameraPosition) * CFrame.new(objectSpaceVelocity)
    end)
end

local function StopCFly()
    local speaker = game.Players.LocalPlayer
    local character = speaker.Character
    
    if CFLoop then
        CFLoop:Disconnect()
        CFLoop = nil
    end
    
    if character then
        local humanoid = character:FindFirstChildOfClass('Humanoid')
        local head = character:FindFirstChild("Head")
        
        if humanoid then
            humanoid.PlatformStand = false
        end
        if head then
            head.Anchored = false
        end
    end
end

ZZ:AddToggle("CFlyToggle", {
    Text = "飞行",
    Default = false,
    Callback = function(Value)
        if Value then
            StartCFly()
        else
            StopCFly()
        end
    end
})

ZZ:AddSlider("CFlySpeed", {
    Text = "飞行速度",
    Default = 50,
    Min = 1,
    Max = 200,
    Rounding = 1,
    Callback = function(Value)
        CFSpeed = Value
    end
})


local FunGroup = Tabs.yul:AddRightGroupbox("后空翻")

local ff_connection = nil
local ff_enabled = false
local ff_cd = false
local jumpHeight = 72  -- 默认高度: 6 * 12 = 72
local jumpDistance = 35  -- 默认距离

local function Flip()
    if ff_cd then
        return
    end
    ff_cd = true
    local character = game.Players.LocalPlayer.Character
    if not character then
        ff_cd = false
        return
    end
    local hrp = character:FindFirstChild("HumanoidRootPart")
    local Humanoid = character:FindFirstChildOfClass("Humanoid")
    local animator = Humanoid and Humanoid:FindFirstChildOfClass("Animator")
    if not hrp or not Humanoid then
        ff_cd = false
        return
    end
    local savedTracks = {}
    if animator then
        for _, track in ipairs(animator:GetPlayingAnimationTracks()) do
            savedTracks[#savedTracks + 1] = { track = track, time = track.TimePosition }
            track:Stop(0)
        end
    end
    Humanoid:ChangeState(Enum.HumanoidStateType.Physics)
    Humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
    Humanoid:SetStateEnabled(Enum.HumanoidStateType.Freefall, false)
    Humanoid:SetStateEnabled(Enum.HumanoidStateType.Running, false)
    Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, false)
    Humanoid:SetStateEnabled(Enum.HumanoidStateType.Climbing, false)
    local duration = 0.45
    local steps = 120
    local startCFrame = hrp.CFrame
    local forwardVector = startCFrame.LookVector
    local upVector = Vector3.new(0, 1, 0)
    task.spawn(function()
        local startTime = tick()
        for i = 1, steps do
            local t = i / steps
            local height = jumpHeight * (t - t ^ 2)  -- 使用滑块调节的高度
            local nextPos = startCFrame.Position + forwardVector * (jumpDistance * t) + upVector * height    
            local rotation = startCFrame.Rotation * CFrame.Angles(-math.rad(i * (360 / steps)), 0, 0)

            hrp.CFrame = CFrame.new(nextPos) * rotation
            local elapsedTime = tick() - startTime
            local expectedTime = (duration / steps) * i
            local waitTime = expectedTime - elapsedTime
            if waitTime > 0 then
                task.wait(waitTime)
            end
        end

        hrp.CFrame = CFrame.new(startCFrame.Position + forwardVector * jumpDistance) * startCFrame.Rotation
        Humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, true)
        Humanoid:SetStateEnabled(Enum.HumanoidStateType.Freefall, true)
        Humanoid:SetStateEnabled(Enum.HumanoidStateType.Running, true)
        Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, true)
        Humanoid:SetStateEnabled(Enum.HumanoidStateType.Climbing, true)
        Humanoid:ChangeState(Enum.HumanoidStateType.Running)

        if animator then
            for _, data in ipairs(savedTracks) do
                local track = data.track
                track:Play()
                track.TimePosition = data.time
            end
        end
        task.wait(0.25)
        ff_cd = false
    end)
end

local sausageHolder = nil
local originalSize = nil
local ff_button = nil

local function SetFrontFlip(bool)
    ff_enabled = bool
    if ff_enabled == true then
        pcall(function()
            sausageHolder = game.CoreGui.TopBarApp.TopBarApp.UnibarLeftFrame.UnibarMenu["2"]
            originalSize = sausageHolder.Size.X.Offset
            ff_button = Instance.new("Frame", sausageHolder)
            ff_button.Size = UDim2.new(0, 48, 0, 44)
            ff_button.BackgroundTransparency = 1
            ff_button.BorderSizePixel = 0
            ff_button.Position = UDim2.new(0, sausageHolder.Size.X.Offset - 48, 0, 0)
            
            local imageButton = Instance.new("ImageButton", ff_button)
            imageButton.BackgroundTransparency = 1
            imageButton.BorderSizePixel = 0
            imageButton.Size = UDim2.new(0, 36, 0, 36)
            imageButton.AnchorPoint = Vector2.new(0.5, 0.5)
            imageButton.Position = UDim2.new(0.5, 0, 0.5, 0)
            imageButton.Image = "rbxthumb://type=Asset&id=2714338264&w=150&h=150"
            
            ff_connection = imageButton.Activated:Connect(Flip)
            sausageHolder.Size = UDim2.new(0, originalSize + 48, 0, sausageHolder.Size.Y.Offset)
            task.wait()
            ff_button.Position = UDim2.new(0, sausageHolder.Size.X.Offset - 48, 0, 0)
            
            task.spawn(function()
                pcall(function()
                    repeat
                        sausageHolder.Size = UDim2.new(0, originalSize + 48, 0, sausageHolder.Size.Y.Offset)
                        task.wait()
                        ff_button.Position = UDim2.new(0, sausageHolder.Size.X.Offset - 48, 0, 0)
                    until ff_enabled == false
                end)
            end)
        end)
    elseif ff_enabled == false then
        if ff_connection then
            ff_connection:Disconnect()
            ff_connection = nil
        end
        if ff_button then
            ff_button:Destroy()
            ff_button = nil
        end
        if sausageHolder then
            sausageHolder.Size = UDim2.new(0, originalSize, 0, sausageHolder.Size.Y.Offset)
        end
    end
end

FunGroup:AddToggle("Frontflip", {
    Text = "显示后空翻按钮",
    Default = false,
    Tooltip = "启用后空翻功能",
    Callback = function(Value)
        SetFrontFlip(Value)
        Library:Notify({
            Title = "后空翻",
            Description = Value and "后空翻已启用" or "后空翻已禁用",
            Time = 3,
        })
    end,
})

FunGroup:AddSlider("JumpHeight", {
    Text = "跳跃高度",
    Default = 72,
    Min = 20,
    Max = 200,
    Rounding = 0,
    Compact = false,
    Callback = function(Value)
        jumpHeight = Value
        Library:Notify({
            Title = "跳跃高度",
            Description = "已设置为: " .. Value,
            Time = 2,
        })
    end,
    Tooltip = "调节后空翻的跳跃高度",
})

FunGroup:AddSlider("JumpDistance", {
    Text = "跳跃距离",
    Default = 35,
    Min = 10,
    Max = 100,
    Rounding = 0,
    Compact = false,
    Callback = function(Value)
        jumpDistance = Value
        Library:Notify({
            Title = "跳跃距离",
            Description = "已设置为: " .. Value,
            Time = 2,
        })
    end,
    Tooltip = "调节后空翻的跳跃距离",
})

local MenuGroup = Tabs["UI Settings"]:AddLeftGroupbox("Debug")

-- 1. 显示/隐藏快捷键菜单
MenuGroup:AddToggle("KeybindMenuOpen", {
    Default = Library.KeybindFrame.Visible,  -- 默认显示快捷键菜单
    Text = "shortcut menu",
    Callback = function(value)
        Library.KeybindFrame.Visible = value  -- 控制快捷键菜单的显示/隐藏
    end,
})

-- 2. 自定义鼠标光标
MenuGroup:AddToggle("ShowCustomCursor", {
    Text = "custom cursors",
    Default = true,  -- 默认启用
    Callback = function(Value)
        Library.ShowCustomCursor = Value  -- 启用/禁用自定义光标
    end,
})

-- 3. 设置通知位置（左/右）
MenuGroup:AddDropdown("NotificationSide", {
    Values = { "Left", "Right" },
    Default = "Right",  -- 默认右侧显示通知
    Text = "informer location",
    Callback = function(Value)
        Library:SetNotifySide(Value)  -- 设置通知位置
    end,
})

-- 4. 调整UI缩放比例（DPI）
MenuGroup:AddDropdown("DPIDropdown", {
    Values = { "25%", "50%", "75%", "100%", "125%", "150%", "175%", "200%" },
    Default = "100%",  -- 默认100%大小
    Text = "UI Size",
    Callback = function(Value)
        Value = Value:gsub("%%", "")  -- 移除百分号
        local DPI = tonumber(Value)   -- 转换为数字
        Library:SetDPIScale(DPI)      -- 调整UI缩放
    end,
})


MenuGroup:AddDivider()  
MenuGroup:AddLabel("Menu bind")  
    :AddKeyPicker("MenuKeybind", { 
        Default = "RightShift",  
        NoUI = true,            
        Text = "Menu keybind"    
    })


MenuGroup:AddButton("Destroy UI", function()
    Library:Unload()  
end)


ThemeManager:SetLibrary(Library)  
SaveManager:SetLibrary(Library)   
SaveManager:IgnoreThemeSettings() 


SaveManager:SetIgnoreIndexes({ "MenuKeybind" })  
ThemeManager:SetFolder("MyScriptHub")            
SaveManager:SetFolder("MyScriptHub/specific-game")  
SaveManager:SetSubFolder("specific-place")       
SaveManager:BuildConfigSection(Tabs["UI Settings"])  

ThemeManager:ApplyToTab(Tabs["UI Settings"])

SaveManager:LoadAutoloadConfig()



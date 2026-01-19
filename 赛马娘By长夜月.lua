--By长夜月脚本自制版
--此版本有部分bug自己修复

local WindUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/Footagesus/WindUI/main/dist/main.lua"))()

local function getExecutorName()
    if type(getexecutor) == "function" and getexecutor() then 
        return getexecutor()
    elseif type(identifyexecutor) == "function" and identifyexecutor() then 
        return identifyexecutor()
    else
        return "未知 (未找到识别函数)"
    end
end

WindUI:Popup({
    Title = "欢迎使用脚本",
    Icon = "sparkles",
    Content = "工艺UG缝合脚本",
    Buttons = {
        {
            Title = "进入",
            Icon = "arrow-right",
            Variant = "Primary",
            Callback = function() 
                print("进入")
                createMainWindow()
            end
        }
    }
})

local state = false
local staminaCheckLoop = nil
local noclipEnabled = false
local noclipConnection = nil

local function startStaminaLoop()
    if staminaCheckLoop then
        pcall(function() staminaCheckLoop:disconnect() end)
        staminaCheckLoop = nil
    end
    
    staminaCheckLoop = game:GetService("RunService").Heartbeat:Connect(function()
        if not state then return end
        
        pcall(function()
            local LocalPlayer = game:GetService("Players").LocalPlayer
            if not LocalPlayer or not LocalPlayer.Character then return end
            
            local playerCharacter = LocalPlayer.Character
            local humanoidRootPart = playerCharacter:FindFirstChild("HumanoidRootPart")
            
            if humanoidRootPart then
                local runningUI = humanoidRootPart:FindFirstChild("RunningUI")
                if runningUI then
                    local bars = runningUI:FindFirstChild("Bars")
                    if bars then
                        local staminaBar = bars:FindFirstChild("StaminaBar")
                        if staminaBar then
                            staminaBar.Name = "_StaminaBar"
                        end
                    end
                end
                
                local staminaInfo = playerCharacter:FindFirstChild("Info")
                if staminaInfo then
                    local staminaValue = staminaInfo:FindFirstChild("Stamina")
                    if staminaValue then
                        staminaValue.Value = 150
                    end
                end
            end
        end)
    end)
end

local function stopStaminaLoop()
    if staminaCheckLoop then
        pcall(function() staminaCheckLoop:disconnect() end)
        staminaCheckLoop = nil
    end
end

local function toggleNoclip(value)
    noclipEnabled = value
    
    if noclipConnection then
        noclipConnection:Disconnect()
        noclipConnection = nil
    end
    
    if value then
        noclipConnection = game:GetService("RunService").Stepped:Connect(function()
            if noclipEnabled then
                local character = game.Players.LocalPlayer.Character
                if character then
                    for _, part in pairs(character:GetDescendants()) do
                        if part:IsA("BasePart") then
                            part.CanCollide = false
                        end
                    end
                end
            end
        end
    else
        local character = game.Players.LocalPlayer.Character
        if character then
            for _, part in pairs(character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = true
                end
            end
        end
    end
end

local function setupCharacterListeners()
    local LocalPlayer = game:GetService("Players").LocalPlayer
    
    LocalPlayer.CharacterAdded:Connect(function()
        if state then
            task.wait(1)
            startStaminaLoop()
        end
        
        
        if noclipEnabled then
            task.wait(0.5)
            toggleNoclip(true)
        end
    end)
    
    LocalPlayer.CharacterRemoving:Connect(function()
        if state then
            stopStaminaLoop()
        end
    end)
end

function createMainWindow()
    local Players = game:GetService("Players")
    local LocalPlayer = Players.LocalPlayer

    local Window = WindUI:CreateWindow({
        Title = "CYYhub<font color='#00FF00'>1.0</font>",
        Icon = "rbxassetid://113581030666473",
        IconTransparency = 0.5,
        IconThemed = true,
        Author = "作者:长夜月",
        Folder = "CloudHub",
        Size = UDim2.fromOffset(400, 300),
        Transparent = true,
        Theme = "Light",
        User = {
            Enabled = true,
            Callback = function() print("clicked") end,
            Anonymous = false
        },
        SideBarWidth = 200,
        ScrollBarEnabled = true,
        Background = "rbxassetid://100291624074476"
    })
    
    local TimeTag = Window:Tag({
        Title = "00:00",
        Color = Color3.fromHex("#30ff6a")
    })
    
    local hue = 0
    task.spawn(function()
        while true do
            local now = os.date("*t")
            local hours = string.format("%02d", now.hour)
            local minutes = string.format("%02d", now.min)
            
            hue = (hue + 0.01) % 1
            local color = Color3.fromHSV(hue, 1, 1)
            
            TimeTag:SetTitle(hours .. ":" .. minutes)
            TimeTag:SetColor(color) 

            task.wait(0.06)
        end
    end)
    
    Window:Tag({
        Title = "v1.1",
        Color = Color3.fromHex("#30ff6a")
    })

    Window:EditOpenButton({
        Title = "赛马娘脚本",
        Icon = "crown",
        CornerRadius = UDim.new(0,16),
        StrokeThickness = 3, 
        Color = ColorSequence.new(
            Color3.fromHex("FF0F7B"), 
            Color3.fromHex("F89B29")
        ),
        Draggable = true, 
        StrokeColor = ColorSequence.new({ 
            ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),     
            ColorSequenceKeypoint.new(0.2, Color3.fromRGB(255, 165, 0)), 
            ColorSequenceKeypoint.new(0.4, Color3.fromRGB(255, 255, 0)), 
            ColorSequenceKeypoint.new(0.6, Color3.fromRGB(0, 255, 0)),   
            ColorSequenceKeypoint.new(0.8, Color3.fromRGB(0, 0, 255)),   
            ColorSequenceKeypoint.new(1, Color3.fromRGB(128, 0, 128))    
        }),
    })
    
    local MainTab = Window:Tab({
        Title = "主页",
        Icon = "zap",
        Locked = false,
    })
    
    MainTab:Paragraph({
        Title = "欢迎使用YG脚本",
        Desc = "YG工艺缝合脚本",
        Image = "rbxassetid://77151669177766",
        ImageSize = 42,
        Thumbnail = "rbxassetid://113581030666473",
        ThumbnailSize = 120
    })
    
    MainTab:Paragraph({
        Title = "工艺YG缝合",
        Desc = "当前服务器ID: " .. game.PlaceId, 
    })
    
    local executorName = getExecutorName() 
    
    MainTab:Paragraph({
        Title = "注入器",
        Desc = ": " .. executorName, 
    })
    
    local GeneralTab = Window:Tab({
        Title = "玩家",
        Icon = "zap",
        Locked = false,
    })
    
    GeneralTab:Slider({
        Title = "移速",
        Value = {
            Min = 16,
            Max = 400,
            Default = 16,
        },
        Increment = 1,
        Callback = function(value)
            if game.Players.LocalPlayer.Character then
                local humanoid = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
                if humanoid then
                    humanoid.WalkSpeed = value
                end
            end
        end
    })

    GeneralTab:Slider({
        Title = "跳跃",
        Value = {
            Min = 50,
            Max = 200,
            Default = 50,
        },
        Increment = 1,
        Callback = function(value)
            if game.Players.LocalPlayer.Character then
                local humanoid = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
                if humanoid then
                    humanoid.JumpPower = value
                end
            end
        end
    })

    GeneralTab:Slider({
        Title = "重力",
        Value = {
            Min = 0.1,
            Max = 500.0,
            Default = 196.2,
        },
        Increment = 0.1, 
        Callback = function(value)
            game.Workspace.Gravity = value
        end
    })

    GeneralTab:Toggle({
        Title = "无限体力",
        Desc = "每回合开始动画时需重新打开",
        Default = false,
        Callback = function(Value)
            state = Value
            
            if Value then
                startStaminaLoop()
            else
                stopStaminaLoop()
            end
        end
    })
    
    GeneralTab:Toggle({
        Title = "穿墙",
        Desc = "开启后可以穿过墙壁和障碍物",
        Default = false,
        Callback = function(Value)
            toggleNoclip(Value)
        end
    })
    
    local FeaturesTab = Window:Tab({
        Title = "其他功能",
        Icon = "settings",
        Locked = false,
    })
    
    FeaturesTab:Button({
        Title = "重置（自杀）角色",
        Icon = "refresh-cw",
        Variant = "Outline",
        Callback = function()
            local char = game.Players.LocalPlayer.Character
            if char then
                char:BreakJoints()
            end
        end
    })
    
    FeaturesTab:Toggle({
        Title = "夜视",
        Desc = "提高亮度",
        Default = false,
        Callback = function(Value)
            if Value then
                game.Lighting.Brightness = 2
                game.Lighting.ClockTime = 14
                game.Lighting.FogEnd = 100000
            else
                game.Lighting.Brightness = 1
                game.Lighting.FogEnd = 100000
            end
        end
    })
    
    FeaturesTab:Toggle({
        Title = "无限跳跃",
        Desc = "此服务器中可能无法使用",
        Default = false,
        Callback = function(Value)
            if Value then
                game.Players.LocalPlayer.Character:WaitForChild("Humanoid").UseJumpPower = true
                game:GetService("UserInputService").JumpRequest:Connect(function()
                    game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
                end)
            end
        end
    })
end

setupCharacterListeners()
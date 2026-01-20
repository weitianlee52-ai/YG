local WindUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/Potato5466794/New/refs/heads/main/Library%E2%80%93ZeroXNOL.lua"))()


WindUI:Notify({
    Title = "YG SCRIPT",
    Content = "Load！",
    Duration = 4
})


function gradient(text, startColor, endColor)
    local result = ""
    local chars = {}
    
    for uchar in text:gmatch("[%z\1-\127\194-\244][\128-\191]*") do
        table.insert(chars, uchar)
    end
    
    local length = #chars
    
    for i = 1, length do
        local t = (i - 1) / math.max(length - 1, 1)
        local r = startColor.R + (endColor.R - startColor.R) * t
        local g = startColor.G + (endColor.G - startColor.G) * t
        local b = startColor.B + (endColor.B - startColor.B) * t
        
        result = result .. string.format('<font color="rgb(%d,%d,%d)">%s</font>', 
            math.floor(r * 255), 
            math.floor(g * 255), 
            math.floor(b * 255), 
            chars[i])
    end
    
    return result
end

local myDarkTheme = {
    Name = "DarkPurpleRed",
    
    Accent = Color3.fromHex("#4A235A"),
    Dialog = Color3.fromHex("#2C003E"),
    Outline = Color3.fromHex("#FFFFFF"),
    Text = Color3.fromHex("#FFFFFF"),
    Placeholder = Color3.fromHex("#8B5A8C"),
    Background = Color3.fromHex("#0A0A0F"),
    Button = Color3.fromHex("#641E16"),
    Icon = Color3.fromHex("#D4AF37"),
    Toggle = Color3.fromHex("#8B0000"),
    Slider = Color3.fromHex("#8B0000"),
    Checkbox = Color3.fromHex("#4A235A"),
    
    Hover = Color3.fromHex("#8B5A8C"),
    
    WindowBackground = Color3.fromHex("#1A0A1A"),
    
    WindowTopbarTitle = Color3.fromHex("#FFFFFF"),
    WindowTopbarAuthor = Color3.fromHex("#D4AF37"),
    WindowTopbarIcon = Color3.fromHex("#D4AF37"),
    WindowTopbarButtonIcon = Color3.fromHex("#FFFFFF"),
    
    Tooltip = Color3.fromHex("#4A235A"),
    TooltipText = Color3.fromHex("#FFFFFF"),
    TooltipSecondary = Color3.fromHex("#8B0000"),
    TooltipSecondaryText = Color3.fromHex("#FFFFFF"),
}

WindUI:AddTheme(myDarkTheme)

local Window = WindUI:CreateWindow({
    Title = gradient("YG SCRIPT   ", Color3.fromHex("#8B0000"), Color3.fromHex("#4A235A")), 
    Author = gradient("Loader", Color3.fromHex("#D4AF37"), Color3.fromHex("#FFFFFF")),
    IconThemed = true,
    Folder = "加载器",
    Size = UDim2.fromOffset(150, 100),
    Transparent = getgenv().TransparencyEnabled,
    Theme = "DarkPurpleRed",
    Resizable = true,
    SideBarWidth = 150,
    BackgroundImageTransparency = 0.8,
    HideSearchBar = true,
    ScrollBarEnabled = true,
    Acrylic = false,
    User = {
        Enabled = true,
        Anonymous = false,
        Callback = function()
            local themes = {"DarkPurpleRed", "Dark", "Crimson", "Violet", "Midnight"}
            if not currentThemeIndex then
                currentThemeIndex = 1
            else
                currentThemeIndex = currentThemeIndex + 1
                if currentThemeIndex > #themes then
                    currentThemeIndex = 1
                end
            end
            
            local newTheme = themes[currentThemeIndex]
            WindUI:SetTheme(newTheme)
            
            WindUI:Notify({
                Title = "主题已切换",
                Content = "切换到 " .. newTheme .. " 主题",
                Duration = 2,
                Icon = "palette",
                IconThemed = true
            })
        end,
    },
})
    
Window:EditOpenButton({
    Title = "加载器",
    Icon = "monitor",
    CornerRadius = UDim.new(3,20),
    StrokeThickness = 2,
    Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromHex("FF0000")),
        ColorSequenceKeypoint.new(0.16, Color3.fromHex("FF7F00")),
        ColorSequenceKeypoint.new(0.33, Color3.fromHex("FFFF00")),
        ColorSequenceKeypoint.new(0.5, Color3.fromHex("00FF00")),
        ColorSequenceKeypoint.new(0.66, Color3.fromHex("0000FF")),
        ColorSequenceKeypoint.new(0.83, Color3.fromHex("4B0082")),
        ColorSequenceKeypoint.new(1, Color3.fromHex("9400D3"))
    }),
    Draggable = true,
})




Window:Tag({
    Title = "Loader",----标签名
    Radius = 5,
    Color = Color3.fromHex("#8B0000"),
})






Window:SetToggleKey(Enum.KeyCode.F)




local MainSection = Window:Section({ 
    Title = "服务器列表",
    Icon = "star",
    IconThemed = true
})






local MainTab = MainSection:Tab({ 
    Title = "通缉", ----服务器名称或者类型
    Icon = "zap",
    IconColor = Color3.fromHex("#D4AF37")
})

MainTab:Button({
    Title = "通缉",---服务器名称
    Icon = "play",
    Color = "Red",
    Callback = function()
      ---  ↓↓↓↓↓↓↓ 你的源代码放进去(不用混淆)
      local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")

-- 创建主屏幕GUI
local player = Players.LocalPlayer
local gui = Instance.new("ScreenGui")
gui.Name = "WenDing_Full_Loader_WhiteParticles"
gui.ResetOnSpawn = false
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.Parent = player:WaitForChild("PlayerGui")

-- ========================
-- 1. 黑色背景幕布与白色背景粒子
-- ========================
local blackBackground = Instance.new("Frame")
blackBackground.Name = "BlackBackground"
blackBackground.Size = UDim2.new(1, 0, 1, 0)
blackBackground.BackgroundColor3 = Color3.new(0, 0, 0)
blackBackground.BackgroundTransparency = 1
blackBackground.ZIndex = 1
blackBackground.Parent = gui

-- 白色粒子容器
local bgParticleContainer = Instance.new("Frame")
bgParticleContainer.Name = "WhiteParticleContainer"
bgParticleContainer.Size = UDim2.new(1, 0, 1, 0)
bgParticleContainer.BackgroundTransparency = 1
bgParticleContainer.ClipsDescendants = true
bgParticleContainer.ZIndex = 2
bgParticleContainer.Parent = blackBackground

-- 创建白色小粒子
local whiteParticles = {}
local whiteParticleCount = 40 -- 白色粒子数量

for i = 1, whiteParticleCount do
    local particle = Instance.new("Frame")
    particle.Name = "WhiteParticle_"..i
    particle.AnchorPoint = Vector2.new(0.5, 0.5)
    particle.BackgroundColor3 = Color3.fromRGB(255, 255, 255) -- 纯白色
    particle.Size = UDim2.new(0, math.random(2, 5), 0, math.random(2, 5)) -- 小尺寸
    particle.Position = UDim2.new(math.random(), 0, math.random(), 0)
    particle.BackgroundTransparency = 1 -- 初始透明
    particle.ZIndex = 2
    particle.Parent = bgParticleContainer
    
    local particleCorner = Instance.new("UICorner")
    particleCorner.CornerRadius = UDim.new(1, 0)
    particleCorner.Parent = particle
    
    whiteParticles[i] = {
        element = particle,
        xSpeed = (math.random() - 0.5) * 0.15, -- 较慢速度
        ySpeed = (math.random() - 0.5) * 0.15,
        scale = 0.5 + math.random() * 0.5,
        alpha = 0.2 + math.random() * 0.3 -- 半透明效果
    }
end

-- ========================
-- 2. NOL定制字幕动画
-- ========================
local nolText = Instance.new("TextLabel")
nolText.Name = "NOLText"
nolText.AnchorPoint = Vector2.new(0.5, 0.5)
nolText.Position = UDim2.new(0.5, 0, 0.5, 0)
nolText.Size = UDim2.new(0, 0, 0, 80)
nolText.BackgroundTransparency = 1
nolText.Font = Enum.Font.GothamBold
nolText.Text = "NOL PRESENTS"
nolText.TextColor3 = Color3.fromRGB(255, 255, 255) -- 白色文字
nolText.TextSize = 36
nolText.TextTransparency = 1
nolText.TextWrapped = true
nolText.ZIndex = 10
nolText.Parent = gui

-- ========================
-- 3. 主加载UI
-- ========================
local container = Instance.new("Frame")
container.Name = "MainContainer"
container.AnchorPoint = Vector2.new(0.5, 0.5)
container.BackgroundColor3 = Color3.fromRGB(30, 20, 50)
container.BackgroundTransparency = 1
container.Position = UDim2.new(0.5, 0, 0.5, 0)
container.Size = UDim2.new(0, 350, 0, 250)
container.ZIndex = 20
container.Parent = gui

-- 圆角效果
local uiCorner = Instance.new("UICorner")
uiCorner.CornerRadius = UDim.new(0.08, 0)
uiCorner.Parent = container

-- 边框发光效果
local uiStroke = Instance.new("UIStroke")
uiStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
uiStroke.Color = Color3.fromRGB(120, 80, 180)
uiStroke.Transparency = 1
uiStroke.Thickness = 2
uiStroke.Parent = container

-- 主标题
local title = Instance.new("TextLabel")
title.Name = "Title"
title.AnchorPoint = Vector2.new(0.5, 0)
title.BackgroundTransparency = 1
title.Position = UDim2.new(0.5, 0, 0.1, 0)
title.Size = UDim2.new(0.8, 0, 0, 60)
title.Font = Enum.Font.SciFi
title.Text = "YG 脚本"
title.TextColor3 = Color3.fromRGB(180, 140, 255)
title.TextScaled = true
title.TextSize = 28
title.TextStrokeColor3 = Color3.fromRGB(80, 40, 120)
title.TextStrokeTransparency = 1
title.TextTransparency = 1
title.TextWrapped = true
title.ZIndex = 21
title.Parent = container

-- 标题下划线
local underline = Instance.new("Frame")
underline.Name = "Underline"
underline.AnchorPoint = Vector2.new(0.5, 0)
underline.BackgroundColor3 = Color3.fromRGB(150, 100, 220)
underline.BorderSizePixel = 0
underline.Position = UDim2.new(0.5, 0, 0.35, 0)
underline.Size = UDim2.new(0, 0, 0, 2)
underline.ZIndex = 21
underline.Parent = container

-- 前景粒子容器（彩色粒子）
local particleContainer = Instance.new("Frame")
particleContainer.Name = "ParticleContainer"
particleContainer.AnchorPoint = Vector2.new(0.5, 0.5)
particleContainer.BackgroundTransparency = 1
particleContainer.Position = UDim2.new(0.5, 0, 0.5, 0)
particleContainer.Size = UDim2.new(1, 0, 0.5, 0)
particleContainer.ClipsDescendants = true
particleContainer.ZIndex = 21
particleContainer.Parent = container

-- 创建前景彩色粒子
local particles = {}
local particleCount = 18

for i = 1, particleCount do
    local particle = Instance.new("Frame")
    particle.Name = "Particle_"..i
    particle.AnchorPoint = Vector2.new(0.5, 0.5)
    particle.BackgroundColor3 = Color3.fromRGB(
        math.random(160, 200),
        math.random(120, 180),
        math.random(200, 255)
    )
    particle.Size = UDim2.new(0, math.random(4, 8), 0, math.random(4, 8))
    particle.Position = UDim2.new(math.random(), 0, math.random(), 0)
    particle.BackgroundTransparency = 1
    particle.ZIndex = 21
    particle.Parent = particleContainer
    
    local particleCorner = Instance.new("UICorner")
    particleCorner.CornerRadius = UDim.new(1, 0)
    particleCorner.Parent = particle
    
    particles[i] = {
        element = particle,
        xSpeed = (math.random() - 0.5) * 0.4,
        ySpeed = (math.random() - 0.5) * 0.4,
        scale = 0.5 + math.random(),
        alpha = 0.3 + math.random() * 0.7
    }
end

-- 加载进度条背景
local progressBarBg = Instance.new("Frame")
progressBarBg.Name = "ProgressBarBg"
progressBarBg.AnchorPoint = Vector2.new(0.5, 0)
progressBarBg.BackgroundColor3 = Color3.fromRGB(40, 30, 70)
progressBarBg.BackgroundTransparency = 1
progressBarBg.BorderSizePixel = 0
progressBarBg.Position = UDim2.new(0.5, 0, 0.8, 0)
progressBarBg.Size = UDim2.new(0.7, 0, 0, 8)
progressBarBg.ZIndex = 21
progressBarBg.Parent = container

local progressCorner = Instance.new("UICorner")
progressCorner.CornerRadius = UDim.new(0.5, 0)
progressCorner.Parent = progressBarBg

-- 加载进度条填充
local progressFill = Instance.new("Frame")
progressFill.Name = "ProgressFill"
progressFill.AnchorPoint = Vector2.new(0, 0.5)
progressFill.BackgroundColor3 = Color3.fromRGB(160, 120, 255)
progressFill.BorderSizePixel = 0
progressFill.Position = UDim2.new(0, 0, 0.5, 0)
progressFill.Size = UDim2.new(0, 0, 1, 0)
progressFill.ZIndex = 22
progressFill.Parent = progressBarBg

local fillCorner = Instance.new("UICorner")
fillCorner.CornerRadius = UDim.new(0.5, 0)
fillCorner.Parent = progressFill

-- 进度条发光效果
local fillGlow = Instance.new("UIStroke")
fillGlow.Color = Color3.fromRGB(200, 180, 255)
fillGlow.Thickness = 1
fillGlow.Transparency = 1
fillGlow.Parent = progressFill

-- 百分比文本
local percentText = Instance.new("TextLabe
      



---↑↑↑↑↑↑ 源代码放入
destroyUI()
         
       
    end
})

------以此类推  比如 local Player = MainSecton:Tab...
--   local MainTab ← [这里随便起 必须是字母]= MainSection:Tab({ 
--   Title = "", ----服务器名称或者类型
--  Icon = "zap",
--  IconColor = Color3.fromHex("#D4AF37")
--  })

---MainTab ← [这里要和上面对应]:Button({

--[[
    Modern Premium GUI – Medium Gray with White Glow Outlines
]]

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

task.wait(1)

-- Blur effect (subtle)
local blur = Instance.new("BlurEffect")
blur.Size = 0
blur.Parent = Lighting

-- Main GUI
local gui = Instance.new("ScreenGui")
gui.Name = "PremiumGUI"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.Parent = playerGui

-- Snow particles (200) - ambient effect
local particles = {}
for i = 1, 200 do
    local size = math.random(2, 6)
    local x = math.random(0, 100)
    local y = math.random(-100, 105)
    local speed = 0.3 + math.random() * 1.2
    local drift = (math.random() - 0.5) * 1.5

    local p = Instance.new("Frame")
    p.Size = UDim2.new(0, size, 0, size)
    p.Position = UDim2.new(x / 100, 0, y / 100, 0)
    p.BackgroundColor3 = Color3.new(1, 1, 1)
    p.BackgroundTransparency = 0.15 + math.random() * 0.25
    p.BorderSizePixel = 0
    p.Parent = gui

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(1, 0)
    corner.Parent = p

    p:SetAttribute("X", x)
    p:SetAttribute("Y", y)
    p:SetAttribute("Speed", speed)
    p:SetAttribute("Drift", drift)
    p:SetAttribute("DriftTimer", 0)
    p:SetAttribute("DriftChange", 2 + math.random() * 4)
    p:SetAttribute("Rotation", math.random() * 360)
    p:SetAttribute("RotSpeed", (math.random() - 0.5) * 3)

    table.insert(particles, p)
end

-- ===== MAIN WINDOW =====
local mainWindow = Instance.new("Frame")
mainWindow.Size = UDim2.new(0, 420, 0, 340)
mainWindow.Position = UDim2.new(0.5, -210, 0.5, -170)
mainWindow.AnchorPoint = Vector2.new(0, 0)
mainWindow.BackgroundColor3 = Color3.new(0.35, 0.35, 0.38)
mainWindow.BackgroundTransparency = 0.15
mainWindow.BorderSizePixel = 2
mainWindow.BorderColor3 = Color3.new(0.7, 0.7, 0.75)
mainWindow.Visible = false
mainWindow.Parent = gui

local windowCorner = Instance.new("UICorner")
windowCorner.CornerRadius = UDim.new(0, 14)
windowCorner.Parent = mainWindow

-- Outer glow effect
local glowFrame = Instance.new("Frame")
glowFrame.Size = UDim2.new(1, 8, 1, 8)
glowFrame.Position = UDim2.new(0, -4, 0, -4)
glowFrame.BackgroundColor3 = Color3.new(1, 1, 1)
glowFrame.BackgroundTransparency = 0.9
glowFrame.BorderSizePixel = 0
glowFrame.Parent = mainWindow

local glowCorner = Instance.new("UICorner")
glowCorner.CornerRadius = UDim.new(0, 16)
glowCorner.Parent = glowFrame

-- Inner subtle glow
local innerGlow = Instance.new("Frame")
innerGlow.Size = UDim2.new(1, -8, 1, -8)
innerGlow.Position = UDim2.new(0, 4, 0, 4)
innerGlow.BackgroundColor3 = Color3.new(0.4, 0.4, 0.45)
innerGlow.BackgroundTransparency = 0.5
innerGlow.BorderSizePixel = 1
innerGlow.BorderColor3 = Color3.new(0.6, 0.6, 0.65)
innerGlow.Parent = mainWindow

local innerCorner = Instance.new("UICorner")
innerCorner.CornerRadius = UDim.new(0, 12)
innerCorner.Parent = innerGlow

-- ===== HEADER / TITLE =====
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 40)
title.Position = UDim2.new(0, 0, 0, 16)
title.BackgroundTransparency = 1
title.Text = "Main Settings"
title.TextColor3 = Color3.new(1, 1, 1)
title.TextSize = 22
title.Font = Enum.Font.GothamSemibold
title.TextTransparency = 1
title.Parent = mainWindow

-- Divider line
local divider = Instance.new("Frame")
divider.Size = UDim2.new(0.9, 0, 0, 1)
divider.Position = UDim2.new(0.05, 0, 0, 60)
divider.BackgroundColor3 = Color3.new(0.6, 0.6, 0.65)
divider.BackgroundTransparency = 0.5
divider.BorderSizePixel = 0
divider.Parent = mainWindow

-- ===== CHECKBOX 1 =====
local checkContainer1 = Instance.new("Frame")
checkContainer1.Size = UDim2.new(0, 250, 0, 32)
checkContainer1.Position = UDim2.new(0.05, 0, 0, 80)
checkContainer1.AnchorPoint = Vector2.new(0, 0)
checkContainer1.BackgroundTransparency = 1
checkContainer1.Parent = mainWindow

local checkBox1 = Instance.new("Frame")
checkBox1.Size = UDim2.new(0, 20, 0, 20)
checkBox1.Position = UDim2.new(0, 0, 0.5, -10)
checkBox1.AnchorPoint = Vector2.new(0, 0)
checkBox1.BackgroundColor3 = Color3.new(0.15, 0.15, 0.18)
checkBox1.BackgroundTransparency = 0.1
checkBox1.BorderSizePixel = 2
checkBox1.BorderColor3 = Color3.new(0.5, 0.5, 0.55)
checkBox1.Parent = checkContainer1

local checkCorner1 = Instance.new("UICorner")
checkCorner1.CornerRadius = UDim.new(0, 4)
checkCorner1.Parent = checkBox1

local glowRing1 = Instance.new("Frame")
glowRing1.Size = UDim2.new(1, 8, 1, 8)
glowRing1.Position = UDim2.new(0, -4, 0, -4)
glowRing1.BackgroundColor3 = Color3.new(1, 1, 1)
glowRing1.BackgroundTransparency = 1
glowRing1.BorderSizePixel = 0
glowRing1.Parent = checkBox1

local glowRingCorner1 = Instance.new("UICorner")
glowRingCorner1.CornerRadius = UDim.new(0, 6)
glowRingCorner1.Parent = glowRing1

local checkLabel1 = Instance.new("TextLabel")
checkLabel1.Size = UDim2.new(0, 180, 0, 20)
checkLabel1.Position = UDim2.new(0, 28, 0.5, -10)
checkLabel1.AnchorPoint = Vector2.new(0, 0)
checkLabel1.BackgroundTransparency = 1
checkLabel1.Text = "Use Website (Currently not added yet.)"
checkLabel1.TextColor3 = Color3.new(0.95, 0.95, 1)
checkLabel1.TextSize = 16
checkLabel1.Font = Enum.Font.Gotham
checkLabel1.TextXAlignment = Enum.TextXAlignment.Left
checkLabel1.TextTransparency = 1
checkLabel1.Parent = checkContainer1

-- ===== CHECKBOX 2 =====
local checkContainer2 = Instance.new("Frame")
checkContainer2.Size = UDim2.new(0, 250, 0, 32)
checkContainer2.Position = UDim2.new(0.05, 0, 0, 120)
checkContainer2.AnchorPoint = Vector2.new(0, 0)
checkContainer2.BackgroundTransparency = 1
checkContainer2.Parent = mainWindow

local checkBox2 = Instance.new("Frame")
checkBox2.Size = UDim2.new(0, 20, 0, 20)
checkBox2.Position = UDim2.new(0, 0, 0.5, -10)
checkBox2.AnchorPoint = Vector2.new(0, 0)
checkBox2.BackgroundColor3 = Color3.new(0.15, 0.15, 0.18)
checkBox2.BackgroundTransparency = 0.1
checkBox2.BorderSizePixel = 2
checkBox2.BorderColor3 = Color3.new(0.5, 0.5, 0.55)
checkBox2.Parent = checkContainer2

local checkCorner2 = Instance.new("UICorner")
checkCorner2.CornerRadius = UDim.new(0, 4)
checkCorner2.Parent = checkBox2

local glowRing2 = Instance.new("Frame")
glowRing2.Size = UDim2.new(1, 8, 1, 8)
glowRing2.Position = UDim2.new(0, -4, 0, -4)
glowRing2.BackgroundColor3 = Color3.new(1, 1, 1)
glowRing2.BackgroundTransparency = 1
glowRing2.BorderSizePixel = 0
glowRing2.Parent = checkBox2

local glowRingCorner2 = Instance.new("UICorner")
glowRingCorner2.CornerRadius = UDim.new(0, 6)
glowRingCorner2.Parent = glowRing2

local checkLabel2 = Instance.new("TextLabel")
checkLabel2.Size = UDim2.new(0, 180, 0, 20)
checkLabel2.Position = UDim2.new(0, 28, 0.5, -10)
checkLabel2.AnchorPoint = Vector2.new(0, 0)
checkLabel2.BackgroundTransparency = 1
checkLabel2.Text = "Use GUI (Currently not added yet.)"
checkLabel2.TextColor3 = Color3.new(0.95, 0.95, 1)
checkLabel2.TextSize = 16
checkLabel2.Font = Enum.Font.Gotham
checkLabel2.TextXAlignment = Enum.TextXAlignment.Left
checkLabel2.TextTransparency = 1
checkLabel2.Parent = checkContainer2

-- ===== CHECKBOX 3 =====
local checkContainer3 = Instance.new("Frame")
checkContainer3.Size = UDim2.new(0, 250, 0, 32)
checkContainer3.Position = UDim2.new(0.05, 0, 0, 160)
checkContainer3.AnchorPoint = Vector2.new(0, 0)
checkContainer3.BackgroundTransparency = 1
checkContainer3.Parent = mainWindow

local checkBox3 = Instance.new("Frame")
checkBox3.Size = UDim2.new(0, 20, 0, 20)
checkBox3.Position = UDim2.new(0, 0, 0.5, -10)
checkBox3.AnchorPoint = Vector2.new(0, 0)
checkBox3.BackgroundColor3 = Color3.new(0.15, 0.15, 0.18)
checkBox3.BackgroundTransparency = 0.1
checkBox3.BorderSizePixel = 2
checkBox3.BorderColor3 = Color3.new(0.5, 0.5, 0.55)
checkBox3.Parent = checkContainer3

local checkCorner3 = Instance.new("UICorner")
checkCorner3.CornerRadius = UDim.new(0, 4)
checkCorner3.Parent = checkBox3

local glowRing3 = Instance.new("Frame")
glowRing3.Size = UDim2.new(1, 8, 1, 8)
glowRing3.Position = UDim2.new(0, -4, 0, -4)
glowRing3.BackgroundColor3 = Color3.new(1, 1, 1)
glowRing3.BackgroundTransparency = 1
glowRing3.BorderSizePixel = 0
glowRing3.Parent = checkBox3

local glowRingCorner3 = Instance.new("UICorner")
glowRingCorner3.CornerRadius = UDim.new(0, 6)
glowRingCorner3.Parent = glowRing3

local checkLabel3 = Instance.new("TextLabel")
checkLabel3.Size = UDim2.new(0, 180, 0, 20)
checkLabel3.Position = UDim2.new(0, 28, 0.5, -10)
checkLabel3.AnchorPoint = Vector2.new(0, 0)
checkLabel3.BackgroundTransparency = 1
checkLabel3.Text = "Clean Server-Sided Player logs"
checkLabel3.TextColor3 = Color3.new(0.95, 0.95, 1)
checkLabel3.TextSize = 16
checkLabel3.Font = Enum.Font.Gotham
checkLabel3.TextXAlignment = Enum.TextXAlignment.Left
checkLabel3.TextTransparency = 1
checkLabel3.Parent = checkContainer3

-- ===== BOTTOM DIVIDER =====
local bottomDivider = Instance.new("Frame")
bottomDivider.Size = UDim2.new(0.9, 0, 0, 1)
bottomDivider.Position = UDim2.new(0.05, 0, 0, 200)
bottomDivider.BackgroundColor3 = Color3.new(0.6, 0.6, 0.65)
bottomDivider.BackgroundTransparency = 0.5
bottomDivider.BorderSizePixel = 0
bottomDivider.Parent = mainWindow

-- ===== VERTICAL BUTTONS AT BOTTOM =====
-- Inject Button (Top - Lighter Gray)
local injectButton = Instance.new("TextButton")
injectButton.Size = UDim2.new(0, 370, 0, 42)
injectButton.Position = UDim2.new(0.5, -185, 0, 215)
injectButton.AnchorPoint = Vector2.new(0, 0)
injectButton.BackgroundColor3 = Color3.new(0.5, 0.5, 0.55)
injectButton.BackgroundTransparency = 0.2
injectButton.BorderSizePixel = 2
injectButton.BorderColor3 = Color3.new(0.7, 0.7, 0.75)
injectButton.Text = "Inject"
injectButton.TextColor3 = Color3.new(1, 1, 1)
injectButton.TextSize = 20
injectButton.Font = Enum.Font.GothamSemibold
injectButton.TextTransparency = 1
injectButton.Parent = mainWindow

local injectCorner = Instance.new("UICorner")
injectCorner.CornerRadius = UDim.new(0, 8)
injectCorner.Parent = injectButton

-- Inject button glow
local injectGlow = Instance.new("Frame")
injectGlow.Size = UDim2.new(1, 8, 1, 8)
injectGlow.Position = UDim2.new(0, -4, 0, -4)
injectGlow.BackgroundColor3 = Color3.new(0.7, 0.7, 0.8)
injectGlow.BackgroundTransparency = 1
injectGlow.BorderSizePixel = 0
injectGlow.Parent = injectButton

local injectGlowCorner = Instance.new("UICorner")
injectGlowCorner.CornerRadius = UDim.new(0, 10)
injectGlowCorner.Parent = injectGlow

-- Exit Button (Bottom - Lighter Gray)
local exitButton = Instance.new("TextButton")
exitButton.Size = UDim2.new(0, 370, 0, 42)
exitButton.Position = UDim2.new(0.5, -185, 0, 267)
exitButton.AnchorPoint = Vector2.new(0, 0)
exitButton.BackgroundColor3 = Color3.new(0.5, 0.5, 0.55)
exitButton.BackgroundTransparency = 0.2
exitButton.BorderSizePixel = 2
exitButton.BorderColor3 = Color3.new(0.7, 0.7, 0.75)
exitButton.Text = "Exit"
exitButton.TextColor3 = Color3.new(1, 1, 1)
exitButton.TextSize = 20
exitButton.Font = Enum.Font.GothamSemibold
exitButton.TextTransparency = 1
exitButton.Parent = mainWindow

local exitCorner = Instance.new("UICorner")
exitCorner.CornerRadius = UDim.new(0, 8)
exitCorner.Parent = exitButton

-- Exit button glow
local exitGlow = Instance.new("Frame")
exitGlow.Size = UDim2.new(1, 8, 1, 8)
exitGlow.Position = UDim2.new(0, -4, 0, -4)
exitGlow.BackgroundColor3 = Color3.new(0.7, 0.7, 0.8)
exitGlow.BackgroundTransparency = 1
exitGlow.BorderSizePixel = 0
exitGlow.Parent = exitButton

local exitGlowCorner = Instance.new("UICorner")
exitGlowCorner.CornerRadius = UDim.new(0, 10)
exitGlowCorner.Parent = exitGlow

-- ===== LOGO TEXT =====
local logoText = Instance.new("TextLabel")
logoText.Size = UDim2.new(0, 500, 0, 100)
logoText.Position = UDim2.new(0.5, -250, 0.5, -50)
logoText.AnchorPoint = Vector2.new(0, 0)
logoText.BackgroundTransparency = 1
logoText.Text = "Osiris.cc"
logoText.TextColor3 = Color3.new(1, 1, 1)
logoText.TextSize = 72
logoText.FontFace = Font.new("rbxassetid://12187375958", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
logoText.TextTransparency = 1
logoText.Parent = gui

-- ===== CHECKBOX LOGIC =====
local checkStates = {false, false, false}
local checkBoxes = {checkBox1, checkBox2, checkBox3}
local glowRings = {glowRing1, glowRing2, glowRing3}

local function toggleCheckbox(index)
    checkStates[index] = not checkStates[index]
    local box = checkBoxes[index]
    local ring = glowRings[index]
    
    if checkStates[index] then
        local t1 = TweenService:Create(box, TweenInfo.new(0.2, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
            BackgroundColor3 = Color3.new(1, 1, 1),
            BorderColor3 = Color3.new(0.8, 0.8, 0.9)
        })
        t1:Play()
        
        local t2 = TweenService:Create(ring, TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
            BackgroundTransparency = 0.85
        })
        t2:Play()
        
        local popUp = TweenService:Create(box, TweenInfo.new(0.08, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
            Size = UDim2.new(0, 24, 0, 24),
            Position = UDim2.new(0, -2, 0.5, -12)
        })
        popUp:Play()
        popUp.Completed:Wait()
        
        local popDown = TweenService:Create(box, TweenInfo.new(0.08, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
            Size = UDim2.new(0, 20, 0, 20),
            Position = UDim2.new(0, 0, 0.5, -10)
        })
        popDown:Play()
        
    else
        local t1 = TweenService:Create(box, TweenInfo.new(0.2, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
            BackgroundColor3 = Color3.new(0.15, 0.15, 0.18),
            BorderColor3 = Color3.new(0.5, 0.5, 0.55)
        })
        t1:Play()
        
        local t2 = TweenService:Create(ring, TweenInfo.new(0.2, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
            BackgroundTransparency = 1
        })
        t2:Play()
    end
end

-- Create click handlers for each checkbox
local containers = {checkContainer1, checkContainer2, checkContainer3}
for i = 1, 3 do
    local container = containers[i]
    local box = checkBoxes[i]
    
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(1, 0, 1, 0)
    button.Position = UDim2.new(0, 0, 0, 0)
    button.BackgroundTransparency = 1
    button.Text = ""
    button.Parent = container
    
    button.MouseEnter:Connect(function()
        if not checkStates[i] then
            local t = TweenService:Create(box, TweenInfo.new(0.15, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                BorderColor3 = Color3.new(0.7, 0.7, 0.8)
            })
            t:Play()
        end
    end)
    
    button.MouseLeave:Connect(function()
        if not checkStates[i] then
            local t = TweenService:Create(box, TweenInfo.new(0.15, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                BorderColor3 = Color3.new(0.5, 0.5, 0.55)
            })
            t:Play()
        end
    end)
    
    button.MouseButton1Click:Connect(function()
        toggleCheckbox(i)
    end)
end

-- ===== FADE OUT FUNCTION (SYNCED WITH ALL ELEMENTS) =====
local function fadeOutAndCleanup(callback)
    local fadeOutDuration = 1.2
    
    -- Create all tweens in a single table for perfect sync
    local tweens = {}
    
    -- Main window and all its children
    local windowTween = TweenService:Create(mainWindow, TweenInfo.new(fadeOutDuration, Enum.EasingStyle.Quart, Enum.EasingDirection.InOut), {
        BackgroundTransparency = 1,
        BorderColor3 = Color3.new(1, 1, 1)
    })
    table.insert(tweens, windowTween)
    
    -- Title
    local titleTween = TweenService:Create(title, TweenInfo.new(fadeOutDuration, Enum.EasingStyle.Quart, Enum.EasingDirection.InOut), {
        TextTransparency = 1
    })
    table.insert(tweens, titleTween)
    
    -- All labels
    for _, label in ipairs({checkLabel1, checkLabel2, checkLabel3}) do
        local t = TweenService:Create(label, TweenInfo.new(fadeOutDuration, Enum.EasingStyle.Quart, Enum.EasingDirection.InOut), {
            TextTransparency = 1
        })
        table.insert(tweens, t)
    end
    
    -- All checkboxes
    for _, box in ipairs({checkBox1, checkBox2, checkBox3}) do
        local t = TweenService:Create(box, TweenInfo.new(fadeOutDuration, Enum.EasingStyle.Quart, Enum.EasingDirection.InOut), {
            BackgroundTransparency = 1,
            BorderColor3 = Color3.new(1, 1, 1)
        })
        table.insert(tweens, t)
    end
    
    -- Checkbox containers (fade their backgrounds too)
    for _, container in ipairs({checkContainer1, checkContainer2, checkContainer3}) do
        local t = TweenService:Create(container, TweenInfo.new(fadeOutDuration, Enum.EasingStyle.Quart, Enum.EasingDirection.InOut), {
            BackgroundTransparency = 1
        })
        table.insert(tweens, t)
    end
    
    -- Buttons
    local injectTween = TweenService:Create(injectButton, TweenInfo.new(fadeOutDuration, Enum.EasingStyle.Quart, Enum.EasingDirection.InOut), {
        TextTransparency = 1,
        BackgroundTransparency = 1,
        BorderColor3 = Color3.new(1, 1, 1)
    })
    table.insert(tweens, injectTween)
    
    local exitTween = TweenService:Create(exitButton, TweenInfo.new(fadeOutDuration, Enum.EasingStyle.Quart, Enum.EasingDirection.InOut), {
        TextTransparency = 1,
        BackgroundTransparency = 1,
        BorderColor3 = Color3.new(1, 1, 1)
    })
    table.insert(tweens, exitTween)
    
    -- Button glows
    local injectGlowTween = TweenService:Create(injectGlow, TweenInfo.new(fadeOutDuration, Enum.EasingStyle.Quart, Enum.EasingDirection.InOut), {
        BackgroundTransparency = 1
    })
    table.insert(tweens, injectGlowTween)
    
    local exitGlowTween = TweenService:Create(exitGlow, TweenInfo.new(fadeOutDuration, Enum.EasingStyle.Quart, Enum.EasingDirection.InOut), {
        BackgroundTransparency = 1
    })
    table.insert(tweens, exitGlowTween)
    
    -- Dividers
    local dividerTween = TweenService:Create(divider, TweenInfo.new(fadeOutDuration, Enum.EasingStyle.Quart, Enum.EasingDirection.InOut), {
        BackgroundTransparency = 1
    })
    table.insert(tweens, dividerTween)
    
    local bottomDividerTween = TweenService:Create(bottomDivider, TweenInfo.new(fadeOutDuration, Enum.EasingStyle.Quart, Enum.EasingDirection.InOut), {
        BackgroundTransparency = 1
    })
    table.insert(tweens, bottomDividerTween)
    
    -- Glow effects
    local glowTween = TweenService:Create(glowFrame, TweenInfo.new(fadeOutDuration, Enum.EasingStyle.Quart, Enum.EasingDirection.InOut), {
        BackgroundTransparency = 1
    })
    table.insert(tweens, glowTween)
    
    local innerGlowTween = TweenService:Create(innerGlow, TweenInfo.new(fadeOutDuration, Enum.EasingStyle.Quart, Enum.EasingDirection.InOut), {
        BackgroundTransparency = 1,
        BorderColor3 = Color3.new(1, 1, 1)
    })
    table.insert(tweens, innerGlowTween)
    
    -- Logo text
    local logoTween = TweenService:Create(logoText, TweenInfo.new(fadeOutDuration, Enum.EasingStyle.Quart, Enum.EasingDirection.InOut), {
        TextTransparency = 1
    })
    table.insert(tweens, logoTween)
    
    -- Blur effect
    local blurTween = TweenService:Create(blur, TweenInfo.new(fadeOutDuration, Enum.EasingStyle.Quart, Enum.EasingDirection.InOut), {
        Size = 0
    })
    table.insert(tweens, blurTween)
    
    -- Snow particles
    for _, p in ipairs(particles) do
        local t = TweenService:Create(p, TweenInfo.new(fadeOutDuration, Enum.EasingStyle.Quart, Enum.EasingDirection.InOut), {
            BackgroundTransparency = 1
        })
        table.insert(tweens, t)
    end
    
    -- PLAY ALL TWEENS IN PERFECT SYNC
    for _, tween in ipairs(tweens) do
        tween:Play()
    end
    
    -- Wait for all tweens to complete
    task.wait(fadeOutDuration + 0.3)
    
    -- Stop snow
    snowRunning = false
    if snowConnection then snowConnection:Disconnect() end
    
    -- Destroy GUI
    gui:Destroy()
    blur:Destroy()
    
    -- Execute callback if provided
    if callback then
        callback()
    end
end

-- ===== THIS IS WHERE THE MAIN CHEAT SCRIPT GETS LOADED =====
local function LoadMainScript()
    
    -- ===== MAIN CHEAT SCRIPT STARTS HERE =====
    -- This is the full cheat script that gets executed when you click Inject
    
    if not LPH_ENCSTR then
        LPH_ENCSTR = function(str) return str end
    end
    if not LPH_NO_VIRTUALIZE then
        LPH_NO_VIRTUALIZE = function(func) return func end
    end
    if not LPH_OBFUSCATED then
        LPH_OBFUSCATED = false
    end
    local player_service = game["Players"]
    local local_player = player_service["LocalPlayer"]
    -- ts is for the aim accuracy to not get your ass bannned by anti cheat
    local dataFolder = local_player:WaitForChild("DataFolder")

    local shotland = dataFolder:WaitForChild("ShotLand")
    local shotreseter = dataFolder:WaitForChild("ShotReseter")
    local shottotal = dataFolder:WaitForChild("ShotTotal")
    local warning = dataFolder:WaitForChild("Warning")
    local lockflagged = dataFolder:WaitForChild("LockFlagged")

    local gunfiring = local_player.Character.BodyEffects.GunFiring
    local gunshotchanges = local_player.Character.BodyEffects.GunShotChanges

    local ReportersFolder = dataFolder:WaitForChild("Reporters")

    shotland.Value = 0
    shotreseter.Value = 0
    shottotal.Value = 0
    warning.Value = 0
    lockflagged.Value = 0

    shotreseter:GetPropertyChangedSignal("Value"):Connect(function()
        shotreseter.Value = 0
    end)

    shottotal:GetPropertyChangedSignal("Value"):Connect(function()
        shottotal.Value = 0
    end)

    warning:GetPropertyChangedSignal("Value"):Connect(function()
        warning.Value = 0
    end)

    lockflagged:GetPropertyChangedSignal("Value"):Connect(function()
        lockflagged.Value = 0
    end)

    shotland:GetPropertyChangedSignal("Value"):Connect(function()
        shotland.Value = 0
    end)

    task.spawn(function()
        for i = 1, 20 do
            task.wait(0.1)
            pcall(function() shotland.Value = 0 end)
            pcall(function() shotreseter.Value = 0 end)
            pcall(function() shottotal.Value = 0 end)
            pcall(function() warning.Value = 0 end)
            pcall(function() lockflagged.Value = 0 end)
        end
    end)

    gunfiring:GetPropertyChangedSignal("Value"):Connect(function()
        gunfiring.Value = false
    end)

    gunshotchanges:GetPropertyChangedSignal("Value"):Connect(function()
        gunshotchanges.Value = 0
    end)

    ReportersFolder.ChildAdded:Connect(function(child)
        task.wait(0.1)
        pcall(function() child:Destroy() end)
    end)

    for _, reporter in ipairs(ReportersFolder:GetChildren()) do
        pcall(function() reporter:Destroy() end)
    end

    local HttpService = game:GetService("HttpService")
    local Players = game:GetService("Players")
    local Workspace = game.Workspace
    local RunService = game:GetService("RunService")
    local TweenService = game:GetService("TweenService")
    local UserInputService = game:GetService("UserInputService")
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local Self = Players.LocalPlayer
    local Mouse = Self:GetMouse()
    local Camera = game:FindFirstChild("Workspace").CurrentCamera
    local GuiInsetOffsetY = game:GetService('GuiService'):GetGuiInset().Y
    local Script = {
        RBXConnections = {},
        Locals = {},
        Visuals = {}
    }
    local WeaponMap = {}
    local Velocity_Data = {
        Tick = tick(),
        Sample = nil,
        State = Enum.HumanoidStateType.Running,
        Y = nil,
        Recorded = {
            Alpha = nil,
            B_0 = nil,
            V_T = nil,
            V_B = nil
        }
    }
    local aliases = {
        ["[Double-Barrel SG]"] = {"db", "double barrel", "double-barrel", "dbl sg", "double sg", "db sg"},
        ["[TacticalShotgun]"] = {"tac", "tac sg", "tactical shotgun", "tactical sg", "tacshot", "tactical"},
        ["[Drum-Shotgun]"] = {"drum sg", "drum shotgun", "auto sg", "drum auto", "drum"},
        ["[Shotgun]"] = {"sg", "shotgun", "pump", "pump sg", "pump shotgun", "buckshot"},
        ["[Revolver]"] = {"rev", "revolver", "six shooter", "wheel gun", "colt", "magnum"},
        ["[Silencer]"] = {"silencer", "suppressed", "supp pistol", "silenced pistol", "quiet gun"},
        ["[Glock]"] = {"glock", "g17", "glock 17", "pistol", "semi", "9mm"},
        ["[Rifle]"] = {"rifle", "ar", "assault rifle", "m4", "m4a1", "m16"},
        ["[AUG]"] = {"aug", "steyr aug", "bullpup", "aug rifle"},
        ["[AR]"] = {"ar", "assault rifle", "m4", "m4a1", "rifle"},
        ["[SMG]"] = {"smg", "submachine gun", "uzi", "mp5", "mp7", "vector"},
        ["[LMG]"] = {"lmg", "light machine gun", "m249", "saw", "negev"},
        ["[P90]"] = {"p90", "fn p90", "pdw", "personal defense weapon"},
        ["[AK47]"] = {"ak", "ak47", "kalashnikov", "akm", "russian rifle"},
        ["[SilencerAR]"] = {"silencer ar", "suppressed ar", "silenced rifle", "quiet ar"},
        ["[DrumGun]"] = {"drum gun", "tommy gun", "thompson", "drum ar", "drum rifle"}
    }
    for weapon, names in pairs(aliases) do
        for _, alias in ipairs(names) do
            WeaponMap[alias] = weapon
        end
    end
    local Modules = { Cache = {} }
    function Modules.Get(Id)
        if not Modules.Cache[Id] then
            Modules.Cache[Id] = {
                c = Modules[Id](),
            }
        end

        return Modules.Cache[Id].c
    end
    local function InitializeLocals()
        local defaults = {
            LPH_ENCSTR("GunScriptDisabled"), LPH_ENCSTR("SilentAimTarget"), 
            LPH_ENCSTR("AimAssistTarget"), LPH_ENCSTR("IsWalkSpeeding"), LPH_ENCSTR("CurrentWeapon"), 
            LPH_ENCSTR("IsBoxFocused"), LPH_ENCSTR("HitPosition"), LPH_ENCSTR("MoveVector"), LPH_ENCSTR("LastShot"), 
            LPH_ENCSTR("IsAimed"), LPH_ENCSTR("HitPart"), LPH_ENCSTR("CodeRegion"), LPH_ENCSTR("FieldOfViewOne"), LPH_ENCSTR("FieldOfViewTwo")
        }
        
        for _, v in ipairs(defaults) do Script.Locals[v] = nil end
        Script.Locals.LastShot = 0
        Script.Locals.CodeRegion = "Initialization"
        Script.Locals.HitPosition = Vector3.new()
        Script.Locals.IsWalkSpeeding = false 
    end
    local function SetRegion(Region)
        Script.Locals.CodeRegion = Region
    end
    local function GetRegion()
        return Script.Locals.CodeRegion
    end
    InitializeLocals()

    local WeaponInfo = {
        Shotguns = {"[TacticalShotgun]", "[Shotgun]", "[Double-Barrel SG]"},
        AutoShotguns = {"[Drum-Shotgun]"},
        Pistols = {"[Revolver]", "[Silencer]", "[Glock]"},
        Rifles = {"[AR]", "[SilencerAR]", "[AK47]", "[LMG]", "[DrumGun]"},
        Bursts = {"[AUG]"},
        SMG = {"[SMG]", "[P90]"},
        Snipers = {"[Rifle]"},
        Offsets = {
            ["[Double-Barrel SG]"] = CFrame.new(0, 0.35, -2.2),
            ["[TacticalShotgun]"] = CFrame.new(0, 0.25, -2.5),
            ["[Drum-Shotgun]"] = CFrame.new(-0.1, 0.5, -2.5),
            ["[Shotgun]"] = CFrame.new(0, 0.25, -2.5),
            ["[Revolver]"] = CFrame.new(-1, 0.4, 0),
            ["[Silencer]"] = CFrame.new(0, 0.4, 1.3),
            ["[Glock]"] = CFrame.new(0.6, 0.25, 0),
            ["[Rifle]"] = CFrame.new(0, 0.25, 2.5),
            ["[AUG]"] = CFrame.new(-0.1, 0.4, 1.8),
            ["[AR]"] = CFrame.new(2, 0.35, 0),
            ["[SMG]"] = CFrame.new(0, 1, 0.5),
            ["[LMG]"] = CFrame.new(0, 0.7, -3.8),
            ["[P90]"] = CFrame.new(0, 0.2, -1.7),
            ["[AK47]"] = CFrame.new(-0.1, 0.5, -2.5),
            ["[SilencerAR]"] = CFrame.new(2.5, 0.35, 0),
            ["[DrumGun]"] = CFrame.new(0, 0.4, 2.4)
        },
        Delays = {
            ["[Double-Barrel SG]"] = 0.0, ["[TacticalShotgun]"] = 0.0, ["[Drum-Shotgun]"] = 0.415,
            ["[Shotgun]"] = 1.2, ["[Revolver]"] = 0.0, ["[Silencer]"] = 0.0095, ["[Glock]"] = 0.0095,
            ["[Rifle]"] = 1.3095, ["[AUG]"] = 0.0095, ["[AR]"] = 0.15, ["[SMG]"] = 0.6,
            ["[LMG]"] = 0.62, ["[P90]"] = 0.6, ["[AK47]"] = 0.15, ["[SilencerAR]"] = 0.02
        }
    }
    local CurrentFOV, CurrentFOVX, CurrentFOVY = 0, 0, 0
    local SilentAimPart = Instance.new("Part")
    SilentAimPart.Name = math.random(1, 99999999)


    local function GameFunctions()
        SetRegion("Game Functions")
        return {
            IsKnocked = function(Player)
                return Player and Player:FindFirstChild('BodyEffects') and 
                       Player.BodyEffects['K.O'].Value or false
            end,
            IsGrabbed = function(Player)
                return Player and Player.Character and Player.Character:FindFirstChild('GRABBING_CONSTRAINT') ~= nil
            end,
        }
    end
    local Games = {
        [LPH_ENCSTR('Da Hood')] = { HoodGame = true, Functions = GameFunctions() },
    }
    local MarketplaceService = game:GetService("MarketplaceService")
    local Success, Info = pcall(function()
        return MarketplaceService:GetProductInfo(game.PlaceId)
    end)
    local GameName = Success and Info.Name or "Universal"
    local Match
    for Index in pairs(Games) do
        if string.match(GameName, Index) then
            Match = Index
            break
        end
    end
    local CurrentGame = Games[Match] or Games.Universal
    SetRegion("Threading")
    local function ThreadLoop(Wait, Func)
        task.spawn(function()
            while true do
                local Delta = task.wait(Wait)
                local Success, Result = pcall(Func, Delta)
                if not Success then
                    warn("Thread error:", Result)
                elseif Result == "break" then
                    break
                end
            end
        end)
    end

    local function ThreadFunction(Func, Name, ...)
        local WrappedFunc = Name and function()
            local Passed, Statement = pcall(Func)
            if not Passed then
                warn('ThreadFunction Error:\n', '              ' .. Name .. ':', Statement)
            end
        end or Func
        local Thread = coroutine.create(WrappedFunc)
        coroutine.resume(Thread, ...)  
        return Thread
    end

    local function RBXConnection(Signal, Callback)
        local connection = Signal:Connect(Callback)
        Script.RBXConnections[#Script.RBXConnections + 1] = connection
        return connection
    end
    do
        SetRegion("Drawing")
        local CustomLibIndex = 0
        local UtilityUI = Instance.new('ScreenGui'); UtilityUI.Parent = game:GetService("CoreGui"); UtilityUI.IgnoreGuiInset = true
        local UserInputService = game:GetService("UserInputService")
        local Clamp = math.clamp
        local Atan2 = math.atan2
        local Deg = math.deg
        local LibraryMeta = setmetatable({
            Visible = true,
            ZIndex = 0,
            Transparency = 1,
            Color = Color3.new(),
            Remove = function(self)
                setmetatable(self, nil)
            end,
            Destroy = function(self)
                setmetatable(self, nil)
            end
        }, {
            __add = function(t1, t2)
                local result = table.clone(t1)

                for index, value in t2 do
                    result[index] = value
                end
                return result
            end
        })
        local function ClampTransparency(number)
            return Clamp(1 - number, 0, 1)
        end
        function Script.Visuals.new(ClassType)
            CustomLibIndex += 1
            if ClassType == 'Line' then
                local LineObject = ({
                    From = Vector2.zero,
                    To = Vector2.zero,
                    Thickness = 1
                } + LibraryMeta)

                local Line = Instance.new('Frame')

                Line.Name = CustomLibIndex
                Line.AnchorPoint = (Vector2.one * .5)
                Line.BorderSizePixel = 0
                Line.BackgroundColor3 = LineObject.Color
                Line.Visible = LineObject.Visible
                Line.ZIndex = LineObject.ZIndex
                Line.BackgroundTransparency = ClampTransparency(LineObject.Transparency)
                Line.Size = UDim2.new()
                Line.Parent = UtilityUI

                return setmetatable(table.create(0), {
                    __newindex = function(_, Property, Value)
                        if Property == 'From' then
                            local Direction = (LineObject.To - Value)
                            local Center = (LineObject.To + Value) / 2
                            local Magnitude = Direction.Magnitude
                            local Theta = Deg(Atan2(Direction.Y, Direction.X))

                            Line.Position = UDim2.fromOffset(Center.X, Center.Y)
                            Line.Rotation = Theta
                            Line.Size = UDim2.fromOffset(Magnitude, LineObject.Thickness)
                        elseif Property == 'To' then
                            local Direction = (Value - LineObject.From)
                            local Center = (Value + LineObject.From) / 2
                            local Magnitude = Direction.Magnitude
                            local Theta = Deg(Atan2(Direction.Y, Direction.X))

                            Line.Position = UDim2.fromOffset(Center.X, Center.Y)
                            Line.Rotation = Theta
                            Line.Size = UDim2.fromOffset(Magnitude, LineObject.Thickness)
                        elseif Property == 'Thickness' then
                            local Thickness = (LineObject.To - LineObject.From).Magnitude
                            Line.Size = UDim2.fromOffset(Thickness, Value)
                        elseif Property == 'Visible' then
                            Line.Visible = Value
                        elseif Property == 'ZIndex' then
                            Line.ZIndex = Value
                        elseif Property == 'Transparency' then
                            Line.BackgroundTransparency = ClampTransparency(Value)
                        elseif Property == 'Color' then
                            Line.BackgroundColor3 = Value
                        end
                        LineObject[Property] = Value
                    end,
                    __index = function(self, index)
                        if index == 'Remove' or index == 'Destroy' then
                            return function()
                                Line:Destroy()
                                LineObject.Remove(self)
                                return LineObject:Remove()
                            end
                        end
                        return LineObject[index]
                    end,
                    __tostring = function() return 'CustomLib' end
                })
            elseif ClassType == 'Circle' then
                local circleObj = ({
                    Radius = 150,
                    Position = Vector2.zero,
                    Thickness = .7,
                    Filled = false
                } + LibraryMeta)

                local circleFrame, uiCorner, uiStroke = Instance.new('Frame'), Instance.new('UICorner'), Instance.new('UIStroke')
                circleFrame.Name = CustomLibIndex
                circleFrame.AnchorPoint = (Vector2.one * .5)
                circleFrame.BorderSizePixel = 0

                circleFrame.BackgroundTransparency = (circleObj.Filled and ClampTransparency(circleObj.Transparency) or 1)
                circleFrame.BackgroundColor3 = circleObj.Color
                circleFrame.Visible = circleObj.Visible
                circleFrame.ZIndex = circleObj.ZIndex

                uiCorner.CornerRadius = UDim.new(1, 0)
                circleFrame.Size = UDim2.fromOffset(circleObj.Radius, circleObj.Radius)

                uiStroke.Thickness = circleObj.Thickness
                uiStroke.Enabled = not circleObj.Filled
                uiStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

                circleFrame.Parent, uiCorner.Parent, uiStroke.Parent = UtilityUI, circleFrame, circleFrame
                return setmetatable(table.create(0), {
                    __newindex = function(_, index, value)
                        if typeof(circleObj[index]) == 'nil' then return end

                        if index == 'Radius' then
                            local radius = value * 2
                            circleFrame.Size = UDim2.fromOffset(radius, radius)
                        elseif index == 'Position' then
                            circleFrame.Position = UDim2.fromOffset(value.X, value.Y)
                        elseif index == 'Thickness' then
                            value = Clamp(value, .6, 0x7fffffff)
                            uiStroke.Thickness = value
                        elseif index == 'Filled' then
                            circleFrame.BackgroundTransparency = (circleObj.Filled and ClampTransparency(circleObj.Transparency) or 1)
                            uiStroke.Enabled = not value
                        elseif index == 'Visible' then
                            circleFrame.Visible = value
                        elseif index == 'ZIndex' then
                            circleFrame.ZIndex = value
                        elseif index == 'Transparency' then
                            local transparency = ClampTransparency(value)

                            circleFrame.BackgroundTransparency = (circleObj.Filled and transparency or 1)
                            uiStroke.Transparency = transparency
                        elseif index == 'Color' then
                            circleFrame.BackgroundColor3 = value
                            uiStroke.Color = value
                        end
                        circleObj[index] = value
                    end,
                    __index = function(self, index)
                        if index == 'Remove' or index == 'Destroy' then
                            return function()
                                circleFrame:Destroy()
                                circleObj.Remove(self)
                                return circleObj:Remove()
                            end
                        end
                        return circleObj[index]
                    end,
                    __tostring = function() return 'CustomLib' end
                })
            elseif ClassType == 'Square' then
                local squareObj = ({
                    Size = Vector2.zero,
                    Position = Vector2.zero,
                    Thickness = .7,
                    Filled = false,
                    Drag = false,
                } + LibraryMeta)

                local squareFrame, uiStroke = Instance.new('Frame'), Instance.new('UIStroke')
                squareFrame.Name = CustomLibIndex
                squareFrame.BorderSizePixel = 0
                local transparency
                if squareObj.Filled then
                    transparency = ClampTransparency(squareObj.Transparency)
                else
                    transparency = 1
                end
                squareFrame.BackgroundTransparency = transparency
                squareFrame.ZIndex = squareObj.ZIndex
                squareFrame.BackgroundColor3 = squareObj.Color
                squareFrame.Visible = squareObj.Visible
                uiStroke.Thickness = squareObj.Thickness
                uiStroke.Enabled = not squareObj.Filled
                uiStroke.LineJoinMode = Enum.LineJoinMode.Miter
                squareFrame.Parent, uiStroke.Parent = UtilityUI, squareFrame
                local dragging = false
                local dragStart = nil
                local startPos = nil
                squareFrame.MouseEnter:Connect(function()
                    if squareObj.Drag then
                        local inputConnection
                        inputConnection = UserInputService.InputBegan:Connect(function(input)
                            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                                dragging = true
                                dragStart = input.Position
                                startPos = squareFrame.Position
                            end
                        end)
                        local leaveConnection
                        leaveConnection = squareFrame.MouseLeave:Connect(function()
                            inputConnection:Disconnect()
                            leaveConnection:Disconnect()
                        end)
                    end
                end)
                UserInputService.InputChanged:Connect(function(input)
                    if squareObj.Drag then
                        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                            local delta = input.Position - dragStart
                            local newX = startPos.X.Offset + delta.X
                            local newY = startPos.Y.Offset + delta.Y
                            squareFrame.Position = UDim2.new(startPos.X.Scale, newX, startPos.Y.Scale, newY)
                        end
                    end
                end)
                UserInputService.InputEnded:Connect(function(input)
                    if squareObj.Drag then
                        if input.UserInputType == Enum.UserInputType.MouseButton1 then
                            dragging = false
                        end
                    end
                end)
                return setmetatable(table.create(0), {
                    __newindex = function(_, index, value)
                        if typeof(squareObj[index]) == 'nil' then return end

                        if index == 'Size' then
                            squareFrame.Size = UDim2.fromOffset(value.X, value.Y)
                        elseif index == 'Position' then
                            squareFrame.Position = UDim2.fromOffset(value.X, value.Y)
                        elseif index == 'Thickness' then
                            value = Clamp(value, 0.6, 0x7fffffff)
                            uiStroke.Thickness = value
                        elseif index == 'Visible' then
                            squareFrame.Visible = value
                        elseif index == 'Transparency' then
                            local transparency = ClampTransparency(value)
                            squareFrame.BackgroundTransparency = 1
                            uiStroke.Transparency = transparency
                        elseif index == 'Color' then
                            uiStroke.Color = value
                            squareFrame.BackgroundColor3 = value
                        end
                        squareObj[index] = value
                    end,
                    __index = function(self, index)
                        if index == 'Remove' or index == 'Destroy' then
                            return function()
                                squareFrame:Destroy()
                                squareObj.Remove(self)
                                return squareObj:Remove()
                            end
                        end
                        return squareObj[index]
                    end,
                    __tostring = function() return 'CustomLib' end
                })
            elseif ClassType == 'Text' then
                local textObj = ({
                    Text = '',
                    Font = Enum.Font.SourceSansBold,
                    Size = 0,
                    Position = Vector2.zero,
                    Center = false,
                    Outline = false,
                    OutlineColor = Color3.new()
                } + LibraryMeta)

                local textLabel, uiStroke = Instance.new('TextLabel'), Instance.new('UIStroke')
                textLabel.Name = CustomLibIndex
                textLabel.AnchorPoint = (Vector2.one * .5)
                textLabel.BorderSizePixel = 0
                textLabel.BackgroundTransparency = 1
                textLabel.RichText = true
                textLabel.Visible = textObj.Visible
                textLabel.TextColor3 = textObj.Color
                textLabel.TextTransparency = ClampTransparency(textObj.Transparency)
                textLabel.ZIndex = textObj.ZIndex

                textLabel.Font = Enum.Font.SourceSansBold
                textLabel.TextSize = textObj.Size

                textLabel:GetPropertyChangedSignal('TextBounds'):Connect(function()
                    local textBounds = textLabel.TextBounds
                    local offset = textBounds / 2

                    local offsetX
                    if not textObj.Center then
                        offsetX = offset.X
                    else
                        offsetX = 0
                    end

                    textLabel.Position = UDim2.fromOffset(textObj.Position.X + offsetX, textObj.Position.Y + offset.Y)
                end)

                uiStroke.Thickness = 1
                uiStroke.Enabled = textObj.Outline
                uiStroke.Color = textObj.Color

                textLabel.Parent, uiStroke.Parent = UtilityUI, textLabel
                return setmetatable(table.create(0), {
                    __newindex = function(_, index, value)
                        if typeof(textObj[index]) == 'nil' then return end

                        if index == 'Text' then
                            textLabel.Text = value
                        elseif index == 'Font' then
                            value = Clamp(value, 0, 3)
                        elseif index == 'Size' then
                            textLabel.TextSize = value
                        elseif index == 'Position' then
                            local offset = textLabel.TextBounds / 2

                            local offsetX
                            if not textObj.Center then
                                offsetX = offset.X
                            else
                                offsetX = 0
                            end

                            textLabel.Position = UDim2.fromOffset(textObj.Position.X + offsetX, textObj.Position.Y + offset.Y)
                        elseif index == 'Center' then
                            local position
                            if value then
                                position = game:FindFirstChild("Workspace").CurrentCamera.ViewportSize / 2
                            else
                                position = textObj.Position
                            end
                            textLabel.Position = UDim2.fromOffset(position.X, position.Y)
                        elseif index == 'Outline' then
                            uiStroke.Enabled = value
                        elseif index == 'OutlineColor' then
                            uiStroke.Color = value
                        elseif index == 'Visible' then
                            textLabel.Visible = value
                        elseif index == 'ZIndex' then
                            textLabel.ZIndex = value
                        elseif index == 'Transparency' then
                            local transparency = ClampTransparency(value)

                            textLabel.TextTransparency = transparency
                            uiStroke.Transparency = transparency
                        elseif index == 'Color' then
                            textLabel.TextColor3 = value
                        end
                        textObj[index] = value
                    end,
                    __index = function(self, index)
                        if index == 'Remove' or index == 'Destroy' then
                            return function()
                                textLabel:Destroy()
                                textObj.Remove(self)
                                return textObj:Remove()
                            end
                        elseif index == 'TextBounds' then
                            return textLabel.TextBounds
                        end
                        return textObj[index]
                    end,
                    __tostring = function() return 'CustomLib' end
                })
            end
        end
    end
    do
        SetRegion("Game")
        function Script:RayCast(Part, Origin, Ignore, Distance)
            Ignore = Ignore or {}
            Distance = Distance or 2000
            local Direction = (Part.Position - Origin).Unit * Distance
            local Cast = Ray.new(Origin, Direction)
            local Hit = Workspace:FindPartOnRayWithIgnoreList(Cast, Ignore)
            return Hit and Hit:IsDescendantOf(Part.Parent), Hit
        end
        
        function Script:ValidateClient(Player)
            local Object = Player.Character
            local Humanoid = (Object and Object:FindFirstChild("Humanoid")) or false
            local RootPart = (Humanoid and Humanoid.RootPart) or false
            return Object, Humanoid, RootPart
        end

        function Script:GetOrigin(Origin)
            local Object, Humanoid, RootPart = Script:ValidateClient(Self)
            if Origin == 'Head' then
                local Head = Object:FindFirstChild('Head')
                if Head and Head:IsA('RootPart') then
                    return Head.CFrame.Position
                end
            elseif Origin == 'Torso' and RootPart then
                return RootPart.CFrame.Position
            end
            return Workspace.CurrentCamera.CFrame.Position
        end

        function Script:CalculateAngle(v1, v2)
            local dotProduct = v1:Dot(v2)
            local magnitude1 = v1.Magnitude
            local magnitude2 = v2.Magnitude
            local cosTheta = dotProduct / (magnitude1 * magnitude2)
            return math.acos(cosTheta) * (180 / math.pi) 
        end
        
        function Script:GetClosestPlayerToCursor(Max, FOV)
            local CurrentCamera = game:FindFirstChild("Workspace").CurrentCamera
            local MousePosition = UserInputService:GetMouseLocation()
            local Closest
            local Distance = Max or math.huge
            local Conditions = getgenv().saved.Osiris['General']['Checks']
            FOV = FOV or math.huge

            for _, Player in ipairs(Players:GetPlayers()) do
                if (Player == Self) then
                    continue
                end
        
                local Character = Player.Character

                if Player and Player.Character then
                    
                    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")
                    if (not HumanoidRootPart) then
                        continue
                    end

                    local Position, OnScreen = CurrentCamera:WorldToViewportPoint(HumanoidRootPart.Position)

                    if not OnScreen then
                        continue
                    end

                    if Conditions['Visible'] then
                        if not Script:RayCast(Character.HumanoidRootPart, Script:GetOrigin('Camera'), {Self.Character, SilentAimPart}) then
                            continue
                        end
                    end

                    if Conditions['Knocked'] and Player.Character and CurrentGame.Functions.IsKnocked(Player.Character) then
                        continue
                    end

                    if Conditions['Self Knocked'] and CurrentGame.Functions.IsKnocked(Self.Character) then
                        continue
                    end

                    if Conditions['Knocked'] and CurrentGame.Functions.IsGrabbed(Player) then
                        continue
                    end


                    local Magnitude = (Vector2.new(Position.X, Position.Y) - MousePosition).Magnitude
                    if (Magnitude < Distance and Magnitude < FOV) then
                        Closest = Player
                        Distance = Magnitude
                    end
                end
            end
            return Closest
        end
    end
    do
        SetRegion("Gun System")
        function Modules.DaHood()
            if string.find(GameName, "Da Hood") then
                local IsClient = RunService:IsClient()
                local PlaceIDCheck = game.PlaceId == 88976059384565
                local function CanShoot(Character)
                    if Character then
                        local Humanoid = Character:FindFirstChild("Humanoid")
                        if Humanoid and (Humanoid.Health > 0 and Humanoid:GetState() ~= Enum.HumanoidStateType.Dead) then
                            local BodyEffects = Character:FindFirstChild("BodyEffects")
                            if BodyEffects then
                                local Tool = Character:FindFirstChildWhichIsA("Tool")
                                if Tool and (Tool:FindFirstChild("Handle") and Tool:FindFirstChild("Ammo")) then
                                    if not PlaceIDCheck and IsClient then
                                        if BodyEffects:FindFirstChild("Block") then
                                            shared.playerShot(Tool.Handle)
                                            Tool.Handle.NoAmmo:Play()
                                            return
                                        end
                                        if Tool.Ammo.Value == 0 then
                                            Tool.Handle.NoAmmo:Play()
                                            return
                                        end
                                    end
                                    if Character:FindFirstChild("FULLY_LOADED_CHAR") == nil then
                                        return
                                    elseif Character:FindFirstChild("FORCEFIELD") then
                                        return
                                    elseif Character:FindFirstChild("GRABBING_CONSTRAINT") then
                                        return
                                    elseif Character:FindFirstChild("Christmas_Sock") then
                                        return
                                    elseif BodyEffects.Cuff.Value == true then
                                        return
                                    elseif BodyEffects.Attacking.Value == true then
                                        return
                                    elseif BodyEffects["K.O"].Value == true then
                                        return
                                    elseif BodyEffects.Grabbed.Value then
                                        return
                                    elseif BodyEffects.Reload.Value == true then
                                        return
                                    elseif BodyEffects.Dead.Value == true then
                                        return
                                    elseif not Tool:GetAttribute("Cooldown") then
                                        local LastShot = Character:GetAttribute("LastGunShot")
                                        Character:SetAttribute("LastGunShot", Tool.Name)
                                        if not IsClient or (LastShot == Tool.Name or not Character:GetAttribute("ShotgunDebounce")) then
                                            if not IsClient and (not Character:GetAttribute("ShotgunDebounce") and (Tool.Name == "[Shotgun]" or (Tool.Name == "[Double-Barrel SG]" or (Tool.Name == "TacticalShotgun" or Tool.Name == "Drum-Shotgun")))) then
                                                
                                                Character:SetAttribute("ShotgunDebounce", true)
                                                task.delay(0.65, function()
                                                    Character:SetAttribute("ShotgunDebounce", nil)
                                                end)
                                            end
                                            return true
                                        end
                                    end
                                else
                                    return
                                end
                            else
                                return
                            end
                        else
                            return
                        end
                    else
                        return
                    end
                end


                local function ColorTransform(p14, p15)
                    if p15 == 0 then
                        return p14.Keypoints[1].Value
                    end
                    if p15 == 1 then
                        return p14.Keypoints[#p14.Keypoints].Value
                    end
                    for v16 = 1, #p14.Keypoints - 1 do
                        local v17 = p14.Keypoints[v16]
                        local v18 = p14.Keypoints[v16 + 1]
                        if v17.Time <= p15 and p15 < v18.Time then
                            local v19 = (p15 - v17.Time) / (v18.Time - v17.Time)
                            return Color3.new((v18.Value.R - v17.Value.R) * v19 + v17.Value.R, (v18.Value.G - v17.Value.G) * v19 + v17.Value.G, (v18.Value.B - v17.Value.B) * v19 + v17.Value.B)
                        end
                    end
                end

                local replicatedStorage = game:GetService("ReplicatedStorage")
                local playersService = game:GetService("Players")
                local localPlayer = playersService.LocalPlayer
                local playerCharacter = Self.Character or Self.CharacterAdded:Wait()
                local shootAnimation = playerCharacter.Humanoid.Animator:LoadAnimation(
                    replicatedStorage:WaitForChild("Animations"):WaitForChild("GunCombat"):WaitForChild("Shoot")
                )
                local aimShootAnimation = playerCharacter.Humanoid.Animator:LoadAnimation(
                    replicatedStorage:WaitForChild("Animations"):WaitForChild("GunCombat"):WaitForChild("AimShoot")
                )
                
                local v_u_14 = { MouseButton2 = {} }
        
                local function changefunc()
                    local v_u_38 = {
                        ["functions"] = {},
                    }

                    function v_u_38.connect(_, p36)
                        local v37 = v_u_38.functions
                        table.insert(v37, p36)
                    end
                    local v_u_39 = nil
                    function v_u_38.updatechanges(_, p_u_40)
                        for _, v_u_41 in pairs(v_u_38.functions) do
                            spawn(function()
                                v_u_41(p_u_40.Press, p_u_40.Time, v_u_39)
                            end)
                        end
                        v_u_39 = p_u_40.Time
                    end
                    return v_u_38
                end


                setmetatable(v_u_14, {
        ["__index"] = function(_, p42)
            local v43 = v_u_14
            if getmetatable(v43)[p42] == nil then
                v_u_14[p42] = {}
            end
            local v44 = v_u_14
            return getmetatable(v44)[p42]
        end,
        ["__newindex"] = function(_, p45, p46)
            local v47 = v_u_14
            if getmetatable(v47)[p45] == nil then
                local v48 = v_u_14
                getmetatable(v48)[p45] = {
                    ["val"] = p46,
                    ["changed"] = changefunc()
                }
            else
                local v49 = v_u_14
                getmetatable(v49)[p45].val = p46
                local v50 = v_u_14
                getmetatable(v50)[p45].changed:updatechanges(p46)
            end
        end
    })

    UserInputService.InputBegan:connect(function(p51, p52)
        if not p52 or (p51.UserInputType == Enum.UserInputType.Keyboard and p51.KeyCode == Enum.KeyCode.LeftShift) or (p51.UserInputType == Enum.UserInputType.Gamepad1 and p51.KeyCode == Enum.KeyCode.ButtonL2) then
            if p51.UserInputType == Enum.UserInputType.Keyboard or p51.UserInputType == Enum.UserInputType.Gamepad1 then
                v_u_14[p51.KeyCode.Name] = {
                    ["Press"] = true,
                    ["Time"] = tick()
                }
                return
            end
        end
        if p51.UserInputType == Enum.UserInputType.MouseButton2 then
            v_u_14[Enum.UserInputType.MouseButton2.Name] = {
                ["Press"] = true,
                ["Time"] = tick()
            }
        end
    end)

    UserInputService.InputEnded:connect(function(p53, p54)
        if not p54 or (p53.UserInputType == Enum.UserInputType.Keyboard and p53.KeyCode == Enum.KeyCode.LeftShift) or (p53.UserInputType == Enum.UserInputType.Gamepad1 and p53.KeyCode == Enum.KeyCode.ButtonL2) then
            if p53.UserInputType == Enum.UserInputType.Keyboard or p53.UserInputType == Enum.UserInputType.Gamepad1 then
                v_u_14[p53.KeyCode.Name] = {
                    ["Press"] = false,
                    ["Time"] = tick()
                }
                return
            end
        end
        if p53.UserInputType == Enum.UserInputType.MouseButton2 then
            v_u_14[Enum.UserInputType.MouseButton2.Name] = {
                ["Press"] = false,
                ["Time"] = tick()
            }
        end
    end)

    local v_u_70 = true

    if not v_u_14.MouseButton2 then
        v_u_14.MouseButton2 = {}
    end
    if not v_u_14.MouseButton2.changed then
        v_u_14.MouseButton2.changed = changefunc()
    end

    v_u_14.MouseButton2.changed:connect(function(p71, _, _)
        if v_u_70 ~= false then
            Script.Locals.IsAimed = p71
            if Script.Locals.IsAimed == false then
                v_u_70 = false
                wait(0.1)
                v_u_70 = true
            end
        end
    end)

    local function Animate(target)
        if Script.Locals.IsAimed then
            return
        end
        
        playerCharacter = localPlayer.Character or localPlayer.CharacterAdded:Wait()
        if playerCharacter and playerCharacter:FindFirstChild("Humanoid") and playerCharacter.Humanoid:FindFirstChild("Animator") then
            if shootAnimation and shootAnimation.IsPlaying then
                shootAnimation:Stop()
            end
            if aimShootAnimation and aimShootAnimation.IsPlaying then
                aimShootAnimation:Stop()
            end
            
            shootAnimation = playerCharacter.Humanoid.Animator:LoadAnimation(replicatedStorage.Animations.GunCombat.Shoot)
            aimShootAnimation = playerCharacter.Humanoid.Animator:LoadAnimation(replicatedStorage.Animations.GunCombat.AimShoot)
            
            shootAnimation:Play()
            
            task.delay(0.01, function()
                if shootAnimation and shootAnimation.IsPlaying then
                    shootAnimation:Stop()
                end
            end)
        end
    end
 
                shared.playerShot = Animate
                local v3 = game:GetService("Players")
                local v_u_5 = game:GetService("TweenService")
                local v_u_7 = v3.LocalPlayer
                local v_u_9 = ReplicatedStorage.SkinAssets
                local v_u_13 = game:FindFirstChild("Workspace"):GetServerTimeNow()
                local _ = game.PlaceId == 88976059384565
                local SoundsPlaying = {}
        
                
                local function GetAim(Position)
            
                    if _G.MobileShiftLock then
                        return (Camera.CFrame.p + Camera.CFrame.LookVector * 60 - Position).unit
                    end
                    local v24
                    if Mouse.Target then
                        v24 = Mouse.Hit.p
                    else
                        local v25 = Camera.CFrame
                        local v26 = v25.p + v25.LookVector * 60
                        local v27 = v25.LookVector
                        local v28 = Camera:ScreenPointToRay(Mouse.X, Mouse.Y)
                        local v29 = v28.Direction
                        local v30 = v28.Origin
                        v24 = v30 + v29 * ((v26 - v30):Dot(v27) / v29:Dot(v27))
                    end
                    return (v24 - Position).Unit, (v24 - Position).Magnitude
                end
                
                local function ShootGun(p34)
                
                    local v35 = p34.Shooter
                    local v_u_36 = p34.Handle
                    local v37 = p34.AimPosition
                    local v38 = p34.BeamColor
                    local v39 = p34.isReflecting
                    local v40 = p34.Hit
                    local v41 = p34.Range or 200
                    local LegitPosition = p34.LegitPosition
                    local v_u_42
                    if v_u_36 then
                        v_u_42 = v_u_36:GetAttribute("SkinName")
                    else
                        v_u_42 = v_u_36
                    end
                    local _, v43 = GetAim(v_u_36.Position)
                    local v_u_44 = p34.ForcedOrigin or v_u_36.Muzzle.WorldPosition
                    local v45 = (v37 - v_u_44).Unit
                    local v46 = RaycastParams.new()
                    local v47 = {}
                    local function set_list(targetTable, index, values)
                        for i, v in ipairs(values) do
                            targetTable[index + i - 1] = v
                        end
                    end
                    
                    local v48 = { game:FindFirstChild("Workspace"):WaitForChild("Bush"), game:FindFirstChild("Workspace"):WaitForChild("Ignored"), SilentAimPart }
                    set_list(v47, 1, {v35, unpack(v48)})
                    
                    v46.FilterDescendantsInstances = v47
                    v46.FilterType = Enum.RaycastFilterType.Exclude
                    v46.IgnoreWater = true
                    local v_u_49, v_u_50, v_u_51
                    if v40 then
                        v_u_49 = p34.Hit
                        v_u_50 = p34.AimPosition
                        v_u_51 = p34.Normal
                    else
                        local v52 = game:FindFirstChild("Workspace"):Raycast(v_u_44, v45 * v41, v46)
                        if v52 then
                            v_u_49 = v52.Instance
                            v_u_50 = v52.Position
                            v_u_51 = v52.Normal
                        else
                            v_u_50 = v_u_44 + v45 * math.min(v43, v41)
                            v_u_51 = nil
                            v_u_49 = nil
                        end
                    end
                    
                    
                    local v_u_53 = Instance.new("Part")
                    v_u_53:SetAttribute("OwnerCharacter", v35.Name)
                    v_u_53.Name = "BULLET_RAYS"
                    v_u_53.Anchored = true
                    v_u_53.CanCollide = false
                    v_u_53.Size = Vector3.new(0, 0, 0)
                    v_u_53.Transparency = 1
                    game.Debris:AddItem(v_u_53, 1)
                    if getgenv().saved.Osiris['General']['Silent Aim Misc']['Anti Curve Mode'] then
                        v_u_53.CFrame = CFrame.new(v_u_44, LegitPosition)
                    else
                        v_u_53.CFrame = CFrame.new(v_u_44, v_u_50)
                    end
                    v_u_53.Material = Enum.Material.SmoothPlastic
                    v_u_53.Parent = game:FindFirstChild("Workspace").Ignored.Siren.Radius
                    local v54 = Instance.new("Attachment")
                    v54.Position = Vector3.new(0, 0, 0)
                    v54.Parent = v_u_53
                    local v55 = Instance.new("Attachment")
                    local v56 = -(v_u_50 - v_u_44).magnitude
                    v55.Position = Vector3.new(0, 0, v56)
                    v55.Parent = v_u_53
                    local v_u_57 = false
                    local v_u_58 = nil
                    local v59
                    if v_u_36 then
                        local v60 = v_u_36.Parent.Name
                        if v_u_42 and v_u_42 ~= "" then
                            if v_u_9.GunSkinMuzzleParticle:FindFirstChild(v_u_42) then
                                if not v39 then
                                    if v_u_9.GunSkinMuzzleParticle[v_u_42]:FindFirstChild("Muzzle") then
                                        if v_u_36.Parent:FindFirstChild("Default") and (v_u_36.Parent.Default:FindFirstChild("Mesh") and v_u_36.Parent.Default.Mesh:FindFirstChild("Muzzle")) then
                                            local v61
                                            if v_u_9.GunSkinMuzzleParticle[v_u_42].Muzzle:FindFirstChild("Different_GunMuzzle") then
                                                v61 = v_u_9.GunSkinMuzzleParticle[v_u_42].Muzzle.Different_GunMuzzle[v60]
                                            else
                                                v61 = v_u_9.GunSkinMuzzleParticle[v_u_42].Muzzle
                                            end
                                            for _, v62 in pairs(v61:GetChildren()) do
                                                local v63 = v62:GetAttribute("EmitCount") or 1
                                                local v_u_64 = v62:Clone()
                                                v_u_64.Parent = v_u_36.Parent.Default.Mesh.Muzzle
                                                v_u_64:Emit(v63)
                                                task.delay(v_u_64.Lifetime.Max, function()
                                                    v_u_64:Destroy()
                                                end)
                                            end
                                        end
                                    else
                                        local v65 = v_u_9.GunSkinMuzzleParticle[v_u_42]:GetChildren()
                                        local v66 = v65[math.random(#v65)]:Clone()
                                        v66.Parent = v54
                                        v66:Emit(v66.Rate)
                                    end
                                end
                                v_u_57 = true
                            end
                            if v_u_9.GunBeam:FindFirstChild(v_u_42) then
                                if v_u_9.GunBeam[v_u_42].GunBeam:IsA("BasePart") then
                                    v59 = {
                                        ["Parent"] = nil,
                                        ["Attachment0"] = nil,
                                        ["Attachment1"] = nil
                                    }
                                    if v_u_9.GunBeam[v_u_42].GunBeam:FindFirstChild("Different_GunBeam") then
                                        if v_u_9.GunBeam[v_u_42].GunBeam.Different_GunBeam[v60].GunBeam:IsA("BasePart") then
                                            v_u_58 = v_u_9.GunBeam[v_u_42].GunBeam.Different_GunBeam[v60].GunBeam:Clone()
                                        else
                                            v59 = v_u_9.GunBeam[v_u_42].GunBeam.Different_GunBeam[v60].GunBeam:Clone()
                                        end
                                    else
                                        v_u_58 = v_u_9.GunBeam[v_u_42].GunBeam:Clone()
                                    end
                                else
                                    v59 = v_u_9.GunBeam[v_u_42].GunBeam:Clone()
                                end
                            else
                                v59 = game.ReplicatedStorage.GunBeam:Clone()
                                v59.Color = v38 and ColorSequence.new(v38) or v59.Color
                            end
                        else
                            v59 = game.ReplicatedStorage.GunBeam:Clone()
                            v59.Color = v38 and ColorSequence.new(v38) or v59.Color
                        end
                    else
                        v59 = nil
                    end
                    task.spawn(function()
                        if v_u_58 then
                            local v67 = (v_u_50 - v_u_44).magnitude
                            local v68 = v67 / 725
                            v_u_58.Anchored = true
                            v_u_58.CanCollide = false
                            v_u_58.CanQuery = false
                            v_u_58.CFrame = CFrame.new(v_u_44, v_u_50)
                            local v69 = v_u_58.CFrame * CFrame.new(0, 0, -v67)
                            v_u_58.Parent = game:FindFirstChild("Workspace").Ignored.Siren.Radius
                            task.delay(v68 + 5, function()
                                v_u_58:Destroy()
                                v_u_58 = nil
                            end)
                            if v_u_58:GetAttribute("SpecialEffects") then
                                for _, v70 in pairs(v_u_58:GetDescendants()) do
                                    if v70:IsA("Trail") and v70:GetAttribute("ColorRandom") then
                                        local v71 = v70:GetAttribute("ColorRandom")
                                        v70.Color = ColorSequence.new(ColorTransform(v71, math.random()))
                                    end
                                end
                            end
                            local v72 = game:GetService("TweenService"):Create(v_u_58, TweenInfo.new(0.05, Enum.EasingStyle.Linear), {
                                ["CFrame"] = v_u_58.CFrame * CFrame.new(0, 0, -0.1)
                            })
                            v72:Play()
                            task.wait(0.05)
                            if v72.PlaybackState ~= Enum.PlaybackState.Completed then
                                v72:Pause()
                            end
                            local v73 = nil
                            if _G.Reduce_Lag and not v_u_58:GetAttribute("NoSlow") or v_u_58:GetAttribute("LOWGFX") then
                                v_u_58.CFrame = v69
                            else
                                v73 = game:GetService("TweenService"):Create(v_u_58, TweenInfo.new(v68, Enum.EasingStyle.Linear), {
                                    ["CFrame"] = v69
                                })
                                v73:Play()
                                task.wait(v68)
                            end
                            if v_u_58:FindFirstChild("Impact") and (v_u_49 and (v_u_51 and not v_u_49.Parent:FindFirstChild("Humanoid"))) then
                                if v73 and v73.PlaybackState ~= Enum.PlaybackState.Completed then
                                    task.wait(0.05)
                                end
                                if not v_u_58:FindFirstChild("NoNormal") then
                                    v_u_58.CFrame = CFrame.new(v_u_50, v_u_50 - v_u_51)
                                end
                                for _, v74 in pairs(v_u_58.Impact:GetChildren()) do
                                    if v74:IsA("ParticleEmitter") then
                                        v74:Emit(v74:GetAttribute("EmitCount") or 1)
                                    end
                                end
                            else
                                for _, v75 in pairs(v_u_58:GetChildren()) do
                                    if v75:IsA("BasePart") then
                                        v75.Transparency = 1
                                    end
                                end
                            end
                            if v_u_58 then
                                for _, v76 in pairs(v_u_58:GetDescendants()) do
                                    if v76:IsA("ParticleEmitter") then
                                        v76.Enabled = false
                                    end
                                end
                            end
                        elseif v_u_49 and (v_u_49:IsDescendantOf(game:FindFirstChild("Workspace").MAP) and (v_u_42 and (v_u_9.GunBeam:FindFirstChild(v_u_42) and v_u_9.GunBeam[v_u_42]:FindFirstChild("Impact")))) then
                            local v_u_77 = v_u_9.GunBeam[v_u_42].Impact:Clone()
                            v_u_77.Parent = game:FindFirstChild("Workspace").Ignored
                            v_u_77:PivotTo(CFrame.new(v_u_50, v_u_50 + v_u_51 * 5) * CFrame.Angles(-1.5707963267948966, 0, 0))
                            for _, v78 in pairs(v_u_77:GetDescendants()) do
                                if v78:IsA("ParticleEmitter") then
                                    v78:Emit(v78:GetAttribute("EmitCount") or 1)
                                end
                            end
                            task.delay(1.5, function()
                                v_u_77:Destroy()
                                v_u_77 = nil
                            end)
                        end
                        local v79 = Instance.new("PointLight")
                        v79.Brightness = 0.5
                        v79.Range = 15
                        v79.Shadows = true
                        v79.Color = Color3.new(1, 1, 1)
                        v79.Parent = v_u_53
                        local v80 = v_u_36:FindFirstChild("ShootBBGUI")
                        local v81 = v80 and (not v_u_57 and v80:FindFirstChild("Shoot"))
                        if v81 then
                            v81.Size = UDim2.new(0, 0, 0, 0)
                            v81.ImageTransparency = 1
                            v81.Visible = true
                            v_u_5:Create(v81, TweenInfo.new(0.4, Enum.EasingStyle.Bounce, Enum.EasingDirection.In, 0, false, 0), {
                                ["Size"] = UDim2.new(1, 0, 1, 0),
                                ["ImageTransparency"] = 0.4
                            }):Play()
                            v_u_5:Create(v79, TweenInfo.new(0.4, Enum.EasingStyle.Bounce, Enum.EasingDirection.In, 0, false, 0), {
                                ["Range"] = 0
                            }):Play()
                            wait(0.4)
                            v_u_53:Destroy()
                            v_u_5:Create(v81, TweenInfo.new(0.2, Enum.EasingStyle.Bounce, Enum.EasingDirection.In, 0, false, 0), {
                                ["Size"] = UDim2.new(1, 0, 1, 0),
                                ["ImageTransparency"] = 1
                            }):Play()
                            wait(0.2)
                            v81.Visible = false
                        end
                    end)
                    v59.Attachment0 = v54
                    v59.Attachment1 = v55
                    v59.Name = "NewGunBeam"
                    v59.Parent = v_u_53
                    if v35 == v_u_7.Character and game:FindFirstChild("Workspace"):GetServerTimeNow() - v_u_13 > 0.95 then
                        Animate(v_u_36)
                    end
                    local playsound = function(p1, p2)
                        local v3 = p1.ShootSound:GetAttribute("SequenceSFX")
                        if v3 then
                            if p1.ShootSound:GetAttribute("CurrentSequence") == nil then
                                p1.ShootSound:SetAttribute("CurrentSequence", 1)
                            else
                                p1.ShootSound:SetAttribute("CurrentSequence", p1.ShootSound:GetAttribute("CurrentSequence") + 1)
                            end
                            local v4 = p1.ShootSound:GetAttribute("CurrentSequence")
                            local v5 = {}
                            for v6 in string.gmatch(v3, "%d+") do
                                table.insert(v5, v6)
                            end
                            p1.ShootSound.SoundId = "rbxassetid://" .. v5[v4 % #v5 + 1]
                        end
                        if p2 then
                            local v_u_7 = p1.ShootSound:Clone()
                            v_u_7.Name = "MG"
                            v_u_7.Parent = p1
                            v_u_7:Play()
                            delay(1, function()
                                v_u_7:Destroy()
                            end)
                        else
                            p1.ShootSound:Play()
                        end
                    end    

                    if not SoundsPlaying[v_u_36] then
                        task.spawn(playsound, v_u_36, true)
                        SoundsPlaying[v_u_36] = true
                        task.delay(0.021, function()
                            SoundsPlaying[v_u_36] = nil
                        end)
                    end
                    if game.Lighting:GetAttribute("printhits") then
                        local v82 = print
                        local v83 = v_u_49
                        if v83 then
                            v83 = v_u_49:GetFullName()
                        end
                        v82(v83)
                    end
                    return v_u_50, v_u_49, v_u_51
                end
                return {
                    CanShoot = CanShoot,
                    Animate = Animate,
                    GetAim = GetAim,
                    ColorTransform = ColorTransform,
                    ShootGun = ShootGun,
                }
            else
                return {}
            end
        end
    end
    do
        SetRegion("Main")
        local DaHood = Modules.Get("DaHood")
        function Script:GetClosestPointOnPart(Part, Scale)
            local PartCFrame = Part.CFrame
            local PartSize = Part.Size
            local PartSizeTransformed = PartSize * (Scale / 2)

            local MousePosition = UserInputService:GetMouseLocation()
            local CurrentCamera = Workspace.CurrentCamera

            local MouseRay = CurrentCamera:ViewportPointToRay(MousePosition.X, MousePosition.Y)
            local Transformed = PartCFrame:PointToObjectSpace(MouseRay.Origin + (MouseRay.Direction * MouseRay.Direction:Dot(PartCFrame.Position - MouseRay.Origin)))

            if (Mouse.Target == Part) then
                return Vector3.new(Mouse.Hit.X, Mouse.Hit.Y, Mouse.Hit.Z)
            end

            return PartCFrame * Vector3.new(
                math.clamp(Transformed.X, -PartSizeTransformed.X, PartSizeTransformed.X),
                math.clamp(Transformed.Y, -PartSizeTransformed.Y, PartSizeTransformed.Y),
                math.clamp(Transformed.Z, -PartSizeTransformed.Z, PartSizeTransformed.Z)
            )
        end

        function Script:GetClosestPointOnPartBasic(Part)
            if Part then
                local MouseRay = Mouse.UnitRay
                MouseRay = MouseRay.Origin + (MouseRay.Direction * (Part.Position - MouseRay.Origin).Magnitude)
                local Point = (MouseRay.Y >= (Part.Position - Part.Size / 2).Y and MouseRay.Y <= (Part.Position + Part.Size / 2).Y) and (Part.Position + Vector3.new(0, -Part.Position.Y + MouseRay.Y, 0)) or Part.Position
                local Check = RaycastParams.new()
                Check.FilterType = Enum.RaycastFilterType.Whitelist
                Check.FilterDescendantsInstances = {Part}
                local Ray = Workspace:Raycast(MouseRay, (Point - MouseRay), Check)

                if Mouse.Target == Part then
                    return Mouse.Hit.Position
                end

                if Ray then
                    return Ray.Position
                else
                    return Mouse.Hit.Position
                end
            end 
        end

        function Script:GetClosestPartToCursor(Character)
            local CurrentCamera = Workspace.CurrentCamera
            local Closest
            local Distance = 1/0
            for _, Part in ipairs(Character:GetChildren()) do
                if (not Part:IsA("BasePart")) then
                    continue
                end

                local Position = CurrentCamera:WorldToViewportPoint(Part.Position)
                Position = Vector2.new(Position.X, Position.Y)
                local Magnitude = (UserInputService:GetMouseLocation() - Position).Magnitude

                if (Magnitude < Distance) then
                    Closest = Part
                    Distance = Magnitude
                end
            end

            return Closest
        end
        
        function Script:GetClosestPartToCursorFilter(Character, PartsToCheck)
            local CurrentCamera = Workspace.CurrentCamera
            local Closest = nil
            local Distance = 1/0
            
            for _, Part in ipairs(Character:GetChildren()) do
                if not Part:IsA("BasePart") or (PartsToCheck and not table.find(PartsToCheck, Part.Name)) then
                    continue
                end
        
                local Position = CurrentCamera:WorldToViewportPoint(Part.Position)
                Position = Vector2.new(Position.X, Position.Y)
                local Magnitude = (UserInputService:GetMouseLocation() - Position).Magnitude
        
                if Magnitude < Distance then
                    Closest = Part
                    Distance = Magnitude
                end
            end
        
            return Closest
        end

        function Script:GetResolvedVelocity(Part)
            local LastPosition = Part.Position
            task.wait(0.085)
            local CurrentPosition = Part.Position
            local Velocity = (CurrentPosition - LastPosition) / 0.085
            return Velocity
        end

        local smoothedVelocity = Vector3.new(0, 0, 0)  
        
        local function getDynamicSmoothingFactor(velocityMagnitude)
            if velocityMagnitude < 5 then
                return 0.05  
            elseif velocityMagnitude < 20 then
                return 0.1
            else
                return 0.2 
            end
        end
        
        local function GetResolvedVelocity(Part)
            local LastPosition = Part.Position
            task.wait(0.085)
            local CurrentPosition = Part.Position
            local Velocity = (CurrentPosition - LastPosition) / 0.085
        
            local velocityMagnitude = Velocity.Magnitude
            local dynamicSmoothing = getDynamicSmoothingFactor(velocityMagnitude)
        
            smoothedVelocity = smoothedVelocity * (1 - dynamicSmoothing) + Velocity * dynamicSmoothing
        
            return smoothedVelocity * Vector3.new(1, 0, 1)
        end
        
    function Script:GetHitPosition(Mode)
        if Mode == 'Assist' then
            local Osiris = getgenv().saved.Osiris['Aim Assist']
            local Object = Script.Locals.AimAssistTarget.Character
            if not Object then return end  
        
            local Humanoid = Object:FindFirstChild("Humanoid")
            if not Humanoid then return end 
        
            local NearestPart = Script:GetClosestPartToCursor(Object)
            if not NearestPart then return end
            
            local HitPosition
        
            -- Custom Parts OVERRIDES Hit Part when enabled
            if Osiris['Custom Parts'] and Osiris['Custom Parts']['Enabled'] then
                local customParts = Osiris['Custom Parts']['Parts'] or {}
                local mode = Osiris['Custom Parts']['Mode'] or "Point"
                
                if mode == "Point" then
                    -- Find the closest custom part to cursor and get nearest point on it (GLIDES)
                    local closestPart = Script:GetClosestPartToCursorFilter(Object, customParts)
                    if closestPart then
                        if Osiris['Nearest Point']['Mode'] == 'Smart' then
                            HitPosition = Script:GetClosestPointOnPart(closestPart, Osiris['Nearest Point']['Scale'])
                        else
                            HitPosition = Script:GetClosestPointOnPartBasic(closestPart)
                        end
                    else
                        -- Fallback to nearest point on any part
                        if Osiris['Nearest Point']['Mode'] == 'Smart' then
                            HitPosition = Script:GetClosestPointOnPart(NearestPart, Osiris['Nearest Point']['Scale'])
                        else
                            HitPosition = Script:GetClosestPointOnPartBasic(NearestPart)
                        end
                    end
                elseif mode == "Part" then
                    -- WORKS LIKE "Nearest Part" - aims at CENTER of closest part from custom list
                    local closestPart = nil
                    local closestDistance = math.huge
                    
                    for _, partName in ipairs(customParts) do
                        local part = Object:FindFirstChild(partName)
                        if part and part:IsA("BasePart") then
                            local pos, onScreen = Camera:WorldToViewportPoint(part.Position)
                            if onScreen then
                                local mousePos = UserInputService:GetMouseLocation()
                                local distance = (Vector2.new(pos.X, pos.Y) - mousePos).Magnitude
                                if distance < closestDistance then
                                    closestDistance = distance
                                    closestPart = part
                                end
                            end
                        end
                    end
                    
                    if closestPart then
                        -- AIM AT CENTER of the closest part (like "Nearest Part")
                        HitPosition = closestPart.Position
                    else
                        -- Fallback to regular Nearest Part behavior
                        HitPosition = NearestPart.Position
                    end
                end
            else
                -- Custom Parts is DISABLED, so use normal Hit Part setting
                if Osiris['Hit Part'] == 'Nearest Point' then
                    local NearestPoint
                    if Osiris['Nearest Point']['Mode'] == 'Smart' then
                        NearestPoint = Script:GetClosestPointOnPart(NearestPart, Osiris['Nearest Point']['Scale'])
                    else
                        NearestPoint = Script:GetClosestPointOnPartBasic(NearestPart)
                    end
                    HitPosition = NearestPoint
            
                elseif Osiris['Hit Part'] == 'Nearest Part' then
                    HitPosition = NearestPart.Position
            
                elseif typeof(Osiris['Hit Part']) == 'table' then
                    local part = Script:GetClosestPartToCursorFilter(Object, Osiris['Hit Part'])
                    if part then
                        HitPosition = part.Position
                    else
                        HitPosition = NearestPart.Position
                    end
            
                else
                    local targetPart = Object:FindFirstChild(Osiris['Hit Part'])
                    if targetPart then
                        HitPosition = targetPart.Position
                    else
                        HitPosition = NearestPart.Position
                    end
                end
            end
        
            -- Prediction applies regardless of what targeting mode is used
            if Osiris['Prediction']['Enabled'] then
                local BasePrediction = Vector3.new(Osiris['Prediction']['X'], Osiris['Prediction']['Y'], Osiris['Prediction']['Z'])
                local Prediction = HitPosition + Script:GetResolvedVelocity(Object.HumanoidRootPart) * BasePrediction
        
                return Prediction
            else
                return HitPosition
            end
        end -- <-- THIS END WAS MISSING!
        
        if Mode == 'Silent' then 
            local Osiris = getgenv().saved.Osiris['Silent Aim']
            local Object = Script.Locals.SilentAimTarget.Character
            if not Object then return end  
            
            local Humanoid = Object:FindFirstChild("Humanoid")
            if not Humanoid then return end 
            
            local NearestPart = Script:GetClosestPartToCursor(Object)
            if not NearestPart then return end
            
            local HitPosition
            local HitPart = Osiris['Hit Part']
            
            if HitPart == 'Nearest Point' then
                local NearestPoint
                if Osiris['Nearest Point']['Mode'] == 'Smart' then
                    NearestPoint = Script:GetClosestPointOnPart(NearestPart, Osiris['Nearest Point']['Scale'])
                else
                    NearestPoint = Script:GetClosestPointOnPartBasic(NearestPart)
                end
                HitPosition = NearestPoint
            
            elseif HitPart == 'Nearest Part' then
                HitPosition = NearestPart.Position
            
            elseif typeof(HitPart) == 'table' then
                local part = Script:GetClosestPartToCursorFilter(Object, HitPart)
                if part then
                    HitPosition = part.Position
                else
                    HitPosition = NearestPart.Position
                end
            
            else
                local targetPart = Object:FindFirstChild(HitPart)
                if targetPart then
                    HitPosition = targetPart.Position
                else
                    HitPosition = NearestPart.Position
                end
            end
            
            -- Prediction for Silent Aim
            if Osiris['Prediction'] and Osiris['Prediction']['Enabled'] then
                local BasePrediction = Vector3.new(Osiris['Prediction']['X'] or 0, Osiris['Prediction']['Y'] or 0, Osiris['Prediction']['Z'] or 0)
                local Prediction = HitPosition + Script:GetResolvedVelocity(Object.HumanoidRootPart) * BasePrediction
                return Prediction
            else
                return HitPosition
            end
        end    
        end 
        if Mode == 'Silent' then 
            local Osiris = getgenv().saved.Osiris['Silent Aim']
            local Object = Script.Locals.SilentAimTarget.Character
            if not Object then return end  
            
            local Humanoid = Object:FindFirstChild("Humanoid")
            if not Humanoid then return end 
            
            local NearestPart = Script:GetClosestPartToCursor(Object)
            local HitPosition
            
            local HitPart = Osiris['Hit Part']
            
            if HitPart == 'Nearest Point' then
                local NearestPoint
                if Osiris['Nearest Point']['Mode'] == 'Smart' then
                    NearestPoint = Script:GetClosestPointOnPart(NearestPart, Osiris['Nearest Point']['Scale'])
                else
                    NearestPoint = Script:GetClosestPointOnPartBasic(NearestPart)
                end
                HitPosition = NearestPoint
            
            elseif HitPart == 'Nearest Part' then
                HitPosition = NearestPart.Position
            
            elseif typeof(HitPart) == 'table' then
                local part = Script:GetClosestPartToCursorFilter(Object, HitPart)
                if part then
                    HitPosition = part.Position
                else
                    HitPosition = NearestPart.Position
                end
            
            else
                local targetPart = Object:FindFirstChild(HitPart)
                if targetPart then
                    HitPosition = targetPart.Position
                else
                    HitPosition = NearestPart.Position
                end
            end 
            -- Prediction applies regardless of what targeting mode is used
            if Osiris['Prediction']['Enabled'] then
                local BasePrediction = Vector3.new(Osiris['Prediction']['X'], Osiris['Prediction']['Y'], Osiris['Prediction']['Z'])
                local Prediction = HitPosition + Script:GetResolvedVelocity(Object.HumanoidRootPart) * BasePrediction
        
                return Prediction
            else
                return HitPosition
            end
        end

        function Script:UpdateBox()
            if Script.Locals.SilentAimTarget and Script.Locals.SilentAimTarget.Character then
                local Object, Humanoid, RootPart = Script:ValidateClient(Script.Locals.SilentAimTarget)
                if (Object and Humanoid and RootPart) then		
                    local Pos
                    Pos = RootPart.Position
                    local Position, Visible = Camera:WorldToViewportPoint(Pos)
                    local Size = RootPart.Size.Y
                    local scaleFactor = (Size * Camera.ViewportSize.Y) / (Position.Z * 2) * 80 / game:FindFirstChild("Workspace").CurrentCamera.FieldOfView
                    local w, h = CurrentFOVX * scaleFactor, CurrentFOVY * scaleFactor
                    
                    Script.Locals.FieldOfViewOne.Position = Vector2.new(Position.X - w / 2, Position.Y - h / 2)
                    Script.Locals.FieldOfViewOne.Size = Vector2.new(w, h)
                    Script.Locals.FieldOfViewOne.Visible = (Visible and getgenv().saved.Osiris['Silent Aim']['Field Of View']['Mode'] == '2D' and getgenv().saved.Osiris['Silent Aim']['Field Of View']['Visible']) or false

                    local mouseLocation = UserInputService:GetMouseLocation()
                    local boxPos = Script.Locals.FieldOfViewOne.Position
                    local boxSize = Script.Locals.FieldOfViewOne.Size
                
                    if mouseLocation.X >= boxPos.X and mouseLocation.X <= boxPos.X + boxSize.X and
                        mouseLocation.Y >= boxPos.Y and mouseLocation.Y <= boxPos.Y + boxSize.Y then
                        Script.Locals.IsBoxFocused = true
                        Script.Locals.FieldOfViewOne.Color = Color3.fromRGB(106, 50, 159)
                        else
                            Script.Locals.IsBoxFocused = false
                        Script.Locals.FieldOfViewOne.Color =Color3.fromRGB(255, 255, 255)
                    end
                else
                    Script.Locals.FieldOfViewOne.Visible = false
                end
            else
                Script.Locals.FieldOfViewOne.Visible = false
            end
        end

        function Script:UpdateLabels()
        end
        
        function Script:ShouldShoot(Target)
            if not Target then 
                SilentAimPart.Position = Vector3.zero
                return false 
            end
            if not Target.Character then 
                SilentAimPart.Position = Vector3.zero
                return false 
            end
            
            local allConditionsPassed = true
            local Conditions = getgenv().saved.Osiris['General']['Checks']
        
            if Conditions['Visible'] then
                if not Script:RayCast(Target.Character.HumanoidRootPart, Script:GetOrigin('Camera'), {Self.Character, SilentAimPart}) then
                    allConditionsPassed = false
                    SilentAimPart.Position = Vector3.zero
                end
            end
        
            if Conditions['Knocked'] and CurrentGame.Functions.IsKnocked(Target.Character) then
                allConditionsPassed = false
                SilentAimPart.Position = Vector3.zero
            end
        
            if Conditions['Self Knocked'] and CurrentGame.Functions.IsKnocked(Self.Character) then
                allConditionsPassed = false
                SilentAimPart.Position = Vector3.zero
            end
        
            if Conditions['Carried'] and CurrentGame.Functions.IsGrabbed(Target) then
                allConditionsPassed = false
                SilentAimPart.Position = Vector3.zero
            end



            local screen, _ = Camera:WorldToViewportPoint(Script.Locals.HitPosition)

            local DistanceX = math.abs(screen.X - Mouse.X)
            local DistanceY = math.abs(screen.Y - Mouse.Y)
            local Box = Vector2.new(0, 0)
            local RadiusX 
            local RadiusY 
            if Script.Locals.IsBoxFocused then
                Box = Vector2.new(1000, 1000)
            else
                Box = Vector2.new(0, 0)
            end


            if getgenv().saved.Osiris['Silent Aim']['Field Of View']['Mode'] == '2D' then
                RadiusX = Box.X
                RadiusY = Box.Y
            else
                RadiusX = CurrentFOV
                RadiusY = CurrentFOV
            end
            
            if getgenv().saved.Osiris['Silent Aim']['Field Of View']['Enabled'] and (getgenv().saved.Osiris['Silent Aim']['Field Of View']['Mode'] == '2D' or getgenv().saved.Osiris['Silent Aim']['Field Of View']['Mode'] == 'Circle') and not (RadiusX > DistanceX and RadiusY > DistanceY and (DistanceX^2 + DistanceY^2) < (1/0)^2) then
                allConditionsPassed = false
            end
        

            return allConditionsPassed
        end   

        local Ticks = {}
        
        function Script:GetGunCategory()
            if Self and Self.Character then
                local Tool = Self.Character:FindFirstChildWhichIsA("Tool")
                if Tool then
                    if table.find(WeaponInfo.Shotguns, Tool.Name) then
                        return "Shotgun"
                    end
        
                    if table.find(WeaponInfo.Pistols, Tool.Name) then
                        return "Pistol"
                    end

                    if table.find(WeaponInfo.Rifles, Tool.Name) then
                        return "Rifle"
                    end

                    if table.find(WeaponInfo.Bursts, Tool.Name) then
                        return "Burst"
                    end

                    if table.find(WeaponInfo.SMG, Tool.Name) then
                        return "SMG"
                    end

                    if table.find(WeaponInfo.Snipers, Tool.Name) then
                        return "Sniper"
                    end

                    if table.find(WeaponInfo.AutoShotguns, Tool.Name) then
                        return "Auto"
                    end
                end
            end
            return nil
        end

        function Script:SilentAimFunc(Tool)
            if (string.find(GameName, "Dee Hood") or string.find(GameName, "Der Hood")) and getgenv().saved.Osiris['Silent Aim']['Enabled'] then
                if Script.Locals.SilentAimTarget and Script.Locals.SilentAimTarget.Character then
                    local Player = Script.Locals.SilentAimTarget
                    local Character = Player.Character
               
                    local Position, OnScreen = Camera:WorldToViewportPoint(Script.Locals.HitPosition)
        
                    if not OnScreen then
                        return
                    end
                    
                    if Script:ShouldShoot(Script.Locals.SilentAimTarget) then
                        local Arguments = {
                            [1] = CurrentGame.Updater,
                            [2] = Script.Locals.HitPosition
                        }
        
                        CurrentGame.RemotePath():FireServer(unpack(Arguments))
                    else
                        SilentAimPart.Position = Vector3.zero
                    end
                end
            else
                if string.find(GameName, "Da Hood") then
                    if not Ticks[Tool.Name] then
                        Ticks[Tool.Name] = 0
                    end

                    local WeaponOffset = WeaponInfo.Offsets[Tool.Name]
                    local Gun = Script:GetGunCategory()
                    local ToolHandle = Tool:WaitForChild("Handle")
                    local LocalCharacter = Self.Character or Self.CharacterAdded:Wait()
                    local Cooldown = Tool:WaitForChild("ShootingCooldown").Value
                    local NoClueWhatThisIs = game.PlaceId == 88976059384565 and {
                        ["Value"] = 5
                    } or Tool.Ammo
                    local Time = game:FindFirstChild("Workspace"):GetServerTimeNow()
                    local Check = tick() - Ticks[Tool.Name] >= Cooldown + WeaponInfo.Delays[Tool.Name]
                    local ToolEvent = Tool:WaitForChild("RemoteEvent", 2) or {
                        ["FireServer"] = function(_, _) end
                    }


                    local BeamCol = Color3.new(1, 0.545098, 0.14902)

                    local function ShootFunc(GunType, SilentAim)
                        if GunType == "Shotgun" then
                            if Check and (NoClueWhatThisIs.Value >= 1 and (not _G.GUN_COMBAT_TOGGLE and DaHood.CanShoot(Self.Character))) then
                                Ticks[Tool.Name] = tick()
                                ToolEvent:FireServer("Shoot")
                                for _ = 1, 5 do
                                    local HitPosition = Script.Locals.HitPosition 
                                    local SpreadX 
                                    local SpreadY
                                    local SpreadZ
                
                                    if getgenv().saved.Osiris['Spread Modifier']['Enabled'] then
                                        local spreadData = getgenv().saved.Osiris['Spread Modifier'][Tool.Name]
                                        local spreadReduction = spreadData and spreadData['Value'] or 1
                                        local randomizer = getgenv().saved.Osiris['Spread Modifier']['Randomizer']
                                    

                                        spreadReduction = math.clamp(spreadReduction, 0, 1)
                                    
                                        local spreadFactor = spreadReduction 
                                    
                                        if randomizer.Enabled then
                                            spreadFactor = spreadFactor * (1 - math.random() * randomizer.Value)
                                        end
                                    
                                        SpreadX = math.random() > 0.5 and math.random() * 0.05 * spreadFactor or -math.random() * 0.05 * spreadFactor
                                        SpreadY = math.random() > 0.5 and math.random() * 0.1 * spreadFactor or -math.random() * 0.1 * spreadFactor
                                        SpreadZ = math.random() > 0.5 and math.random() * 0.05 * spreadFactor or -math.random() * 0.05 * spreadFactor
                                    
                                    else
                                        SpreadX = math.random() > 0.5 and math.random() * 0.05 or -math.random() * 0.05
                                        SpreadY = math.random() > 0.5 and math.random() * 0.1 or -math.random() * 0.1
                                        SpreadZ = math.random() > 0.5 and math.random() * 0.05 or -math.random() * 0.05
                                    end
                                    

                                    local ForcedOrigin = Tool:FindFirstChild("Default") and (Tool.Default:FindFirstChild("Mesh") and Tool.Default.Mesh:FindFirstChild("Muzzle")) or {
                                        ["WorldPosition"] = (ToolHandle.CFrame * WeaponOffset).Position
                                    }
                    
                                    local TotalSpread = Vector3.new(SpreadX, SpreadY, SpreadZ)
                        
                                    local AimPosition
                                    local WeaponRange = Tool:FindFirstChild("Range")
                                    if SilentAim and (Self.Character.HumanoidRootPart.Position - Script.Locals.SilentAimTarget.Character.HumanoidRootPart.Position).Magnitude < WeaponRange.Value then
                                        AimPosition = ForcedOrigin.WorldPosition + ((HitPosition - ForcedOrigin.WorldPosition).Unit + TotalSpread) * WeaponRange.Value
                                    else
                                        AimPosition = ForcedOrigin.WorldPosition + (DaHood.GetAim(ForcedOrigin.WorldPosition) + TotalSpread) * WeaponRange.Value
                                    end

                                    local Arg0, Arg1, Arg2 = DaHood.ShootGun({
                                        ["Shooter"] = LocalCharacter,
                                        ["Handle"] = ToolHandle,
                                        ["AimPosition"] = AimPosition,
                                        ["BeamColor"] = BeamCol,
                                        ["ForcedOrigin"] = ForcedOrigin.WorldPosition,
                                        ["LegitPosition"] = ForcedOrigin.WorldPosition + (DaHood.GetAim(ForcedOrigin.WorldPosition) + TotalSpread) * WeaponRange.Value,
                                        ["Range"] = WeaponRange.Value
                                    })
                                    ReplicatedStorage.MainEvent:FireServer("ShootGun", ToolHandle, ForcedOrigin.WorldPosition, Arg0, Arg1, Arg2, Time)
                                end
                                ToolEvent:FireServer()
                            end
                        elseif Gun == "Pistol" then
                            if Check and (NoClueWhatThisIs.Value >= 1 and (not _G.GUN_COMBAT_TOGGLE and DaHood.CanShoot(Self.Character))) then
                                Ticks[Tool.Name] = tick()
                                local HitPosition = Script.Locals.HitPosition 
                               
                                ToolEvent:FireServer("Shoot")

                                local AimPosition
                                local ForcedOrigin = Tool:FindFirstChild("Default") and (Tool.Default:FindFirstChild("Mesh") and Tool.Default.Mesh:FindFirstChild("Muzzle")) or {
                                    ["WorldPosition"] = (ToolHandle.CFrame * WeaponOffset).Position
                                    }
                
                                local WeaponRange = Tool:WaitForChild("Range")
                                if SilentAim and (Self.Character.HumanoidRootPart.Position - Script.Locals.SilentAimTarget.Character.HumanoidRootPart.Position).Magnitude < WeaponRange.Value then
                                    AimPosition = HitPosition
                                else
                                    AimPosition = ForcedOrigin.WorldPosition + DaHood.GetAim(ForcedOrigin.WorldPosition) * 200  
                                end
                                local Arg0, Arg1, Arg2 = DaHood.ShootGun({
                                    ["Shooter"] = LocalCharacter,
                                    ["Handle"] = ToolHandle,
                                    ["ForcedOrigin"] = ForcedOrigin.WorldPosition or (ToolHandle.CFrame * WeaponOffset).Position,
                                    ["AimPosition"] = AimPosition,
                                    ["BeamColor"] = BeamCol,
                                    ["LegitPosition"] = ForcedOrigin.WorldPosition + DaHood.GetAim(ForcedOrigin.WorldPosition) * 200,
                                    ["Range"] = WeaponRange.Value
                                })
                                ReplicatedStorage.MainEvent:FireServer("ShootGun", ToolHandle, ForcedOrigin.WorldPosition, Arg0, Arg1, Arg2)
                                ToolEvent:FireServer()
                            end
                        elseif Gun == "Auto" then
                            if Check and (not _G.GUN_COMBAT_TOGGLE and DaHood.CanShoot(LocalCharacter)) then
                                Ticks[Tool.Name] = tick()
                                ToolEvent:FireServer("Shoot")
                                local Flag = true
                                task.spawn(function()
                                    while Flag and (Tool.Parent == LocalCharacter and (NoClueWhatThisIs.Value > 0 and DaHood.CanShoot(LocalCharacter))) do
                                        local HitPosition = Script.Locals.HitPosition 
                                        local CurrentTime = game:FindFirstChild("Workspace"):GetServerTimeNow()
                                        for _ = 1, 5 do
                                            local SpreadX 
                                            local SpreadY
                                            local SpreadZ
                                            if getgenv().saved.Osiris['Spread Modifier']['Enabled'] then
                                                local spreadData = getgenv().saved.Osiris['Spread Modifier'][Tool.Name]
                                                local spreadReduction = spreadData and spreadData['Value'] or 1
                                                local randomizer = getgenv().saved.Osiris['Spread Modifier']['Randomizer']
                                                spreadReduction = math.clamp(spreadReduction, 0, 1)
                                                local spreadFactor = spreadReduction 
                                            
                                                if randomizer.Enabled then
                                                    spreadFactor = spreadFactor * (1 - math.random() * randomizer.Value)
                                                end
                                                SpreadX = math.random() > 0.5 and math.random() * 0.05 * spreadFactor or -math.random() * 0.05 * spreadFactor
                                                SpreadY = math.random() > 0.5 and math.random() * 0.1 * spreadFactor or -math.random() * 0.1 * spreadFactor
                                                SpreadZ = math.random() > 0.5 and math.random() * 0.05 * spreadFactor or -math.random() * 0.05 * spreadFactor
                                            
                                            else
                                                SpreadX = math.random() > 0.5 and math.random() * 0.05 or -math.random() * 0.05
                                                SpreadY = math.random() > 0.5 and math.random() * 0.1 or -math.random() * 0.1
                                                SpreadZ = math.random() > 0.5 and math.random() * 0.05 or -math.random() * 0.05
                                            end

                                            local ForcedOrigin = Tool:FindFirstChild("Default") and (Tool.Default:FindFirstChild("Mesh") and Tool.Default.Mesh:FindFirstChild("Muzzle")) or {
                                                ["WorldPosition"] = (ToolHandle.CFrame * WeaponOffset).Position
                                            }
                            
                                            local TotalSpread = Vector3.new(SpreadX, SpreadY, SpreadZ)
                                            local AimPosition
                                            local WeaponRange = Tool:WaitForChild("Range")
                                            if SilentAim and (Self.Character.HumanoidRootPart.Position - Script.Locals.SilentAimTarget.Character.HumanoidRootPart.Position).Magnitude < WeaponRange.Value then
                                                AimPosition = ForcedOrigin.WorldPosition + ((HitPosition - ForcedOrigin.WorldPosition).Unit + TotalSpread) * WeaponRange.Value
                                            else
                                                AimPosition = ForcedOrigin.WorldPosition + (DaHood.GetAim(ForcedOrigin.WorldPosition) + TotalSpread) * WeaponRange.Value
                                            end
                                            local Arg0, Arg1, Arg2 = DaHood.ShootGun({
                                                ["Shooter"] = LocalCharacter,
                                                ["Handle"] = ToolHandle,
                                                ["AimPosition"] = AimPosition,
                                                ["BeamColor"] = BeamCol,
                                                ["ForcedOrigin"] = ForcedOrigin.WorldPosition,
                                                ["LegitPosition"] = ForcedOrigin.WorldPosition + (DaHood.GetAim(ForcedOrigin.WorldPosition) + TotalSpread) * WeaponRange.Value,
                                                ["Range"] = WeaponRange.Value
                                            })
                                            ReplicatedStorage.MainEvent:FireServer("ShootGun", ToolHandle, ForcedOrigin.WorldPosition, Arg0, Arg1, Arg2, CurrentTime)
                                        end
                                        task.wait(Cooldown + 0.0095)
                                        Ticks[Tool.Name] = tick()
                                    end
                                    ToolEvent:FireServer()
                                end)
                                Tool.Deactivated:Wait()
                                Flag = false
                            end
                        elseif Gun == "Burst" then
                            local Tolerance = Tool:WaitForChild("ToleranceCooldown").Value
                            local ShootingCool = Tool:WaitForChild("ShootingCooldown").Value
                            if tick() - Ticks[Tool.Name] >= Tolerance and (not _G.GUN_COMBAT_TOGGLE and DaHood.CanShoot(LocalCharacter)) then
                                Ticks[Tool.Name] = tick()
                                ToolEvent:FireServer("Shoot")
                                game:FindFirstChild("Workspace"):GetServerTimeNow()
                                task.spawn(function()
                                    for _ = 1, NoClueWhatThisIs.Value > 3 and 3 or NoClueWhatThisIs.Value do
                                        local HitPosition = Script.Locals.HitPosition 
                                        local v17
                                        local ForcedOrigin = Tool:FindFirstChild("Default") and (Tool.Default:FindFirstChild("Mesh") and Tool.Default.Mesh:FindFirstChild("Muzzle")) or {
                                            ["WorldPosition"] = (ToolHandle.CFrame * WeaponOffset).Position
                                        }
                                        local WeaponRange = Tool:WaitForChild("Range")
                                        if SilentAim and (Self.Character.HumanoidRootPart.Position - Script.Locals.SilentAimTarget.Character.HumanoidRootPart.Position).Magnitude < WeaponRange.Value then
                                            v17 = ForcedOrigin.WorldPosition + ((HitPosition - ForcedOrigin.WorldPosition).Unit) * 200
                                        else
                                            v17 = ForcedOrigin.WorldPosition + DaHood.GetAim(ForcedOrigin.WorldPosition) * 200
                                        end
                                        local v18, v19, v20 = DaHood.ShootGun({
                                            ["Shooter"] = LocalCharacter,
                                            ["Handle"] = ToolHandle,
                                            ["ForcedOrigin"] = ForcedOrigin.WorldPosition,
                                            ["AimPosition"] = v17,
                                            ["LegitPosition"] = ForcedOrigin.WorldPosition + DaHood.GetAim(ForcedOrigin.WorldPosition) * 200,
                                            ["BeamColor"] = BeamCol,
                                            ["Range"] = WeaponRange.Value
                                        })
                                        ReplicatedStorage.MainEvent:FireServer("ShootGun", ToolHandle, ForcedOrigin.WorldPosition, v18, v19, v20)
                                        task.wait(ShootingCool + 0.0095)
                                    end
                                    ToolEvent:FireServer()
                                end)
                            end
                        elseif Gun == "Rifle" or GunType == "SMG" then
                            local ShootingCool = Tool:WaitForChild("ShootingCooldown").Value
                            if Check and (not _G.GUN_COMBAT_TOGGLE and DaHood.CanShoot(LocalCharacter)) then
                                Ticks[Tool.Name] = tick()
                                ToolEvent:FireServer("Shoot")
                                local Flag = true
                                task.spawn(function()
                                    while task.wait(ShootingCool + 0.0095) and (Flag and (Tool.Parent == LocalCharacter and (NoClueWhatThisIs.Value > 0 and DaHood.CanShoot(LocalCharacter)))) do
                                        local HitPosition = Script.Locals.HitPosition 
                                        local ForcedOrigin = Tool:FindFirstChild("Default") and (Tool.Default:FindFirstChild("Mesh") and Tool.Default.Mesh:FindFirstChild("Muzzle")) or {
                                            ["WorldPosition"] = (ToolHandle.CFrame * WeaponOffset).Position
                                        }
                        
                                        local AimPosition
                                        local WeaponRange = Tool:WaitForChild("Range")
                                        if SilentAim and (Self.Character.HumanoidRootPart.Position - Script.Locals.SilentAimTarget.Character.HumanoidRootPart.Position).Magnitude < WeaponRange.Value then
                                            AimPosition =  ForcedOrigin.WorldPosition + ((HitPosition - ForcedOrigin.WorldPosition).Unit) * 200
                                        else
                                            AimPosition = ForcedOrigin.WorldPosition + DaHood.GetAim(ForcedOrigin.WorldPosition) * 200
                                        end
                                        
                                        local v18, v19, v20 = DaHood.ShootGun({
                                            ["Shooter"] = LocalCharacter,
                                            ["Handle"] = ToolHandle,
                                            ["ForcedOrigin"] = ForcedOrigin.WorldPosition,
                                            ["AimPosition"] = AimPosition,
                                            ["LegitPosition"] = ForcedOrigin.WorldPosition + DaHood.GetAim(ForcedOrigin.WorldPosition) * 200,
                                            ["BeamColor"] = BeamCol,
                                            ["Range"] = WeaponRange.Value
                                        })
                                        ReplicatedStorage.MainEvent:FireServer("ShootGun", ToolHandle, ForcedOrigin.WorldPosition, v18, v19, v20)
                                        Ticks[Tool.Name] = tick()
                                    end
                                    ToolEvent:FireServer()
                                end)
                                Tool.Deactivated:Wait()
                                Flag = false
                            end
                        elseif Gun == "Sniper" then
                            if Check and (not _G.GUN_COMBAT_TOGGLE and DaHood.CanShoot(LocalCharacter)) then
                                Ticks[Tool.Name] = tick()
                                ToolEvent:FireServer("Shoot")
                                local HitPosition = Script.Locals.HitPosition 
                                local ForcedOrigin = Tool:FindFirstChild("Default") and (Tool.Default:FindFirstChild("Mesh") and Tool.Default.Mesh:FindFirstChild("Muzzle")) or {
                                    ["WorldPosition"] = (ToolHandle.CFrame * WeaponOffset).Position
                                }
                
                                local AimPosition
                                local WeaponRange = Tool:WaitForChild("Range")
                                if SilentAim and (Self.Character.HumanoidRootPart.Position - Script.Locals.SilentAimTarget.Character.HumanoidRootPart.Position).Magnitude < WeaponRange.Value then
                                    AimPosition =  ForcedOrigin.WorldPosition + ((HitPosition - ForcedOrigin.WorldPosition).Unit) * 50
                                else
                                    AimPosition = ForcedOrigin.WorldPosition + DaHood.GetAim(ForcedOrigin.WorldPosition) * 50
                                end
        
                                local v16, v17, v18 = DaHood.ShootGun({
                                    ["Shooter"] = LocalCharacter,
                                    ["Handle"] = ToolHandle,
                                    ["ForcedOrigin"] = ForcedOrigin.WorldPosition,
                                    ["AimPosition"] = AimPosition,
                                    ["LegitPosition"] = ForcedOrigin.WorldPosition + DaHood.GetAim(ForcedOrigin.WorldPosition) * 50,
                                    ["BeamColor"] = BeamCol,
                                    ["Range"] = WeaponRange.Value
                                })
                                ReplicatedStorage.MainEvent:FireServer("ShootGun", ToolHandle, ForcedOrigin.WorldPosition, v16, v17, v18)
                                ToolEvent:FireServer()
                            end
                        end
                    end
                       
                    if getgenv().saved.Osiris['Silent Aim']['Enabled'] and Script.Locals.SilentAimTarget and Script.Locals.SilentAimTarget.Character then
                        local target = Script.Locals.SilentAimTarget
                        ShootFunc(Gun, Script:ShouldShoot(target))
                    else
                        ShootFunc(Gun, false)
                    end
                end
            end
        end

        function Script:AimAssist()
            if BackwardActive then return end
        local Enabled = getgenv().saved.Osiris['Aim Assist']['Enabled'] 
        local Cond = getgenv().saved.Osiris['General']['Checks']
        if (Enabled and Script.Locals.AimAssistTarget and Script.Locals.AimAssistTarget.Character) then
            local Player = Script.Locals.AimAssistTarget
            local Character = Player.Character

            if Cond['Visible'] then
                if not Script:RayCast(Character.HumanoidRootPart, Script:GetOrigin('Camera'), {Self.Character, SilentAimPart}) then return end
            end
            if Cond['Knocked'] and CurrentGame.Functions.IsKnocked(Player.Character) then return end
            if Cond['Self Knocked'] and CurrentGame.Functions.IsKnocked(Self.Character) then return end
            if Cond['Carried'] and CurrentGame.Functions.IsGrabbed(Player) then return end

            local Osiris = getgenv().saved.Osiris['Aim Assist']
            local CurrentCamera = Workspace.CurrentCamera
            
            local Hit = Script:GetHitPosition("Assist")
            if not Hit then return end
            
            local TargetSnappiness = Osiris['Snappiness']
            
            if Osiris['Smart Snappiness']['Enabled'] then
                local targetVelocity = Vector3.new(0, 0, 0)
                if Character and Character:FindFirstChild("HumanoidRootPart") then
                    targetVelocity = Character.HumanoidRootPart.Velocity
                end
                local currentSpeed = targetVelocity.Magnitude
                
                local minSpeed = Osiris['Smart Snappiness']['Speed']['Min']
                local maxSpeed = Osiris['Smart Snappiness']['Speed']['Max']
                local minSmooth = Osiris['Smart Snappiness']['Min']
                local maxSmooth = Osiris['Smart Snappiness']['Max']
                local mode = Osiris['Smart Snappiness']['Mode']
                
                if CurrentSnappiness == nil then
                    CurrentSnappiness = minSmooth
                end
                

                local speedFactor = 0
                if currentSpeed <= minSpeed then
                    speedFactor = 0
                elseif currentSpeed >= maxSpeed then
                    speedFactor = 1
                else
                    speedFactor = (currentSpeed - minSpeed) / (maxSpeed - minSpeed)
                end

                if mode == "Fast" then
                    speedFactor = speedFactor ^ 1.5 
                else  -- "Slow"
                    speedFactor = speedFactor ^ 2.0
                end
                
                -- calculate target smoothness
                TargetSnappiness = minSmooth + (maxSmooth - minSmooth) * speedFactor
                TargetSnappiness = math.clamp(TargetSnappiness, minSmooth, maxSmooth)
            end
            
            if Osiris['Smart Snappiness']['Enabled'] then
                if CurrentSnappiness == nil then
                    CurrentSnappiness = Osiris['Smart Snappiness']['Min']
                end
                
                local transitionRate
                if Osiris['Smart Snappiness']['Mode'] == "Fast" then
                    transitionRate = 0.25
                else
                    transitionRate = 0.08
                end
                
                CurrentSnappiness = CurrentSnappiness + (TargetSnappiness - CurrentSnappiness) * transitionRate
                
                if math.abs(TargetSnappiness - CurrentSnappiness) < 0.0005 then
                    CurrentSnappiness = TargetSnappiness
                end
                
                local EasedSmoothing = TweenService:GetValue(CurrentSnappiness, Enum.EasingStyle[Osiris['Easing Style']], Enum.EasingDirection[Osiris['Easing Direction']])
                
                CurrentCamera.CFrame = CurrentCamera.CFrame:Lerp(
                    CFrame.new(CurrentCamera.CFrame.Position, Hit),
                    EasedSmoothing
                )
            else
                local EasedSmoothing = TweenService:GetValue(TargetSnappiness, Enum.EasingStyle[Osiris['Easing Style']], Enum.EasingDirection[Osiris['Easing Direction']])
                
                CurrentCamera.CFrame = CurrentCamera.CFrame:Lerp(
                    CFrame.new(CurrentCamera.CFrame.Position, Hit),
                    EasedSmoothing
                )
            end
        end
    end
        function Script:Physics()
            if not Self.Character or not Self.Character:FindFirstChild("Humanoid") then return end
            local Hum = Self.Character.Humanoid
            
            if getgenv().saved.Osiris['Player']['Anti Fall'] then
                if Hum.Health > 1 and Hum:GetState() == Enum.HumanoidStateType.FallingDown then
                    Hum:ChangeState("GettingUp")
                end
            end

            if Script.Locals.IsWalkSpeeding and getgenv().saved.Osiris['Walk Speed']['Enabled'] then
                Hum.WalkSpeed = getgenv().saved.Osiris['Walk Speed']['Speed']
            end
        end

        local function HijackTool()
            local character = Self.Character
            if not character then return end
            
            local tool = character:FindFirstChildWhichIsA("Tool")
            if not tool then return end
            
            if not tool._originalActivate then
                tool._originalActivate = tool.Activate
            end
            
            tool.Activate = function(self)
                local isAimed = Script.Locals.IsAimed
                Script.Locals.IsAimed = false 
                tool._originalActivate(self)
                Script.Locals.IsAimed = isAimed 
            end
        end

        Self.CharacterAdded:Connect(function()
            task.wait(0.5)
            HijackTool()
        end)
    end
    do
        local FOVOsiris = getgenv().saved.Osiris['Silent Aim']['Field Of View']
        local SilentAimOsiris = getgenv().saved.Osiris['Silent Aim']

        local FieldOfViewSquare = Script.Visuals.new("Square")
        FieldOfViewSquare.Visible = FOVOsiris['Visible']
        FieldOfViewSquare.Color = Color3.fromRGB(255, 255, 255)
        FieldOfViewSquare.Thickness = 1
        FieldOfViewSquare.Transparency = 1

        local FieldOfViewCircle = Script.Visuals.new("Circle")
        FieldOfViewCircle.Visible = FOVOsiris['Visible']
        FieldOfViewCircle.Color = Color3.fromRGB(255, 255, 255)
        FieldOfViewCircle.Thickness = 1
        FieldOfViewCircle.Transparency = 1

        Script.Locals.FieldOfViewOne = FieldOfViewSquare

        local function GetBodySize(Character)
            local Part = Script:GetClosestPartToCursor(Character)
            if (Part) then
                local l = game:FindFirstChild("Workspace").CurrentCamera:WorldToScreenPoint(Part.Position - Part.Size / 2)
                local r = game:FindFirstChild("Workspace").CurrentCamera:WorldToScreenPoint(Part.Position + Part.Size / 2)
                local w = math.abs(l.X - r.X)
                local h = math.abs(l.Y - r.Y)
                return w, h
            end
            return 0, 0 
        end
        
        local Activated
        local function OnLocalCharacterAdded(Character)
            if (not Character) then
                return
            end

            Character.ChildAdded:Connect(function(Tool)
                if (not Tool:IsA("Tool")) then
                    return
                end
                
                Activated = Tool.Activated:Connect(function()
                    Script:SilentAimFunc(Tool)
                end)
            end)

            Character.ChildRemoved:Connect(function(Tool)
                if (not Tool:IsA("Tool")) then
                    return
                end

                if Activated then
                    Activated:Disconnect()
                end
            end)
        end
        local DebugCircle = Script.Visuals.new("Circle")
        OnLocalCharacterAdded(Self.Character)
        Self.CharacterAdded:Connect(OnLocalCharacterAdded)
        local Guns = getgenv().saved.Osiris['Silent Aim']['Field Of View']['Guns']
        local function UpdateDrawings()
            local Character = Self.Character
            if not Character then return end
            local Tool = Character:FindFirstChildWhichIsA("Tool")
            
            if Guns['Enabled'] and Tool then
                if table.find(WeaponInfo.Shotguns, Tool.Name) then
                    CurrentFOV = Guns['Shotguns']['Circle']
                    CurrentFOVX = Guns['Shotguns']['2D']['X']
                    CurrentFOVY = Guns['Shotguns']['2D']['Y']
                elseif table.find(WeaponInfo.Pistols, Tool.Name) then
                    CurrentFOV = Guns['Pistols']['Circle']
                    CurrentFOVX = Guns['Pistols']['2D']['X']
                    CurrentFOVY = Guns['Pistols']['2D']['Y']
                else
                    CurrentFOV = Guns['Automatics']['Circle']
                    CurrentFOVX = Guns['Automatics']['2D']['X']
                    CurrentFOVY = Guns['Automatics']['2D']['Y']
                end
            else
                CurrentFOV = Guns['Automatics']['Circle']
                CurrentFOVX = Guns['Automatics']['2D']['X']
                CurrentFOVY = Guns['Automatics']['2D']['Y']
            end 
         
            DebugCircle.Visible = false
            Script.Locals.FieldOfViewTwo = FieldOfViewCircle
            Script.Locals.FieldOfViewTwo.Visible = getgenv().saved.Osiris['Silent Aim']['Field Of View']['Mode'] == 'Circle' and getgenv().saved.Osiris['Silent Aim']['Field Of View']['Visible']
            Script.Locals.FieldOfViewTwo.Radius = CurrentFOV
            Script.Locals.FieldOfViewTwo.Position = Vector2.new(Mouse.X, Mouse.Y + GuiInsetOffsetY)
            Script:UpdateBox()
        end
        
        ThreadLoop(0.0001, function()
            
            if string.find(GameName, "Da Hood") then
                local GunType = Script:GetGunCategory()
                local Tool = Self.Character:FindFirstChildWhichIsA("Tool")
                if Tool then
                    if GunType == "Pistol" or GunType == "Sniper" then
                        for I, v in pairs(Tool:GetChildren()) do
                            if v.Name == "GunClient" then
                                v:Destroy()
                            end
                        end
                    elseif GunType == "Shotgun" then
                        for I, v in pairs(Tool:GetChildren()) do
                            if v.Name == "GunClientShotgun" then
                                v:Destroy()
                            end
                        end
                    elseif GunType == "Auto" then
                        for I, v in pairs(Tool:GetChildren()) do
                            if v.Name == "GunClientAutomaticShotgun" then
                                v:Destroy()
                            end
                        end
                    elseif GunType == "Burst" then
                        for I, v in pairs(Tool:GetChildren()) do
                            if v.Name == "GunClientBurst" then
                                v:Destroy()
                            end
                        end
                    elseif GunType == "Rifle" or GunType == "SMG" then
                        for I, v in pairs(Tool:GetChildren()) do
                            if v.Name == "GunClientAutomatic" then
                                v:Destroy()
                            end
                        end
                    end    
                end
            end
        end)
        local SP = false
        local SP2 = false
        RBXConnection(UserInputService.InputBegan, function(Input, Processed)
            local AimAssistKey = Enum.KeyCode[getgenv().saved.Osiris['General']['Keybind']['Aim Assist']:upper()]
            local SilentAimTarget = Enum.KeyCode[getgenv().saved.Osiris['General']['Keybind']['Silent Aim Target']:upper()]
            local ESPKey = Enum.KeyCode[getgenv().saved.Osiris['General']['Keybind']['Visual']:upper()]
            
            local WSKey = Enum.KeyCode[getgenv().saved.Osiris['General']['Keybind']['Walk Speed']:upper()]
            if Input.KeyCode == WSKey and not Processed then
                Script.Locals.IsWalkSpeeding = not Script.Locals.IsWalkSpeeding
                if not Script.Locals.IsWalkSpeeding and Self.Character and Self.Character:FindFirstChild("Humanoid") then
                    Self.Character.Humanoid.WalkSpeed = 16 
                end
            end

            if Input.KeyCode == SilentAimTarget and getgenv().saved.Osiris['General']['Silent Aim Misc']['Targeting Mode'] == 'Select' then
                SP = not SP
                if SP then 
                    Script.Locals.SilentAimTarget = Script:GetClosestPlayerToCursor(
                        SilentAimOsiris['Max Distance'] * 102220,
                        SilentAimOsiris['Field Of View']['Enabled'] and CurrentFOV or math.huge
                    )    
                else
                    if Script.Locals.SilentAimTarget then
                        Script.Locals.SilentAimTarget = nil
                    end
                end
            end

            if Input.KeyCode == ESPKey then
                getgenv().saved.Osiris['Player']['Visual']['Enabled'] = not getgenv().saved.Osiris['Player']['Visual']['Enabled']
            end

            if Input.KeyCode == AimAssistKey then
                SP2 = not SP2
                if SP2 then
                    Script.Locals.AimAssistTarget = Script:GetClosestPlayerToCursor(
                        SilentAimOsiris['Max Distance'] * 700,
                        math.huge
                    )
                else
                    if Script.Locals.AimAssistTarget then
                        Script.Locals.AimAssistTarget = nil
                    end
                end
            end
        end)

    RBXConnection(RunService.PreRender, LPH_NO_VIRTUALIZE(function()
        if getgenv().saved.Osiris['General']['Silent Aim Misc']['Targeting Mode'] == 'Auto' then
            Script.Locals.SilentAimTarget = Script:GetClosestPlayerToCursor(
                SilentAimOsiris['Max Distance'] * 100,
                math.huge 
            )    
        end
        
        if Script.Locals.SilentAimTarget and Script.Locals.SilentAimTarget.Character then
            Script.Locals.HitPosition = Script:GetHitPosition('Silent')
        end
        Script:ShouldShoot(Script.Locals.SilentAimTarget)


        ThreadFunction(Script.AimAssist)
        ThreadFunction(Script.Physics)
        UpdateDrawings()
    end))

    local ESP_Cache = {}

    local function ClearDeadESP()
        for player, objects in pairs(ESP_Cache) do
            if not player or not player.Parent then
                if objects.Gui then objects.Gui:Destroy() end
                ESP_Cache[player] = nil
            end
        end
    end

    local function GetPlayerESP(player)
        if ESP_Cache[player] then return ESP_Cache[player] end
        
        local billboard = Instance.new("BillboardGui")
        billboard.Name = "Custom_ESP"
        billboard.AlwaysOnTop = true
        billboard.Size = UDim2.new(0, 100, 0, 50)
        billboard.StudsOffset = Vector3.new(0, -5, 0)
        
        local text = Instance.new("TextLabel")
        text.BackgroundTransparency = 1
        text.Size = UDim2.new(1, 0, 1, 0)
        text.Font = Enum.Font.SourceSansBold
        text.TextSize = 13
        text.TextColor3 = getgenv().saved.Osiris['Player']['Visual']['Normal Color']
        text.TextStrokeTransparency = 0
        text.Parent = billboard
        
        ESP_Cache[player] = {Gui = billboard, Label = text}
        return ESP_Cache[player]
    end

    local function GlobalESPUpdate()
        local ESP_Cfg = getgenv().saved.Osiris['Player']['Visual']
        ClearDeadESP()
        
        for _, plr in ipairs(Players:GetPlayers()) do
            if plr == Self then continue end
            local char = plr.Character
            local root = char and char:FindFirstChild("HumanoidRootPart")
            local esp_data = GetPlayerESP(plr)
            
            if root and ESP_Cfg['Enabled'] then
                esp_data.Gui.Parent = root
                esp_data.Gui.Adornee = root
                esp_data.Gui.Enabled = true
                
                local display = ""
                if ESP_Cfg['Names'] then display = plr.DisplayName or plr.Name end
                if ESP_Cfg['Distance'] then
                    local dist = math.floor((root.Position - Self.Character.HumanoidRootPart.Position).Magnitude)
                    display = display .. "\n[" .. dist .. "m]"
                end
                esp_data.Label.Text = display
                
                local isKnocked = CurrentGame.Functions.IsKnocked(char)
                local isTargeted = (Script.Locals.AimAssistTarget == plr or Script.Locals.SilentAimTarget == plr)

                if isTargeted and not isKnocked then
                    esp_data.Label.TextColor3 = ESP_Cfg['Targeted Color']
                else
                    esp_data.Label.TextColor3 = ESP_Cfg['Normal Color']
                end
                
            else
                esp_data.Gui.Enabled = false
            end
        end
    end

    RunService.RenderStepped:Connect(GlobalESPUpdate)

    RunService.Heartbeat:Connect(function()
        if getgenv().saved.Osiris['Player']['Enable POV Headless'] and Self.Character then
            local head = Self.Character:FindFirstChild("Head")
            if head then
                if head:FindFirstChildOfClass("SpecialMesh") then
                    head:FindFirstChildOfClass("SpecialMesh"):Destroy()
                end
                head.Transparency = 1
                for _, v in pairs(head:GetChildren()) do
                    if v:IsA("Decal") then v:Destroy() end
                end
            end
        end
    end)
    end

    -- ==================== BACKWARD SWITCH SYSTEM ====================

    local BackwardEnabled = getgenv().saved.Osiris['Aim Assist']['Backward Switch']['Enabled']
    local BackwardKeybind = getgenv().saved.Osiris['Aim Assist']['Backward Switch']['Keybind']

    local BackwardActive = false
    local BackwardKeyCode = Enum.KeyCode[BackwardKeybind:upper()]
    local TweenSpeed = 0.3

    -- Store the backward CFrame
    local LockedCameraCFrame = nil
    local LockedBodyCFrame = nil
    local IsTurning = false

    -- Function to toggle backward switch
    local function ToggleBackward()
        if not BackwardEnabled then return end
        if not Self.Character then return end
        
        local rootPart = Self.Character:FindFirstChild("HumanoidRootPart")
        if not rootPart then return end
        
        local hum = Self.Character:FindFirstChild("Humanoid")
        if not hum or hum.Health <= 0 then return end
        
        BackwardActive = not BackwardActive
        IsTurning = true
        
        local charPos = rootPart.Position
        local camPos = Camera.CFrame.Position
        local distance = (camPos - charPos).Magnitude
        
        if BackwardActive then
            -- Get current look vector and preserve pitch
            local lookVector = Camera.CFrame.LookVector
            local pitch = math.asin(-lookVector.Y)
            local yaw = math.atan2(lookVector.X, lookVector.Z)
            
            -- Flip yaw 180 degrees
            local newYaw = yaw + math.pi
            
            -- New look direction with same pitch
            local newLookVector = Vector3.new(
                math.sin(newYaw) * math.cos(pitch),
                -math.sin(pitch),
                math.cos(newYaw) * math.cos(pitch)
            )
            
            -- New camera position (opposite side)
            local newCamPos = charPos + Vector3.new(
                math.sin(newYaw + math.pi) * distance,
                camPos.Y - charPos.Y,
                math.cos(newYaw + math.pi) * distance
            )
            
            -- Store locked CFrames
            LockedCameraCFrame = CFrame.lookAt(newCamPos, newCamPos + newLookVector)
            LockedBodyCFrame = CFrame.new(charPos) * CFrame.Angles(0, math.pi, 0)
            
            -- Tween camera
            local camTween = TweenService:Create(Camera, TweenInfo.new(TweenSpeed, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                CFrame = LockedCameraCFrame
            })
            camTween:Play()
            camTween.Completed:Wait()
            
            -- Tween body
            local bodyTween = TweenService:Create(rootPart, TweenInfo.new(TweenSpeed, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                CFrame = LockedBodyCFrame
            })
            bodyTween:Play()
            bodyTween.Completed:Wait()
            
            IsTurning = false
            
        else
            -- Turn back to normal
            LockedCameraCFrame = nil
            LockedBodyCFrame = nil
            
            local lookVector = Camera.CFrame.LookVector
            local pitch = math.asin(-lookVector.Y)
            local yaw = math.atan2(lookVector.X, lookVector.Z)
            
            -- Flip yaw back
            local newYaw = yaw + math.pi
            
            local newLookVector = Vector3.new(
                math.sin(newYaw) * math.cos(pitch),
                -math.sin(pitch),
                math.cos(newYaw) * math.cos(pitch)
            )
            
            local newCamPos = charPos + Vector3.new(
                math.sin(newYaw + math.pi) * distance,
                camPos.Y - charPos.Y,
                math.cos(newYaw + math.pi) * distance
            )
            
            -- Tween camera back
            local camTween = TweenService:Create(Camera, TweenInfo.new(TweenSpeed, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                CFrame = CFrame.lookAt(newCamPos, newCamPos + newLookVector)
            })
            camTween:Play()
            camTween.Completed:Wait()
            
            -- Tween body back
            local bodyTween = TweenService:Create(rootPart, TweenInfo.new(TweenSpeed, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                CFrame = CFrame.new(charPos) * CFrame.Angles(0, 0, 0)
            })
            bodyTween:Play()
            bodyTween.Completed:Wait()
            
            IsTurning = false
        end
    end

    -- Lock camera and body in backward position
    local function LockBackwardPosition()
        if not BackwardActive then return end
        if IsTurning then return end
        if not Self.Character then 
            BackwardActive = false
            return 
        end
        
        local rootPart = Self.Character:FindFirstChild("HumanoidRootPart")
        if not rootPart then 
            BackwardActive = false
            return 
        end
        
        local hum = Self.Character:FindFirstChild("Humanoid")
        if not hum or hum.Health <= 0 then
            BackwardActive = false
            return
        end
        
        -- Check if knocked
        local bodyEffects = Self.Character:FindFirstChild("BodyEffects")
        if bodyEffects then
            if bodyEffects:FindFirstChild("K.O") and bodyEffects["K.O"].Value == true then
                BackwardActive = false
                LockedCameraCFrame = nil
                LockedBodyCFrame = nil
                return
            end
            if bodyEffects:FindFirstChild("Dead") and bodyEffects.Dead.Value == true then
                BackwardActive = false
                LockedCameraCFrame = nil
                LockedBodyCFrame = nil
                return
            end
        end
        
        if hum.Health <= 0 then
            BackwardActive = false
            LockedCameraCFrame = nil
            LockedBodyCFrame = nil
            return
        end
        
        -- Lock camera to backward position (follows character)
        if LockedCameraCFrame then
            local charPos = rootPart.Position
            local camPos = LockedCameraCFrame.Position
            
            -- Get direction from character to camera
            local dirToCam = (camPos - charPos).Unit
            local distance = (camPos - charPos).Magnitude
            
            -- Keep camera at same relative position but follow character
            local newCamPos = charPos + dirToCam * distance
            local newCamCFrame = CFrame.lookAt(newCamPos, charPos)
            
            -- Apply to camera
            Camera.CFrame = newCamCFrame
            
            -- Update stored CFrame
            LockedCameraCFrame = newCamCFrame
        end
        
        -- Lock body to backward position (follows character)
        if LockedBodyCFrame then
            local charPos = rootPart.Position
            local newBodyCFrame = CFrame.new(charPos) * CFrame.Angles(0, math.pi, 0)
            rootPart.CFrame = newBodyCFrame
            LockedBodyCFrame = newBodyCFrame
        end
    end

    -- Keybind handler
    RBXConnection(UserInputService.InputBegan, function(Input, Processed)
        if Processed then return end
        if Input.KeyCode == BackwardKeyCode and BackwardEnabled then
            ToggleBackward()
        end
    end)

    -- Lock position every frame (but only if not turning)
    RBXConnection(RunService.RenderStepped, function()
        if BackwardEnabled and BackwardActive and not IsTurning then
            LockBackwardPosition()
        end
    end)

    -- Reset on respawn
    Self.CharacterAdded:Connect(function()
        task.wait(0.5)
        BackwardActive = false
        LockedCameraCFrame = nil
        LockedBodyCFrame = nil
        IsTurning = false
    end)

    -- Instant disable on K.O change
    local function SetupKnockCheck()
        local character = Self.Character
        if not character then return end
        
        local bodyEffects = character:FindFirstChild("BodyEffects")
        if not bodyEffects then return end
        
        local ko = bodyEffects:FindFirstChild("K.O")
        if ko then
            ko:GetPropertyChangedSignal("Value"):Connect(function()
                if ko.Value == true and BackwardActive then
                    BackwardActive = false
                    LockedCameraCFrame = nil
                    LockedBodyCFrame = nil
                    IsTurning = false
                end
            end)
        end
        
        local dead = bodyEffects:FindFirstChild("Dead")
        if dead then
            dead:GetPropertyChangedSignal("Value"):Connect(function()
                if dead.Value == true and BackwardActive then
                    BackwardActive = false
                    LockedCameraCFrame = nil
                    LockedBodyCFrame = nil
                    IsTurning = false
                end
            end)
        end
    end

    -- Setup knock checks
    if Self.Character then
        task.wait(0.5)
        SetupKnockCheck()
    end

    Self.CharacterAdded:Connect(function()
        task.wait(0.5)
        SetupKnockCheck()
    end)

    -- Health check
    local function SetupHealthCheck()
        local character = Self.Character
        if not character then return end
        
        local hum = character:FindFirstChild("Humanoid")
        if not hum then return end
        
        hum:GetPropertyChangedSignal("Health"):Connect(function()
            if hum.Health <= 0 and BackwardActive then
                BackwardActive = false
                LockedCameraCFrame = nil
                LockedBodyCFrame = nil
                IsTurning = false
            end
        end)
    end

    if Self.Character then
        task.wait(0.5)
        SetupHealthCheck()
    end

    Self.CharacterAdded:Connect(function()
        task.wait(0.5)
        SetupHealthCheck()
    end)
    -- ==================== HITBOX EXPANDER SYSTEM ====================
    local HitboxEnabled = getgenv().saved.Osiris['Hitbox Expander']['Enabled']
    local HitboxVisible = getgenv().saved.Osiris['Hitbox Expander']['Visible']
    local HitboxSize = getgenv().saved.Osiris['Hitbox Expander']['Size']
    -- local HITBOX_REFRESH_TIME = 0.001

    -- Store hitbox visual objects
    local HitboxVisuals = {}

    -- Get XYZ values
    local function GetHitboxSize()
        if type(HitboxSize) == "table" then
            return Vector3.new(
                HitboxSize.X or 10,
                HitboxSize.Y or 10,
                HitboxSize.Z or 10
            )
        else
            return Vector3.new(HitboxSize, HitboxSize, HitboxSize)
        end
    end

    -- Create a clean outline for a player
    local function CreateHitboxVisual(Player)
        if not Player or not Player.Character then return end
        
        local RootPart = Player.Character:FindFirstChild("HumanoidRootPart")
        if not RootPart then return end
        
        -- Check if visual already exists
        if HitboxVisuals[Player] and HitboxVisuals[Player].Visual then
            return HitboxVisuals[Player].Visual
        end
        
        local size = GetHitboxSize()
        
        -- Create a transparent part as the base
        local VisualPart = Instance.new("Part")
        VisualPart.Name = "HitboxVisual"
        VisualPart.Anchored = true
        VisualPart.CanCollide = false
        VisualPart.CanQuery = false
        VisualPart.Transparency = 1
        VisualPart.Size = size
        VisualPart.Material = Enum.Material.SmoothPlastic
        VisualPart.BrickColor = BrickColor.new("Really red")
        VisualPart.Parent = workspace -- Parent to workspace instead of RootPart
        
        -- Create SelectionBox for clean outline (non-glowy)
        local SelectionBox = Instance.new("SelectionBox")
        SelectionBox.Adornee = VisualPart
        SelectionBox.Color3 = Color3.fromRGB(255, 255, 255)  -- Red outline
        SelectionBox.LineThickness = 0.02
        SelectionBox.Transparency = 0.1
        SelectionBox.Parent = VisualPart
        
        -- Store for cleanup
        if not HitboxVisuals[Player] then
            HitboxVisuals[Player] = {}
        end
        HitboxVisuals[Player].Visual = VisualPart
        HitboxVisuals[Player].SelectionBox = SelectionBox
        HitboxVisuals[Player].RootPart = RootPart
        
        return VisualPart
    end

    -- Remove hitbox visual for a player
    local function RemoveHitboxVisual(Player)
        if HitboxVisuals[Player] then
            if HitboxVisuals[Player].Visual then
                pcall(function() HitboxVisuals[Player].Visual:Destroy() end)
            end
            HitboxVisuals[Player] = nil
        end
    end

    -- Force update hitbox for a player
    local function UpdateHitbox(Player)
        if not Player or not Player.Character then return end
        
        local Character = Player.Character
        if not Character or not Character.Parent then return end
        
        local Humanoid = Character:FindFirstChildOfClass("Humanoid")
        if not Humanoid then return end
        
        local RootPart = Humanoid.RootPart
        if not RootPart then return end
        
        local size = GetHitboxSize()

        if RootPart then
            RootPart.CanCollide = false
            RootPart.Size = size
        else
            return
        end
        
        -- Update visual if visible
        if HitboxVisible then
            pcall(function()
                local Visual = HitboxVisuals[Player] and HitboxVisuals[Player].Visual
                if not Visual then
                    Visual = CreateHitboxVisual(Player)
                end
                if Visual then
                    Visual.Size = size
                    Visual.CFrame = RootPart.CFrame
                else
                    return
                end
            end)
        else
            RemoveHitboxVisual(Player)
        end
    end

    task.spawn(function()
        if HitboxEnabled then
            for _, Player in ipairs(Players:GetPlayers()) do
                if Player ~= Self then
                    UpdateHitbox(Player)
                end
            end
        else
            for Player in pairs(HitboxVisuals) do
                RemoveHitboxVisual(Player)
            end
        end
    end)

    -- Also update when characters are added
    local function OnCharacterAdded(Character)
        if HitboxEnabled then
            task.wait(0.1)
            local Player = Players:GetPlayerFromCharacter(Character)
            if Player and Player ~= Self then
                UpdateHitbox(Player)
            end
        end
    end

    -- Clean up when characters are removed
    local function OnCharacterRemoved(Character)
        local Player = Players:GetPlayerFromCharacter(Character)
        if Player then
            RemoveHitboxVisual(Player)
        end
    end

    -- Connect to existing players
    for _, Player in ipairs(Players:GetPlayers()) do
        if Player ~= Self then
            Player.CharacterAdded:Connect(OnCharacterAdded)
            Player.CharacterRemoved:Connect(OnCharacterRemoved)
            if Player.Character then
                task.wait(0.1)
                OnCharacterAdded(Player.Character)
            end
        end
    end

    -- Connect for players who join later
    Players.PlayerAdded:Connect(function(Player)
        if Player ~= Self then
            Player.CharacterAdded:Connect(OnCharacterAdded)
            Player.CharacterRemoved:Connect(OnCharacterRemoved)
        end
    end)

    -- Also update when character changes (for respawns)
    Self.CharacterAdded:Connect(function(Char)
        task.wait(0.5)
        for _, Player in ipairs(Players:GetPlayers()) do
            if Player ~= Self then
                UpdateHitbox(Player)
            end
        end
    end)

    -- ==================== WALL HOP SYSTEM ====================

    local WallHopEnabled = getgenv().saved.Osiris['Player']['Wall Hop']

    local WallHopOsiris = {
        TouchDistance       = 1.2,
        WallJumpUpBoost     = 60,
        WallJumpAwayBoost   = 18,
        WallNormalThreshold = 0.5,
        CooldownTime        = 0.25,
    }

    local canWallHop = true
    local isTouchingWallHop = false
    local currentWallHopNormal = nil
    local lastWallHopTime = 0

    local function getCharacter()
        local char = Self.Character
        if not char then return nil, nil, nil end
        local hum = char:FindFirstChild("Humanoid")
        local root = char:FindFirstChild("HumanoidRootPart")
        return char, hum, root
    end

    local hopRayParams = RaycastParams.new()
    hopRayParams.FilterType = Enum.RaycastFilterType.Exclude

    local function checkForWallHop()
        local char, hum, root = getCharacter()
        if not root then return false, nil end
        
        hopRayParams.FilterDescendantsInstances = {char}
        local origin = root.Position
        
        local directions = {
            Vector3.new(1, 0, 0), Vector3.new(-1, 0, 0),
            Vector3.new(0, 0, 1), Vector3.new(0, 0, -1),
            Vector3.new(0.7, 0, 0.7), Vector3.new(-0.7, 0, 0.7),
            Vector3.new(0.7, 0, -0.7), Vector3.new(-0.7, 0, -0.7)
        }
        
        for _, dir in ipairs(directions) do
            local result = workspace:Raycast(origin, dir * WallHopOsiris.TouchDistance, hopRayParams)
            if result then
                local normal = result.Normal
                if math.abs(normal.Y) < WallHopOsiris.WallNormalThreshold then
                    return true, normal
                end
            end
        end
        
        return false, nil
    end

    local function performWallHop()
        if not WallHopEnabled then return end
        if not canWallHop then return end
        if not isTouchingWallHop then return end
        
        local char, hum, root = getCharacter()
        if not hum or not root then return end
        if hum.Health <= 0 then return end
        
        local state = hum:GetState()
        if state == Enum.HumanoidStateType.Running or 
           state == Enum.HumanoidStateType.Landed or
           state == Enum.HumanoidStateType.Seated then
            return
        end
        
        if tick() - lastWallHopTime < WallHopOsiris.CooldownTime then return end
        
        local currentVel = root.AssemblyLinearVelocity
        
        local awayDir = Vector3.new(currentWallHopNormal.X, 0, currentWallHopNormal.Z)
        if awayDir.Magnitude > 0.01 then
            awayDir = awayDir.Unit
        else
            awayDir = Vector3.zero
        end
        
        root.AssemblyLinearVelocity = Vector3.new(
            currentVel.X + (awayDir.X * WallHopOsiris.WallJumpAwayBoost),
            WallHopOsiris.WallJumpUpBoost,
            currentVel.Z + (awayDir.Z * WallHopOsiris.WallJumpAwayBoost)
        )
        
        canWallHop = false
        lastWallHopTime = tick()
        
        task.wait(WallHopOsiris.CooldownTime)
        canWallHop = true
    end

    UserInputService.JumpRequest:Connect(function()
        if WallHopEnabled then
            performWallHop()
        end
    end)

    UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if gameProcessed then return end
        if input.KeyCode == Enum.KeyCode.Space and WallHopEnabled then
            performWallHop()
        end
    end)

    RunService.Heartbeat:Connect(function()
        local char, hum, root = getCharacter()
        if not char or not hum or hum.Health <= 0 then
            isTouchingWallHop = false
            return
        end
        
        local touching, normal = checkForWallHop()
        isTouchingWallHop = touching
        currentWallHopNormal = normal
    end)

    Self.CharacterAdded:Connect(function(newChar)
        task.wait(0.2)
        isTouchingWallHop = false
        currentWallHopNormal = nil
        canWallHop = true
        lastWallHopTime = 0
    end)
end

-- ===== BUTTON INTERACTIONS =====
-- Inject button hover
injectButton.MouseEnter:Connect(function()
    TweenService:Create(injectGlow, TweenInfo.new(0.2, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
        BackgroundTransparency = 0.85
    }):Play()
    TweenService:Create(injectButton, TweenInfo.new(0.2, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
        BackgroundColor3 = Color3.new(0.6, 0.6, 0.65)
    }):Play()
end)

injectButton.MouseLeave:Connect(function()
    TweenService:Create(injectGlow, TweenInfo.new(0.2, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
        BackgroundTransparency = 1
    }):Play()
    TweenService:Create(injectButton, TweenInfo.new(0.2, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
        BackgroundColor3 = Color3.new(0.5, 0.5, 0.55)
    }):Play()
end)

injectButton.MouseButton1Click:Connect(function()
    -- Pop animation
    TweenService:Create(injectButton, TweenInfo.new(0.08, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
        Size = UDim2.new(0, 360, 0, 38),
        Position = UDim2.new(0.5, -180, 0, 217)
    }):Play()
    task.wait(0.08)
    TweenService:Create(injectButton, TweenInfo.new(0.08, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
        Size = UDim2.new(0, 370, 0, 42),
        Position = UDim2.new(0.5, -185, 0, 215)
    }):Play()
    task.wait(0.1)
    
    -- Fade out and load main script
    fadeOutAndCleanup(LoadMainScript)
end)

-- Exit button hover
exitButton.MouseEnter:Connect(function()
    TweenService:Create(exitGlow, TweenInfo.new(0.2, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
        BackgroundTransparency = 0.85
    }):Play()
    TweenService:Create(exitButton, TweenInfo.new(0.2, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
        BackgroundColor3 = Color3.new(0.6, 0.6, 0.65)
    }):Play()
end)

exitButton.MouseLeave:Connect(function()
    TweenService:Create(exitGlow, TweenInfo.new(0.2, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
        BackgroundTransparency = 1
    }):Play()
    TweenService:Create(exitButton, TweenInfo.new(0.2, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
        BackgroundColor3 = Color3.new(0.5, 0.5, 0.55)
    }):Play()
end)

exitButton.MouseButton1Click:Connect(function()
    -- Pop animation
    TweenService:Create(exitButton, TweenInfo.new(0.08, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
        Size = UDim2.new(0, 360, 0, 38),
        Position = UDim2.new(0.5, -180, 0, 269)
    }):Play()
    task.wait(0.08)
    TweenService:Create(exitButton, TweenInfo.new(0.08, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
        Size = UDim2.new(0, 370, 0, 42),
        Position = UDim2.new(0.5, -185, 0, 267)
    }):Play()
    task.wait(0.1)
    
    -- Fade out and kick the player
    fadeOutAndCleanup(function()
        player:Kick("You have been kicked from the game.")
    end)
end)

-- Snow update function
local snowRunning = true

local function updateSnow(dt)
    for _, p in ipairs(particles) do
        local x = p:GetAttribute("X")
        local y = p:GetAttribute("Y")
        local speed = p:GetAttribute("Speed")
        local drift = p:GetAttribute("Drift")
        local driftTimer = p:GetAttribute("DriftTimer") or 0
        local driftChange = p:GetAttribute("DriftChange")
        local rot = p:GetAttribute("Rotation") or 0
        local rotSpeed = p:GetAttribute("RotSpeed")

        y = y + speed * dt * 60
        driftTimer = driftTimer + dt
        if driftTimer > driftChange then
            drift = (math.random() - 0.5) * 1.5
            driftChange = 2 + math.random() * 4
            driftTimer = 0
        end
        x = x + drift * dt * 25
        rot = rot + rotSpeed * dt * 30

        if x > 105 then x = -5 end
        if x < -5 then x = 105 end

        if y > 105 then
            y = -5 - math.random() * 10
            x = math.random(0, 100)
            speed = 0.3 + math.random() * 1.2
            drift = (math.random() - 0.5) * 1.5
            rotSpeed = (math.random() - 0.5) * 3
            local size = math.random(2, 6)
            p.Size = UDim2.new(0, size, 0, size)
            p.BackgroundTransparency = 0.15 + math.random() * 0.25
        end

        p.Position = UDim2.new(x / 100, 0, y / 100, 0)
        p.Rotation = rot

        p:SetAttribute("X", x)
        p:SetAttribute("Y", y)
        p:SetAttribute("Speed", speed)
        p:SetAttribute("Drift", drift)
        p:SetAttribute("DriftTimer", driftTimer)
        p:SetAttribute("DriftChange", driftChange)
        p:SetAttribute("Rotation", rot)
        p:SetAttribute("RotSpeed", rotSpeed)
    end
end

local snowConnection
local function startSnow()
    local lastTime = tick()
    snowConnection = RunService.Heartbeat:Connect(function()
        if not snowRunning then return end
        local now = tick()
        local dt = math.min(now - lastTime, 0.05)
        lastTime = now
        updateSnow(dt)
    end)
end
startSnow()

-- ===== MAIN SEQUENCE =====
task.wait(0.5)

-- Blur in (2s)
local blurIn = TweenService:Create(blur, TweenInfo.new(2, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), { Size = 18 })
blurIn:Play()
task.wait(2)

-- Logo fade in (1s)
local logoFadeIn = TweenService:Create(logoText, TweenInfo.new(1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), { 
    TextTransparency = 0 
})
logoFadeIn:Play()
task.wait(1)

-- Hold logo (3s)
task.wait(1)

-- Logo transitions to top-left (1.5s)
local logoDrag = TweenService:Create(logoText, TweenInfo.new(1.5, Enum.EasingStyle.Quart, Enum.EasingDirection.InOut), {
    Position = UDim2.new(0, 2, 0, 65),
    Size = UDim2.new(0, 250, 0, 50),
    TextSize = 56,
    TextTransparency = 0
})
logoDrag:Play()
task.wait(1.5)

-- Fade in main window
mainWindow.Visible = true

-- Fade window
local windowFade = TweenService:Create(mainWindow, TweenInfo.new(1.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
    BackgroundTransparency = 0.15
})
windowFade:Play()

-- Fade title
local titleFade = TweenService:Create(title, TweenInfo.new(1.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
    TextTransparency = 0
})
titleFade:Play()

-- Fade labels
local labels = {checkLabel1, checkLabel2, checkLabel3}
for _, label in ipairs(labels) do
    local t = TweenService:Create(label, TweenInfo.new(1.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
        TextTransparency = 0
    })
    t:Play()
end

-- Fade buttons
local buttonFade1 = TweenService:Create(injectButton, TweenInfo.new(1.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
    TextTransparency = 0
})
buttonFade1:Play()

local buttonFade2 = TweenService:Create(exitButton, TweenInfo.new(1.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
    TextTransparency = 0
})
buttonFade2:Play()

-- Start glow pulse animation
task.wait(0.5)

local glowPulseRunning = true
local function startGlowPulse()
    while glowPulseRunning do
        local pulse1 = TweenService:Create(glowFrame, TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
            BackgroundTransparency = 0.85
        })
        pulse1:Play()
        pulse1.Completed:Wait()
        
        if not glowPulseRunning then break end
        
        local pulse2 = TweenService:Create(glowFrame, TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
            BackgroundTransparency = 0.92
        })
        pulse2:Play()
        pulse2.Completed:Wait()
    end
end

task.spawn(startGlowPulse)

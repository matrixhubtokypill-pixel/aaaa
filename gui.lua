    --[[
        OsirisCC v3.5 — Black & Dark Crimson
        Fixed Dropdowns · Rebuilt Tabs · Source Integrated · All 6 fixes applied
    ]]

    local TweenService     = game:GetService("TweenService")
    local UserInputService = game:GetService("UserInputService")
    local RunService       = game:GetService("RunService")
    local CoreGui          = game:GetService("CoreGui")
    local HttpService      = game:GetService("HttpService")

    local Theme = {
        BaseVoid=Color3.fromRGB(6,6,8),BaseCharcoal=Color3.fromRGB(10,10,14),SurfaceRaised=Color3.fromRGB(16,16,22),SurfaceHover=Color3.fromRGB(24,24,32),SurfaceActive=Color3.fromRGB(28,18,20),SurfaceList=Color3.fromRGB(12,12,18),BorderDefault=Color3.fromRGB(30,30,38),BorderHover=Color3.fromRGB(48,26,26),BorderActive=Color3.fromRGB(95,14,14),CrimsonPrimary=Color3.fromRGB(139,0,0),CrimsonBright=Color3.fromRGB(175,28,28),CrimsonDeep=Color3.fromRGB(60,6,6),CrimsonShadow=Color3.fromRGB(35,3,3),TextPrimary=Color3.fromRGB(228,228,236),TextSecondary=Color3.fromRGB(148,148,160),TextDim=Color3.fromRGB(88,88,100),TextAccent=Color3.fromRGB(190,50,50),StatusOnline=Color3.fromRGB(46,139,87),StatusError=Color3.fromRGB(178,34,34),
    }

    getgenv = getgenv or function() return _G end
    getgenv().saved = getgenv().saved or {}
    getgenv().saved.Osiris = getgenv().saved.Osiris or {}

    local Defaults = {
        ["General"]={["Keybind"]={["Aim Assist"]="C",["Silent Aim Target"]="Y",["Visual"]="Z",["Walk Speed"]="T"},["Checks"]={["Visible"]=true,["Carried"]=true,["Knocked"]=true,["Self Knocked"]=true},["Targeting Mode"]="Auto"},
        ["Silent Aim"]={["Enabled"]=true,["Max Distance"]=1234,["Bullet Redirection"]=false,["Hit Part"]="Nearest Point",["Nearest Point"]={["Mode"]="Smart",["Scale"]=0.55},["Field Of View"]={["Enabled"]=true,["Visible"]=false,["Mode"]="2D",["Circle"]=150,["2D"]={["X"]=8,["Y"]=8},["Weapon Configuration"]={["Enabled"]=false,["Shotguns"]={["Circle"]=150,["2D"]={["X"]=8,["Y"]=8}},["Pistols"]={["Circle"]=150,["2D"]={["X"]=8,["Y"]=8}},["Automatics"]={["Circle"]=150,["2D"]={["X"]=8,["Y"]=8}}}}},
        ["Aim Assist"]={["Enabled"]=true,["Easing Style"]="Quad",["Easing Direction"]="Out",["Hit Part"]="Nearest Point",["Nearest Point"]={["Mode"]="Smart",["Scale"]=0.99},["Custom Parts"]={["Enabled"]=false,["Mode"]="Point",["Parts"]={"Head","UpperTorso","HumanoidRootPart","LowerTorso"}},["Snappiness"]=0.045,["Smart Snappiness"]={["Enabled"]=false,["Mode"]="Slow",["Min"]=0.025,["Max"]=0.085,["Speed"]={["Min"]=16,["Max"]=100}},["Prediction"]={["Enabled"]=false,["X"]=0.01,["Y"]=0.01,["Z"]=0.01}},
        ["Weapon Modifications"]={["Spread Modifier"]={["Enabled"]=true,["[Double-Barrel SG]"]={["Value"]=0.8},["[TacticalShotgun]"]={["Value"]=0.8},["[Shotgun]"]={["Value"]=0},["Randomizer"]={["Enabled"]=false,["Value"]=0.1}},["Skin Changer"]={["Enabled"]=true,["Weapons List"]={["[Double-Barrel SG]"]="Galaxy",["[Revolver]"]="Galaxy",["[TacticalShotgun]"]="Shadow",["[Knife]"]="GPO-Knife"}}},
        ["Walk Speed"]={["Enabled"]=true,["Speed"]=600},
        ["Hitbox Expander"]={["Enabled"]=false,["Target Only"]=true,["Visible"]=true,["Size"]={["X"]=3.2,["Y"]=5.6,["Z"]=3.1}},
        ["Player"]={["Anti Fall"]=true,["Wall Hop"]=false,["Avatar"]={["Enabled"]=false,["User ID"]=11437740757,["Custom Animations"]={["idle"]="rbxassetid://10921344533",["walk"]="rbxassetid://10921355261",["run"]="rbxassetid://616163682",["jump"]="rbxassetid://656117878",["fall"]="rbxassetid://656115606"},["Visual Headless"]=true},["Visual"]={["Enabled"]=false,["Target Name"]=false,["Names"]=true,["Distance"]=false,["Targeted Color"]=Color3.fromRGB(255,0,0),["Normal Color"]=Color3.fromRGB(255,255,255)}},
        ["Misc"]={["Delay"]=0.1,["Menu Keybind"]="RightShift",["Anti Aimview"] = true},
        ["Config"]={["CurrentName"]=""},
    }

    local function deepMerge(target, source)
        for key, value in pairs(source) do
            if type(value) == "table" then
                if type(target[key]) ~= "table" then target[key] = {} end
                deepMerge(target[key], value)
            else
                if target[key] == nil then target[key] = value end
            end
        end
    end
    deepMerge(getgenv().saved.Osiris, Defaults)

    local function getConfig(path)
        local current = getgenv().saved
        for _, key in ipairs(path) do
            if type(current) ~= "table" then return nil end
            current = current[key]
        end
        return current
    end

    local function setConfig(path, value)
        local current = getgenv().saved
        for i = 1, #path - 1 do
            if type(current[path[i]]) ~= "table" then current[path[i]] = {} end
            current = current[path[i]]
        end
        current[path[#path]] = value
        return value
    end

    local function SaveConfig(configName)
        pcall(function()
            if not isfolder("OsirisCC_configs") then makefolder("OsirisCC_configs") end
            writefile("OsirisCC_configs/" .. configName .. ".json", HttpService:JSONEncode(getgenv().saved.Osiris))
            pcall(function() game:GetService("StarterGui"):SetCore("SendNotification", {Title="OsirisCC",Text="Config saved: "..configName,Duration=3}) end)
        end)
    end

    local function LoadConfig(configName)
        local ok = pcall(function()
            local path = "OsirisCC_configs/" .. configName .. ".json"
            if not isfile(path) then return false end
            getgenv().saved.Osiris = HttpService:JSONDecode(readfile(path))
            getgenv().saved.Osiris.Player.Avatar.Animations = getgenv().saved.Osiris.Player.Avatar["Custom Animations"] -- [FIX 8]
            pcall(function() game:GetService("StarterGui"):SetCore("SendNotification", {Title="OsirisCC",Text="Config loaded: "..configName,Duration=3}) end)
            return true
        end)
        return ok
    end

    local function DeleteConfig(configName)
        pcall(function() local p="OsirisCC_configs/"..configName..".json"; if isfile(p) then delfile(p) end end)
    end

    local function GetConfigs()
        local configs = {}
        pcall(function()
            if not isfolder("OsirisCC_configs") then makefolder("OsirisCC_configs") return end
            for _, filePath in ipairs(listfiles("OsirisCC_configs")) do
                local name = filePath:match("OsirisCC_configs[/\\](.+)%.json$")
                if name then table.insert(configs, name) end
            end
        end)
        return configs
    end

    local function create(class, props, children)
        local instance = Instance.new(class)
        local parent = nil
        if props then for prop, value in pairs(props) do
            if prop == "Parent" then parent = value else instance[prop] = value end
        end end
        pcall(function() instance.BorderSizePixel = 0 end)
        if children then for _, child in ipairs(children) do child.Parent = instance end end
        if parent then instance.Parent = parent end
        return instance
    end

    local function tween(instance, props, duration, style, direction)
        local t = TweenService:Create(instance, TweenInfo.new(duration or 0.2, style or Enum.EasingStyle.Quad, direction or Enum.EasingDirection.Out), props)
        t:Play()
        return t
    end

    local function addCorner(parent, radius)
        return create("UICorner", { CornerRadius = UDim.new(0, radius), Parent = parent })
    end
    local function addStroke(parent, color, thickness)
        return create("UIStroke", { Color = color, Thickness = thickness or 1, ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Parent = parent })
    end
    local function addGradient(parent, color1, color2, rotation)
        return create("UIGradient", { Color = ColorSequence.new(color1, color2), Rotation = rotation or 90, Parent = parent })
    end

    local function getGuiParent()
        if type(gethui) == "function" then local ok, result = pcall(gethui); if ok and result then return result end end
        return CoreGui
    end
    local guiParent = getGuiParent()
    local old = guiParent:FindFirstChild("Osiris.cc")
    if old then old:Destroy() end

    local ScreenGui = create("ScreenGui", {Name="Osiris.cc",ResetOnSpawn=false,ZIndexBehavior=Enum.ZIndexBehavior.Sibling,DisplayOrder=999})
    if syn and syn.protect_gui then syn.protect_gui(ScreenGui) end
    ScreenGui.Parent = guiParent

        local MainWindow = create("Frame", {Name="MainWindow",Size=UDim2.new(0,780,0,0),Position=UDim2.new(0.5,-390,0.5,0),BackgroundColor3=Theme.BaseVoid,ClipsDescendants=true,Parent=ScreenGui})
    addCorner(MainWindow, 8); addStroke(MainWindow, Theme.BorderDefault, 1)

    local TopBar = create("Frame", {Name="TopBar",Size=UDim2.new(1,0,0,35),BackgroundColor3=Theme.BaseCharcoal,Parent=MainWindow})
    addCorner(TopBar, 8)
    create("Frame", {Size=UDim2.new(1,0,0,10),Position=UDim2.new(0,0,1,-10),BackgroundColor3=Theme.BaseCharcoal,Parent=TopBar})
    create("Frame", {Size=UDim2.new(1,0,0,1),Position=UDim2.new(0,0,1,0),BackgroundColor3=Theme.BorderDefault,Parent=TopBar})
    local Logo = create("ImageLabel", {Size=UDim2.new(0,47,0,47),Position=UDim2.new(0,-1,0.5,-22),BackgroundTransparency=1,Image="rbxassetid://129486495456925",ScaleType=Enum.ScaleType.Fit,Parent=TopBar})
    create("TextLabel", {Size=UDim2.new(0,220,0,35),Position=UDim2.new(0,45,0,0),BackgroundTransparency=1,Font=Enum.Font.Montserrat,TextSize=20,TextColor3=Theme.TextPrimary,TextXAlignment=Enum.TextXAlignment.Left,Text="Osiris.cc",Parent=TopBar})
    create("TextLabel", {Size=UDim2.new(0,70,0,36),Position=UDim2.new(1,-80,0,0),BackgroundTransparency=1,Font=Enum.Font.Montserrat,TextSize=11,TextColor3=Theme.TextDim,TextXAlignment=Enum.TextXAlignment.Left,Text="User Build",Parent=TopBar})
    create("TextLabel", {Size=UDim2.new(0,70,0,36),Position=UDim2.new(1,-600,0,1),BackgroundTransparency=1,Font=Enum.Font.Montserrat,TextSize=11,TextColor3=Theme.TextLoi,TextXAlignment=Enum.TextXAlignment.Left,Text="v1.0.2",Parent=TopBar})

    local TabBarContainer = create("Frame", {Name="TabBarContainer",Size=UDim2.new(1,-150,0,40),Position=UDim2.new(0,150,0,30),BackgroundColor3=Theme.BaseCharcoal,Parent=MainWindow})
    create("Frame", {Size=UDim2.new(1,0,0,1),Position=UDim2.new(0,0,1,0),BackgroundColor3=Theme.BorderDefault,Parent=TabBarContainer})
    local TabBar = create("Frame", {Size=UDim2.new(1,-20,1,0),Position=UDim2.new(0,10,0,0),BackgroundTransparency=1,Parent=TabBarContainer})
    create("UIListLayout", {Padding=UDim.new(0,0),FillDirection=Enum.FillDirection.Horizontal,HorizontalAlignment=Enum.HorizontalAlignment.Left,VerticalAlignment=Enum.VerticalAlignment.Center,Parent=TabBar})
    local TabUnderline = create("Frame", {Name="Underline",Size=UDim2.new(0,0,0,2),Position=UDim2.new(0,0,1,-1),BackgroundColor3=Theme.CrimsonPrimary,BackgroundTransparency=1,Parent=TabBarContainer})
    addCorner(TabUnderline, 1)

    local Sidebar = create("Frame", {Name="Sidebar",Size=UDim2.new(0,150,1,-36),Position=UDim2.new(0,0,0,36),BackgroundColor3=Theme.BaseCharcoal,Parent=MainWindow})
    addCorner(Sidebar, 8)
    create("Frame", {Size=UDim2.new(1,0,0,10),BackgroundColor3=Theme.BaseCharcoal,Parent=Sidebar})
    create("Frame", {Size=UDim2.new(0,1,1,0),Position=UDim2.new(1,-1,0,0),BackgroundColor3=Theme.BorderDefault,Parent=Sidebar})
    local SidebarIndicator = create("Frame", {Name="SidebarIndicator",Size=UDim2.new(0,2,0,16),Position=UDim2.new(0,0,0,0),BackgroundColor3=Theme.CrimsonPrimary,BackgroundTransparency=1,ZIndex=10,Visible=false,Parent=Sidebar})
    addCorner(SidebarIndicator, 1)
    local SidebarList = create("Frame", {Size=UDim2.new(1,0,1,-20),Position=UDim2.new(0,0,0,12),BackgroundTransparency=1,Parent=Sidebar})
    create("UIListLayout", {Padding=UDim.new(0,4),Parent=SidebarList})
    create("UIPadding", {PaddingLeft=UDim.new(0,10),PaddingRight=UDim.new(0,6),Parent=SidebarList})

    local ContentArea = create("Frame", {Name="ContentArea",Size=UDim2.new(1,-150,1,-70),Position=UDim2.new(0,150,0,71),BackgroundColor3=Theme.BaseVoid,Parent=MainWindow})
    addCorner(ContentArea, 8)
    create("Frame", {Size=UDim2.new(1,0,0,10),BackgroundColor3=Theme.BaseVoid,Parent=ContentArea})
    local DropdownOverlay = create("Frame", {Name="DropdownOverlay",Size=UDim2.new(1,0,1,0),BackgroundTransparency=1,ClipsDescendants=false,ZIndex=50,Parent=MainWindow})

    local Categories = {
        {name="General",tabs={"General"}},
        {name="Combat",tabs={"Silent Aim","Aim Assist"}},
        {name="Weapons",tabs={"Weapon Modifications"}},
        {name="Movement",tabs={"Walk Speed"}},
        {name="Misc",tabs={"Hitbox Expander","Player","Misc"}},
        {name="Config",tabs={"Config"}},
    }
    local categoryButtons = {}
    local tabButtons = {}
    local currentCategory = nil
    local currentTab = nil
    local isBindingKey = false
    local activeDropdown = nil
    local function closeActiveDropdown()
        if activeDropdown then local fn = activeDropdown; activeDropdown = nil; fn() end
    end
    local createSection, createToggle, createSlider, createDropdown
    local createCheckbox, createKeybind, createTextInput, createButton
    local TabBuilders
    local selectCategory, selectTab
    local currentMenuKey, currentToggleTween

    createSection = function(parent, title)
        local container = create("Frame", {Size=UDim2.new(1,0,0,0),AutomaticSize=Enum.AutomaticSize.Y,BackgroundTransparency=1,Parent=parent})
        if title and #title > 0 then
            create("TextLabel", {Size=UDim2.new(1,0,0,14),BackgroundTransparency=1,Font=Enum.Font.Montserrat,TextSize=10,TextColor3=Theme.TextDim,TextXAlignment=Enum.TextXAlignment.Left,Text=string.upper(title),Parent=container})
        end
        local content = create("Frame", {Size=UDim2.new(1,0,0,0),Position=UDim2.new(0,0,0,(title and #title > 0) and 20 or 0),AutomaticSize=Enum.AutomaticSize.Y,BackgroundTransparency=1,Parent=container})
        create("UIListLayout", {Padding=UDim.new(0,4),Parent=content})
        return content
    end

    createToggle = function(parent, labelText, configPath)
        local state = getConfig(configPath) or false
        local row = create("Frame", {BackgroundTransparency=1,Size=UDim2.new(1,0,0,28),Parent=parent})
        create("TextLabel", {Size=UDim2.new(1,-56,1,0),BackgroundTransparency=1,Font=Enum.Font.Montserrat,TextSize=13,TextColor3=Theme.TextSecondary,TextXAlignment=Enum.TextXAlignment.Left,Text=labelText,Parent=row})
        local glow = create("ImageLabel", {Size=UDim2.new(0,56,0,32),Position=UDim2.new(1,-48,0.5,-16),BackgroundTransparency=1,Image="rbxassetid://5028857084",ImageColor3=Theme.CrimsonDeep,ImageTransparency=1,ZIndex=0,Parent=row})
        local bg = create("TextButton", {Size=UDim2.new(0,40,0,20),Position=UDim2.new(1,-40,0.5,-10),BackgroundColor3=Theme.SurfaceRaised,Text="",AutoButtonColor=false,Parent=row})
        addCorner(bg, 10); local stroke = addStroke(bg, Theme.BorderDefault, 1)
        local fill = create("Frame", {Size=UDim2.new(1,0,1,0),BackgroundColor3=Theme.CrimsonPrimary,BackgroundTransparency=1,Parent=bg})
        addCorner(fill, 10); addGradient(fill, Theme.CrimsonPrimary, Theme.CrimsonDeep, 90)
        local circle = create("Frame", {Size=UDim2.new(0,14,0,14),Position=UDim2.new(0,3,0.5,-7),BackgroundColor3=Theme.TextPrimary,Parent=bg})
        addCorner(circle, 7); addStroke(circle, Theme.BorderDefault, 1)
        local function updateState(animate)
            local d = animate and 0.18 or 0
            if state then
                tween(circle, {Position=UDim2.new(1,-17,0.5,-7)}, d, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
                tween(fill, {BackgroundTransparency=0}, animate and 0.15 or 0)
                tween(glow, {ImageTransparency=0.5}, animate and 0.2 or 0, Enum.EasingStyle.Sine)
                tween(stroke, {Color=Theme.CrimsonBright}, animate and 0.15 or 0)
                tween(circle, {BackgroundColor3=Color3.fromRGB(255,240,240)}, animate and 0.15 or 0)
            else
                tween(circle, {Position=UDim2.new(0,3,0.5,-7)}, d, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
                tween(fill, {BackgroundTransparency=1}, animate and 0.15 or 0)
                tween(glow, {ImageTransparency=1}, animate and 0.2 or 0, Enum.EasingStyle.Sine)
                tween(stroke, {Color=Theme.BorderDefault}, animate and 0.15 or 0)
                tween(circle, {BackgroundColor3=Theme.TextPrimary}, animate and 0.15 or 0)
            end
        end
        updateState(false)
        bg.MouseEnter:Connect(function() if not state then tween(bg, {BackgroundColor3=Theme.SurfaceHover}, 0.12) end end)
        bg.MouseLeave:Connect(function() if not state then tween(bg, {BackgroundColor3=Theme.SurfaceRaised}, 0.12) end end)
        bg.MouseButton1Click:Connect(function() state = not state; setConfig(configPath, state); updateState(true) end)
        return row
    end

    createSlider = function(parent, labelText, configPath, minVal, maxVal, defaultVal, suffix, decimals)
        local value = getConfig(configPath); if value == nil then value = defaultVal end
        suffix = suffix or ""; decimals = decimals or 0
        local function formatValue(val)
            if decimals > 0 then return string.format("%." .. decimals .. "f", val) .. suffix
            else return tostring(math.floor(val + 0.5)) .. suffix end
        end
        local row = create("Frame", {BackgroundTransparency=1,Size=UDim2.new(1,0,0,38),Parent=parent})
        create("TextLabel", {Size=UDim2.new(1,-60,0,16),BackgroundTransparency=1,Font=Enum.Font.Montserrat,TextSize=13,TextColor3=Theme.TextSecondary,TextXAlignment=Enum.TextXAlignment.Left,Text=labelText,Parent=row})
        local valueBox = create("Frame", {Size=UDim2.new(0,52,0,20),Position=UDim2.new(1,-52,0,0),BackgroundColor3=Theme.SurfaceRaised,Parent=row})
        addCorner(valueBox, 4); local valueStroke = addStroke(valueBox, Theme.BorderDefault, 1)
        local valueText = create("TextBox", {Size=UDim2.new(1,-8,1,0),Position=UDim2.new(0,4,0,0),BackgroundTransparency=1,Font=Enum.Font.Montserrat,TextSize=11,TextColor3=Theme.TextPrimary,Text=formatValue(value),TextXAlignment=Enum.TextXAlignment.Center,ClearTextOnFocus=false,Parent=valueBox})
        local track = create("TextButton", {Size=UDim2.new(1,0,0,18),Position=UDim2.new(0,0,0,20),BackgroundTransparency=1,Text="",AutoButtonColor=false,Parent=row})
        local trackBar = create("Frame", {Size=UDim2.new(1,0,0,3),Position=UDim2.new(0,0,0.5,-1.5),BackgroundColor3=Theme.BorderDefault,Parent=track})
        addCorner(trackBar, 1.5)
        local fill = create("Frame", {Size=UDim2.new((value-minVal)/(maxVal-minVal),0,1,0),BackgroundColor3=Theme.CrimsonPrimary,Parent=trackBar})
        addCorner(fill, 1.5); addGradient(fill, Theme.CrimsonPrimary, Theme.CrimsonDeep, 0)
        local grabber = create("Frame", {Size=UDim2.new(0,12,0,12),Position=UDim2.new((value-minVal)/(maxVal-minVal),-6,0.5,-6),BackgroundColor3=Theme.TextPrimary,Parent=trackBar})
        addCorner(grabber, 6); addStroke(grabber, Theme.BorderDefault, 1)
        local grabberGlow = create("ImageLabel", {Size=UDim2.new(0,26,0,26),Position=UDim2.new(0.5,-13,0.5,-13),BackgroundTransparency=1,Image="rbxassetid://5028857084",ImageColor3=Theme.CrimsonDeep,ImageTransparency=1,ZIndex=0,Parent=grabber})
        local function updateValue(val, instant)
            val = math.clamp(val, minVal, maxVal); value = val; setConfig(configPath, val)
            local pct = (val - minVal) / (maxVal - minVal)
            if instant then fill.Size = UDim2.new(pct,0,1,0); grabber.Position = UDim2.new(pct,-6,0.5,-6)
            else tween(fill, {Size=UDim2.new(pct,0,1,0)}, 0.1); tween(grabber, {Position=UDim2.new(pct,-6,0.5,-6)}, 0.1) end
            valueText.Text = formatValue(val)
        end
        local dragging = false
        track.MouseButton1Down:Connect(function()
            dragging = true
            tween(grabber, {Size=UDim2.new(0,16,0,16)}, 0.12, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
            tween(grabberGlow, {ImageTransparency=0.3}, 0.15)
            local mPos = UserInputService:GetMouseLocation(); local tPos = trackBar.AbsolutePosition; local tW = trackBar.AbsoluteSize.X
            updateValue(minVal + math.clamp((mPos.X - tPos.X) / tW, 0, 1) * (maxVal - minVal), true)
        end)
        UserInputService.InputChanged:Connect(function(input)
            if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                local mPos = UserInputService:GetMouseLocation(); local tPos = trackBar.AbsolutePosition; local tW = trackBar.AbsoluteSize.X
                updateValue(minVal + math.clamp((mPos.X - tPos.X) / tW, 0, 1) * (maxVal - minVal), true)
            end
        end)
        UserInputService.InputEnded:Connect(function(input)
            if dragging and input.UserInputType == Enum.UserInputType.MouseButton1 then
                dragging = false
                tween(grabber, {Size=UDim2.new(0,12,0,12)}, 0.12, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
                tween(grabberGlow, {ImageTransparency=1}, 0.15)
            end
        end)
        valueText.Focused:Connect(function() tween(valueStroke, {Color=Theme.BorderActive}, 0.15) end)
        valueText.FocusLost:Connect(function()
            local txt = valueText.Text:gsub("%s", "")
            if suffix and #suffix > 0 and txt:sub(-#suffix) == suffix then txt = txt:sub(1, -#suffix - 1) end
            local num = tonumber(txt)
            if num then updateValue(num) else valueText.Text = formatValue(value) end
            tween(valueStroke, {Color=Theme.BorderDefault}, 0.15)
        end)
        return row
    end

    createDropdown = function(parent, labelText, configPath, options)
        local selected = getConfig(configPath) or options[1]
        local isOpen = false
        local itemHeight = 24
        local maxVisibleItems = 6
        local listItems = {}
        local container = create("Frame", {BackgroundTransparency=1,Size=UDim2.new(1,0,0,44),Parent=parent})
        create("TextLabel", {Size=UDim2.new(1,0,0,14),BackgroundTransparency=1,Font=Enum.Font.Montserrat,TextSize=13,TextColor3=Theme.TextSecondary,TextXAlignment=Enum.TextXAlignment.Left,Text=labelText,Parent=container})
        local button = create("TextButton", {Size=UDim2.new(1,0,0,26),Position=UDim2.new(0,0,0,16),BackgroundColor3=Theme.SurfaceRaised,Text="",AutoButtonColor=false,ZIndex=2,Parent=container})
        addCorner(button, 4); local border = addStroke(button, Theme.BorderDefault, 1)
        local selectedText = create("TextLabel", {Size=UDim2.new(1,-30,1,0),Position=UDim2.new(0,10,0,0),BackgroundTransparency=1,Font=Enum.Font.Montserrat,TextSize=12,TextColor3=Theme.TextPrimary,TextXAlignment=Enum.TextXAlignment.Left,Text=selected,ZIndex=2,Parent=button})
        local arrow = create("ImageLabel", {Size=UDim2.new(0,10,0,10),Position=UDim2.new(1,-20,0.5,-5),BackgroundTransparency=1,Image="rbxassetid://6031094678",ImageColor3=Theme.TextDim,ZIndex=2,Parent=button})
        local listFrame = create("Frame", {Size=UDim2.new(0,0,0,0),BackgroundColor3=Theme.SurfaceList,ClipsDescendants=true,Visible=false,ZIndex=100,Parent=DropdownOverlay})
        addCorner(listFrame, 4); addStroke(listFrame, Theme.BorderDefault, 1)
        local listScroll = create("ScrollingFrame", {Size=UDim2.new(1,0,1,0),BackgroundTransparency=1,ScrollBarThickness=2,ScrollBarImageColor3=Theme.CrimsonDeep,ScrollBarImageTransparency=0.5,CanvasSize=UDim2.new(0,0,0,0),AutomaticCanvasSize=Enum.AutomaticSize.Y,Parent=listFrame})
        create("UIListLayout", {Padding=UDim.new(0,0),Parent=listScroll})
        for i, option in ipairs(options) do
            local item = create("TextButton", {Size=UDim2.new(1,0,0,itemHeight),BackgroundTransparency=1,Font=Enum.Font.Montserrat,TextSize=12,TextColor3=(option==selected) and Theme.TextAccent or Theme.TextSecondary,TextXAlignment=Enum.TextXAlignment.Left,Text="    "..option,TextTransparency=1,AutoButtonColor=false,Parent=listScroll})
            addCorner(item, 3) -- [FIX 3] Cantos redondo
            local selectedBar = create("Frame", {Size=UDim2.new(0,2,0,12),Position=UDim2.new(0,6,0.5,-6),BackgroundColor3=Theme.CrimsonPrimary,BackgroundTransparency=(option==selected) and 0 or 1,Parent=item})
            addCorner(selectedBar, 1)
            item.MouseEnter:Connect(function() tween(item, {BackgroundTransparency=0.85}, 0.1); item.BackgroundColor3=Theme.SurfaceHover; if option~=selected then tween(item, {TextColor3=Theme.TextPrimary}, 0.1) end end)
            item.MouseLeave:Connect(function() tween(item, {BackgroundTransparency=1}, 0.1); if option~=selected then tween(item, {TextColor3=Theme.TextSecondary}, 0.1) end end)
            item.MouseButton1Click:Connect(function()
                selected = option; setConfig(configPath, selected); selectedText.Text = selected
                for _, di in ipairs(listItems) do
                    if di.option == selected then di.item.TextColor3 = Theme.TextAccent; tween(di.bar, {BackgroundTransparency=0}, 0.15)
                    else di.item.TextColor3 = Theme.TextSecondary; tween(di.bar, {BackgroundTransparency=1}, 0.15) end
                end
                closeDropdown()
            end)
            table.insert(listItems, {item=item, bar=selectedBar, option=option})
        end
        local targetHeight = math.min(itemHeight * #options, itemHeight * maxVisibleItems) + 4
        local function closeDropdown()
            isOpen = false
            if activeDropdown == closeDropdown then activeDropdown = nil end
            tween(arrow, {Rotation=0}, 0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
            tween(listFrame, {Size=UDim2.new(0,listFrame.AbsoluteSize.X,0,0)}, 0.18, Enum.EasingStyle.Quint, Enum.EasingDirection.In)
            tween(border, {Color=Theme.BorderDefault}, 0.15)
            tween(button, {BackgroundColor3=Theme.SurfaceRaised}, 0.15)
            task.delay(0.2, function() if not isOpen then listFrame.Visible = false end end)
        end
        local function openDropdown()
            if activeDropdown and activeDropdown ~= closeDropdown then activeDropdown() end
            isOpen = true; activeDropdown = closeDropdown
            local btnPos = button.AbsolutePosition; local btnSize = button.AbsoluteSize; local winPos = MainWindow.AbsolutePosition
            local relX = btnPos.X - winPos.X; local relY = btnPos.Y - winPos.Y + btnSize.Y
            local listBottom = relY + targetHeight; local winHeight = MainWindow.AbsoluteSize.Y
            if listBottom > winHeight then relY = btnPos.Y - winPos.Y - targetHeight - 2 end
            listFrame.Position = UDim2.new(0, relX, 0, relY)
            listFrame.Size = UDim2.new(0, btnSize.X, 0, 0)
            listFrame.Visible = true
            tween(arrow, {Rotation=180}, 0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
            tween(listFrame, {Size=UDim2.new(0, btnSize.X, 0, targetHeight)}, 0.22, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
            tween(border, {Color=Theme.BorderActive}, 0.15)
            tween(button, {BackgroundColor3=Theme.SurfaceHover}, 0.15)
            for i, li in ipairs(listItems) do
                li.item.TextTransparency = 1
                task.delay(0.04 + i * 0.02, function() if isOpen then tween(li.item, {TextTransparency=0}, 0.15) end end)
            end
        end
        button.MouseEnter:Connect(function() if not isOpen then tween(button, {BackgroundColor3=Theme.SurfaceHover}, 0.12) end end)
        button.MouseLeave:Connect(function() if not isOpen then tween(button, {BackgroundColor3=Theme.SurfaceRaised}, 0.12) end end)
        button.MouseButton1Click:Connect(function() if isOpen then closeDropdown() else openDropdown() end end)
        UserInputService.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 and isOpen then
                local mPos = UserInputService:GetMouseLocation()
                local listPos = listFrame.AbsolutePosition; local listSize = listFrame.AbsoluteSize
                local btnPos = button.AbsolutePosition; local btnSize = button.AbsoluteSize
                local inList = mPos.X >= listPos.X and mPos.X <= listPos.X + listSize.X and mPos.Y >= listPos.Y and mPos.Y <= listPos.Y + listSize.Y
                local inBtn = mPos.X >= btnPos.X and mPos.X <= btnPos.X + btnSize.X and mPos.Y >= btnPos.Y and mPos.Y <= btnPos.Y + btnSize.Y
                if not inList and not inBtn then closeDropdown() end
            end
        end)
        return container
    end

    createCheckbox = function(parent, labelText, configPath)
        local state = getConfig(configPath) or false
        local row = create("Frame", {BackgroundTransparency=1,Size=UDim2.new(1,0,0,24),Parent=parent})
        local checkbox = create("TextButton", {Size=UDim2.new(0,16,0,16),Position=UDim2.new(0,0,0.5,-8),BackgroundColor3=Theme.SurfaceRaised,Text="",AutoButtonColor=false,Parent=row})
        addCorner(checkbox, 4); local cbStroke = addStroke(checkbox, Theme.BorderDefault, 1)
        local checkmark = create("ImageLabel", {Size=UDim2.new(0,10,0,10),Position=UDim2.new(0.5,-5,0.5,-5),BackgroundTransparency=1,Image="rbxassetid://6031094678",ImageColor3=Theme.TextPrimary,ImageTransparency=1,Parent=checkbox})
        create("TextLabel", {Size=UDim2.new(1,-24,1,0),Position=UDim2.new(0,22,0,0),BackgroundTransparency=1,Font=Enum.Font.Montserrat,TextSize=13,TextColor3=Theme.TextSecondary,TextXAlignment=Enum.TextXAlignment.Left,Text=labelText,Parent=row})
        local function updateState()
            if state then
                tween(checkbox, {BackgroundColor3=Theme.CrimsonPrimary}, 0.15)
                tween(cbStroke, {Color=Theme.CrimsonBright}, 0.15)
                checkmark.Size = UDim2.new(0,5,0,5); checkmark.ImageTransparency = 1
                task.delay(0.02, function() tween(checkmark, {ImageTransparency=0,Size=UDim2.new(0,10,0,10)}, 0.22, Enum.EasingStyle.Back, Enum.EasingDirection.Out) end)
            else
                tween(checkbox, {BackgroundColor3=Theme.SurfaceRaised}, 0.15)
                tween(cbStroke, {Color=Theme.BorderDefault}, 0.15)
                tween(checkmark, {ImageTransparency=1,Size=UDim2.new(0,5,0,5)}, 0.15)
            end
        end
        updateState()
        checkbox.MouseButton1Click:Connect(function() state = not state; setConfig(configPath, state); updateState() end)
        return row
    end

    createKeybind = function(parent, labelText, configPath, onChanged)
        local currentKey = getConfig(configPath) or "None"
        local listening = false
        local row = create("Frame", {BackgroundTransparency=1,Size=UDim2.new(1,0,0,24),Parent=parent})
        create("TextLabel", {Size=UDim2.new(1,-72,1,0),BackgroundTransparency=1,Font=Enum.Font.Montserrat,TextSize=13,TextColor3=Theme.TextSecondary,TextXAlignment=Enum.TextXAlignment.Left,Text=labelText,Parent=row})
        local keyBtn = create("TextButton", {Size=UDim2.new(0,66,0,22),Position=UDim2.new(1,-66,0.5,-11),BackgroundColor3=Theme.SurfaceRaised,Font=Enum.Font.Montserrat,TextSize=11,TextColor3=Theme.TextPrimary,Text=currentKey,AutoButtonColor=false,Parent=row})
        addCorner(keyBtn, 4); local keyStroke = addStroke(keyBtn, Theme.BorderDefault, 1)
        keyBtn.MouseEnter:Connect(function() if not listening then tween(keyBtn, {BackgroundColor3=Theme.SurfaceHover}, 0.12) end end)
        keyBtn.MouseLeave:Connect(function() if not listening then tween(keyBtn, {BackgroundColor3=Theme.SurfaceRaised}, 0.12) end end)
        keyBtn.MouseButton1Click:Connect(function()
            listening = true; isBindingKey = true; keyBtn.Text = "..."
            tween(keyBtn, {BackgroundColor3=Theme.CrimsonDeep}, 0.15)
            tween(keyStroke, {Color=Theme.CrimsonBright}, 0.15)
        end)
        UserInputService.InputBegan:Connect(function(input, gpe)
            if listening and input.UserInputType == Enum.UserInputType.Keyboard then
                currentKey = input.KeyCode.Name; setConfig(configPath, currentKey); keyBtn.Text = currentKey
                listening = false; isBindingKey = false
                tween(keyBtn, {BackgroundColor3=Theme.SurfaceRaised}, 0.15)
                tween(keyStroke, {Color=Theme.BorderDefault}, 0.15)
                if onChanged then onChanged(currentKey) end
            end
        end)
        return row
    end

    createTextInput = function(parent, labelText, configPath, placeholder)
        local currentVal = getConfig(configPath); if currentVal == nil then currentVal = "" end; currentVal = tostring(currentVal)
        local row = create("Frame", {BackgroundTransparency=1,Size=UDim2.new(1,0,0,46),Parent=parent})
        create("TextLabel", {Size=UDim2.new(1,0,0,14),BackgroundTransparency=1,Font=Enum.Font.Montserrat,TextSize=13,TextColor3=Theme.TextSecondary,TextXAlignment=Enum.TextXAlignment.Left,Text=labelText,Parent=row})
        local inputBox = create("Frame", {Size=UDim2.new(1,0,0,26),Position=UDim2.new(0,0,0,18),BackgroundColor3=Theme.SurfaceRaised,Parent=row})
        addCorner(inputBox, 4); local inputStroke = addStroke(inputBox, Theme.BorderDefault, 1)
        local inputGlow = create("ImageLabel", {Size=UDim2.new(1,10,0,36),Position=UDim2.new(0,-5,0.5,-5),BackgroundTransparency=1,Image="rbxassetid://5028857084",ImageColor3=Theme.CrimsonDeep,ImageTransparency=1,ZIndex=0,Parent=inputBox})
        local textBox = create("TextBox", {Size=UDim2.new(1,-16,1,0),Position=UDim2.new(0,8,0,0),BackgroundTransparency=1,Font=Enum.Font.Montserrat,TextSize=12,TextColor3=Theme.TextPrimary,PlaceholderText=placeholder or "",PlaceholderColor3=Theme.TextDim,Text=currentVal,ClearTextOnFocus=false,TextXAlignment=Enum.TextXAlignment.Left,Parent=inputBox})
        textBox.Focused:Connect(function() tween(inputStroke, {Color=Theme.BorderActive}, 0.15); tween(inputGlow, {ImageTransparency=0.7}, 0.2) end)
        textBox.FocusLost:Connect(function() if configPath then setConfig(configPath, textBox.Text) end; tween(inputStroke, {Color=Theme.BorderDefault}, 0.15); tween(inputGlow, {ImageTransparency=1}, 0.2) end)
        return row, textBox
    end

    createButton = function(parent, buttonText, callback)
        local btn = create("TextButton", {Size=UDim2.new(1,0,0,28),BackgroundColor3=Theme.SurfaceRaised,Font=Enum.Font.Montserrat,TextSize=12,TextColor3=Theme.TextPrimary,Text=buttonText,AutoButtonColor=false,Parent=parent})
        addCorner(btn, 4); local btnStroke = addStroke(btn, Theme.BorderDefault, 1)
        local hoverOverlay = create("Frame", {Size=UDim2.new(1,0,1,0),BackgroundColor3=Theme.CrimsonShadow,BackgroundTransparency=1,Parent=btn})
        addCorner(hoverOverlay, 4)
        btn.MouseEnter:Connect(function() tween(hoverOverlay, {BackgroundTransparency=0.6}, 0.15, Enum.EasingStyle.Sine); tween(btnStroke, {Color=Theme.BorderHover}, 0.15) end)
        btn.MouseLeave:Connect(function() tween(hoverOverlay, {BackgroundTransparency=1}, 0.15, Enum.EasingStyle.Sine); tween(btnStroke, {Color=Theme.BorderDefault}, 0.15) end)
        btn.MouseButton1Down:Connect(function() tween(btn, {Size=UDim2.new(0.98,0,0,26)}, 0.06, Enum.EasingStyle.Quad, Enum.EasingDirection.Out); tween(hoverOverlay, {BackgroundTransparency=0.4}, 0.05) end)
        btn.MouseButton1Up:Connect(function() tween(btn, {Size=UDim2.new(1,0,0,28)}, 0.1, Enum.EasingStyle.Back, Enum.EasingDirection.Out); tween(hoverOverlay, {BackgroundTransparency=0.6}, 0.08) end)
        btn.MouseButton1Click:Connect(function() if callback then callback() end end)
        return btn
    end

    -- ================================================================
    -- DROPDOWN OPTION LISTS [FIX 1+2]
    -- ================================================================
    local R15Parts = {"Head","UpperTorso","LowerTorso","HumanoidRootPart","LeftUpperArm","LeftLowerArm","LeftHand","RightUpperArm","RightLowerArm","RightHand","LeftUpperLeg","LeftLowerLeg","LeftFoot","RightUpperLeg","RightLowerLeg","RightFoot"}
    local GunSkins = {"Golden Age","Christmas Wrap","Galaxy","Wild West","Ninja","Iced Out","Reptile","Heaven","Electric","Blue Wrap","Dragon","Inferno","Luck","Valentine","Magma","Shadow","Rainbow","Fish","Red Skull","Patriot","Red Hot","Snow Wrap","Matrix"}
    local KnifeSkins = {"Golden Age Tanto","GPO-Knife","GPO-Knife Prestige","Heaven","Love Kukri","Purple Dagger","Blue Dagger","Green Dagger","Red Dagger","Portal","Emerald Butterfly","Boy","Girl","Dragon","Void","Wild West","Iced Out","Reptile","Emerald"}

    -- ================================================================
    -- TAB CONTENT BUILDERS
    -- ================================================================
    TabBuilders = {}

    TabBuilders["General"] = function(parent)
        local sec1 = createSection(parent, "Keybinds")
        createKeybind(sec1, "Aim Assist",        {"Osiris", "General", "Keybind", "Aim Assist"})
        createKeybind(sec1, "Silent Aim Target", {"Osiris", "General", "Keybind", "Silent Aim Target"})
        createKeybind(sec1, "Visual",            {"Osiris", "General", "Keybind", "Visual"})
        createKeybind(sec1, "Walk Speed",        {"Osiris", "General", "Keybind", "Walk Speed"})
        local sec2 = createSection(parent, "Target Checks")
        createCheckbox(sec2, "Visible",      {"Osiris", "General", "Checks", "Visible"})
        createCheckbox(sec2, "Carried",      {"Osiris", "General", "Checks", "Carried"})
        createCheckbox(sec2, "Knocked",      {"Osiris", "General", "Checks", "Knocked"})
        createCheckbox(sec2, "Self Knocked", {"Osiris", "General", "Checks", "Self Knocked"})
        local sec3 = createSection(parent, "Targeting")
        createDropdown(sec3, "Targeting Mode", {"Osiris", "General", "Targeting Mode"}, {"Auto", "Toggle"})
    end

    TabBuilders["Silent Aim"] = function(parent)
        local sec1 = createSection(parent, "Configuration")
        createToggle(sec1, "Enabled",            {"Osiris", "Silent Aim", "Enabled"})
        createSlider(sec1, "Max Distance",       {"Osiris", "Silent Aim", "Max Distance"}, 0, 5000, 1234, " studs")
        createToggle(sec1, "Bullet Redirection",{"Osiris", "Silent Aim", "Bullet Redirection"})
        createDropdown(sec1, "Hit Part",         {"Osiris", "Silent Aim", "Hit Part"}, {"Nearest Point","Nearest Part","Head","UpperTorso","HumanoidRootPart","LowerTorso"})
        local sec2 = createSection(parent, "Nearest Point")
        createDropdown(sec2, "Mode",  {"Osiris", "Silent Aim", "Nearest Point", "Mode"}, {"Smart", "Basic"})
        createSlider(sec2, "Scale",   {"Osiris", "Silent Aim", "Nearest Point", "Scale"}, 0.01, 1, 0.55, "", 2)
        local sec3 = createSection(parent, "Field Of View")
        createToggle(sec3,  "FOV Enabled", {"Osiris", "Silent Aim", "Field Of View", "Enabled"})
        createToggle(sec3,  "FOV Visible", {"Osiris", "Silent Aim", "Field Of View", "Visible"})
        createDropdown(sec3, "FOV Mode",   {"Osiris", "Silent Aim", "Field Of View", "Mode"}, {"Circle", "2D"})
        createSlider(sec3,  "Circle Size", {"Osiris", "Silent Aim", "Field Of View", "Circle"}, 10, 500, 150, "px")
        createSlider(sec3,  "2D X",        {"Osiris", "Silent Aim", "Field Of View", "2D", "X"}, 1, 50, 8, "px")
        createSlider(sec3,  "2D Y",        {"Osiris", "Silent Aim", "Field Of View", "2D", "Y"}, 1, 50, 8, "px")
        local sec4 = createSection(parent, "Weapon Configuration")
        createToggle(sec4, "Enabled", {"Osiris", "Silent Aim", "Field Of View", "Weapon Configuration", "Enabled"})
        local sec5 = createSection(parent, "Shotguns")
        createSlider(sec5, "Circle", {"Osiris", "Silent Aim", "Field Of View", "Weapon Configuration", "Shotguns", "Circle"}, 10, 500, 150, "px")
        createSlider(sec5, "2D X",    {"Osiris", "Silent Aim", "Field Of View", "Weapon Configuration", "Shotguns", "2D", "X"}, 1, 50, 8, "px")
        createSlider(sec5, "2D Y",    {"Osiris", "Silent Aim", "Field Of View", "Weapon Configuration", "Shotguns", "2D", "Y"}, 1, 50, 8, "px")
        local sec6 = createSection(parent, "Pistols")
        createSlider(sec6, "Circle", {"Osiris", "Silent Aim", "Field Of View", "Weapon Configuration", "Pistols", "Circle"}, 10, 500, 150, "px")
        createSlider(sec6, "2D X",    {"Osiris", "Silent Aim", "Field Of View", "Weapon Configuration", "Pistols", "2D", "X"}, 1, 50, 8, "px")
        createSlider(sec6, "2D Y",    {"Osiris", "Silent Aim", "Field Of View", "Weapon Configuration", "Pistols", "2D", "Y"}, 1, 50, 8, "px")
        local sec7 = createSection(parent, "Automatics")
        createSlider(sec7, "Circle", {"Osiris", "Silent Aim", "Field Of View", "Weapon Configuration", "Automatics", "Circle"}, 10, 500, 150, "px")
        createSlider(sec7, "2D X",    {"Osiris", "Silent Aim", "Field Of View", "Weapon Configuration", "Automatics", "2D", "X"}, 1, 50, 8, "px")
        createSlider(sec7, "2D Y",    {"Osiris", "Silent Aim", "Field Of View", "Weapon Configuration", "Automatics", "2D", "Y"}, 1, 50, 8, "px")
    end

    TabBuilders["Aim Assist"] = function(parent)
        local sec1 = createSection(parent, "Configuration")
        createToggle(sec1,  "Enabled",          {"Osiris", "Aim Assist", "Enabled"})
        createDropdown(sec1, "Easing Style",     {"Osiris", "Aim Assist", "Easing Style"}, {"Linear","Quad","Cubic","Quart","Quint","Sine","Exponential","Circular","Back","Bounce","Elastic"})
        createDropdown(sec1, "Easing Direction", {"Osiris", "Aim Assist", "Easing Direction"}, {"In", "Out", "InOut"})
        createDropdown(sec1, "Hit Part",         {"Osiris", "Aim Assist", "Hit Part"}, {"Nearest Point","Nearest Part","Head","UpperTorso","HumanoidRootPart","LowerTorso"})
        local sec2 = createSection(parent, "Nearest Point")
        createDropdown(sec2, "Mode",  {"Osiris", "Aim Assist", "Nearest Point", "Mode"}, {"Smart", "Basic"})
        createSlider(sec2, "Scale",   {"Osiris", "Aim Assist", "Nearest Point", "Scale"}, 0.01, 1, 0.99, "", 2)
        local sec3 = createSection(parent, "Custom Parts")
        createToggle(sec3,  "Enabled", {"Osiris", "Aim Assist", "Custom Parts", "Enabled"})
        createDropdown(sec3, "Mode",    {"Osiris", "Aim Assist", "Custom Parts", "Mode"}, {"Point", "Part"})
        createDropdown(sec3, "Part 1", {"Osiris", "Aim Assist", "Custom Parts", "Parts", 1}, R15Parts)
        createDropdown(sec3, "Part 2", {"Osiris", "Aim Assist", "Custom Parts", "Parts", 2}, R15Parts)
        createDropdown(sec3, "Part 3", {"Osiris", "Aim Assist", "Custom Parts", "Parts", 3}, R15Parts)
        createDropdown(sec3, "Part 4", {"Osiris", "Aim Assist", "Custom Parts", "Parts", 4}, R15Parts)
        local sec4 = createSection(parent, "Snappiness")
        createSlider(sec4, "Snappiness", {"Osiris", "Aim Assist", "Snappiness"}, 0.001, 1, 0.045, "", 3)
        local sec5 = createSection(parent, "Smart Snappiness")
        createToggle(sec5,  "Enabled",   {"Osiris", "Aim Assist", "Smart Snappiness", "Enabled"})
        createDropdown(sec5, "Mode",      {"Osiris", "Aim Assist", "Smart Snappiness", "Mode"}, {"Slow", "Fast"})
        createSlider(sec5, "Min",        {"Osiris", "Aim Assist", "Smart Snappiness", "Min"}, 0.001, 1, 0.025, "", 3)
        createSlider(sec5, "Max",        {"Osiris", "Aim Assist", "Smart Snappiness", "Max"}, 0.001, 1, 0.085, "", 3)
        createSlider(sec5, "Speed Min",  {"Osiris", "Aim Assist", "Smart Snappiness", "Speed", "Min"}, 1, 500, 16, "")
        createSlider(sec5, "Speed Max",  {"Osiris", "Aim Assist", "Smart Snappiness", "Speed", "Max"}, 1, 500, 100, "")
        local sec6 = createSection(parent, "Prediction")
        createToggle(sec6, "Enabled", {"Osiris", "Aim Assist", "Prediction", "Enabled"})
        createSlider(sec6, "X",         {"Osiris", "Aim Assist", "Prediction", "X"}, 0, 0.5, 0.01, "", 3)
        createSlider(sec6, "Y",         {"Osiris", "Aim Assist", "Prediction", "Y"}, 0, 0.5, 0.01, "", 3)
        createSlider(sec6, "Z",         {"Osiris", "Aim Assist", "Prediction", "Z"}, 0, 0.5, 0.01, "", 3)
    end

    TabBuilders["Weapon Modifications"] = function(parent)
        local sec1 = createSection(parent, "Spread Modifier")
        createToggle(sec1, "Enabled",             {"Osiris", "Weapon Modifications", "Spread Modifier", "Enabled"})
        createSlider(sec1, "[Double-Barrel SG]", {"Osiris", "Weapon Modifications", "Spread Modifier", "[Double-Barrel SG]", "Value"}, 0, 1, 0.8, "", 2)
        createSlider(sec1, "[TacticalShotgun]",    {"Osiris", "Weapon Modifications", "Spread Modifier", "[TacticalShotgun]", "Value"}, 0, 1, 0.8, "", 2)
        createSlider(sec1, "[Shotgun]",            {"Osiris", "Weapon Modifications", "Spread Modifier", "[Shotgun]", "Value"}, 0, 1, 0, "", 2)
        local sec2 = createSection(parent, "Randomizer")
        createToggle(sec2, "Enabled", {"Osiris", "Weapon Modifications", "Spread Modifier", "Randomizer", "Enabled"})
        createSlider(sec2, "Value",    {"Osiris", "Weapon Modifications", "Spread Modifier", "Randomizer", "Value"}, 0, 1, 0.1, "", 2)
        local sec3 = createSection(parent, "Skin Changer")
        createToggle(sec3, "Enabled", {"Osiris", "Weapon Modifications", "Skin Changer", "Enabled"})
        createDropdown(sec3, "[Double-Barrel SG]", {"Osiris", "Weapon Modifications", "Skin Changer", "Weapons List", "[Double-Barrel SG]"}, GunSkins)
        createDropdown(sec3, "[Revolver]",          {"Osiris", "Weapon Modifications", "Skin Changer", "Weapons List", "[Revolver]"}, GunSkins)
        createDropdown(sec3, "[TacticalShotgun]",   {"Osiris", "Weapon Modifications", "Skin Changer", "Weapons List", "[TacticalShotgun]"}, GunSkins)
        createDropdown(sec3, "[Knife]",             {"Osiris", "Weapon Modifications", "Skin Changer", "Weapons List", "[Knife]"}, KnifeSkins)
    end

    TabBuilders["Walk Speed"] = function(parent)
        local sec1 = createSection(parent, "Walk Speed")
        createToggle(sec1, "Enabled", {"Osiris", "Walk Speed", "Enabled"})
        createSlider(sec1, "Speed",   {"Osiris", "Walk Speed", "Speed"}, 16, 1000, 600, "")
    end

    TabBuilders["Hitbox Expander"] = function(parent)
        local sec1 = createSection(parent, "Hitbox Expander")
        createToggle(sec1, "Enabled",     {"Osiris", "Hitbox Expander", "Enabled"})
        createToggle(sec1, "Target Only", {"Osiris", "Hitbox Expander", "Target Only"})
        createToggle(sec1, "Visible",     {"Osiris", "Hitbox Expander", "Visible"})
        createSlider(sec1, "Size X",       {"Osiris", "Hitbox Expander", "Size", "X"}, 0.1, 20, 3.2, "", 1)
        createSlider(sec1, "Size Y",       {"Osiris", "Hitbox Expander", "Size", "Y"}, 0.1, 20, 5.6, "", 1)
        createSlider(sec1, "Size Z",       {"Osiris", "Hitbox Expander", "Size", "Z"}, 0.1, 20, 3.1, "", 1)
    end

    TabBuilders["Player"] = function(parent)
        local sec1 = createSection(parent, "Player")
        createToggle(sec1, "Anti Fall", {"Osiris", "Player", "Anti Fall"})
        createToggle(sec1, "Wall Hop",  {"Osiris", "Player", "Wall Hop"})
        local sec2 = createSection(parent, "Avatar")
        createToggle(sec2, "Enabled",         {"Osiris", "Player", "Avatar", "Enabled"})
        createTextInput(sec2, "User ID",       {"Osiris", "Player", "Avatar", "User ID"}, "Enter Roblox User ID...")
        createToggle(sec2, "Visual Headless",  {"Osiris", "Player", "Avatar", "Visual Headless"})
        local sec3 = createSection(parent, "Custom Animations")
        createTextInput(sec3, "Idle", {"Osiris", "Player", "Avatar", "Custom Animations", "idle"}, "rbxassetid://...")
        createTextInput(sec3, "Walk", {"Osiris", "Player", "Avatar", "Custom Animations", "walk"}, "rbxassetid://...")
        createTextInput(sec3, "Run",  {"Osiris", "Player", "Avatar", "Custom Animations", "run"},  "rbxassetid://...")
        createTextInput(sec3, "Jump", {"Osiris", "Player", "Avatar", "Custom Animations", "jump"}, "rbxassetid://...")
        createTextInput(sec3, "Fall", {"Osiris", "Player", "Avatar", "Custom Animations", "fall"}, "rbxassetid://...")
        local sec4 = createSection(parent, "Visual")
        createToggle(sec4, "Enabled",     {"Osiris", "Player", "Visual", "Enabled"})
        createToggle(sec4, "Target Name",  {"Osiris", "Player", "Visual", "Target Name"})
        createToggle(sec4, "Names",        {"Osiris", "Player", "Visual", "Names"})
        createToggle(sec4, "Distance",    {"Osiris", "Player", "Visual", "Distance"})
    end

    TabBuilders["Misc"] = function(parent)
    local sec1 = createSection(parent, "Settings")
    createSlider(sec1, "Delay", {"Osiris", "Misc", "Delay"}, 0, 1, 0.1, "s", 2)
    createKeybind(sec1, "Toggle Menu", {"Osiris", "Misc", "Menu Keybind"}, function(newKey)
        currentMenuKey = newKey
    end)

    local sec2 = createSection(parent, "Actions")
    createToggle(sec2, "Anti Aimview", {"Osiris", "Misc", "Anti Aimview"})

    createButton(sec2, "Unload Script", function()
        -- Chama a função de cleanup da source (desliga tudo + mata o player)
        if getgenv().OsirisUnload then getgenv().OsirisUnload() end

        -- Fecha a GUI
        if currentToggleTween then currentToggleTween:Cancel() end
        local t = tween(MainWindow, {
            Size = UDim2.new(0, 720, 0, 0),
            Position = UDim2.new(0.5, -360, 0.5, 0),
        }, 0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.In)
        t.Completed:Wait()
        ScreenGui:Destroy()
    end)

    createButton(sec2, "Reset Config", function()
        getgenv().saved.Osiris = {}
        deepMerge(getgenv().saved.Osiris, Defaults)
    end)
end

    TabBuilders["Config"] = function(parent)
        local sec1 = createSection(parent, "Save Configuration")
        local _, nameTextBox = createTextInput(sec1, "Config Name", {"Osiris", "Config", "CurrentName"}, "Enter config name...")
        createButton(sec1, "Save Config", function()
            local name = nameTextBox.Text
            if name and #name > 0 then SaveConfig(name); if currentTab == "Config" then selectTab("Config") end end
        end)
        local sec2 = createSection(parent, "Saved Configurations")
        local configList = create("Frame", {Size=UDim2.new(1,0,0,0),AutomaticSize=Enum.AutomaticSize.Y,BackgroundTransparency=1,Parent=sec2})
        create("UIListLayout", {Padding=UDim.new(0,4),Parent=configList})
        local function refreshConfigList()
            for _, child in ipairs(configList:GetChildren()) do if child:IsA("GuiObject") then child:Destroy() end end
            local configs = GetConfigs()
            if #configs == 0 then
                create("TextLabel", {Size=UDim2.new(1,0,0,20),BackgroundTransparency=1,Font=Enum.Font.Montserrat,TextSize=11,TextColor3=Theme.TextDim,TextXAlignment=Enum.TextXAlignment.Left,Text="No saved configurations found.",Parent=configList})
                return
            end
            for _, configName in ipairs(configs) do
                local row = create("Frame", {Size=UDim2.new(1,0,0,26),BackgroundTransparency=1,Parent=configList})
                create("TextLabel", {Size=UDim2.new(1,-120,1,0),BackgroundTransparency=1,Font=Enum.Font.Montserrat,TextSize=12,TextColor3=Theme.TextPrimary,TextXAlignment=Enum.TextXAlignment.Left,Text=configName,Parent=row})
                local loadBtn = create("TextButton", {Size=UDim2.new(0,50,0,22),Position=UDim2.new(1,-108,0.5,-11),BackgroundColor3=Theme.SurfaceRaised,Font=Enum.Font.Montserrat,TextSize=11,TextColor3=Theme.TextPrimary,Text="Load",AutoButtonColor=false,Parent=row})
                addCorner(loadBtn, 4); local ls = addStroke(loadBtn, Theme.BorderDefault, 1)
                local lh = create("Frame", {Size=UDim2.new(1,0,1,0),BackgroundColor3=Theme.CrimsonShadow,BackgroundTransparency=1,Parent=loadBtn}); addCorner(lh, 4)
                loadBtn.MouseEnter:Connect(function() tween(lh, {BackgroundTransparency=0.6}, 0.15); tween(ls, {Color=Theme.BorderHover}, 0.15) end)
                loadBtn.MouseLeave:Connect(function() tween(lh, {BackgroundTransparency=1}, 0.15); tween(ls, {Color=Theme.BorderDefault}, 0.15) end)
                loadBtn.MouseButton1Click:Connect(function() LoadConfig(configName) end)
                local delBtn = create("TextButton", {Size=UDim2.new(0,50,0,22),Position=UDim2.new(1,-54,0.5,-11),BackgroundColor3=Theme.SurfaceRaised,Font=Enum.Font.Montserrat,TextSize=11,TextColor3=Theme.TextPrimary,Text="Delete",AutoButtonColor=false,Parent=row})
                addCorner(delBtn, 4); local ds = addStroke(delBtn, Theme.BorderDefault, 1)
                local dh = create("Frame", {Size=UDim2.new(1,0,1,0),BackgroundColor3=Theme.CrimsonShadow,BackgroundTransparency=1,Parent=delBtn}); addCorner(dh, 4)
                delBtn.MouseEnter:Connect(function() tween(dh, {BackgroundTransparency=0.6}, 0.15); tween(ds, {Color=Theme.BorderHover}, 0.15) end)
                delBtn.MouseLeave:Connect(function() tween(dh, {BackgroundTransparency=1}, 0.15); tween(ds, {Color=Theme.BorderDefault}, 0.15) end)
                delBtn.MouseButton1Click:Connect(function() DeleteConfig(configName); refreshConfigList() end)
            end
        end
        refreshConfigList()
        createButton(sec2, "Refresh List", function() refreshConfigList() end)
    end

    -- ================================================================
    -- NAVIGATION LOGIC
    -- ================================================================
    selectCategory = function(catName)
        if currentCategory == catName then return end
        closeActiveDropdown()
        currentCategory = catName
        for _, catBtn in ipairs(categoryButtons) do
            if catBtn.name == catName then
                tween(catBtn.button, {TextColor3=Theme.TextPrimary}, 0.2)
                local targetY = catBtn.button.Position.Y.Offset + (catBtn.button.AbsoluteSize.Y / 2) - 8
                tween(SidebarIndicator, {Position=UDim2.new(0,0,0,targetY)}, 0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
                tween(SidebarIndicator, {BackgroundTransparency=0}, 0.2)
            else
                tween(catBtn.button, {TextColor3=Theme.TextDim}, 0.2)
            end
        end
        for _, child in ipairs(TabBar:GetChildren()) do if child:IsA("GuiObject") then child:Destroy() end end
        tabButtons = {}
        local catData = nil
        for _, cat in ipairs(Categories) do if cat.name == catName then catData = cat break end end
        if not catData then return end
        for i, tabName in ipairs(catData.tabs) do
            local btn = create("TextButton", {Size=UDim2.new(0,0,1,0),AutomaticSize=Enum.AutomaticSize.X,BackgroundTransparency=1,Font=Enum.Font.Montserrat,TextSize=13,TextColor3=Theme.TextDim,Text="  "..tabName.."  ",TextTransparency=1,AutoButtonColor=false,Parent=TabBar})
            btn.MouseEnter:Connect(function() if currentTab ~= tabName then tween(btn, {TextColor3=Theme.TextSecondary}, 0.15) end end)
            btn.MouseLeave:Connect(function() if currentTab ~= tabName then tween(btn, {TextColor3=Theme.TextDim}, 0.15) end end)
            btn.MouseButton1Click:Connect(function() selectTab(tabName) end)
            table.insert(tabButtons, {name=tabName, button=btn})
            task.delay(i * 0.03, function() tween(btn, {TextTransparency=0}, 0.2, Enum.EasingStyle.Sine) end)
        end
        if #tabButtons > 0 then task.delay(#catData.tabs * 0.03 + 0.05, function() selectTab(tabButtons[1].name) end) end
    end

    selectTab = function(tabName)
    if currentTab == tabName then return end
    closeActiveDropdown()
    currentTab = tabName
    for _, tb in ipairs(tabButtons) do
        if tb.name == tabName then tween(tb.button, {TextColor3=Theme.TextPrimary}, 0.15)
        else tween(tb.button, {TextColor3=Theme.TextDim}, 0.15) end
    end
    for _, tb in ipairs(tabButtons) do
        if tb.name == tabName then
                        local targetBtn = tb.button
            task.spawn(function()
                RunService.Heartbeat:Wait()
                RunService.Heartbeat:Wait()
                RunService.Heartbeat:Wait()
                
                -- Get the actual text label
                local textLabel = targetBtn:FindFirstChildWhichIsA("TextLabel")
                if not textLabel then textLabel = targetBtn end
                
                -- Get the real, accurate positions
                local btnAbsX = targetBtn.AbsolutePosition.X
                local tabBarAbsX = TabBar.AbsolutePosition.X
                local textWidth = textLabel.TextBounds.X
                
                if textWidth <= 0 then textWidth = targetBtn.AbsoluteSize.X end
                
                -- ✅ CORRECTED ALIGNMENT:
                local EXTRA_WIDTH = 10
                local finalWidth = textWidth + EXTRA_WIDTH
                
                -- The math was wrong before! We calculate the exact left position
                -- WITHOUT subtracting anything extra.
                local relX = btnAbsX - tabBarAbsX
                
                if finalWidth > 0 then 
                    -- Remove any rounded corners
                    if TabUnderline:FindFirstChild("UICorner") then
                        TabUnderline.UICorner:Destroy()
                    end
                    
                    tween(TabUnderline, {
                        Position=UDim2.new(0, relX, 1, -1),
                        Size=UDim2.new(0, finalWidth, 0, 2),
                        BackgroundTransparency=0
                    }, 0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out) 
                end
            end)
            break
        end
    end
    for _, child in ipairs(ContentArea:GetChildren()) do if child:IsA("GuiObject") then child:Destroy() end end
    local page = create("ScrollingFrame", {Size=UDim2.new(1,0,1,0),BackgroundTransparency=1,ScrollBarThickness=3,ScrollBarImageColor3=Theme.CrimsonDeep,ScrollBarImageTransparency=0.3,CanvasSize=UDim2.new(0,0,0,0),AutomaticCanvasSize=Enum.AutomaticSize.Y,Position=UDim2.new(0.02,0,0,0),Parent=ContentArea})
    create("UIListLayout", {Padding=UDim.new(0,14),Parent=page})
    create("UIPadding", {PaddingTop=UDim.new(0,14),PaddingBottom=UDim.new(0,14),PaddingLeft=UDim.new(0,14),PaddingRight=UDim.new(0,14),Parent=page})
    local builder = TabBuilders[tabName]
    if builder then builder(page) end
    tween(page, {Position=UDim2.new(0,0,0,0)}, 0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
end

    for _, cat in ipairs(Categories) do
        local btn = create("TextButton", {Size=UDim2.new(1,0,0,28),BackgroundTransparency=1,Font=Enum.Font.Montserrat,TextSize=13,TextColor3=Theme.TextDim,TextXAlignment=Enum.TextXAlignment.Left,Text="    "..cat.name,AutoButtonColor=false,Parent=SidebarList})
        btn.MouseEnter:Connect(function() if currentCategory ~= cat.name then tween(btn, {TextColor3=Theme.TextSecondary}, 0.15) end end)
        btn.MouseLeave:Connect(function() if currentCategory ~= cat.name then tween(btn, {TextColor3=Theme.TextDim}, 0.15) end end)
        btn.MouseButton1Click:Connect(function() selectCategory(cat.name) end)
        table.insert(categoryButtons, {name=cat.name, button=btn})
    end

    local dragging = false
    local dragStart, startPos
    TopBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            closeActiveDropdown(); dragging = true; dragStart = input.Position; startPos = MainWindow.Position
        end
    end)
    TopBar.InputEnded:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end end)
    UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = input.Position - dragStart
            MainWindow.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)

    currentMenuKey = getConfig({"Osiris", "Misc", "Menu Keybind"}) or "RightShift"
    local menuVisible = true
    currentToggleTween = nil
    local toggleId = 0

    local function isTypingInTextBox() return UserInputService:GetFocusedTextBox() ~= nil end

    -- [FIX 4] Smoother hide/show with Back easing + transparency fade + text fade
    local function toggleMenu()
        toggleId = toggleId + 1
        local myId = toggleId
        menuVisible = not menuVisible
        if currentToggleTween then currentToggleTween:Cancel() end
        if menuVisible then
            ScreenGui.Enabled = true
            MainWindow.Size = UDim2.new(0, 712, 0, 0)
            MainWindow.Position = UDim2.new(0.5, -356, 0.5, 0)
            MainWindow.BackgroundTransparency = 0.3
            currentToggleTween = tween(MainWindow, {
                Size = UDim2.new(0, 720, 0, 440),
                Position = UDim2.new(0.5, -360, 0.5, -220),
                BackgroundTransparency = 0,
            }, 0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
            task.delay(0.15, function()
                if menuVisible then
                    for _, child in ipairs(MainWindow:GetDescendants()) do
                        if (child:IsA("TextLabel") or child:IsA("TextButton") or child:IsA("TextBox")) and child.TextTransparency > 0.9 then
                            tween(child, {TextTransparency=0}, 0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
                        end
                    end
                end
            end)
        else
            for _, child in ipairs(MainWindow:GetDescendants()) do
                if (child:IsA("TextLabel") or child:IsA("TextButton") or child:IsA("TextBox")) and child.TextTransparency < 0.1 then
                    tween(child, {TextTransparency=1}, 0.12, Enum.EasingStyle.Sine, Enum.EasingDirection.In)
                end
            end
            task.delay(0.1, function()
                if not menuVisible then
                    currentToggleTween = tween(MainWindow, {
                        Size = UDim2.new(0, 712, 0, 0),
                        Position = UDim2.new(0.5, -356, 0.5, 0),
                        BackgroundTransparency = 0.3,
                    }, 0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.In)
                    currentToggleTween.Completed:Once(function()
                        if myId == toggleId and not menuVisible then ScreenGui.Enabled = false end
                    end)
                end
            end)
        end
    end

    UserInputService.InputBegan:Connect(function(input, gpe)
        if gpe then return end
        if isBindingKey then return end
        if isTypingInTextBox() then return end
        if input.UserInputType == Enum.UserInputType.Keyboard then
            if input.KeyCode.Name == currentMenuKey then toggleMenu() end
        end
    end)

    task.delay(0.05, function()
        tween(MainWindow, {Size=UDim2.new(0,720,0,440),Position=UDim2.new(0.5,-360,0.5,-220)}, 0.35, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
        task.delay(0.2, function() selectCategory("General") end)
    end)

    -- ================================================================
    -- SOURCE INTEGRATION LAYER
    -- ================================================================
    _G.MobileShiftLock = false
    _G.GUN_COMBAT_TOGGLE = false
    _G.Reduce_Lag = false
    getgenv().saved.Osiris.Player.Avatar.Animations = getgenv().saved.Osiris.Player.Avatar["Custom Animations"]

    -- ================================================================
    -- SOURCE CODE (all fixes applied inline — marked with [FIX N])
    -- ================================================================
    do
    if not LPH_ENCSTR then LPH_ENCSTR = function(str) return str end end
    if not LPH_NO_VIRTUALIZE then LPH_NO_VIRTUALIZE = function(func) return func end end
    if not LPH_OBFUSCATED then LPH_OBFUSCATED = false end

    local player_service = game["Players"]
    local local_player = player_service["LocalPlayer"]
    local dataFolder = local_player:WaitForChild("DataFolder")

    local checks = game:GetService("StarterPlayer").StarterCharacterScripts["CheckingKOED                                                                   ."].LocalScript
    local checks2 = game:GetService("StarterPlayer").StarterPlayerScripts.LSC
    checks:Destroy()
    checks2:Destroy()

    local shotland = dataFolder:WaitForChild("ShotLand")
    local shotreseter = dataFolder:WaitForChild("ShotReseter")
    local shottotal = dataFolder:WaitForChild("ShotTotal")
    local warning = dataFolder:WaitForChild("Warning")
    local lockflagged = dataFolder:WaitForChild("LockFlagged")
    local gunfiring = local_player.Character.BodyEffects.GunFiring
    local gunshotchanges = local_player.Character.BodyEffects.GunShotChanges
    local ReportersFolder = dataFolder:WaitForChild("Reporters")

    shottotal.Value = 0
    shotland.Value = 0
    shotreseter:GetPropertyChangedSignal("Value"):Connect(function() shotreseter.Value = 0 end)
    shottotal:GetPropertyChangedSignal("Value"):Connect(function() shottotal.Value = 0 end)
    shotland:GetPropertyChangedSignal("Value"):Connect(function() shotland.Value = 0 end)
    warning:GetPropertyChangedSignal("Value"):Connect(function() warning.Value = 0 end)
    lockflagged:GetPropertyChangedSignal("Value"):Connect(function() lockflagged.Value = 0 end)
    gunfiring:GetPropertyChangedSignal("Value"):Connect(function() gunfiring.Value = false end)
    gunshotchanges:GetPropertyChangedSignal("Value"):Connect(function() gunshotchanges.Value = 0 end)

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

    task.spawn(function()
        local isXeno = syn and syn.crypt and syn.crypt.custom or (getexecutorname and getexecutorname() == "Xeno")
        if isXeno then return end
        while not getgenv().saved or not getgenv().saved.Osiris or not getgenv().saved.Osiris['Weapon Modifications'] do task.wait() end
        local cfg = getgenv().saved.Osiris['Weapon Modifications']['Skin Changer']
        if not cfg or not cfg['Enabled'] then return end
        local replicatedstorage = game:GetService("ReplicatedStorage")
        local workspace = game:GetService("Workspace")
        local localplayer = Players.LocalPlayer
        while not replicatedstorage:FindFirstChild("SkinModules") do task.wait() end
        local knifedata = {}
        local toolregistry = {}
        local knifeskins = {
            ["Golden Age Tanto"]={soundid="rbxassetid://5917819099",animationid="rbxassetid://13473404819",positionoffset=Vector3.new(0,-0.20,-1.2),rotationoffset=Vector3.new(90,263.7,180)},
            ["GPO-Knife"]={soundid="rbxassetid://4604390759",animationid="rbxassetid://14014278925",positionoffset=Vector3.new(0.00,-0.32,-1.07),rotationoffset=Vector3.new(90,-97.4,90)},
            ["GPO-Knife Prestige"]={soundid="rbxassetid://4604390759",animationid="rbxassetid://14014278925",positionoffset=Vector3.new(0.00,-0.32,-1.07),rotationoffset=Vector3.new(90,-97.4,90)},
            ["Heaven"]={soundid="rbxassetid://14489860007",animationid="rbxassetid://14500266726",positionoffset=Vector3.new(-0.02,-0.82,0.20),rotationoffset=Vector3.new(64.42,3.79,0.00)},
            ["Love Kukri"]={soundid="",animationid="",positionoffset=Vector3.new(-0.14,0.14,-1.62),rotationoffset=Vector3.new(-90.00,180.00,-4.97),particle=true,textureid="rbxassetid://12124159284"},
            ["Purple Dagger"]={soundid="rbxassetid://17822743153",animationid="rbxassetid://17824999722",positionoffset=Vector3.new(-0.13,-0.24,-1.80),rotationoffset=Vector3.new(89.05,96.63,180.00)},
            ["Blue Dagger"]={soundid="rbxassetid://17822737046",animationid="rbxassetid://17824995184",positionoffset=Vector3.new(-0.13,-0.24,-1.80),rotationoffset=Vector3.new(89.05,96.63,180.00)},
            ["Green Dagger"]={soundid="rbxassetid://17822741762",animationid="rbxassetid://17825004320",positionoffset=Vector3.new(-0.13,-0.24,-1.07),rotationoffset=Vector3.new(89.05,96.63,180.00)},
            ["Red Dagger"]={soundid="rbxassetid://17822952417",animationid="rbxassetid://17825008844",positionoffset=Vector3.new(-0.13,-0.24,-1.07),rotationoffset=Vector3.new(89.05,96.63,180.00)},
            ["Portal"]={soundid="rbxassetid://16058846352",animationid="rbxassetid://16058633881",positionoffset=Vector3.new(-0.13,-0.35,-0.57),rotationoffset=Vector3.new(89.05,96.63,180.00)},
            ["Emerald Butterfly"]={soundid="rbxassetid://14931902491",animationid="rbxassetid://14918231706",positionoffset=Vector3.new(-0.02,-0.30,-0.65),rotationoffset=Vector3.new(180.00,90.95,180.00)},
            ["Boy"]={soundid="rbxassetid://18765078331",animationid="rbxassetid://18789158908",positionoffset=Vector3.new(-0.02,-0.09,-0.73),rotationoffset=Vector3.new(89.05,-88.11,180.00)},
            ["Girl"]={soundid="rbxassetid://18765078331",animationid="rbxassetid://18789162944",positionoffset=Vector3.new(-0.02,-0.16,-0.73),rotationoffset=Vector3.new(89.05,-88.11,180.00)},
            ["Dragon"]={soundid="rbxassetid://14217789230",animationid="rbxassetid://14217804400",positionoffset=Vector3.new(-0.02,-0.32,-0.98),rotationoffset=Vector3.new(89.05,90.95,180.00)},
            ["Void"]={soundid="rbxassetid://14756591763",animationid="rbxassetid://14774699952",positionoffset=Vector3.new(-0.02,-0.22,-0.85),rotationoffset=Vector3.new(180.00,90.95,180.00)},
            ["Wild West"]={soundid="rbxassetid://16058689026",animationid="rbxassetid://16058148839",positionoffset=Vector3.new(-0.02,-0.24,-1.15),rotationoffset=Vector3.new(-91.89,90.95,180.00)},
            ["Iced Out"]={soundid="rbxassetid://14924261405",animationid="rbxassetid://18465353361",positionoffset=Vector3.new(0.02,-0.08,0.99),rotationoffset=Vector3.new(180.00,-90.95,-180.00)},
            ["Reptile"]={soundid="rbxassetid://18765103349",animationid="rbxassetid://18788955930",positionoffset=Vector3.new(-0.03,-0.06,-0.92),rotationoffset=Vector3.new(168.63,90.00,-180.00)},
            ["Emerald"]={soundid="",animationid="",positionoffset=Vector3.new(-0.03,-0.06,-0.92),rotationoffset=Vector3.new(168.63,90.00,108.00)},
            ["Ribbon"]={soundid="rbxassetid://130974579277249",animationid="rbxassetid://124102609796063",positionoffset=Vector3.new(0.02,-0.25,-0.05),rotationoffset=Vector3.new(90.00,0.00,180.00)},
        }
        local function clearmesh(tool, exclude)
            for _, v in ipairs(tool:GetChildren()) do
                if v:IsA("MeshPart") and v ~= exclude then v:Destroy() end
            end
        end
        local function applygun(tool, name)
            local orig = tool:FindFirstChildOfClass("MeshPart")
            if not orig then return end
            local skinmodules = replicatedstorage:FindFirstChild("SkinModules")
            if not skinmodules then return end
            local ok, req = pcall(function() return require(skinmodules) end)
            if not ok or not req then return end
            local info = req[tool.Name] and req[tool.Name][name]
            if not info then return end
            clearmesh(tool, orig)
            local skinpart = info.TextureID
            if typeof(skinpart) == "Instance" then
                local clone = skinpart:Clone(); clone.Parent = tool; clone.CFrame = orig.CFrame; clone.Name = "CurrentSkin"
                local w = Instance.new("Weld"); w.Part0 = clone; w.Part1 = orig; w.C0 = info.CFrame:Inverse(); w.Parent = clone; orig.Transparency = 1
            else
                orig.TextureID = skinpart; orig.Transparency = 0
            end
            local handle = tool:FindFirstChild("Handle")
            if not handle then return end
            local shoot = handle:FindFirstChild("ShootSound")
            if shoot then
                local skinassets = replicatedstorage:FindFirstChild("SkinAssets")
                if skinassets then
                    local gunsounds = skinassets:FindFirstChild("GunShootSounds")
                    if gunsounds then
                        local sounds = gunsounds:FindFirstChild(tool.Name)
                        local obj = sounds and sounds:FindFirstChild(name)
                        if obj then shoot.SoundId = obj.Value end
                    end
                end
            end
            local skinassets = replicatedstorage:FindFirstChild("SkinAssets")
            if skinassets then
                local pf = skinassets:FindFirstChild("GunHandleParticle")
                if pf then
                    local ps = pf:FindFirstChild(name)
                    if ps then
                        local pe = ps:FindFirstChild("ParticleEmitter")
                        if pe then
                            for _, ex in ipairs(handle:GetChildren()) do if ex:IsA("ParticleEmitter") then ex:Destroy() end end
                            pe:Clone().Parent = handle
                        end
                    end
                end
            end
            handle:SetAttribute("SkinName", name)
        end
        local function cleanknife(tool)
            local data = knifedata[tool]
            if data then
                if data.track then data.track:Stop(); data.track:Destroy(); data.track = nil end
                if data.welds then for _, w in ipairs(data.welds) do if w then w:Destroy() end end; data.welds = {} end
                if data.sounds then for _, s in ipairs(data.sounds) do if s and s.Parent then s:Destroy() end end; data.sounds = {} end
            end
            local mesh = tool:FindFirstChild("Default")
            if mesh then
                for _, v in ipairs(mesh:GetChildren()) do
                    if v.Name == "Handle.R" or v:IsA("Model") or (v:IsA("BasePart") and v.Name ~= "Default") then v:Destroy() end
                end
                mesh.Transparency = 0
            end
            knifedata[tool] = nil
        end
        local function applyknife(char, tool, skin)
            local skincfg = knifeskins[skin]
            if not skincfg then return end
            local hum = char:FindFirstChild("Humanoid")
            local rhand = char:FindFirstChild("RightHand")
            if not hum or not rhand then return end
            cleanknife(tool)
            knifedata[tool] = {track=nil, welds={}, sounds={}}
            local data = knifedata[tool]
            local mesh = tool:FindFirstChild("Default")
            if not mesh then return end
            mesh.Transparency = 1
            local skinmodules = replicatedstorage:FindFirstChild("SkinModules")
            if not skinmodules then return end
            local knives = skinmodules:FindFirstChild("Knives")
            if not knives then return end
            local skinmodel = knives:FindFirstChild(skin)
            if not skinmodel then return end
            local clone = skinmodel:Clone(); clone.Name = skin
            local handr = Instance.new("Part")
            handr.Name = "Handle.R"; handr.Transparency = 1; handr.CanCollide = false; handr.Anchored = false
            handr.Size = Vector3.new(0.001,0.001,0.001); handr.Massless = true; handr.Parent = mesh
            local m6d = Instance.new("Motor6D"); m6d.Name = "Handle.R"; m6d.Part0 = rhand; m6d.Part1 = handr; m6d.Parent = handr
            local offset = CFrame.new(skincfg.positionoffset) * CFrame.Angles(math.rad(skincfg.rotationoffset.X), math.rad(skincfg.rotationoffset.Y), math.rad(skincfg.rotationoffset.Z))
            if clone:IsA("Model") then
                if not clone.PrimaryPart then
                    for _, c in ipairs(clone:GetChildren()) do if c:IsA("BasePart") then clone.PrimaryPart = c break end end
                end
                if clone.PrimaryPart then
                    for _, p in ipairs(clone:GetDescendants()) do
                        if p:IsA("BasePart") then
                            p.CanCollide = false; p.Massless = true; p.Anchored = false
                            local w = Instance.new("Weld"); w.Part0 = handr; w.Part1 = p; w.C0 = offset
                            w.C1 = p.CFrame:ToObjectSpace(clone.PrimaryPart.CFrame); w.Parent = p; table.insert(data.welds, w)
                        end
                    end
                end
                clone.Parent = mesh
            elseif clone:IsA("BasePart") then
                clone.CanCollide = false; clone.Massless = true; clone.Anchored = false
                if clone:IsA("MeshPart") and skincfg.textureid then clone.TextureID = skincfg.textureid end
                if skincfg.particle then
                    local skinassets = replicatedstorage:FindFirstChild("SkinAssets")
                    if skinassets then
                        local pf = skinassets:FindFirstChild("GunHandleParticle")
                        if pf then
                            local ps = pf:FindFirstChild(skin)
                            if ps then
                                local pe = ps:FindFirstChild("ParticleEmitter")
                                if pe then pe:Clone().Parent = clone end
                            end
                        end
                    end
                end
                clone.Parent = mesh
                local w = Instance.new("Weld"); w.Part0 = handr; w.Part1 = clone; w.C0 = offset; w.Parent = clone; table.insert(data.welds, w)
            end
            local animator = hum:FindFirstChildOfClass("Animator")
            if not animator then animator = Instance.new("Animator"); animator.Parent = hum end
            if skincfg.animationid and skincfg.animationid ~= "" then
                local anim = Instance.new("Animation"); anim.AnimationId = skincfg.animationid
                local track = animator:LoadAnimation(anim); track.Looped = false; track:Play(); data.track = track; anim:Destroy()
                track.Ended:Once(function() if data.track == track then data.track = nil end; track:Destroy() end)
            end
            if skincfg.soundid and skincfg.soundid ~= "" then
                local snd = Instance.new("Sound"); snd.SoundId = skincfg.soundid; snd.Parent = workspace; snd:Play(); table.insert(data.sounds, snd)
                snd.Ended:Connect(function() snd:Destroy() end)
            end
            tool:SetAttribute("CurrentKnifeSkin", skin)
        end
        local function setuptool(tool)
            if not tool:IsA("Tool") then return end
            if toolregistry[tool] then return end
            toolregistry[tool] = true
            tool.Equipped:Connect(function()
                if not cfg or not cfg['Enabled'] then return end
                local char = tool.Parent
                if char ~= localplayer.Character then return end
                local skin = cfg['Weapons List'] and cfg['Weapons List'][tool.Name]
                if not skin or skin == "" then return end
                if tool.Name == "[Knife]" then applyknife(char, tool, skin) else applygun(tool, skin) end
            end)
            tool.Unequipped:Connect(function() if tool.Name == "[Knife]" then cleanknife(tool) end end)
            if tool.Parent == localplayer.Character then
                if not cfg or not cfg['Enabled'] then return end
                local skin = cfg['Weapons List'] and cfg['Weapons List'][tool.Name]
                if skin and skin ~= "" then
                    if tool.Name == "[Knife]" then task.spawn(function() applyknife(localplayer.Character, tool, skin) end)
                    else task.spawn(function() applygun(tool, skin) end) end
                end
            end
        end
        local function watchchar(char)
            if not char then return end
            for _, v in ipairs(char:GetChildren()) do if v:IsA("Tool") then setuptool(v) end end
            char.ChildAdded:Connect(function(v) if v:IsA("Tool") then setuptool(v) end end)
        end
        if localplayer.Character then watchchar(localplayer.Character) end
        localplayer.CharacterAdded:Connect(function(char) watchchar(char) end)
        for _, v in ipairs(localplayer.Backpack:GetChildren()) do if v:IsA("Tool") then setuptool(v) end end
        localplayer.Backpack.ChildAdded:Connect(function(v) if v:IsA("Tool") then setuptool(v) end end)
    end)

    local Script = { RBXConnections = {}, Locals = {}, Visuals = {} }
    local WeaponMap = {}
    local aliases = {
        ["[Double-Barrel SG]"]={"db","double barrel","double-barrel","dbl sg","double sg","db sg"},
        ["[TacticalShotgun]"]={"tac","tac sg","tactical shotgun","tactical sg","tacshot","tactical"},
        ["[Drum-Shotgun]"]={"drum sg","drum shotgun","auto sg","drum auto","drum"},
        ["[Shotgun]"]={"sg","shotgun","pump","pump sg","pump shotgun","buckshot"},
        ["[Revolver]"]={"rev","revolver","six shooter","wheel gun","colt","magnum"},
        ["[Silencer]"]={"silencer","suppressed","supp pistol","silenced pistol","quiet gun"},
        ["[Glock]"]={"glock","g17","glock 17","pistol","semi","9mm"},
        ["[Rifle]"]={"rifle","ar","assault rifle","m4","m4a1","m16"},
        ["[AUG]"]={"aug","steyr aug","bullpup","aug rifle"},
        ["[AR]"]={"ar","assault rifle","m4","m4a1","rifle"},
        ["[SMG]"]={"smg","submachine gun","uzi","mp5","mp7","vector"},
        ["[LMG]"]={"lmg","light machine gun","m249","saw","negev"},
        ["[P90]"]={"p90","fn p90","pdw","personal defense weapon"},
        ["[AK47]"]={"ak","ak47","kalashnikov","akm","russian rifle"},
        ["[SilencerAR]"]={"silencer ar","suppressed ar","silenced rifle","quiet ar"},
        ["[DrumGun]"]={"drum gun","tommy gun","thompson","drum ar","drum rifle"}
    }
    for weapon, names in pairs(aliases) do for _, alias in ipairs(names) do WeaponMap[alias] = weapon end end

    local Modules = { Cache = {} }
    function Modules.Get(Id) if not Modules.Cache[Id] then Modules.Cache[Id] = {c = Modules[Id]()} end; return Modules.Cache[Id].c end

    local function InitializeLocals()
        local defaults = {LPH_ENCSTR("GunScriptDisabled"),LPH_ENCSTR("SilentAimTarget"),LPH_ENCSTR("AimAssistTarget"),LPH_ENCSTR("IsWalkSpeeding"),LPH_ENCSTR("CurrentWeapon"),LPH_ENCSTR("IsBoxFocused"),LPH_ENCSTR("HitPosition"),LPH_ENCSTR("MoveVector"),LPH_ENCSTR("LastShot"),LPH_ENCSTR("IsAimed"),LPH_ENCSTR("HitPart"),LPH_ENCSTR("CodeRegion"),LPH_ENCSTR("FieldOfViewOne"),LPH_ENCSTR("FieldOfViewTwo")}
        for _, v in ipairs(defaults) do Script.Locals[v] = nil end
        Script.Locals.LastShot = 0; Script.Locals.CodeRegion = "Initialization"; Script.Locals.HitPosition = Vector3.new(); Script.Locals.IsWalkSpeeding = false
    end
    local function SetRegion(Region) Script.Locals.CodeRegion = Region end
    local function GetRegion() return Script.Locals.CodeRegion end
    InitializeLocals()

    local WeaponInfo = {
        Shotguns={"[TacticalShotgun]","[Shotgun]","[Double-Barrel SG]"}, AutoShotguns={"[Drum-Shotgun]"},
        Pistols={"[Revolver]","[Silencer]","[Glock]"}, Rifles={"[AR]","[SilencerAR]","[AK47]","[LMG]","[DrumGun]"},
        Bursts={"[AUG]"}, SMG={"[SMG]","[P90]"}, Snipers={"[Rifle]"},
        Automatics={"[AR]","[SilencerAR]","[AK47]","[LMG]","[DrumGun]"}, -- [FIX 1]
        Offsets={["[Double-Barrel SG]"]=CFrame.new(0,0.35,-2.2),["[TacticalShotgun]"]=CFrame.new(0,0.25,-2.5),["[Drum-Shotgun]"]=CFrame.new(-0.1,0.5,-2.5),["[Shotgun]"]=CFrame.new(0,0.25,-2.5),["[Revolver]"]=CFrame.new(-1,0.4,0),["[Silencer]"]=CFrame.new(0,0.4,1.3),["[Glock]"]=CFrame.new(0.6,0.25,0),["[Rifle]"]=CFrame.new(0,0.25,2.5),["[AUG]"]=CFrame.new(-0.1,0.4,1.8),["[AR]"]=CFrame.new(2,0.35,0),["[SMG]"]=CFrame.new(0,1,0.5),["[LMG]"]=CFrame.new(0,0.7,-3.8),["[P90]"]=CFrame.new(0,0.2,-1.7),["[AK47]"]=CFrame.new(-0.1,0.5,-2.5),["[SilencerAR]"]=CFrame.new(2.5,0.35,0),["[DrumGun]"]=CFrame.new(0,0.4,2.4)},
        Delays={["[Double-Barrel SG]"]=0.0,["[TacticalShotgun]"]=0.0,["[Drum-Shotgun]"]=0.415,["[Shotgun]"]=0.9,["[Revolver]"]=0.0,["[Silencer]"]=0.0095,["[Glock]"]=0.0095,["[Rifle]"]=1.3095,["[AUG]"]=0.0095,["[AR]"]=0.15,["[SMG]"]=0.6,["[LMG]"]=0.62,["[P90]"]=0.6,["[AK47]"]=0.15,["[SilencerAR]"]=0.02}
    }
    local CurrentFOV, CurrentFOVX, CurrentFOVY = 0, 0, 0
    local SilentAimPart = Instance.new("Part"); SilentAimPart.Name = math.random(1, 99999999)

    local function GameFunctions()
        SetRegion("Game Functions")
        return {
            IsKnocked = function(Player) return Player and Player:FindFirstChild('BodyEffects') and Player.BodyEffects['K.O'].Value or false end,
            IsGrabbed = function(Player) return Player and Player.Character and Player.Character:FindFirstChild('GRABBING_CONSTRAINT') ~= nil end,
        }
    end
    local Games = { [LPH_ENCSTR('Da Hood')] = { HoodGame = true, Functions = GameFunctions() } }
    local MarketplaceService = game:GetService("MarketplaceService")
    local Success, Info = pcall(function() return MarketplaceService:GetProductInfo(game.PlaceId) end)
    local GameName = Success and Info.Name or "Universal"
    local Match
    for Index in pairs(Games) do if string.match(GameName, Index) then Match = Index break end end
    local CurrentGame = Games[Match] or Games.Universal

    SetRegion("Threading")
    local function ThreadLoop(Wait, Func)
        task.spawn(function()
            while true do
                local Delta = task.wait(Wait)
                local s, r = pcall(Func, Delta)
                if not s then warn("Thread error:", r) elseif r == "break" then break end
            end
        end)
    end
    local function ThreadFunction(Func, Name, ...)
        local wf = Name and function() local p, s = pcall(Func); if not p then warn('ThreadFunction Error:\n','              '..Name..':',s) end end or Func
        local t = coroutine.create(wf); coroutine.resume(t, ...); return t
    end
    local function RBXConnection(Signal, Callback)
        local c = Signal:Connect(Callback); Script.RBXConnections[#Script.RBXConnections + 1] = c; return c
    end

    do
        SetRegion("Drawing")
        local CustomLibIndex = 0
        local UtilityUI = Instance.new('ScreenGui'); UtilityUI.Parent = game:GetService("CoreGui"); UtilityUI.IgnoreGuiInset = true
        local Clamp = math.clamp
        local Atan2 = math.atan2
        local Deg = math.deg
        local LibraryMeta = setmetatable({Visible=true,ZIndex=0,Transparency=1,Color=Color3.new(),Remove=function(self) setmetatable(self,nil) end,Destroy=function(self) setmetatable(self,nil) end}, {__add=function(t1,t2) local r=table.clone(t1) for i,v in t2 do r[i]=v end return r end})
        local function CT(n) return Clamp(1-n,0,1) end
        function Script.Visuals.new(ClassType)
            CustomLibIndex += 1
            if ClassType=='Line' then
                local lo=({From=Vector2.zero,To=Vector2.zero,Thickness=1}+LibraryMeta)
                local l=Instance.new('Frame'); l.Name=CustomLibIndex; l.AnchorPoint=Vector2.one*.5; l.BorderSizePixel=0; l.BackgroundColor3=lo.Color; l.Visible=lo.Visible; l.ZIndex=lo.ZIndex; l.BackgroundTransparency=CT(lo.Transparency); l.Size=UDim2.new(); l.Parent=UtilityUI
                return setmetatable(table.create(0),{__newindex=function(_,p,v)
                    if p=='From' or p=='To' then
                        local a=p=='From' and v or lo.From; local b=p=='To' and v or lo.To
                        local d=b-a; local c=(b+a)/2; local m=d.Magnitude; local t=Deg(Atan2(d.Y,d.X))
                        l.Position=UDim2.fromOffset(c.X,c.Y); l.Rotation=t; l.Size=UDim2.fromOffset(m,lo.Thickness)
                        lo[p]=v
                    elseif p=='Thickness' then local th=(lo.To-lo.From).Magnitude; l.Size=UDim2.fromOffset(th,v); lo[p]=v
                    elseif p=='Visible' then l.Visible=v; lo[p]=v
                    elseif p=='ZIndex' then l.ZIndex=v; lo[p]=v
                    elseif p=='Transparency' then l.BackgroundTransparency=CT(v); lo[p]=v
                    elseif p=='Color' then l.BackgroundColor3=v; lo[p]=v end
                end,__index=function(s,i) if i=='Remove' or i=='Destroy' then return function() l:Destroy(); lo.Remove(s); return lo:Remove() end end return lo[i] end,__tostring=function() return 'CustomLib' end})
            elseif ClassType=='Circle' then
                local co=({Radius=150,Position=Vector2.zero,Thickness=.7,Filled=false}+LibraryMeta)
                local cf=Instance.new('Frame'); local uc=Instance.new('UICorner'); local us=Instance.new('UIStroke')
                cf.Name=CustomLibIndex; cf.AnchorPoint=Vector2.one*.5; cf.BorderSizePixel=0
                cf.BackgroundTransparency=co.Filled and CT(co.Transparency) or 1; cf.BackgroundColor3=co.Color; cf.Visible=co.Visible; cf.ZIndex=co.ZIndex
                uc.CornerRadius=UDim.new(1,0); cf.Size=UDim2.fromOffset(co.Radius,co.Radius)
                us.Thickness=co.Thickness; us.Enabled=not co.Filled; us.ApplyStrokeMode=Enum.ApplyStrokeMode.Border
                cf.Parent,uc.Parent,us.Parent=UtilityUI,cf,cf
                return setmetatable(table.create(0),{__newindex=function(_,i,v)
                    if typeof(co[i])=='nil' then return end
                    if i=='Radius' then local r=v*2; cf.Size=UDim2.fromOffset(r,r); co[i]=v
                    elseif i=='Position' then cf.Position=UDim2.fromOffset(v.X,v.Y); co[i]=v
                    elseif i=='Thickness' then v=Clamp(v,.6,0x7fffffff); us.Thickness=v; co[i]=v
                    elseif i=='Filled' then cf.BackgroundTransparency=co.Filled and CT(co.Transparency) or 1; us.Enabled=not v; co[i]=v
                    elseif i=='Visible' then cf.Visible=v; co[i]=v
                    elseif i=='ZIndex' then cf.ZIndex=v; co[i]=v
                    elseif i=='Transparency' then local t=CT(v); cf.BackgroundTransparency=co.Filled and t or 1; us.Transparency=t; co[i]=v
                    elseif i=='Color' then cf.BackgroundColor3=v; us.Color=v; co[i]=v end
                end,__index=function(s,i) if i=='Remove' or i=='Destroy' then return function() cf:Destroy(); co.Remove(s); return co:Remove() end end return co[i] end,__tostring=function() return 'CustomLib' end})
            elseif ClassType=='Square' then
                local so=({Size=Vector2.zero,Position=Vector2.zero,Thickness=.7,Filled=false,Drag=false}+LibraryMeta)
                local sf=Instance.new('Frame'); local us=Instance.new('UIStroke')
                sf.Name=CustomLibIndex; sf.BorderSizePixel=0
                sf.BackgroundTransparency=so.Filled and CT(so.Transparency) or 1; sf.ZIndex=so.ZIndex; sf.BackgroundColor3=so.Color; sf.Visible=so.Visible
                us.Thickness=so.Thickness; us.Enabled=not so.Filled; us.LineJoinMode=Enum.LineJoinMode.Miter
                sf.Parent,us.Parent=UtilityUI,sf
                return setmetatable(table.create(0),{__newindex=function(_,i,v)
                    if typeof(so[i])=='nil' then return end
                    if i=='Size' then sf.Size=UDim2.fromOffset(v.X,v.Y); so[i]=v
                    elseif i=='Position' then sf.Position=UDim2.fromOffset(v.X,v.Y); so[i]=v
                    elseif i=='Thickness' then v=Clamp(v,0.6,0x7fffffff); us.Thickness=v; so[i]=v
                    elseif i=='Visible' then sf.Visible=v; so[i]=v
                    elseif i=='Transparency' then sf.BackgroundTransparency=1; us.Transparency=CT(v); so[i]=v
                    elseif i=='Color' then us.Color=v; sf.BackgroundColor3=v; so[i]=v end
                end,__index=function(s,i) if i=='Remove' or i=='Destroy' then return function() sf:Destroy(); so.Remove(s); return so:Remove() end end return so[i] end,__tostring=function() return 'CustomLib' end})
            elseif ClassType=='Text' then
                local to=({Text='',Font=Enum.Font.SourceSansBold,Size=0,Position=Vector2.zero,Center=false,Outline=false,OutlineColor=Color3.new()}+LibraryMeta)
                local tl=Instance.new('TextLabel'); local us=Instance.new('UIStroke')
                tl.Name=CustomLibIndex; tl.AnchorPoint=Vector2.one*.5; tl.BorderSizePixel=0; tl.BackgroundTransparency=1; tl.RichText=true; tl.Visible=to.Visible; tl.TextColor3=to.Color; tl.TextTransparency=CT(to.Transparency); tl.ZIndex=to.ZIndex; tl.Font=Enum.Font.SourceSansBold; tl.TextSize=to.Size
                tl:GetPropertyChangedSignal('TextBounds'):Connect(function()
                    local tb=tl.TextBounds; local o=tb/2; local ox=not to.Center and o.X or 0
                    tl.Position=UDim2.fromOffset(to.Position.X+ox, to.Position.Y+o.Y)
                end)
                us.Thickness=1; us.Enabled=to.Outline; us.Color=to.Color
                tl.Parent,us.Parent=UtilityUI,tl
                return setmetatable(table.create(0),{__newindex=function(_,i,v)
                    if typeof(to[i])=='nil' then return end
                    if i=='Text' then tl.Text=v; to[i]=v
                    elseif i=='Font' then v=Clamp(v,0,3); to[i]=v
                    elseif i=='Size' then tl.TextSize=v; to[i]=v
                    elseif i=='Position' then local o=tl.TextBounds/2; local ox=not to.Center and o.X or 0; tl.Position=UDim2.fromOffset(to.Position.X+ox, to.Position.Y+o.Y); to[i]=v
                    elseif i=='Center' then local p=v and game:FindFirstChild("Workspace").CurrentCamera.ViewportSize/2 or to.Position; tl.Position=UDim2.fromOffset(p.X,p.Y); to[i]=v
                    elseif i=='Outline' then us.Enabled=v; to[i]=v
                    elseif i=='OutlineColor' then us.Color=v; to[i]=v
                    elseif i=='Visible' then tl.Visible=v; to[i]=v
                    elseif i=='ZIndex' then tl.ZIndex=v; to[i]=v
                    elseif i=='Transparency' then local t=CT(v); tl.TextTransparency=t; us.Transparency=t; to[i]=v
                    elseif i=='Color' then tl.TextColor3=v; to[i]=v end
                end,__index=function(s,i) if i=='Remove' or i=='Destroy' then return function() tl:Destroy(); to.Remove(s); return to:Remove() end elseif i=='TextBounds' then return tl.TextBounds end return to[i] end,__tostring=function() return 'CustomLib' end})
            end
        end
    end

    do
        SetRegion("Game")
        function Script:RayCast(Part, Origin, Ignore, Distance)
            Ignore = Ignore or {}; Distance = Distance or 2000
            local Direction = (Part.Position - Origin).Unit * Distance
            local Hit = Workspace:FindPartOnRayWithIgnoreList(Ray.new(Origin, Direction), Ignore)
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
            if Origin == 'Head' then local Head = Object:FindFirstChild('Head'); if Head and Head:IsA('RootPart') then return Head.CFrame.Position end
            elseif Origin == 'Torso' and RootPart then return RootPart.CFrame.Position end
            return Workspace.CurrentCamera.CFrame.Position
        end
        function Script:GetClosestPlayerToCursor(Max, FOV)
            local CurrentCamera = game:FindFirstChild("Workspace").CurrentCamera
            local MousePosition = UserInputService:GetMouseLocation()
            local Closest; local Distance = Max or math.huge
            local Conditions = getgenv().saved.Osiris['General']['Checks']
            FOV = FOV or math.huge
            for _, Player in ipairs(Players:GetPlayers()) do
                if Player == Self then continue end
                local Character = Player.Character
                if Player and Player.Character then
                    local HRP = Character:FindFirstChild("HumanoidRootPart")
                    if not HRP then continue end
                    local Position, OnScreen = CurrentCamera:WorldToViewportPoint(HRP.Position)
                    if not OnScreen then continue end
                    if Conditions['Visible'] then if not Script:RayCast(Character.HumanoidRootPart, Script:GetOrigin('Camera'), {Self.Character, SilentAimPart}) then continue end end
                    if Conditions['Knocked'] and Player.Character and CurrentGame.Functions.IsKnocked(Player.Character) then continue end
                    if Conditions['Self Knocked'] and CurrentGame.Functions.IsKnocked(Self.Character) then continue end
                    if Conditions['Knocked'] and CurrentGame.Functions.IsGrabbed(Player) then continue end
                    local Magnitude = (Vector2.new(Position.X, Position.Y) - MousePosition).Magnitude
                    if Magnitude < Distance and Magnitude < FOV then Closest = Player; Distance = Magnitude end
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
                                        if BodyEffects:FindFirstChild("Block") then shared.playerShot(Tool.Handle); Tool.Handle.NoAmmo:Play(); return end
                                        if Tool.Ammo.Value == 0 then Tool.Handle.NoAmmo:Play(); return end
                                    end
                                    if Character:FindFirstChild("FULLY_LOADED_CHAR") == nil then return
                                    elseif Character:FindFirstChild("FORCEFIELD") then return
                                    elseif Character:FindFirstChild("GRABBING_CONSTRAINT") then return
                                    elseif Character:FindFirstChild("Christmas_Sock") then return
                                    elseif BodyEffects.Cuff.Value == true then return
                                    elseif BodyEffects.Attacking.Value == true then return
                                    elseif BodyEffects["K.O"].Value == true then return
                                    elseif BodyEffects.Grabbed.Value then return
                                    elseif BodyEffects.Reload.Value == true then return
                                    elseif BodyEffects.Dead.Value == true then return
                                    elseif not Tool:GetAttribute("Cooldown") then
                                        local LastShot = Character:GetAttribute("LastGunShot")
                                        Character:SetAttribute("LastGunShot", Tool.Name)
                                        if not IsClient or (LastShot == Tool.Name or not Character:GetAttribute("ShotgunDebounce")) then
                                            if not IsClient and (not Character:GetAttribute("ShotgunDebounce") and (Tool.Name == "[Shotgun]" or (Tool.Name == "[Double-Barrel SG]" or (Tool.Name == "TacticalShotgun" or Tool.Name == "Drum-Shotgun")))) then
                                                Character:SetAttribute("ShotgunDebounce", true)
                                                task.delay(0.65, function() Character:SetAttribute("ShotgunDebounce", nil) end)
                                            end
                                            return true
                                        end
                                    end
                                else return end
                            else return end
                        else return end
                    else return end
                end
                local function ColorTransform(p14, p15)
                    if p15 == 0 then return p14.Keypoints[1].Value end
                    if p15 == 1 then return p14.Keypoints[#p14.Keypoints].Value end
                    for v16 = 1, #p14.Keypoints - 1 do
                        local v17 = p14.Keypoints[v16]; local v18 = p14.Keypoints[v16 + 1]
                        if v17.Time <= p15 and p15 < v18.Time then
                            local v19 = (p15 - v17.Time) / (v18.Time - v17.Time)
                            return Color3.new((v18.Value.R-v17.Value.R)*v19+v17.Value.R,(v18.Value.G-v17.Value.G)*v19+v17.Value.G,(v18.Value.B-v17.Value.B)*v19+v17.Value.B)
                        end
                    end
                end
                local replicatedStorage = game:GetService("ReplicatedStorage")
                local playersService = game:GetService("Players")
                local localPlayer = playersService.LocalPlayer
                local playerCharacter = Self.Character or Self.CharacterAdded:Wait()
                local shootAnimation = playerCharacter.Humanoid.Animator:LoadAnimation(replicatedStorage:WaitForChild("Animations"):WaitForChild("GunCombat"):WaitForChild("Shoot"))
                local aimShootAnimation = playerCharacter.Humanoid.Animator:LoadAnimation(replicatedStorage:WaitForChild("Animations"):WaitForChild("GunCombat"):WaitForChild("AimShoot"))
                local weaponNames = {"[Shotgun]","[Drum-Shotgun]","[Rifle]","[TacticalShotgun]","[AR]","[AUG]","[AK47]","[LMG]","[SilencerAR]"}
                local v_u_9 = ReplicatedStorage.SkinAssets
                local v_u_13 = game:FindFirstChild("Workspace"):GetServerTimeNow()
                local _ = game.PlaceId == 88976059384565
                local SoundsPlaying = {}
                local v_u_14 = {}
                local function changefunc()
                    local v_u_38 = {["functions"]={}}
                    function v_u_38.connect(_, p36) table.insert(v_u_38.functions, p36) end
                    local v_u_39 = nil
                    function v_u_38.updatechanges(_, p_u_40)
                        for _, v_u_41 in pairs(v_u_38.functions) do spawn(function() v_u_41(p_u_40.Press, p_u_40.Time, v_u_39) end) end
                        v_u_39 = p_u_40.Time
                    end
                    return v_u_38
                end
                setmetatable(v_u_14, {
                    __index=function(_, p42)
                        if getmetatable(v_u_14)[p42] == nil then v_u_14[p42] = {} end
                        return getmetatable(v_u_14)[p42]
                    end,
                    __newindex=function(_, p45, p46)
                        if getmetatable(v_u_14)[p45] == nil then
                            getmetatable(v_u_14)[p45] = {["val"]=p46,["changed"]=changefunc()}
                        else
                            getmetatable(v_u_14)[p45].val = p46
                            getmetatable(v_u_14)[p45].changed:updatechanges(p46)
                        end
                    end
                })
                UserInputService.InputBegan:connect(function(p51, p52)
                    if not p52 or (p51.UserInputType == Enum.UserInputType.Keyboard and p51.KeyCode == Enum.KeyCode.LeftShift) or (p51.UserInputType == Enum.UserInputType.Gamepad1 and p51.KeyCode == Enum.KeyCode.ButtonL2) then
                        if p51.UserInputType == Enum.UserInputType.Keyboard or p51.UserInputType == Enum.UserInputType.Gamepad1 then
                            v_u_14[p51.KeyCode.Name] = {["Press"]=true,["Time"]=tick()}; return
                        end
                    end
                    if p51.UserInputType == Enum.UserInputType.MouseButton2 then
                        v_u_14[Enum.UserInputType.MouseButton2.Name] = {["Press"]=true,["Time"]=tick()}
                    end
                end)
                UserInputService.InputEnded:connect(function(p53, p54)
                    if not p54 or (p53.UserInputType == Enum.UserInputType.Keyboard and p53.KeyCode == Enum.KeyCode.LeftShift) or (p53.UserInputType == Enum.UserInputType.Gamepad1 and p53.KeyCode == Enum.KeyCode.ButtonL2) then
                        if p53.UserInputType == Enum.UserInputType.Keyboard or p53.UserInputType == Enum.UserInputType.Gamepad1 then
                            v_u_14[p53.KeyCode.Name] = {["Press"]=false,["Time"]=tick()}; return
                        end
                    end
                    if p53.UserInputType == Enum.UserInputType.MouseButton2 then
                        v_u_14[Enum.UserInputType.MouseButton2.Name] = {["Press"]=false,["Time"]=tick()}
                    end
                end)
                local v_u_70 = true
                if not v_u_14.MouseButton2 then v_u_14.MouseButton2 = {} end
                if not v_u_14.MouseButton2.changed then v_u_14.MouseButton2.changed = changefunc() end
                v_u_14.MouseButton2.changed:connect(function(p71, _, _)
                    if v_u_70 ~= false then
                        Script.Locals.IsAimed = p71
                        if Script.Locals.IsAimed == false then v_u_70 = false; wait(0.1); v_u_70 = true end
                    end
                end)
                local function GetAim(Position)
                    if _G.MobileShiftLock then return (Camera.CFrame.p + Camera.CFrame.LookVector * 60 - Position).unit end
                    local v24
                    if Mouse.Target then v24 = Mouse.Hit.p
                    else
                        local v25 = Camera.CFrame; local v26 = v25.p + v25.LookVector * 60; local v27 = v25.LookVector
                        local v28 = Camera:ScreenPointToRay(Mouse.X, Mouse.Y); local v29 = v28.Direction; local v30 = v28.Origin
                        v24 = v30 + v29 * ((v26 - v30):Dot(v27) / v29:Dot(v27))
                    end
                    return (v24 - Position).Unit, (v24 - Position).Magnitude
                end
                local function ShootGun(p34)
                    local v35 = p34.Shooter; local v_u_36 = p34.Handle; local v37 = p34.AimPosition; local v38 = p34.BeamColor
                    local v39 = p34.isReflecting; local v40 = p34.Hit; local v41 = p34.Range or 200; local LegitPosition = p34.LegitPosition
                    local v_u_42
                    if v_u_36 then v_u_42 = v_u_36:GetAttribute("SkinName") else v_u_42 = v_u_36 end
                    local _, v43 = GetAim(v_u_36.Position)
                    local v_u_44 = p34.ForcedOrigin or v_u_36.Muzzle.WorldPosition
                    local v45 = (v37 - v_u_44).Unit
                    local v46 = RaycastParams.new(); local v47 = {}
                    local function set_list(t, i, vs) for j, v in ipairs(vs) do t[i+j-1] = v end end
                    local v48 = {game:FindFirstChild("Workspace"):WaitForChild("Bush"), game:FindFirstChild("Workspace"):WaitForChild("Ignored"), SilentAimPart}
                    set_list(v47, 1, {v35, unpack(v48)})
                    v46.FilterDescendantsInstances = v47; v46.FilterType = Enum.RaycastFilterType.Exclude; v46.IgnoreWater = true
                    local v_u_49, v_u_50, v_u_51
                    if v40 then v_u_49 = p34.Hit; v_u_50 = p34.AimPosition; v_u_51 = p34.Normal
                    else
                        local v52 = game:FindFirstChild("Workspace"):Raycast(v_u_44, v45 * v41, v46)
                        if v52 then v_u_49 = v52.Instance; v_u_50 = v52.Position; v_u_51 = v52.Normal
                        else v_u_50 = v_u_44 + v45 * math.min(v43, v41); v_u_51 = nil; v_u_49 = nil end
                    end
                    local v_u_53 = Instance.new("Part")
                    v_u_53:SetAttribute("OwnerCharacter", v35.Name); v_u_53.Name = "BULLET_RAYS"; v_u_53.Anchored = true; v_u_53.CanCollide = false; v_u_53.Size = Vector3.new(0,0,0); v_u_53.Transparency = 1
                    game.Debris:AddItem(v_u_53, 1)
                    if getgenv().saved.Osiris['Silent Aim']['Bullet Redirection'] then v_u_53.CFrame = CFrame.new(v_u_44, LegitPosition) else v_u_53.CFrame = CFrame.new(v_u_44, v_u_50) end
                    v_u_53.Material = Enum.Material.SmoothPlastic; v_u_53.Parent = game:FindFirstChild("Workspace").Ignored.Siren.Radius
                    local v54 = Instance.new("Attachment"); v54.Position = Vector3.new(0,0,0); v54.Parent = v_u_53
                    local v55 = Instance.new("Attachment"); v55.Position = Vector3.new(0,0,-(v_u_50-v_u_44).magnitude); v55.Parent = v_u_53
                    local v_u_57 = false; local v_u_58 = nil; local v59
                    if v_u_36 then
                        local v60 = v_u_36.Parent.Name
                        if v_u_42 and v_u_42 ~= "" then
                            if v_u_9.GunSkinMuzzleParticle:FindFirstChild(v_u_42) then
                                if not v39 then
                                    if v_u_9.GunSkinMuzzleParticle[v_u_42]:FindFirstChild("Muzzle") then
                                        if v_u_36.Parent:FindFirstChild("Default") and (v_u_36.Parent.Default:FindFirstChild("Mesh") and v_u_36.Parent.Default.Mesh:FindFirstChild("Muzzle")) then
                                            local v61
                                            if v_u_9.GunSkinMuzzleParticle[v_u_42].Muzzle:FindFirstChild("Different_GunMuzzle") then v61 = v_u_9.GunSkinMuzzleParticle[v_u_42].Muzzle.Different_GunMuzzle[v60]
                                            else v61 = v_u_9.GunSkinMuzzleParticle[v_u_42].Muzzle end
                                            for _, v62 in pairs(v61:GetChildren()) do
                                                local v63 = v62:GetAttribute("EmitCount") or 1
                                                local v_u_64 = v62:Clone(); v_u_64.Parent = v_u_36.Parent.Default.Mesh.Muzzle; v_u_64:Emit(v63)
                                                task.delay(v_u_64.Lifetime.Max, function() v_u_64:Destroy() end)
                                            end
                                        end
                                    else
                                        local v65 = v_u_9.GunSkinMuzzleParticle[v_u_42]:GetChildren()
                                        local v66 = v65[math.random(#v65)]:Clone(); v66.Parent = v54; v66:Emit(v66.Rate)
                                    end
                                end
                                v_u_57 = true
                            end
                            if v_u_9.GunBeam:FindFirstChild(v_u_42) then
                                if v_u_9.GunBeam[v_u_42].GunBeam:IsA("BasePart") then
                                    v59 = {["Parent"]=nil,["Attachment0"]=nil,["Attachment1"]=nil}
                                    if v_u_9.GunBeam[v_u_42].GunBeam:FindFirstChild("Different_GunBeam") then
                                        if v_u_9.GunBeam[v_u_42].GunBeam.Different_GunBeam[v60].GunBeam:IsA("BasePart") then v_u_58 = v_u_9.GunBeam[v_u_42].GunBeam.Different_GunBeam[v60].GunBeam:Clone()
                                        else v59 = v_u_9.GunBeam[v_u_42].GunBeam.Different_GunBeam[v60].GunBeam:Clone() end
                                    else v_u_58 = v_u_9.GunBeam[v_u_42].GunBeam:Clone() end
                                else v59 = v_u_9.GunBeam[v_u_42].GunBeam:Clone() end
                            else
                                v59 = game.ReplicatedStorage.GunBeam:Clone(); v59.Color = v38 and ColorSequence.new(v38) or v59.Color
                            end
                        else
                            v59 = game.ReplicatedStorage.GunBeam:Clone(); v59.Color = v38 and ColorSequence.new(v38) or v59.Color
                        end
                    else v59 = nil end
                    task.spawn(function()
                        if v_u_58 then
                            local v67 = (v_u_50 - v_u_44).magnitude; local v68 = v67 / 725
                            v_u_58.Anchored = true; v_u_58.CanCollide = false; v_u_58.CanQuery = false; v_u_58.CFrame = CFrame.new(v_u_44, v_u_50)
                            local v69 = v_u_58.CFrame * CFrame.new(0,0,-v67); v_u_58.Parent = game:FindFirstChild("Workspace").Ignored.Siren.Radius
                            task.delay(v68 + 5, function() v_u_58:Destroy(); v_u_58 = nil end)
                            if v_u_58:GetAttribute("SpecialEffects") then
                                for _, v70 in pairs(v_u_58:GetDescendants()) do
                                    if v70:IsA("Trail") and v70:GetAttribute("ColorRandom") then
                                        local v71 = v70:GetAttribute("ColorRandom"); v70.Color = ColorSequence.new(ColorTransform(v71, math.random()))
                                    end
                                end
                            end
                            local v72 = TweenService:Create(v_u_58, TweenInfo.new(0.05, Enum.EasingStyle.Linear), {["CFrame"]=v_u_58.CFrame * CFrame.new(0,0,-0.1)})
                            v72:Play(); task.wait(0.05)
                            if v72.PlaybackState ~= Enum.PlaybackState.Completed then v72:Pause() end
                            local v73 = nil
                            if _G.Reduce_Lag and not v_u_58:GetAttribute("NoSlow") or v_u_58:GetAttribute("LOWGFX") then v_u_58.CFrame = v69
                            else v73 = TweenService:Create(v_u_58, TweenInfo.new(v68, Enum.EasingStyle.Linear), {["CFrame"]=v69}); v73:Play(); task.wait(v68) end
                            if v_u_58:FindFirstChild("Impact") and (v_u_49 and (v_u_51 and not v_u_49.Parent:FindFirstChild("Humanoid"))) then
                                if v73 and v73.PlaybackState ~= Enum.PlaybackState.Completed then task.wait(0.05) end
                                if not v_u_58:FindFirstChild("NoNormal") then v_u_58.CFrame = CFrame.new(v_u_50, v_u_50 - v_u_51) end
                                for _, v74 in pairs(v_u_58.Impact:GetChildren()) do
                                    if v74:IsA("ParticleEmitter") then v74:Emit(v74:GetAttribute("EmitCount") or 1) end
                                end
                            else
                                for _, v75 in pairs(v_u_58:GetChildren()) do if v75:IsA("BasePart") then v75.Transparency = 1 end end
                            end
                            if v_u_58 then
                                for _, v76 in pairs(v_u_58:GetDescendants()) do if v76:IsA("ParticleEmitter") then v76.Enabled = false end end
                            end
                        elseif v_u_49 and (v_u_49:IsDescendantOf(game:FindFirstChild("Workspace").MAP) and (v_u_42 and (v_u_9.GunBeam:FindFirstChild(v_u_42) and v_u_9.GunBeam[v_u_42]:FindFirstChild("Impact")))) then
                            local v_u_77 = v_u_9.GunBeam[v_u_42].Impact:Clone(); v_u_77.Parent = game:FindFirstChild("Workspace").Ignored
                            v_u_77:PivotTo(CFrame.new(v_u_50, v_u_50 + v_u_51 * 5) * CFrame.Angles(-1.5707963267948966, 0, 0))
                            for _, v78 in pairs(v_u_77:GetDescendants()) do if v78:IsA("ParticleEmitter") then v78:Emit(v78:GetAttribute("EmitCount") or 1) end end
                            task.delay(1.5, function() v_u_77:Destroy(); v_u_77 = nil end)
                        end
                        local v79 = Instance.new("PointLight"); v79.Brightness = 0.5; v79.Range = 15; v79.Shadows = true; v79.Color = Color3.new(1,1,1); v79.Parent = v_u_53
                        local v80 = v_u_36:FindFirstChild("ShootBBGUI"); local v81 = v80 and (not v_u_57 and v80:FindFirstChild("Shoot"))
                        if v81 then
                            v81.Size = UDim2.new(0,0,0,0); v81.ImageTransparency = 1; v81.Visible = true
                            TweenService:Create(v81, TweenInfo.new(0.4, Enum.EasingStyle.Bounce, Enum.EasingDirection.In, 0, false, 0), {["Size"]=UDim2.new(1,0,1,0),["ImageTransparency"]=0.4}):Play()
                            TweenService:Create(v79, TweenInfo.new(0.4, Enum.EasingStyle.Bounce, Enum.EasingDirection.In, 0, false, 0), {["Range"]=0}):Play()
                            wait(0.4); v_u_53:Destroy()
                            TweenService:Create(v81, TweenInfo.new(0.2, Enum.EasingStyle.Bounce, Enum.EasingDirection.In, 0, false, 0), {["Size"]=UDim2.new(1,0,1,0),["ImageTransparency"]=1}):Play()
                            wait(0.2); v81.Visible = false
                        end
                    end)
                    v59.Attachment0 = v54; v59.Attachment1 = v55; v59.Name = "NewGunBeam"; v59.Parent = v_u_53
                    if v35 == localPlayer.Character and game:FindFirstChild("Workspace"):GetServerTimeNow() - v_u_13 > 0.95 then
                        local function Animate(target)
                            playerCharacter = localPlayer.Character or localPlayer.CharacterAdded:Wait()
                            if playerCharacter and playerCharacter:FindFirstChild("Humanoid") and playerCharacter.Humanoid:FindFirstChild("Animator") then
                                shootAnimation = playerCharacter.Humanoid.Animator:LoadAnimation(replicatedStorage.Animations.GunCombat.Shoot)
                                aimShootAnimation = playerCharacter.Humanoid.Animator:LoadAnimation(replicatedStorage.Animations.GunCombat.AimShoot)
                                if Script.Locals.IsAimed or table.find(weaponNames, target.Parent.Name) then aimShootAnimation:Play() else shootAnimation:Play() end
                            end
                        end
                        shared.playerShot = Animate; Animate(v_u_36)
                    end
                    local playsound = function(p1, p2)
                        local v3 = p1.ShootSound:GetAttribute("SequenceSFX")
                        if v3 then
                            if p1.ShootSound:GetAttribute("CurrentSequence") == nil then p1.ShootSound:SetAttribute("CurrentSequence", 1)
                            else p1.ShootSound:SetAttribute("CurrentSequence", p1.ShootSound:GetAttribute("CurrentSequence") + 1) end
                            local v4 = p1.ShootSound:GetAttribute("CurrentSequence"); local v5 = {}
                            for v6 in string.gmatch(v3, "%d+") do table.insert(v5, v6) end
                            p1.ShootSound.SoundId = "rbxassetid://" .. v5[v4 % #v5 + 1]
                        end
                        if p2 then
                            local v_u_7 = p1.ShootSound:Clone(); v_u_7.Name = "MG"; v_u_7.Parent = p1; v_u_7:Play()
                            delay(1, function() v_u_7:Destroy() end)
                        else p1.ShootSound:Play() end
                    end
                    if not SoundsPlaying[v_u_36] then
                        task.spawn(playsound, v_u_36, true)
                        SoundsPlaying[v_u_36] = true
                        task.delay(0.021, function() SoundsPlaying[v_u_36] = nil end)
                    end
                    if game.Lighting:GetAttribute("printhits") then
                        local v82 = print; local v83 = v_u_49
                        if v83 then v83 = v_u_49:GetFullName() end
                        v82(v83)
                    end
                    return v_u_50, v_u_49, v_u_51
                end
                local function Animate(target)
                    playerCharacter = localPlayer.Character or localPlayer.CharacterAdded:Wait()
                    if playerCharacter and playerCharacter:FindFirstChild("Humanoid") and playerCharacter.Humanoid:FindFirstChild("Animator") then
                        shootAnimation = playerCharacter.Humanoid.Animator:LoadAnimation(replicatedStorage.Animations.GunCombat.Shoot)
                        aimShootAnimation = playerCharacter.Humanoid.Animator:LoadAnimation(replicatedStorage.Animations.GunCombat.AimShoot)
                        if Script.Locals.IsAimed or table.find(weaponNames, target.Parent.Name) then aimShootAnimation:Play() else shootAnimation:Play() end
                    end
                end
                shared.playerShot = Animate
                return { CanShoot = CanShoot, Animate = Animate, GetAim = GetAim, ColorTransform = ColorTransform, ShootGun = ShootGun }
            else return {} end
        end
    end

    do
        SetRegion("Main")
        local DaHood = Modules.Get("DaHood")
        local CurrentSnappiness -- [FIX 2]

        function Script:GetClosestPointOnPart(Part, Scale)
            local PartCFrame = Part.CFrame; local PartSize = Part.Size; local PartSizeTransformed = PartSize * (Scale / 2)
            local MousePosition = UserInputService:GetMouseLocation(); local CurrentCamera = Workspace.CurrentCamera
            local MouseRay = CurrentCamera:ViewportPointToRay(MousePosition.X, MousePosition.Y)
            local Transformed = PartCFrame:PointToObjectSpace(MouseRay.Origin + (MouseRay.Direction * MouseRay.Direction:Dot(PartCFrame.Position - MouseRay.Origin)))
            if (Mouse.Target == Part) then return Vector3.new(Mouse.Hit.X, Mouse.Hit.Y, Mouse.Hit.Z) end
            return PartCFrame * Vector3.new(math.clamp(Transformed.X, -PartSizeTransformed.X, PartSizeTransformed.X), math.clamp(Transformed.Y, -PartSizeTransformed.Y, PartSizeTransformed.Y), math.clamp(Transformed.Z, -PartSizeTransformed.Z, PartSizeTransformed.Z))
        end
        function Script:GetClosestPointOnPartBasic(Part)
            if Part then
                local MouseRay = Mouse.UnitRay
                MouseRay = MouseRay.Origin + (MouseRay.Direction * (Part.Position - MouseRay.Origin).Magnitude)
                local Point = (MouseRay.Y >= (Part.Position - Part.Size / 2).Y and MouseRay.Y <= (Part.Position + Part.Size / 2).Y) and (Part.Position + Vector3.new(0, -Part.Position.Y + MouseRay.Y, 0)) or Part.Position
                local Check = RaycastParams.new(); Check.FilterType = Enum.RaycastFilterType.Whitelist; Check.FilterDescendantsInstances = {Part}
                local Ray = Workspace:Raycast(MouseRay, (Point - MouseRay), Check)
                if Mouse.Target == Part then return Mouse.Hit.Position end
                if Ray then return Ray.Position else return Mouse.Hit.Position end
            end
        end
        function Script:GetClosestPartToCursor(Character)
            local CurrentCamera = Workspace.CurrentCamera; local Closest; local Distance = 1/0
            for _, Part in ipairs(Character:GetChildren()) do
                if not Part:IsA("BasePart") then continue end
                local Position = CurrentCamera:WorldToViewportPoint(Part.Position); Position = Vector2.new(Position.X, Position.Y)
                local Magnitude = (UserInputService:GetMouseLocation() - Position).Magnitude
                if Magnitude < Distance then Closest = Part; Distance = Magnitude end
            end
            return Closest
        end
        function Script:GetClosestPartToCursorFilter(Character, PartsToCheck)
            local CurrentCamera = Workspace.CurrentCamera; local Closest = nil; local Distance = 1/0
            for _, Part in ipairs(Character:GetChildren()) do
                if not Part:IsA("BasePart") or (PartsToCheck and not table.find(PartsToCheck, Part.Name)) then continue end
                local Position = CurrentCamera:WorldToViewportPoint(Part.Position); Position = Vector2.new(Position.X, Position.Y)
                local Magnitude = (UserInputService:GetMouseLocation() - Position).Magnitude
                if Magnitude < Distance then Closest = Part; Distance = Magnitude end
            end
            return Closest
        end
        function Script:GetResolvedVelocity(Part)
            local LastPosition = Part.Position; task.wait(0.085); local CurrentPosition = Part.Position
            return (CurrentPosition - LastPosition) / 0.085
        end
        local smoothedVelocity = Vector3.new(0,0,0)
        local function getDynamicSmoothingFactor(v) if v < 5 then return 0.05 elseif v < 20 then return 0.1 else return 0.2 end end
        local function GetResolvedVelocity(Part)
            local LastPosition = Part.Position; task.wait(0.085); local CurrentPosition = Part.Position
            local Velocity = (CurrentPosition - LastPosition) / 0.085
            local dynamicSmoothing = getDynamicSmoothingFactor(Velocity.Magnitude)
            smoothedVelocity = smoothedVelocity * (1 - dynamicSmoothing) + Velocity * dynamicSmoothing
            return smoothedVelocity * Vector3.new(1, 0, 1)
        end

        function Script:GetHitPosition(Mode)
            if Mode == 'Assist' then
                local Osiris = getgenv().saved.Osiris['Aim Assist']
                local Object = Script.Locals.AimAssistTarget and Script.Locals.AimAssistTarget.Character
                if not Object then return end
                local Humanoid = Object:FindFirstChild("Humanoid"); if not Humanoid then return end
                local NearestPart = Script:GetClosestPartToCursor(Object); if not NearestPart then return end
                local HitPosition
                if Osiris['Custom Parts'] and Osiris['Custom Parts']['Enabled'] then
                    local customParts = Osiris['Custom Parts']['Parts'] or {}; local mode = Osiris['Custom Parts']['Mode'] or "Point"
                    if mode == "Point" then
                        local closestPart = Script:GetClosestPartToCursorFilter(Object, customParts)
                        if closestPart then
                            if Osiris['Nearest Point']['Mode'] == 'Smart' then HitPosition = Script:GetClosestPointOnPart(closestPart, Osiris['Nearest Point']['Scale'])
                            else HitPosition = Script:GetClosestPointOnPartBasic(closestPart) end
                        else
                            if Osiris['Nearest Point']['Mode'] == 'Smart' then HitPosition = Script:GetClosestPointOnPart(NearestPart, Osiris['Nearest Point']['Scale'])
                            else HitPosition = Script:GetClosestPointOnPartBasic(NearestPart) end
                        end
                    elseif mode == "Part" then
                        local closestPart = nil; local closestDistance = math.huge
                        for _, partName in ipairs(customParts) do
                            local part = Object:FindFirstChild(partName)
                            if part and part:IsA("BasePart") then
                                local pos, onScreen = Camera:WorldToViewportPoint(part.Position)
                                if onScreen then
                                    local distance = (Vector2.new(pos.X, pos.Y) - UserInputService:GetMouseLocation()).Magnitude
                                    if distance < closestDistance then closestDistance = distance; closestPart = part end
                                end
                            end
                        end
                        if closestPart then HitPosition = closestPart.Position else HitPosition = NearestPart.Position end
                    end
                else
                    if Osiris['Hit Part'] == 'Nearest Point' then
                        if Osiris['Nearest Point']['Mode'] == 'Smart' then HitPosition = Script:GetClosestPointOnPart(NearestPart, Osiris['Nearest Point']['Scale'])
                        else HitPosition = Script:GetClosestPointOnPartBasic(NearestPart) end
                    elseif Osiris['Hit Part'] == 'Nearest Part' then HitPosition = NearestPart.Position
                    elseif typeof(Osiris['Hit Part']) == 'table' then
                        local part = Script:GetClosestPartToCursorFilter(Object, Osiris['Hit Part'])
                        if part then HitPosition = part.Position else HitPosition = NearestPart.Position end
                    else
                        local targetPart = Object:FindFirstChild(Osiris['Hit Part'])
                        if targetPart then HitPosition = targetPart.Position else HitPosition = NearestPart.Position end
                    end
                end
                if Osiris['Prediction']['Enabled'] then
                    local BasePrediction = Vector3.new(Osiris['Prediction']['X'], Osiris['Prediction']['Y'], Osiris['Prediction']['Z'])
                    return HitPosition + Script:GetResolvedVelocity(Object.HumanoidRootPart) * BasePrediction
                else return HitPosition end
            end
            if Mode == 'Silent' then
                local Osiris = getgenv().saved.Osiris['Silent Aim']
                local Object = Script.Locals.SilentAimTarget and Script.Locals.SilentAimTarget.Character
                if not Object then return end
                local Humanoid = Object:FindFirstChild("Humanoid"); if not Humanoid then return end
                local NearestPart = Script:GetClosestPartToCursor(Object); local HitPosition; local HitPart = Osiris['Hit Part']
                if HitPart == 'Nearest Point' then
                    if Osiris['Nearest Point']['Mode'] == 'Smart' then HitPosition = Script:GetClosestPointOnPart(NearestPart, Osiris['Nearest Point']['Scale'])
                    else HitPosition = Script:GetClosestPointOnPartBasic(NearestPart) end
                elseif HitPart == 'Nearest Part' then HitPosition = NearestPart.Position
                elseif typeof(HitPart) == 'table' then
                    local part = Script:GetClosestPartToCursorFilter(Object, HitPart)
                    if part then HitPosition = part.Position else HitPosition = NearestPart.Position end
                else
                    -- [FIX 6] Nil-safe part lookup
                    local targetPart = Object:FindFirstChild(HitPart)
                    if targetPart then HitPosition = targetPart.Position else HitPosition = NearestPart.Position end
                end
                return HitPosition
            end
        end

        function Script:UpdateBox()
            if Script.Locals.SilentAimTarget and Script.Locals.SilentAimTarget.Character then
                local Object, Humanoid, RootPart = Script:ValidateClient(Script.Locals.SilentAimTarget)
                if Object and Humanoid and RootPart then
                    local Position, Visible = Camera:WorldToViewportPoint(RootPart.Position)
                    local Size = RootPart.Size.Y
                    local scaleFactor = (Size * Camera.ViewportSize.Y) / (Position.Z * 2) * 80 / game:FindFirstChild("Workspace").CurrentCamera.FieldOfView
                    local w, h = CurrentFOVX * scaleFactor, CurrentFOVY * scaleFactor
                    Script.Locals.FieldOfViewOne.Position = Vector2.new(Position.X - w / 2, Position.Y - h / 2)
                    Script.Locals.FieldOfViewOne.Size = Vector2.new(w, h)
                    Script.Locals.FieldOfViewOne.Visible = (Visible and getgenv().saved.Osiris['Silent Aim']['Field Of View']['Mode'] == '2D' and getgenv().saved.Osiris['Silent Aim']['Field Of View']['Visible']) or false
                    local mouseLocation = UserInputService:GetMouseLocation()
                    local boxPos = Script.Locals.FieldOfViewOne.Position; local boxSize = Script.Locals.FieldOfViewOne.Size
                    if mouseLocation.X >= boxPos.X and mouseLocation.X <= boxPos.X + boxSize.X and mouseLocation.Y >= boxPos.Y and mouseLocation.Y <= boxPos.Y + boxSize.Y then
                        Script.Locals.IsBoxFocused = true; Script.Locals.FieldOfViewOne.Color = Color3.fromRGB(255, 0, 0)
                    else
                        Script.Locals.IsBoxFocused = false; Script.Locals.FieldOfViewOne.Color = Color3.fromRGB(255, 255, 255)
                    end
                else Script.Locals.FieldOfViewOne.Visible = false end
            else Script.Locals.FieldOfViewOne.Visible = false end
        end
        function Script:UpdateLabels() end

        function Script:ShouldShoot(Target)
            if not Target then SilentAimPart.Position = Vector3.zero; return false end
            if not Target.Character then SilentAimPart.Position = Vector3.zero; return false end
            local allConditionsPassed = true
            local Conditions = getgenv().saved.Osiris['General']['Checks']
            if Conditions['Visible'] then if not Script:RayCast(Target.Character.HumanoidRootPart, Script:GetOrigin('Camera'), {Self.Character, SilentAimPart}) then allConditionsPassed = false; SilentAimPart.Position = Vector3.zero end end
            if Conditions['Knocked'] and CurrentGame.Functions.IsKnocked(Target.Character) then allConditionsPassed = false; SilentAimPart.Position = Vector3.zero end
            if Conditions['Self Knocked'] and CurrentGame.Functions.IsKnocked(Self.Character) then allConditionsPassed = false; SilentAimPart.Position = Vector3.zero end
            if Conditions['Carried'] and CurrentGame.Functions.IsGrabbed(Target) then allConditionsPassed = false; SilentAimPart.Position = Vector3.zero end
            local screen, _ = Camera:WorldToViewportPoint(Script.Locals.HitPosition)
            local DistanceX = math.abs(screen.X - Mouse.X); local DistanceY = math.abs(screen.Y - Mouse.Y)
            local Box = Script.Locals.IsBoxFocused and Vector2.new(1000, 1000) or Vector2.new(0, 0)
            local RadiusX, RadiusY
            if getgenv().saved.Osiris['Silent Aim']['Field Of View']['Mode'] == '2D' then RadiusX = Box.X; RadiusY = Box.Y else RadiusX = CurrentFOV; RadiusY = CurrentFOV end
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
                    if table.find(WeaponInfo.Shotguns, Tool.Name) then return "Shotgun" end
                    if table.find(WeaponInfo.Pistols, Tool.Name) then return "Pistol" end
                    if table.find(WeaponInfo.Rifles, Tool.Name) then return "Rifle" end
                    if table.find(WeaponInfo.Bursts, Tool.Name) then return "Burst" end
                    if table.find(WeaponInfo.SMG, Tool.Name) then return "SMG" end
                    if table.find(WeaponInfo.Snipers, Tool.Name) then return "Sniper" end
                    if table.find(WeaponInfo.AutoShotguns, Tool.Name) then return "Auto" end
                end
            end
            return nil
        end

        function Script:SilentAimFunc(Tool)
            if string.find(GameName, "Da Hood") then
                if not Ticks[Tool.Name] then Ticks[Tool.Name] = 0 end
                local WeaponOffset = WeaponInfo.Offsets[Tool.Name]
                local Gun = Script:GetGunCategory()
                local ToolHandle = Tool:WaitForChild("Handle")
                local LocalCharacter = Self.Character or Self.CharacterAdded:Wait()
                local Cooldown = Tool:WaitForChild("ShootingCooldown").Value
                local NoClueWhatThisIs = game.PlaceId == 88976059384565 and {["Value"]=5} or Tool.Ammo
                local Time = game:FindFirstChild("Workspace"):GetServerTimeNow()
                local Check = tick() - Ticks[Tool.Name] >= Cooldown + WeaponInfo.Delays[Tool.Name]
                local ToolEvent = Tool:WaitForChild("RemoteEvent", 2) or {["FireServer"]=function(_,_) end}
                local BeamCol = Color3.new(1, 0.545098, 0.14902)
                local function ShootFunc(GunType, SilentAim)
                    if GunType == "Shotgun" then
                        if Check and (NoClueWhatThisIs.Value >= 1 and (not _G.GUN_COMBAT_TOGGLE and DaHood.CanShoot(Self.Character))) then
                            Ticks[Tool.Name] = tick(); ToolEvent:FireServer("Shoot")
                            for _ = 1, 5 do
                                local HitPosition = Script.Locals.HitPosition; local SpreadX, SpreadY, SpreadZ
                                if getgenv().saved.Osiris['Weapon Modifications']['Spread Modifier']['Enabled'] then
                                    local spreadData = getgenv().saved.Osiris['Weapon Modifications']['Spread Modifier'][Tool.Name]
                                    local spreadReduction = spreadData and spreadData['Value'] or 1
                                    local randomizer = getgenv().saved.Osiris['Weapon Modifications']['Spread Modifier']['Randomizer']
                                    spreadReduction = math.clamp(spreadReduction, 0, 1); local spreadFactor = spreadReduction
                                    if randomizer.Enabled then spreadFactor = spreadFactor * (1 - math.random() * randomizer.Value) end
                                    SpreadX = math.random() > 0.5 and math.random()*0.05*spreadFactor or -math.random()*0.05*spreadFactor
                                    SpreadY = math.random() > 0.5 and math.random()*0.1*spreadFactor or -math.random()*0.1*spreadFactor
                                    SpreadZ = math.random() > 0.5 and math.random()*0.05*spreadFactor or -math.random()*0.05*spreadFactor
                                else
                                    SpreadX = math.random() > 0.5 and math.random()*0.05 or -math.random()*0.05
                                    SpreadY = math.random() > 0.5 and math.random()*0.1 or -math.random()*0.1
                                    SpreadZ = math.random() > 0.5 and math.random()*0.05 or -math.random()*0.05
                                end
                                local ForcedOrigin = Tool:FindFirstChild("Default") and (Tool.Default:FindFirstChild("Mesh") and Tool.Default.Mesh:FindFirstChild("Muzzle")) or {["WorldPosition"]=(ToolHandle.CFrame * WeaponOffset).Position}
                                local TotalSpread = Vector3.new(SpreadX, SpreadY, SpreadZ); local AimPosition
                                local WeaponRange = Tool:FindFirstChild("Range")
                                if SilentAim and (Self.Character.HumanoidRootPart.Position - Script.Locals.SilentAimTarget.Character.HumanoidRootPart.Position).Magnitude < WeaponRange.Value then
                                    AimPosition = ForcedOrigin.WorldPosition + ((HitPosition - ForcedOrigin.WorldPosition).Unit + TotalSpread) * WeaponRange.Value
                                else
                                    AimPosition = ForcedOrigin.WorldPosition + (DaHood.GetAim(ForcedOrigin.WorldPosition) + TotalSpread) * WeaponRange.Value
                                end
                                local Arg0, Arg1, Arg2 = DaHood.ShootGun({["Shooter"]=LocalCharacter,["Handle"]=ToolHandle,["AimPosition"]=AimPosition,["BeamColor"]=BeamCol,["ForcedOrigin"]=ForcedOrigin.WorldPosition,["LegitPosition"]=ForcedOrigin.WorldPosition + (DaHood.GetAim(ForcedOrigin.WorldPosition) + TotalSpread) * WeaponRange.Value,["Range"]=WeaponRange.Value})
                                ReplicatedStorage.MainEvent:FireServer("ShootGun", ToolHandle, ForcedOrigin.WorldPosition, Arg0, Arg1, Arg2, Time)
                            end
                            ToolEvent:FireServer()
                        end
                    elseif Gun == "Pistol" then
                        if Check and (NoClueWhatThisIs.Value >= 1 and (not _G.GUN_COMBAT_TOGGLE and DaHood.CanShoot(Self.Character))) then
                            Ticks[Tool.Name] = tick(); local HitPosition = Script.Locals.HitPosition; ToolEvent:FireServer("Shoot")
                            local ForcedOrigin = Tool:FindFirstChild("Default") and (Tool.Default:FindFirstChild("Mesh") and Tool.Default.Mesh:FindFirstChild("Muzzle")) or {["WorldPosition"]=(ToolHandle.CFrame * WeaponOffset).Position}
                            local WeaponRange = Tool:WaitForChild("Range"); local AimPosition
                            if SilentAim and (Self.Character.HumanoidRootPart.Position - Script.Locals.SilentAimTarget.Character.HumanoidRootPart.Position).Magnitude < WeaponRange.Value then AimPosition = HitPosition
                            else AimPosition = ForcedOrigin.WorldPosition + DaHood.GetAim(ForcedOrigin.WorldPosition) * 200 end
                            local Arg0, Arg1, Arg2 = DaHood.ShootGun({["Shooter"]=LocalCharacter,["Handle"]=ToolHandle,["ForcedOrigin"]=ForcedOrigin.WorldPosition or (ToolHandle.CFrame * WeaponOffset).Position,["AimPosition"]=AimPosition,["BeamColor"]=BeamCol,["LegitPosition"]=ForcedOrigin.WorldPosition + DaHood.GetAim(ForcedOrigin.WorldPosition) * 200,["Range"]=WeaponRange.Value})
                            ReplicatedStorage.MainEvent:FireServer("ShootGun", ToolHandle, ForcedOrigin.WorldPosition, Arg0, Arg1, Arg2); ToolEvent:FireServer()
                        end
                    elseif Gun == "Auto" then
                        if Check and (not _G.GUN_COMBAT_TOGGLE and DaHood.CanShoot(LocalCharacter)) then
                            Ticks[Tool.Name] = tick(); ToolEvent:FireServer("Shoot"); local Flag = true
                            task.spawn(function()
                                while Flag and (Tool.Parent == LocalCharacter and (NoClueWhatThisIs.Value > 0 and DaHood.CanShoot(LocalCharacter))) do
                                    local HitPosition = Script.Locals.HitPosition; local CurrentTime = game:FindFirstChild("Workspace"):GetServerTimeNow()
                                    for _ = 1, 5 do
                                        local SpreadX, SpreadY, SpreadZ
                                        if getgenv().saved.Osiris['Weapon Modifications']['Spread Modifier']['Enabled'] then
                                            local spreadData = getgenv().saved.Osiris['Weapon Modifications']['Spread Modifier'][Tool.Name]
                                            local spreadReduction = spreadData and spreadData['Value'] or 1
                                            local randomizer = getgenv().saved.Osiris['Weapon Modifications']['Spread Modifier']['Randomizer']
                                            spreadReduction = math.clamp(spreadReduction, 0, 1); local spreadFactor = spreadReduction
                                            if randomizer.Enabled then spreadFactor = spreadFactor * (1 - math.random() * randomizer.Value) end
                                            SpreadX = math.random() > 0.5 and math.random()*0.05*spreadFactor or -math.random()*0.05*spreadFactor
                                            SpreadY = math.random() > 0.5 and math.random()*0.1*spreadFactor or -math.random()*0.1*spreadFactor
                                            SpreadZ = math.random() > 0.5 and math.random()*0.05*spreadFactor or -math.random()*0.05*spreadFactor
                                        else
                                            SpreadX = math.random() > 0.5 and math.random()*0.05 or -math.random()*0.05
                                            SpreadY = math.random() > 0.5 and math.random()*0.1 or -math.random()*0.1
                                            SpreadZ = math.random() > 0.5 and math.random()*0.05 or -math.random()*0.05
                                        end
                                        local ForcedOrigin = Tool:FindFirstChild("Default") and (Tool.Default:FindFirstChild("Mesh") and Tool.Default.Mesh:FindFirstChild("Muzzle")) or {["WorldPosition"]=(ToolHandle.CFrame * WeaponOffset).Position}
                                        local TotalSpread = Vector3.new(SpreadX, SpreadY, SpreadZ); local AimPosition
                                        local WeaponRange = Tool:WaitForChild("Range")
                                        if SilentAim and (Self.Character.HumanoidRootPart.Position - Script.Locals.SilentAimTarget.Character.HumanoidRootPart.Position).Magnitude < WeaponRange.Value then
                                            AimPosition = ForcedOrigin.WorldPosition + ((HitPosition - ForcedOrigin.WorldPosition).Unit + TotalSpread) * WeaponRange.Value
                                        else
                                            AimPosition = ForcedOrigin.WorldPosition + (DaHood.GetAim(ForcedOrigin.WorldPosition) + TotalSpread) * WeaponRange.Value
                                        end
                                        local Arg0, Arg1, Arg2 = DaHood.ShootGun({["Shooter"]=LocalCharacter,["Handle"]=ToolHandle,["AimPosition"]=AimPosition,["BeamColor"]=BeamCol,["ForcedOrigin"]=ForcedOrigin.WorldPosition,["LegitPosition"]=ForcedOrigin.WorldPosition + (DaHood.GetAim(ForcedOrigin.WorldPosition) + TotalSpread) * WeaponRange.Value,["Range"]=WeaponRange.Value})
                                        ReplicatedStorage.MainEvent:FireServer("ShootGun", ToolHandle, ForcedOrigin.WorldPosition, Arg0, Arg1, Arg2, CurrentTime)
                                    end
                                    task.wait(Cooldown + 0.0095); Ticks[Tool.Name] = tick()
                                end
                                ToolEvent:FireServer()
                            end)
                            Tool.Deactivated:Wait(); Flag = false
                        end
                    elseif Gun == "Burst" then
                        local Tolerance = Tool:WaitForChild("ToleranceCooldown").Value; local ShootingCool = Tool:WaitForChild("ShootingCooldown").Value
                        if tick() - Ticks[Tool.Name] >= Tolerance and (not _G.GUN_COMBAT_TOGGLE and DaHood.CanShoot(LocalCharacter)) then
                            Ticks[Tool.Name] = tick(); ToolEvent:FireServer("Shoot"); game:FindFirstChild("Workspace"):GetServerTimeNow()
                            task.spawn(function()
                                for _ = 1, NoClueWhatThisIs.Value > 3 and 3 or NoClueWhatThisIs.Value do
                                    local HitPosition = Script.Locals.HitPosition; local v17
                                    local ForcedOrigin = Tool:FindFirstChild("Default") and (Tool.Default:FindFirstChild("Mesh") and Tool.Default.Mesh:FindFirstChild("Muzzle")) or {["WorldPosition"]=(ToolHandle.CFrame * WeaponOffset).Position}
                                    local WeaponRange = Tool:WaitForChild("Range")
                                    if SilentAim and (Self.Character.HumanoidRootPart.Position - Script.Locals.SilentAimTarget.Character.HumanoidRootPart.Position).Magnitude < WeaponRange.Value then
                                        v17 = ForcedOrigin.WorldPosition + ((HitPosition - ForcedOrigin.WorldPosition).Unit) * 200
                                    else
                                        v17 = ForcedOrigin.WorldPosition + DaHood.GetAim(ForcedOrigin.WorldPosition) * 200
                                    end
                                    local v18, v19, v20 = DaHood.ShootGun({["Shooter"]=LocalCharacter,["Handle"]=ToolHandle,["ForcedOrigin"]=ForcedOrigin.WorldPosition,["AimPosition"]=v17,["LegitPosition"]=ForcedOrigin.WorldPosition + DaHood.GetAim(ForcedOrigin.WorldPosition) * 200,["BeamColor"]=BeamCol,["Range"]=WeaponRange.Value})
                                    ReplicatedStorage.MainEvent:FireServer("ShootGun", ToolHandle, ForcedOrigin.WorldPosition, v18, v19, v20)
                                    task.wait(ShootingCool + 0.0095)
                                end
                                ToolEvent:FireServer()
                            end)
                        end
                    elseif Gun == "Rifle" or GunType == "SMG" then
                        local ShootingCool = Tool:WaitForChild("ShootingCooldown").Value
                        if Check and (not _G.GUN_COMBAT_TOGGLE and DaHood.CanShoot(LocalCharacter)) then
                            Ticks[Tool.Name] = tick(); ToolEvent:FireServer("Shoot"); local Flag = true
                            task.spawn(function()
                                while task.wait(ShootingCool + 0.0095) and (Flag and (Tool.Parent == LocalCharacter and (NoClueWhatThisIs.Value > 0 and DaHood.CanShoot(LocalCharacter)))) do
                                    local HitPosition = Script.Locals.HitPosition
                                    local ForcedOrigin = Tool:FindFirstChild("Default") and (Tool.Default:FindFirstChild("Mesh") and Tool.Default.Mesh:FindFirstChild("Muzzle")) or {["WorldPosition"]=(ToolHandle.CFrame * WeaponOffset).Position}
                                    local AimPosition; local WeaponRange = Tool:WaitForChild("Range")
                                    if SilentAim and (Self.Character.HumanoidRootPart.Position - Script.Locals.SilentAimTarget.Character.HumanoidRootPart.Position).Magnitude < WeaponRange.Value then
                                        AimPosition = ForcedOrigin.WorldPosition + ((HitPosition - ForcedOrigin.WorldPosition).Unit) * 200
                                    else
                                        AimPosition = ForcedOrigin.WorldPosition + DaHood.GetAim(ForcedOrigin.WorldPosition) * 200
                                    end
                                    local v18, v19, v20 = DaHood.ShootGun({["Shooter"]=LocalCharacter,["Handle"]=ToolHandle,["ForcedOrigin"]=ForcedOrigin.WorldPosition,["AimPosition"]=AimPosition,["LegitPosition"]=ForcedOrigin.WorldPosition + DaHood.GetAim(ForcedOrigin.WorldPosition) * 200,["BeamColor"]=BeamCol,["Range"]=WeaponRange.Value})
                                    ReplicatedStorage.MainEvent:FireServer("ShootGun", ToolHandle, ForcedOrigin.WorldPosition, v18, v19, v20)
                                    Ticks[Tool.Name] = tick()
                                end
                                ToolEvent:FireServer()
                            end)
                            Tool.Deactivated:Wait(); Flag = false
                        end
                    elseif Gun == "Sniper" then
                        if Check and (not _G.GUN_COMBAT_TOGGLE and DaHood.CanShoot(LocalCharacter)) then
                            Ticks[Tool.Name] = tick(); ToolEvent:FireServer("Shoot"); local HitPosition = Script.Locals.HitPosition
                            local ForcedOrigin = Tool:FindFirstChild("Default") and (Tool.Default:FindFirstChild("Mesh") and Tool.Default.Mesh:FindFirstChild("Muzzle")) or {["WorldPosition"]=(ToolHandle.CFrame * WeaponOffset).Position}
                            local AimPosition; local WeaponRange = Tool:WaitForChild("Range")
                            if SilentAim and (Self.Character.HumanoidRootPart.Position - Script.Locals.SilentAimTarget.Character.HumanoidRootPart.Position).Magnitude < WeaponRange.Value then
                                AimPosition = ForcedOrigin.WorldPosition + ((HitPosition - ForcedOrigin.WorldPosition).Unit) * 50
                            else
                                AimPosition = ForcedOrigin.WorldPosition + DaHood.GetAim(ForcedOrigin.WorldPosition) * 50
                            end
                            local v16, v17, v18 = DaHood.ShootGun({["Shooter"]=LocalCharacter,["Handle"]=ToolHandle,["ForcedOrigin"]=ForcedOrigin.WorldPosition,["AimPosition"]=AimPosition,["LegitPosition"]=ForcedOrigin.WorldPosition + DaHood.GetAim(ForcedOrigin.WorldPosition) * 50,["BeamColor"]=BeamCol,["Range"]=WeaponRange.Value})
                            ReplicatedStorage.MainEvent:FireServer("ShootGun", ToolHandle, ForcedOrigin.WorldPosition, v16, v17, v18); ToolEvent:FireServer()
                        end
                    end
                end
                if getgenv().saved.Osiris['Silent Aim']['Enabled'] and Script.Locals.SilentAimTarget and Script.Locals.SilentAimTarget.Character then
                    ShootFunc(Gun, Script:ShouldShoot(Script.Locals.SilentAimTarget))
                else
                    ShootFunc(Gun, false)
                end
            end
        end

        function Script:AimAssist()
            local Enabled = getgenv().saved.Osiris['Aim Assist']['Enabled']
            local Cond = getgenv().saved.Osiris['General']['Checks']
            if Enabled and Script.Locals.AimAssistTarget and Script.Locals.AimAssistTarget.Character then
                local Player = Script.Locals.AimAssistTarget; local Character = Player.Character
                if Cond['Visible'] then if not Script:RayCast(Character.HumanoidRootPart, Script:GetOrigin('Camera'), {Self.Character, SilentAimPart}) then return end end
                if Cond['Knocked'] and CurrentGame.Functions.IsKnocked(Player.Character) then return end
                if Cond['Self Knocked'] and CurrentGame.Functions.IsKnocked(Self.Character) then return end
                if Cond['Carried'] and CurrentGame.Functions.IsGrabbed(Player) then return end
                local Osiris = getgenv().saved.Osiris['Aim Assist']; local CurrentCamera = Workspace.CurrentCamera
                local Hit = Script:GetHitPosition("Assist"); if not Hit then return end
                local TargetSnappiness = Osiris['Snappiness']
                if Osiris['Smart Snappiness']['Enabled'] then
                    local targetVelocity = Vector3.new(0,0,0)
                    if Character and Character:FindFirstChild("HumanoidRootPart") then targetVelocity = Character.HumanoidRootPart.Velocity end
                    local currentSpeed = targetVelocity.Magnitude
                    local minSpeed = Osiris['Smart Snappiness']['Speed']['Min']; local maxSpeed = Osiris['Smart Snappiness']['Speed']['Max']
                    local minSmooth = Osiris['Smart Snappiness']['Min']; local maxSmooth = Osiris['Smart Snappiness']['Max']
                    local mode = Osiris['Smart Snappiness']['Mode']
                    if CurrentSnappiness == nil then CurrentSnappiness = minSmooth end
                    local speedFactor = 0
                    if currentSpeed <= minSpeed then speedFactor = 0
                    elseif currentSpeed >= maxSpeed then speedFactor = 1
                    else speedFactor = (currentSpeed - minSpeed) / (maxSpeed - minSpeed) end
                    if mode == "Fast" then speedFactor = speedFactor ^ 1.5 else speedFactor = speedFactor ^ 2.0 end
                    TargetSnappiness = minSmooth + (maxSmooth - minSmooth) * speedFactor
                    TargetSnappiness = math.clamp(TargetSnappiness, minSmooth, maxSmooth)
                end
                if Osiris['Smart Snappiness']['Enabled'] then
                    if CurrentSnappiness == nil then CurrentSnappiness = Osiris['Smart Snappiness']['Min'] end
                    local transitionRate = Osiris['Smart Snappiness']['Mode'] == "Fast" and 0.25 or 0.08
                    CurrentSnappiness = CurrentSnappiness + (TargetSnappiness - CurrentSnappiness) * transitionRate
                    if math.abs(TargetSnappiness - CurrentSnappiness) < 0.0005 then CurrentSnappiness = TargetSnappiness end
                    local EasedSmoothing = TweenService:GetValue(CurrentSnappiness, Enum.EasingStyle[Osiris['Easing Style']], Enum.EasingDirection[Osiris['Easing Direction']])
                    CurrentCamera.CFrame = CurrentCamera.CFrame:Lerp(CFrame.new(CurrentCamera.CFrame.Position, Hit), EasedSmoothing)
                else
                    local EasedSmoothing = TweenService:GetValue(TargetSnappiness, Enum.EasingStyle[Osiris['Easing Style']], Enum.EasingDirection[Osiris['Easing Direction']])
                    CurrentCamera.CFrame = CurrentCamera.CFrame:Lerp(CFrame.new(CurrentCamera.CFrame.Position, Hit), EasedSmoothing)
                end
            end
        end

        function Script:Physics()
            if not Self.Character or not Self.Character:FindFirstChild("Humanoid") then return end
            local Hum = Self.Character.Humanoid
            if getgenv().saved.Osiris['Player']['Anti Fall'] then
                if Hum.Health > 1 and Hum:GetState() == Enum.HumanoidStateType.FallingDown then Hum:ChangeState("GettingUp") end
            end
            if Script.Locals.IsWalkSpeeding and getgenv().saved.Osiris['Walk Speed']['Enabled'] then Hum.WalkSpeed = getgenv().saved.Osiris['Walk Speed']['Speed'] end
        end

        local function HijackTool()
            local character = Self.Character; if not character then return end
            local tool = character:FindFirstChildWhichIsA("Tool"); if not tool then return end
            if not tool._originalActivate then tool._originalActivate = tool.Activate end
            tool.Activate = function(self)
                local isAimed = Script.Locals.IsAimed; Script.Locals.IsAimed = false
                tool._originalActivate(self); Script.Locals.IsAimed = isAimed
            end
        end
        Self.CharacterAdded:Connect(function() task.wait(0.5); HijackTool() end)
    end

    do
        local FOVOsiris = getgenv().saved.Osiris['Silent Aim']['Field Of View']
        local SilentAimOsiris = getgenv().saved.Osiris['Silent Aim']
        local FieldOfViewSquare = Script.Visuals.new("Square")
        FieldOfViewSquare.Visible = FOVOsiris['Visible']; FieldOfViewSquare.Color = Color3.fromRGB(255,255,255); FieldOfViewSquare.Thickness = 1; FieldOfViewSquare.Transparency = 1
        local FieldOfViewCircle = Script.Visuals.new("Circle")
        FieldOfViewCircle.Visible = FOVOsiris['Visible']; FieldOfViewCircle.Color = Color3.fromRGB(255,255,255); FieldOfViewCircle.Thickness = 1; FieldOfViewCircle.Transparency = 1
        Script.Locals.FieldOfViewOne = FieldOfViewSquare
        local Activated
        local function OnLocalCharacterAdded(Character)
            if not Character then return end
            Character.ChildAdded:Connect(function(Tool)
                if not Tool:IsA("Tool") then return end
                Activated = Tool.Activated:Connect(function() Script:SilentAimFunc(Tool) end)
            end)
            Character.ChildRemoved:Connect(function(Tool)
                if not Tool:IsA("Tool") then return end
                if Activated then Activated:Disconnect() end
            end)
        end
        local DebugCircle = Script.Visuals.new("Circle")
        OnLocalCharacterAdded(Self.Character)
        Self.CharacterAdded:Connect(OnLocalCharacterAdded)

        local function UpdateDrawings()
            local Character = Self.Character; if not Character then return end
            local Tool = Character:FindFirstChildWhichIsA("Tool")
            local gunCfg = getgenv().saved.Osiris['Silent Aim']['Field Of View']['Weapon Configuration'] -- [FIX] dynamic read
            if gunCfg['Enabled'] and Tool then
                if table.find(WeaponInfo.Shotguns, Tool.Name) then CurrentFOV=gunCfg['Shotguns']['Circle']; CurrentFOVX=gunCfg['Shotguns']['2D']['X']; CurrentFOVY=gunCfg['Shotguns']['2D']['Y']
                elseif table.find(WeaponInfo.Pistols, Tool.Name) then CurrentFOV=gunCfg['Pistols']['Circle']; CurrentFOVX=gunCfg['Pistols']['2D']['X']; CurrentFOVY=gunCfg['Pistols']['2D']['Y']
                elseif table.find(WeaponInfo.Automatics, Tool.Name) then CurrentFOV=gunCfg['Automatics']['Circle']; CurrentFOVX=gunCfg['Automatics']['2D']['X']; CurrentFOVY=gunCfg['Automatics']['2D']['Y']
                else CurrentFOV=getgenv().saved.Osiris['Silent Aim']['Field Of View']['Circle']; CurrentFOVX=getgenv().saved.Osiris['Silent Aim']['Field Of View']['2D']['X']; CurrentFOVY=getgenv().saved.Osiris['Silent Aim']['Field Of View']['2D']['Y'] end
            else
                CurrentFOV=getgenv().saved.Osiris['Silent Aim']['Field Of View']['Circle']; CurrentFOVX=getgenv().saved.Osiris['Silent Aim']['Field Of View']['2D']['X']; CurrentFOVY=getgenv().saved.Osiris['Silent Aim']['Field Of View']['2D']['Y']
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
                local GunType = Script:GetGunCategory(); local Tool = Self.Character:FindFirstChildWhichIsA("Tool")
                if Tool then
                    if GunType == "Pistol" or GunType == "Sniper" then for _, v in pairs(Tool:GetChildren()) do if v.Name == "GunClient" then v:Destroy() end end
                    elseif GunType == "Shotgun" then for _, v in pairs(Tool:GetChildren()) do if v.Name == "GunClientShotgun" then v:Destroy() end end
                    elseif GunType == "Auto" then for _, v in pairs(Tool:GetChildren()) do if v.Name == "GunClientAutomaticShotgun" then v:Destroy() end end
                    elseif GunType == "Burst" then for _, v in pairs(Tool:GetChildren()) do if v.Name == "GunClientBurst" then v:Destroy() end end
                    elseif GunType == "Rifle" or GunType == "SMG" then for _, v in pairs(Tool:GetChildren()) do if v.Name == "GunClientAutomatic" then v:Destroy() end end end
                end
            end
        end)

        local SP = false; local SP2 = false
        RBXConnection(UserInputService.InputBegan, function(Input, Processed)
            if UserInputService:GetFocusedTextBox() then return end -- [FIX 7]
            local AimAssistKey = Enum.KeyCode[getgenv().saved.Osiris['General']['Keybind']['Aim Assist']:upper()]
            local SilentAimTarget = Enum.KeyCode[getgenv().saved.Osiris['General']['Keybind']['Silent Aim Target']:upper()]
            local ESPKey = Enum.KeyCode[getgenv().saved.Osiris['General']['Keybind']['Visual']:upper()]
            local WSKey = Enum.KeyCode[getgenv().saved.Osiris['General']['Keybind']['Walk Speed']:upper()]
            if Input.KeyCode == WSKey and not Processed then
                Script.Locals.IsWalkSpeeding = not Script.Locals.IsWalkSpeeding
                if not Script.Locals.IsWalkSpeeding and Self.Character and Self.Character:FindFirstChild("Humanoid") then Self.Character.Humanoid.WalkSpeed = 16 end
            end
            if Input.KeyCode == SilentAimTarget and getgenv().saved.Osiris['General']['Targeting Mode'] == 'Toggle' then
                SP = not SP
                if SP then Script.Locals.SilentAimTarget = Script:GetClosestPlayerToCursor(SilentAimOsiris['Max Distance'] * 102220, SilentAimOsiris['Field Of View']['Enabled'] and CurrentFOV or math.huge)
                else if Script.Locals.SilentAimTarget then Script.Locals.SilentAimTarget = nil end end
            end
            if Input.KeyCode == ESPKey then getgenv().saved.Osiris['Player']['Visual']['Enabled'] = not getgenv().saved.Osiris['Player']['Visual']['Enabled'] end
            if Input.KeyCode == AimAssistKey then
                SP2 = not SP2
                if SP2 then Script.Locals.AimAssistTarget = Script:GetClosestPlayerToCursor(SilentAimOsiris['Max Distance'] * 700, math.huge)
                else if Script.Locals.AimAssistTarget then Script.Locals.AimAssistTarget = nil end end
            end
        end)

        RBXConnection(RunService.PreRender, LPH_NO_VIRTUALIZE(function()
            if getgenv().saved.Osiris['General']['Targeting Mode'] == 'Auto' then
                Script.Locals.SilentAimTarget = Script:GetClosestPlayerToCursor(SilentAimOsiris['Max Distance'] * 100, math.huge)
            end
            if Script.Locals.SilentAimTarget and Script.Locals.SilentAimTarget.Character then
                Script.Locals.HitPosition = Script:GetHitPosition('Silent')
            end
            Script:ShouldShoot(Script.Locals.SilentAimTarget)
            ThreadFunction(Script.AimAssist)
            ThreadFunction(Script.Physics)
            UpdateDrawings()
        end))

        -- ==================== ESP SYSTEM ====================
        local ESP_Cache = {}
        local function ClearDeadESP()
            for player, objects in pairs(ESP_Cache) do
                if not player or not player.Parent then if objects.Gui then objects.Gui:Destroy() end; ESP_Cache[player] = nil end
            end
        end
        local function GetPlayerESP(player)
            if ESP_Cache[player] then return ESP_Cache[player] end
            local billboard = Instance.new("BillboardGui"); billboard.Name = "Custom_ESP"; billboard.AlwaysOnTop = true; billboard.Size = UDim2.new(0,100,0,50); billboard.StudsOffset = Vector3.new(0,-5,0)
            local text = Instance.new("TextLabel"); text.BackgroundTransparency = 1; text.Size = UDim2.new(1,0,1,0); text.Font = Enum.Font.SourceSansBold; text.TextSize = 13; text.TextColor3 = getgenv().saved.Osiris['Player']['Visual']['Normal Color']; text.TextStrokeTransparency = 0; text.Parent = billboard
            ESP_Cache[player] = {Gui = billboard, Label = text}; return ESP_Cache[player]
        end
        local function GlobalESPUpdate()
            local ESP_Cfg = getgenv().saved.Osiris['Player']['Visual']; ClearDeadESP()
            for _, plr in ipairs(Players:GetPlayers()) do
                if plr == Self then continue end
                local char = plr.Character; local root = char and char:FindFirstChild("HumanoidRootPart"); local esp_data = GetPlayerESP(plr)
                if root and ESP_Cfg['Enabled'] then
                    esp_data.Gui.Parent = root; esp_data.Gui.Adornee = root; esp_data.Gui.Enabled = true
                    local display = ""
                    if ESP_Cfg['Names'] then display = plr.DisplayName or plr.Name end
                    if ESP_Cfg['Distance'] then local dist = math.floor((root.Position - Self.Character.HumanoidRootPart.Position).Magnitude); display = display .. "\n[" .. dist .. "m]" end
                    esp_data.Label.Text = display
                    local isKnocked = CurrentGame.Functions.IsKnocked(char)
                    local isTargeted = (Script.Locals.AimAssistTarget == plr or Script.Locals.SilentAimTarget == plr)
                    if isTargeted and not isKnocked then esp_data.Label.TextColor3 = ESP_Cfg['Targeted Color'] else esp_data.Label.TextColor3 = ESP_Cfg['Normal Color'] end
                else esp_data.Gui.Enabled = false end
            end
        end
        RunService.RenderStepped:Connect(GlobalESPUpdate)

        -- ==================== AVATAR SYSTEM [FIX 8] ====================
        local HAIR_MULTIPLIER = 1.2; local appliedCharacters = {}
        local function applyCustomAnimations(character)
            local avatarCfg = getgenv().saved.Osiris.Player.Avatar
            if not avatarCfg or not avatarCfg.Enabled then return end
            local humanoid = character:WaitForChild("Humanoid", 10); if not humanoid then return end
            local animator = humanoid:FindFirstChild("Animator"); if not animator then animator = Instance.new("Animator"); animator.Parent = humanoid end
            local anims = avatarCfg["Custom Animations"]; if not anims then return end
            local function loadAnimation(animId)
                if not animId or animId == "" then return end
                local animObj = Instance.new("Animation"); animObj.AnimationId = animId
                local success, track = pcall(function() return animator:LoadAnimation(animObj) end)
                if success and track then track:Stop(); track:Destroy() end
                animObj:Destroy()
            end
            loadAnimation(anims.idle); loadAnimation(anims.walk); loadAnimation(anims.run); loadAnimation(anims.jump); loadAnimation(anims.fall)
            local animateScript = character:FindFirstChild("Animate")
            if animateScript then
                local function setAnimId(folder, animName, newId)
                    if not folder or not newId or newId == "" then return end
                    local anim = folder:FindFirstChild(animName); if anim and anim:IsA("Animation") then anim.AnimationId = newId end
                end
                local idleFolder = animateScript:FindFirstChild("idle"); local walkFolder = animateScript:FindFirstChild("walk")
                local runFolder = animateScript:FindFirstChild("run"); local jumpFolder = animateScript:FindFirstChild("jump"); local fallFolder = animateScript:FindFirstChild("fall")
                if idleFolder then setAnimId(idleFolder,"Animation1",anims.idle); setAnimId(idleFolder,"Animation2",anims.idle); setAnimId(idleFolder,"Animation3",anims.idle) end
                if walkFolder then setAnimId(walkFolder,"WalkAnim",anims.walk) end
                if runFolder then setAnimId(runFolder,"RunAnim",anims.run) end
                if jumpFolder then setAnimId(jumpFolder,"JumpAnim",anims.jump) end
                if fallFolder then setAnimId(fallFolder,"FallAnim",anims.fall) end
            end
        end
        local function applyAvatar(character)
            local avatarCfg = getgenv().saved.Osiris.Player.Avatar
            if not avatarCfg or not avatarCfg.Enabled then return end
            if appliedCharacters[character] then return end
            appliedCharacters[character] = true
            character.AncestryChanged:Connect(function() if not character.Parent then appliedCharacters[character] = nil end end)
            local uid = tonumber(avatarCfg['User ID']); if not uid then return end
            if not character.Parent then character.AncestryChanged:Wait() end
            local humanoid = character:WaitForChild("Humanoid", 10); if not humanoid then return end
            local descSuccess, targetDesc = pcall(function() return Players:GetHumanoidDescriptionFromUserId(uid) end)
            if descSuccess and targetDesc then pcall(function() humanoid:ApplyDescription(targetDesc) end) end
            local modelSuccess, targetModel = pcall(function() return Players:CreateHumanoidModelFromUserId(uid) end)
            if modelSuccess and targetModel then
                for _, v in pairs(character:GetChildren()) do if v:IsA("Accessory") or v:IsA("Shirt") or v:IsA("Pants") or v:IsA("ShirtGraphic") or v:IsA("BodyColors") then v:Destroy() end end
                for _, v in pairs(targetModel:GetChildren()) do if v:IsA("Shirt") or v:IsA("Pants") or v:IsA("ShirtGraphic") or v:IsA("BodyColors") then v:Clone().Parent = character end end
                for _, v in pairs(targetModel:GetChildren()) do
                    if v:IsA("Accessory") then
                        local acc = v:Clone(); local handle = acc:FindFirstChild("Handle")
                        if handle then for _, w in pairs(handle:GetChildren()) do if w:IsA("Weld") or w:IsA("JointInstance") then w:Destroy() end end end
                        acc.Parent = character
                        if handle then
                            local myHead = character:FindFirstChild("Head"); local att = handle:FindFirstChildOfClass("Attachment")
                            if att then
                                local targetAtt
                                for _, desc in pairs(character:GetDescendants()) do if desc:IsA("Attachment") and desc.Name == att.Name then targetAtt = desc break end end
                                if targetAtt and targetAtt.Parent then
                                    handle.CFrame = targetAtt.Parent.CFrame * targetAtt.CFrame * att.CFrame:Inverse()
                                    local w = Instance.new("Weld"); w.Name = "AccessoryWeld"; w.Part0 = targetAtt.Parent; w.Part1 = handle; w.C0 = targetAtt.CFrame; w.C1 = att.CFrame; w.Parent = handle
                                end
                            else
                                if myHead then
                                    handle.CFrame = myHead.CFrame * CFrame.new(0, 0.5, 0)
                                    local w = Instance.new("Weld"); w.Name = "AccessoryWeld"; w.Part0 = myHead; w.Part1 = handle; w.C0 = CFrame.new(0, 0.5, 0); w.C1 = acc.AttachmentPoint; w.Parent = handle
                                end
                            end
                        end
                    end
                end
                if avatarCfg['Visual Headless'] then local myHead = character:FindFirstChild("Head"); if myHead then myHead.Transparency = 1 end end
                local myHead = character:FindFirstChild("Head"); local tHead = targetModel:FindFirstChild("Head")
                if myHead and tHead then
                    if myHead:IsA("MeshPart") and tHead:IsA("MeshPart") then myHead.MeshId = tHead.MeshId; myHead.TextureID = tHead.TextureID; myHead.Color = tHead.Color end
                    for _, obj in pairs(tHead:GetChildren()) do if obj:IsA("Decal") or obj:IsA("SpecialMesh") or obj:IsA("SurfaceAppearance") or obj.Name == "Mesh" then obj:Clone().Parent = myHead end end
                end
                targetModel:Destroy()
            end
            local function setHairScale(value) local hs = humanoid:FindFirstChild("HairScale"); if hs and hs:IsA("NumberValue") then hs.Value = value else hs = Instance.new("NumberValue"); hs.Name = "HairScale"; hs.Value = value; hs.Parent = humanoid end end
            local currentHair = 1.0; local hs = humanoid:FindFirstChild("HairScale"); if hs and hs:IsA("NumberValue") then currentHair = hs.Value end
            local newHairValue = currentHair * HAIR_MULTIPLIER; setHairScale(newHairValue)
            task.spawn(function() while character and character.Parent do task.wait(0.5); setHairScale(newHairValue) end end)
            task.wait(0.5); applyCustomAnimations(character)
        end
        local function onCharacterAdded(character)
            for oldChar in pairs(appliedCharacters) do if oldChar ~= character and not oldChar.Parent then appliedCharacters[oldChar] = nil end end
            task.wait(0.1); applyAvatar(character)
        end
        Self.CharacterAdded:Connect(onCharacterAdded)
        if Self.Character then task.spawn(function() onCharacterAdded(Self.Character) end) end

        -- ==================== HITBOX EXPANDER [FIX 5] ====================
        local HITBOX_REFRESH_TIME = 0.001; local HitboxVisuals = {}
        local function GetHitboxSize()
            local cfg = getgenv().saved.Osiris['Hitbox Expander']['Size']
            if type(cfg) == "table" then return Vector3.new(cfg.X or 10, cfg.Y or 10, cfg.Z or 10) else return Vector3.new(cfg, cfg, cfg) end
        end
        local function CreateHitboxVisual(Player)
            if not Player or not Player.Character then return end
            local RootPart = Player.Character:FindFirstChild("HumanoidRootPart"); if not RootPart then return end
            if HitboxVisuals[Player] and HitboxVisuals[Player].Visual then return HitboxVisuals[Player].Visual end
            local size = GetHitboxSize()
            local VisualPart = Instance.new("Part"); VisualPart.Name = "HitboxVisual"; VisualPart.Anchored = true; VisualPart.CanCollide = false; VisualPart.CanQuery = false; VisualPart.Transparency = 1; VisualPart.Size = size; VisualPart.Material = Enum.Material.SmoothPlastic; VisualPart.BrickColor = BrickColor.new("Really red"); VisualPart.Parent = workspace
            local SelectionBox = Instance.new("SelectionBox"); SelectionBox.Adornee = VisualPart; SelectionBox.Color3 = Color3.fromRGB(255,255,255); SelectionBox.LineThickness = 0.02; SelectionBox.Transparency = 0.1; SelectionBox.Parent = VisualPart
            if not HitboxVisuals[Player] then HitboxVisuals[Player] = {} end
            HitboxVisuals[Player].Visual = VisualPart; HitboxVisuals[Player].SelectionBox = SelectionBox; HitboxVisuals[Player].RootPart = RootPart
            return VisualPart
        end
        local function RemoveHitboxVisual(Player)
            if HitboxVisuals[Player] then pcall(function() HitboxVisuals[Player].Visual:Destroy() end); HitboxVisuals[Player] = nil end
        end
        local function UpdateHitbox(Player)
            if not Player or not Player.Character then return end
            local Character = Player.Character; if not Character or not Character.Parent then return end
            local Humanoid = Character:FindFirstChildOfClass("Humanoid"); if not Humanoid or Humanoid.Health <= 0 then return end
            local RootPart = Character:FindFirstChild("HumanoidRootPart"); if not RootPart then return end
            local size = GetHitboxSize()
            pcall(function() RootPart.Size = size; RootPart.CanCollide = false end)
            if getgenv().saved.Osiris['Hitbox Expander']['Visible'] then
                pcall(function()
                    local Visual = HitboxVisuals[Player] and HitboxVisuals[Player].Visual
                    if not Visual then Visual = CreateHitboxVisual(Player) end
                    if Visual then Visual.Size = size; Visual.CFrame = RootPart.CFrame end
                end)
            else RemoveHitboxVisual(Player) end
        end
        task.spawn(function()
            while true do
                local hbCfg = getgenv().saved.Osiris['Hitbox Expander']
                if not hbCfg or not hbCfg['Enabled'] then
                    for Player in pairs(HitboxVisuals) do RemoveHitboxVisual(Player) end
                    for _, Player in ipairs(Players:GetPlayers()) do
                        if Player ~= Self and Player.Character then
                            local root = Player.Character:FindFirstChild("HumanoidRootPart")
                            if root then pcall(function() root.Size = Vector3.new(2,2,1) end) end
                        end
                    end
                    task.wait(0.5)
                else
                    local targetOnly = hbCfg['Target Only']
                    local hasTarget = Script and Script.Locals and Script.Locals.SilentAimTarget
                    for _, Player in ipairs(Players:GetPlayers()) do
                        if Player ~= Self then
                            if targetOnly and hasTarget then
                                if Script.Locals.SilentAimTarget == Player then UpdateHitbox(Player)
                                else
                                    RemoveHitboxVisual(Player)
                                    if Player.Character then local root = Player.Character:FindFirstChild("HumanoidRootPart"); if root then pcall(function() root.Size = Vector3.new(2,2,1) end) end end
                                end
                            else UpdateHitbox(Player) end
                        end
                    end
                    task.wait(HITBOX_REFRESH_TIME)
                end
            end
        end)
        local function OnCharacterAdded(Character)
            if getgenv().saved.Osiris['Hitbox Expander']['Enabled'] then
                task.wait(0.1); local Player = Players:GetPlayerFromCharacter(Character)
                if Player and Player ~= Self then UpdateHitbox(Player) end
            end
        end
        local function OnCharacterRemoved(Character) local Player = Players:GetPlayerFromCharacter(Character); if Player then RemoveHitboxVisual(Player) end end
        for _, Player in ipairs(Players:GetPlayers()) do
            if Player ~= Self then
                Player.CharacterAdded:Connect(OnCharacterAdded); Player.CharacterRemoved:Connect(OnCharacterRemoved)
                if Player.Character then task.wait(0.1); OnCharacterAdded(Player.Character) end
            end
        end
        Players.PlayerAdded:Connect(function(Player) if Player ~= Self then Player.CharacterAdded:Connect(OnCharacterAdded); Player.CharacterRemoved:Connect(OnCharacterRemoved) end end)
        Self.CharacterAdded:Connect(function(Char) task.wait(0.5); for _, Player in ipairs(Players:GetPlayers()) do if Player ~= Self then UpdateHitbox(Player) end end end)

        -- ==================== WALL HOP [FIX 3+5] ====================
        local WallHopOsiris = {TouchDistance=1.2, WallJumpUpBoost=60, WallJumpAwayBoost=20, WallNormalThreshold=0.5, CooldownTime=0.25}
        local canWallHop = true; local isTouchingWallHop = false; local currentWallHopNormal = nil; local lastWallHopTime = 0
        local function getCharacter() local char = Self.Character; if not char then return nil,nil,nil end; local hum = char:FindFirstChild("Humanoid"); local root = char:FindFirstChild("HumanoidRootPart"); return char, hum, root end
        local hopRayParams = RaycastParams.new(); hopRayParams.FilterType = Enum.RaycastFilterType.Exclude
        local function checkForWallHop()
            local char, hum, root = getCharacter(); if not root then return false, nil end
            hopRayParams.FilterDescendantsInstances = {char}; local origin = root.Position
            local directions = {Vector3.new(1,0,0),Vector3.new(-1,0,0),Vector3.new(0,0,1),Vector3.new(0,0,-1),Vector3.new(0.7,0,0.7),Vector3.new(-0.7,0,0.7),Vector3.new(0.7,0,-0.7),Vector3.new(-0.7,0,-0.7)}
            for _, dir in ipairs(directions) do
                local result = workspace:Raycast(origin, dir * WallHopOsiris.TouchDistance, hopRayParams)
                if result then local normal = result.Normal; if math.abs(normal.Y) < WallHopOsiris.WallNormalThreshold then return true, normal end end
            end
            return false, nil
        end
        local function performWallHop()
            if not getgenv().saved.Osiris['Player']['Wall Hop'] then return end
            if not canWallHop or not isTouchingWallHop then return end
            local char, hum, root = getCharacter(); if not hum or not root or hum.Health <= 0 then return end
            local state = hum:GetState()
            if state == Enum.HumanoidStateType.Running or state == Enum.HumanoidStateType.Landed or state == Enum.HumanoidStateType.Seated then return end
            if tick() - lastWallHopTime < WallHopOsiris.CooldownTime then return end
            local currentVel = root.AssemblyLinearVelocity
            local awayDir = Vector3.new(currentWallHopNormal.X, 0, currentWallHopNormal.Z)
            if awayDir.Magnitude > 0.01 then awayDir = awayDir.Unit else awayDir = Vector3.zero end
            root.AssemblyLinearVelocity = Vector3.new(currentVel.X + (awayDir.X * WallHopOsiris.WallJumpAwayBoost), WallHopOsiris.WallJumpUpBoost, currentVel.Z + (awayDir.Z * WallHopOsiris.WallJumpAwayBoost))
            canWallHop = false; lastWallHopTime = tick(); task.wait(WallHopOsiris.CooldownTime); canWallHop = true
        end
        UserInputService.JumpRequest:Connect(function() if getgenv().saved.Osiris['Player']['Wall Hop'] then performWallHop() end end)
        UserInputService.InputBegan:Connect(function(input, gameProcessed)
            if gameProcessed then return end
            if input.KeyCode == Enum.KeyCode.Space and getgenv().saved.Osiris['Player']['Wall Hop'] then performWallHop() end
        end)
        RunService.Heartbeat:Connect(function()
            local char, hum, root = getCharacter()
            if not char or not hum or hum.Health <= 0 then isTouchingWallHop = false; return end
            local touching, normal = checkForWallHop(); isTouchingWallHop = touching; currentWallHopNormal = normal
            if getgenv().saved.Osiris.Animation and getgenv().saved.Osiris.Animation.Enabled and Script.AnimationUpdate then Script.AnimationUpdate() end -- [FIX 3]
        end)
        Self.CharacterAdded:Connect(function(newChar) task.wait(0.2); isTouchingWallHop = false; currentWallHopNormal = nil; canWallHop = true; lastWallHopTime = 0 end)
    end
    -- ==================== NAMECALL HOOK (Anti Aimview) ====================
    local oldNamecall
    oldNamecall = hookmetamethod(game, "__namecall", function(self, ...)
        local args = {...}
        local method = getnamecallmethod()

        if method == "FireServer" and tostring(self) == "MainEvent"
            and getgenv().saved.Osiris['Silent Aim']['Enabled']
            and getgenv().saved.Osiris['Misc']['Anti Aimview']
            and args[1] == "ShootGun" then

            local target = Script.Locals.SilentAimTarget
            if target and target.Character and target.Character:FindFirstChild("Head")
                and Script:ShouldShoot(target) then

                local headPos = target.Character.Head.Position
                local headPart = target.Character.Head

                if type(args[4]) == "table" then
                    -- Shotgun: tabela de projéteis
                    for i, boolets in ipairs(args[4]) do
                        boolets.AimPosition = headPos
                        boolets.Result1 = headPos
                        boolets.Result2 = headPart
                        boolets.Result3 = Vector3.new(0, 0, 1)
                    end
                else
                    -- Arma normal: args[5] = posição, args[6] = part
                    args[5] = headPos
                    args[6] = headPart
                end

                args[8] = math.huge
                return oldNamecall(self, unpack(args))
            end
        end

        return oldNamecall(self, ...)
    end)

    -- ==================== FULL UNLOAD FUNCTION ====================
    getgenv().OsirisUnload = function()
        -- 1. Desligar todas as opções da config
        pcall(function()
            getgenv().saved.Osiris['Silent Aim']['Enabled'] = false
            getgenv().saved.Osiris['Aim Assist']['Enabled'] = false
            getgenv().saved.Osiris['Walk Speed']['Enabled'] = false
            getgenv().saved.Osiris['Hitbox Expander']['Enabled'] = false
            getgenv().saved.Osiris['Player']['Avatar']['Enabled'] = false
            getgenv().saved.Osiris['Player']['Visual']['Enabled'] = false
            getgenv().saved.Osiris['Player']['Wall Hop'] = false
            getgenv().saved.Osiris['Player']['Anti Fall'] = false
            getgenv().saved.Osiris['Weapon Modifications']['Skin Changer']['Enabled'] = false
            getgenv().saved.Osiris['Weapon Modifications']['Spread Modifier']['Enabled'] = false
            getgenv().saved.Osiris['Misc']['Anti Aimview'] = false
        end)

        -- 2. Resetar walk speed
        pcall(function()
            local p = game:GetService("Players").LocalPlayer
            if p.Character and p.Character:FindFirstChild("Humanoid") then
                p.Character.Humanoid.WalkSpeed = 16
            end
        end)

        -- 3. Resetar hitboxes de todos os jogadores
        pcall(function()
            local plrs = game:GetService("Players")
            for _, player in ipairs(plrs:GetPlayers()) do
                if player.Character then
                    local root = player.Character:FindFirstChild("HumanoidRootPart")
                    if root then
                        pcall(function()
                            root.Size = Vector3.new(2, 2, 1)
                            root.CanCollide = true
                        end)
                    end
                end
            end
        end)

        -- 4. Desconectar todas as connections da source
        pcall(function()
            for _, conn in ipairs(Script.RBXConnections) do
                pcall(function() conn:Disconnect() end)
            end
        end)

        -- 5. Restaurar namecall hook
        pcall(function()
            if oldNamecall then
                hookmetamethod(game, "__namecall", oldNamecall)
            end
        end)

        -- 6. Instant force reset (matar o player)
        pcall(function()
            local p = game:GetService("Players").LocalPlayer
            if p.Character and p.Character:FindFirstChild("Humanoid") then
                p.Character.Humanoid.Health = 0
            end
        end)

        -- 7. Limpar a função global
        getgenv().OsirisUnload = nil
    end
end -- closes outer do block

local library, themes = loadstring(game:HttpGet("https://raw.githubusercontent.com/matrixhubtokypill-pixel/aaaa/refs/heads/main/zzzz.lua"))()

local dim2 = UDim2.new
local hex  = Color3.fromHex

local GunSkins = {
    "Golden Age","Christmas Wrap","Galaxy","Wild West","Ninja","Iced Out","Reptile",
    "Heaven","Electric","Blue Wrap","Dragon","Inferno","Luck","Valentine","Magma",
    "Shadow","Rainbow","Fish","Red Skull","Patriot","Red Hot","Snow Wrap","Matrix"
}
local KnifeSkins = {
    "Golden Age Tanto","GPO-Knife","GPO-Knife Prestige","Heaven","Love Kukri",
    "Purple Dagger","Blue Dagger","Green Dagger","Red Dagger","Portal",
    "Emerald Butterfly","Boy","Girl","Dragon","Void","Wild West","Iced Out","Reptile","Emerald"
}

local AnimPackNames = {"None", "Bubbly", "Stylish", "Werewolf", "Mage", "Levitation", "Ninja", "Pirate", "Cartoony", "Toy", "Zombie"}

getgenv().ResolveKeybind = function(_, value)
    if typeof(value) == "EnumItem" then return value end
    if type(value) == "string" then
        return Enum.KeyCode[value] or Enum.UserInputType[value] or Enum.KeyCode.Unknown
    end
    return Enum.KeyCode.Unknown
end

getgenv().saved = {
    ['Osiris'] = {
        ['General'] = {
            ['Keybind List'] = {
                ['Aim Assist']  = { ['Bind'] = "C" },
                ['Silent Aim']  = { ['Target Bind'] = "V" },
                ['Triggerbot']  = { ['Bind'] = "Z", ['Target Bind'] = "Y" },
                ['Player'] = {
                    ['Walk Speed']  = "T",
                    ['Jump Power']  = "J",
                    ['Visual']      = "B",
                    ['Panic Throw'] = "P",
                },
            },
            ['Checks'] = {
                ['Aim Assist'] = {
                    ['Visible']      = false,
                    ['Carried']      = true,
                    ['Knocked']      = true,
                    ['Self Knocked'] = true,
                },
                ['Silent Aim'] = {
                    ['Visible']      = false,
                    ['Carried']      = true,
                    ['Knocked']      = true,
                    ['Self Knocked'] = true,
                },
                ['Triggerbot'] = {
                    ['Visible']      = true,
                    ['Carried']      = true,
                    ['Knocked']      = true,
                    ['Self Knocked'] = true,
                },
            },
            ['Show Status']    = true,
            ['Targeting Mode'] = 'Auto',
        },
        ['Silent Aim'] = {
            ['Enabled'] = true,
            ['Max Distance'] = 1234,
            ['Bullet Redirection'] = false,
            ['Hit Part'] = "Head",
            ['Nearest Point'] = { ['Mode'] = "Smart", ['Scale'] = 0.36 },
            ['Field Of View'] = {
                ['Enabled'] = true,
                ['Visible'] = false,
                ['Mode'] = "2D",
                ['Circle'] = 150,
                ['2D'] = { ['X'] = 89, ['Y'] = 89 },
                ['Weapon Configuration'] = {
                    ['Enabled'] = false,
                    ['Shotguns']   = { ['Circle'] = 150, ['2D'] = { ['X'] = 8, ['Y'] = 8 } },
                    ['Pistols']    = { ['Circle'] = 150, ['2D'] = { ['X'] = 8, ['Y'] = 8 } },
                    ['Automatics'] = { ['Circle'] = 150, ['2D'] = { ['X'] = 8, ['Y'] = 8 } },
                },
            },
        },
        ['Aim Assist'] = {
            ['Enabled'] = true,
            ['Easing Style'] = "Quad",
            ['Easing Direction'] = "Out",
            ['Hit Part'] = "Head",
            ['Nearest Point'] = { ['Mode'] = "Smart", ['Scale'] = 0.99 },
            ['Snappiness'] = 0.095,
            ['Smart Snappiness'] = {
                ['Enabled'] = false,
                ['Mode'] = "Slow",
                ['Min'] = 0.021,
                ['Max'] = 0.047,
                ['Speed'] = { ['Min'] = 16, ['Max'] = 90 },
            },
            ['Prediction'] = { ['Enabled'] = false, ['X'] = 0.01, ['Y'] = 0.01, ['Z'] = 0.01 },
        },
        ['Triggerbot'] = {
            ['Enabled'] = true,
            ['Max Distance'] = 200,
            ['Cooldown'] = 0.05,
            ['Activation'] = { ['Mode'] = 'Keybind', ['Type'] = 'Toggle' },
            ['FOV'] = { ['Visible'] = false, ['X'] = 3.3, ['Y'] = 7, ['Z'] = 3.6 },
            ['Prediction'] = { ['Enabled'] = false, ['Value'] = 0.13 },
        },
        ['Weapon Modifications'] = {
            ['Spread Modifier'] = {
                ['Enabled'] = true,
                ['[Double-Barrel SG]'] = { ['Value'] = 0 },
                ['[TacticalShotgun]']  = { ['Value'] = 0.8 },
                ['[Shotgun]']          = { ['Value'] = 0.9 },
                ['Randomizer']         = { ['Enabled'] = false, ['Value'] = 0.1 },
            },
            ['Delay Changer'] = {
                ['Enabled'] = true,
                ["[Revolver]"]         = { ['Value'] = 0.01,},
                ["[Double-Barrel SG]"] = { ['Value'] = 0.14,},
                ["[TacticalShotgun]"]  = { ['Value'] = 0.14,},
                ["Others"]             = { ['Value'] = 0.095,},
            },
            ['Skin Changer'] = {
                ['Enabled'] = true,
                ['Weapons List'] = {
                    ['[Double-Barrel SG]'] = "Galaxy",
                    ['[Revolver]']         = "Galaxy",
                    ['[TacticalShotgun]']  = "Galaxy",
                    ['[Knife]']            = "GPO-Knife Prestige",
                },
            },
        },
        ['Walk Speed'] = { ['Enabled'] = true, ['Speed'] = 600 },
        ['Jump Power'] = { ['Enabled'] = true, ['Power'] = 300 },
        ['Hitbox Expander'] = {
            ['Enabled'] = false,
            ['Target Mode'] = false,
            ['Visible'] = true,
            ['Size'] = { ['X'] = 40.2, ['Y'] = 40.6, ['Z'] = 40.1 },
        },
        ['Player'] = {
            ['Anti Fall'] = true,
            ['Anti Stomp'] = true,
            ['Wall Hop'] = true,
            ['Avatar'] = {
                ['Visual Headless'] = true,
                ['Enabled'] = true,
                ['User ID'] = 11437740757,
                ['Animations'] = {
                    ['idle'] = "rbxassetid://10921344533",
                    ['walk'] = "rbxassetid://10921355261",
                    ['run']  = "rbxassetid://616163682",
                    ['jump'] = "rbxassetid://656117878",
                    ['fall'] = "rbxassetid://656115606",
                },
                ['SelectedPacks'] = {
                    Idle = "Zombie",
                    Walk = "Zombie",
                    Run  = "Zombie",
                    Jump = "Ninja",
                    Fall = "Ninja",
                    Pose = "None",
                },
            },
            ['Visual'] = {
                ['Enabled'] = true,
                ['Box'] = true,
                ['Names'] = true,
                ['Distance'] = false,
                ['Health Bar'] = true,
                ['Armor Bar'] = true,
                ['Targeted Color'] = Color3.fromRGB(0, 255, 0),
                ['Normal Color'] = Color3.fromRGB(255, 255, 255),
            },
            ['Panic Throw'] = { ['Enabled'] = true, ['Distance'] = 10000 },
        },
    }
}

local cfg    = getgenv().saved.Osiris
local kbList = cfg['General']['Keybind List']

local function resolveKeyFromFlag(f)
    if typeof(f) == "EnumItem" and f.EnumType == Enum.KeyCode then
        return f
    elseif type(f) == "table" then
        local k = f.key or f.Key or f.value or f.Value or f[1]
        if typeof(k) == "EnumItem" and k.EnumType == Enum.KeyCode then
            return k
        end
        local n = f.Name or f.name
        if type(n) == "string" then
            return Enum.KeyCode[n] or Enum.KeyCode[n:sub(1,1):upper()..n:sub(2)]
        end
    elseif type(f) == "string" then
        return Enum.KeyCode[f] or Enum.KeyCode[f:upper()]
    end
    return nil
end

local function writeBind(path, key)
    if typeof(key) ~= "EnumItem" then return end
    local name = key.Name
    if path[1] == "Player" then
        kbList['Player'][path[2]] = name
    elseif path[2] then
        kbList[path[1]][path[2]] = name
    else
        kbList[path[1]]['Bind'] = name
    end
end

local function makeKeybindCallback(path)
    return function(raw)
        local key = nil
        if typeof(raw) == "EnumItem" and raw.EnumType == Enum.KeyCode then
            key = raw
        elseif type(raw) == "table" then
            local k = raw.key or raw.Key or raw.value or raw.Value or raw[1]
            if typeof(k) == "EnumItem" and k.EnumType == Enum.KeyCode then
                key = k
            end
        elseif type(raw) == "string" then
            key = Enum.KeyCode[raw] or Enum.KeyCode[raw:upper()]
        end
        if key then writeBind(path, key) end
    end
end

local window = library:window({ name = os.date('Osiris.cc | %b %d %Y'), size = dim2(0, 750, 0, 782) })

task.defer(function()
    local dock = nil
    for _, gui in ipairs(gethui():GetChildren()) do
        if gui:IsA("ScreenGui") then
            for _, child in ipairs(gui:GetChildren()) do
                if child:IsA("Frame") and child.Size.X.Offset == 157 and child.Size.Y.Offset == 39 then
                    dock = child
                    break
                end
            end
        end
        if dock then break end
    end
    if dock then
        dock.Size = UDim2.new(0, 93, 0, 39)
    end
end)

local tabAim     = window:tab({ name = "Combat"   })
local tabMisc    = window:tab({ name = "General & Keybind"     })
local tabVisuals = window:tab({ name = "Visuals"  })
local tabPlayer  = window:tab({ name = "Player Mods"   })
local tabWeapons = window:tab({ name = "Weapon Mods"  })

-- ═══════════════════════════════════════════════════════
-- AIMING
-- ═══════════════════════════════════════════════════════
do
    local col1 = tabAim:column()
    local secSA, secAA = col1:multi_section({ names = { "Silent Aim", "Aim Assist" } })

    secSA:toggle({ name = "Enabled", flag = "sa_enabled", default = true,
        callback = function(v) cfg['Silent Aim']['Enabled'] = v end })
    secSA:slider({ name = "Max Distance", flag = "sa_maxdist",
        min = 50, max = 5000, default = 1234, interval = 1,
        callback = function(v) cfg['Silent Aim']['Max Distance'] = v end })
    secSA:toggle({ name = "Bullet Redirection", flag = "sa_br",
        callback = function(v) cfg['Silent Aim']['Bullet Redirection'] = v end })
    secSA:dropdown({ name = "Hit Part", flag = "sa_hitpart",
        items = { "Nearest Point", "Nearest Part", "Head", "HumanoidRootPart" }, default = "Head",
        callback = function(v) cfg['Silent Aim']['Hit Part'] = v end })
    secSA:dropdown({ name = "NP Mode", flag = "sa_npmode",
        items = { "Smart", "Basic" }, default = "Smart",
        callback = function(v) cfg['Silent Aim']['Nearest Point']['Mode'] = v end })
    secSA:slider({ name = "NP Scale", flag = "sa_npscale",
        min = 0.1, max = 2, default = 0.36, interval = 0.01,
        callback = function(v) cfg['Silent Aim']['Nearest Point']['Scale'] = v end })
    secSA:toggle({ name = "FOV Enabled", flag = "sa_foven", default = true,
        callback = function(v) cfg['Silent Aim']['Field Of View']['Enabled'] = v end })
    secSA:toggle({ name = "FOV Visible", flag = "sa_fovvis",
        callback = function(v) cfg['Silent Aim']['Field Of View']['Visible'] = v end })
    secSA:dropdown({ name = "FOV Mode", flag = "sa_fovmode",
        items = { "2D", "Circle" }, default = "2D",
        callback = function(v) cfg['Silent Aim']['Field Of View']['Mode'] = v end })
    secSA:slider({ name = "FOV Circle", flag = "sa_fovcircle",
        min = 10, max = 800, default = 150, interval = 1,
        callback = function(v) cfg['Silent Aim']['Field Of View']['Circle'] = v end })
    secSA:slider({ name = "FOV 2D X", flag = "sa_fov2dx",
        min = 1, max = 200, default = 89, interval = 1,
        callback = function(v) cfg['Silent Aim']['Field Of View']['2D']['X'] = v end })
    secSA:slider({ name = "FOV 2D Y", flag = "sa_fov2dy",
        min = 1, max = 200, default = 89, interval = 1,
        callback = function(v) cfg['Silent Aim']['Field Of View']['2D']['Y'] = v end })

    secAA:toggle({ name = "Enabled", flag = "aa_enabled", default = true,
        callback = function(v) cfg['Aim Assist']['Enabled'] = v end })
    secAA:dropdown({ name = "Hit Part", flag = "aa_hitpart",
        items = { "Nearest Point", "Nearest Part", "Head", "HumanoidRootPart" }, default = "Head",
        callback = function(v) cfg['Aim Assist']['Hit Part'] = v end })
    secAA:dropdown({ name = "Easing Style", flag = "aa_easingstyle",
        items = { "Quad","Linear","Sine","Cubic","Quart","Quint","Exponential","Circular","Back","Bounce","Elastic" },
        default = "Quad",
        callback = function(v) cfg['Aim Assist']['Easing Style'] = v end })
    secAA:dropdown({ name = "Easing Direction", flag = "aa_easingdir",
        items = { "In", "Out", "InOut" }, default = "Out",
        callback = function(v) cfg['Aim Assist']['Easing Direction'] = v end })
    secAA:slider({ name = "Snappiness", flag = "aa_snap",
        min = 0.001, max = 1, default = 0.095, interval = 0.001,
        callback = function(v) cfg['Aim Assist']['Snappiness'] = v end })
    secAA:toggle({ name = "Smart Snappiness", flag = "aa_smartsnap",
        callback = function(v) cfg['Aim Assist']['Smart Snappiness']['Enabled'] = v end })
    secAA:dropdown({ name = "SS Mode", flag = "aa_ssmode",
        items = { "Slow", "Fast" }, default = "Slow",
        callback = function(v) cfg['Aim Assist']['Smart Snappiness']['Mode'] = v end })
    secAA:slider({ name = "SS Min", flag = "aa_ssmin",
        min = 0.001, max = 0.5, default = 0.021, interval = 0.001,
        callback = function(v) cfg['Aim Assist']['Smart Snappiness']['Min'] = v end })
    secAA:slider({ name = "SS Max", flag = "aa_ssmax",
        min = 0.001, max = 0.5, default = 0.047, interval = 0.001,
        callback = function(v) cfg['Aim Assist']['Smart Snappiness']['Max'] = v end })
    secAA:toggle({ name = "Prediction", flag = "aa_pred",
        callback = function(v) cfg['Aim Assist']['Prediction']['Enabled'] = v end })
    secAA:slider({ name = "Pred X", flag = "aa_predx",
        min = 0, max = 0.5, default = 0.01, interval = 0.001,
        callback = function(v) cfg['Aim Assist']['Prediction']['X'] = v end })
    secAA:slider({ name = "Pred Y", flag = "aa_predy",
        min = 0, max = 0.5, default = 0.01, interval = 0.001,
        callback = function(v) cfg['Aim Assist']['Prediction']['Y'] = v end })
    secAA:slider({ name = "Pred Z", flag = "aa_predz",
        min = 0, max = 0.5, default = 0.01, interval = 0.001,
        callback = function(v) cfg['Aim Assist']['Prediction']['Z'] = v end })

    local col2  = tabAim:column()
    local secTB = col2:section({ name = "Triggerbot", toggle = false })

    secTB:toggle({ name = "Enabled", flag = "tb_enabled", default = true,
        callback = function(v) cfg['Triggerbot']['Enabled'] = v end })
    secTB:slider({ name = "Max Distance", flag = "tb_maxdist",
        min = 10, max = 1000, default = 200, interval = 1,
        callback = function(v) cfg['Triggerbot']['Max Distance'] = v end })
    secTB:slider({ name = "Cooldown", flag = "tb_cd",
        min = 0.01, max = 1, default = 0.05, interval = 0.01,
        callback = function(v) cfg['Triggerbot']['Cooldown'] = v end })
    secTB:dropdown({ name = "Activation Mode", flag = "tb_actmode",
        items = { "Keybind", "Mouse" }, default = "Keybind",
        callback = function(v) cfg['Triggerbot']['Activation']['Mode'] = v end })
    secTB:dropdown({ name = "Activation Type", flag = "tb_acttype",
        items = { "Toggle", "Hold" }, default = "Toggle",
        callback = function(v) cfg['Triggerbot']['Activation']['Type'] = v end })
    secTB:toggle({ name = "FOV Visible", flag = "tb_fovvis",
        callback = function(v) cfg['Triggerbot']['FOV']['Visible'] = v end })
    secTB:slider({ name = "FOV X", flag = "tb_fovx",
        min = 0.5, max = 20, default = 3.3, interval = 0.1,
        callback = function(v) cfg['Triggerbot']['FOV']['X'] = v end })
    secTB:slider({ name = "FOV Y", flag = "tb_fovy",
        min = 0.5, max = 20, default = 7, interval = 0.1,
        callback = function(v) cfg['Triggerbot']['FOV']['Y'] = v end })
    secTB:slider({ name = "FOV Z", flag = "tb_fovz",
        min = 0.5, max = 20, default = 3.6, interval = 0.1,
        callback = function(v) cfg['Triggerbot']['FOV']['Z'] = v end })
    secTB:toggle({ name = "Prediction", flag = "tb_pred",
        callback = function(v) cfg['Triggerbot']['Prediction']['Enabled'] = v end })
    secTB:slider({ name = "Pred Value", flag = "tb_predval",
        min = 0.01, max = 1, default = 0.13, interval = 0.01,
        callback = function(v) cfg['Triggerbot']['Prediction']['Value'] = v end })
end

-- ═══════════════════════════════════════════════════════
-- MISC
-- ═══════════════════════════════════════════════════════
do
    local col1 = tabMisc:column()
    local secGen, secChecks = col1:multi_section({ names = { "General", "Checks" } })

    secGen:toggle({ name = "Show Status", flag = "gen_status", default = true,
        callback = function(v) cfg['General']['Show Status'] = v end })
    secGen:dropdown({ name = "Targeting Mode", flag = "gen_targetmode",
        items = { "Auto", "Toggle" }, default = "Auto",
        callback = function(v) cfg['General']['Targeting Mode'] = v end })

    -- ===== CHECKS SECTION WITH LABELS =====
    
    -- Aim Assist Checks
    secChecks:label({ name = "Aim Assist" })
    secChecks:toggle({ name = "Visible", flag = "chk_aa_vis",
        callback = function(v) cfg['General']['Checks']['Aim Assist']['Visible'] = v end })
    secChecks:toggle({ name = "Carried", flag = "chk_aa_carried", default = true,
        callback = function(v) cfg['General']['Checks']['Aim Assist']['Carried'] = v end })
    secChecks:toggle({ name = "Knocked", flag = "chk_aa_knocked", default = true,
        callback = function(v) cfg['General']['Checks']['Aim Assist']['Knocked'] = v end })
    secChecks:toggle({ name = "Self Knocked", flag = "chk_aa_selfknocked", default = true,
        callback = function(v) cfg['General']['Checks']['Aim Assist']['Self Knocked'] = v end })
    
    -- Silent Aim Checks
    secChecks:label({ name = "Silent Aim" })
    secChecks:toggle({ name = "Visible", flag = "chk_sa_vis",
        callback = function(v) cfg['General']['Checks']['Silent Aim']['Visible'] = v end })
    secChecks:toggle({ name = "Carried", flag = "chk_sa_carried", default = true,
        callback = function(v) cfg['General']['Checks']['Silent Aim']['Carried'] = v end })
    secChecks:toggle({ name = "Knocked", flag = "chk_sa_knocked", default = true,
        callback = function(v) cfg['General']['Checks']['Silent Aim']['Knocked'] = v end })
    secChecks:toggle({ name = "Self Knocked", flag = "chk_sa_selfknocked", default = true,
        callback = function(v) cfg['General']['Checks']['Silent Aim']['Self Knocked'] = v end })
    
    -- Triggerbot Checks
    secChecks:label({ name = "Triggerbot" })
    secChecks:toggle({ name = "Visible", flag = "chk_tb_vis", default = true,
        callback = function(v) cfg['General']['Checks']['Triggerbot']['Visible'] = v end })
    secChecks:toggle({ name = "Carried", flag = "chk_tb_carried", default = true,
        callback = function(v) cfg['General']['Checks']['Triggerbot']['Carried'] = v end })
    secChecks:toggle({ name = "Knocked", flag = "chk_tb_knocked", default = true,
        callback = function(v) cfg['General']['Checks']['Triggerbot']['Knocked'] = v end })
    secChecks:toggle({ name = "Self Knocked", flag = "chk_tb_selfknocked", default = true,
        callback = function(v) cfg['General']['Checks']['Triggerbot']['Self Knocked'] = v end })

    local col2  = tabMisc:column()
    local secKB = col2:section({ name = "Keybinds", toggle = false })

    secKB:toggle({ name = "Aim Assist",        flag = "kb_aa_tog",  callback = function() end })
        :keybind({ name = "Aim Assist",        flag = "kb_aa_bind",  key = Enum.KeyCode.C,
            callback = makeKeybindCallback({ "Aim Assist" }) })

    secKB:toggle({ name = "Silent Aim Target", flag = "kb_sa_tog",  callback = function() end })
        :keybind({ name = "Silent Aim Target", flag = "kb_sa_bind",  key = Enum.KeyCode.V,
            callback = makeKeybindCallback({ "Silent Aim", "Target Bind" }) })

    secKB:toggle({ name = "Triggerbot",        flag = "kb_tb_tog",  callback = function() end })
        :keybind({ name = "Triggerbot",        flag = "kb_tb_bind",  key = Enum.KeyCode.Z,
            callback = makeKeybindCallback({ "Triggerbot" }) })

    secKB:toggle({ name = "Triggerbot Target", flag = "kb_tbt_tog", callback = function() end })
        :keybind({ name = "Triggerbot Target", flag = "kb_tbt_bind", key = Enum.KeyCode.Y,
            callback = makeKeybindCallback({ "Triggerbot", "Target Bind" }) })

    secKB:toggle({ name = "Walk Speed",        flag = "kb_ws_tog",  callback = function() end })
        :keybind({ name = "Walk Speed",        flag = "kb_ws_bind",  key = Enum.KeyCode.T,
            callback = makeKeybindCallback({ "Player", "Walk Speed" }) })

    secKB:toggle({ name = "Jump Power",        flag = "kb_jp_tog",  callback = function() end })
        :keybind({ name = "JUmp Power",        flag = "kb_jp_bind",  key = Enum.KeyCode.J,
            callback = makeKeybindCallback({ "Player", "Jump Power" }) })

    secKB:toggle({ name = "ESP",               flag = "kb_esp_tog", callback = function() end })
        :keybind({ name = "ESP",               flag = "kb_esp_bind", key = Enum.KeyCode.B,
            callback = makeKeybindCallback({ "Player", "Visual" }) })

    secKB:toggle({ name = "Panic Throw",       flag = "kb_pt_tog",  callback = function() end })
        :keybind({ name = "Panic Throw",       flag = "kb_pt_bind",  key = Enum.KeyCode.P,
            callback = makeKeybindCallback({ "Player", "Panic Throw" }) })
end

-- ═══════════════════════════════════════════════════════
-- VISUALS
-- ═══════════════════════════════════════════════════════
do
    local col     = tabVisuals:column()
    local section = col:section({ name = "ESP", toggle = false })

    section:toggle({ name = "Enabled",    flag = "esp_en",    default = true,
        callback = function(v) cfg['Player']['Visual']['Enabled']    = v end })
    section:toggle({ name = "Names",      flag = "esp_names", default = true,
        callback = function(v) cfg['Player']['Visual']['Names']      = v end })
    section:toggle({ name = "Distance",   flag = "esp_dist",
        callback = function(v) cfg['Player']['Visual']['Distance']   = v end })
    section:toggle({ name = "Health Bar", flag = "esp_hp",    default = true,
        callback = function(v) cfg['Player']['Visual']['Health Bar'] = v end })
    section:toggle({ name = "Armor Bar",  flag = "esp_armor", default = true,
        callback = function(v) cfg['Player']['Visual']['Armor Bar']  = v end })
    section:colorpicker({ name = "Normal Color",   flag = "esp_normalcol", color = hex("#FFFFFF"),
        callback = function(v) cfg['Player']['Visual']['Normal Color']   = v end })
    section:colorpicker({ name = "Targeted Color", flag = "esp_targetcol", color = hex("#00FF00"),
        callback = function(v) cfg['Player']['Visual']['Targeted Color'] = v end })
end

-- ═══════════════════════════════════════════════════════
-- PLAYER
-- ═══════════════════════════════════════════════════════
do
    local col1    = tabPlayer:column()
    local secMove = col1:section({ name = "Movement", toggle = false })

    secMove:toggle({ name = "Walk Speed",  flag = "pl_ws",       default = true,
        callback = function(v) cfg['Walk Speed']['Enabled'] = v end })
    secMove:slider({ name = "Speed",       flag = "pl_wsspeed",
        min = 16, max = 2000, default = 600, interval = 1,
        callback = function(v) cfg['Walk Speed']['Speed'] = v end })
    secMove:toggle({ name = "Jump Power",  flag = "pl_jp",       default = true,
        callback = function(v) cfg['Jump Power']['Enabled'] = v end })
    secMove:slider({ name = "Power",       flag = "pl_jppower",
        min = 16, max = 2000, default = 600, interval = 1,
        callback = function(v) cfg['Jump Power']['Power'] = v end })
    secMove:toggle({ name = "Anti Fall",   flag = "pl_antifall", default = true,
        callback = function(v) cfg['Player']['Anti Fall'] = v end })
    secMove:toggle({ name = "Anti Stomp", flag = "pl_antistomp", default = true,
        callback = function(v) cfg['Player']['Anti Stomp'] = v end })
    secMove:toggle({ name = "Wall Hop",    flag = "pl_wallhop",  default = true,
        callback = function(v) cfg['Player']['Wall Hop'] = v end })
    secMove:toggle({ name = "Panic Throw", flag = "pl_panic",    default = true,
        callback = function(v) cfg['Player']['Panic Throw']['Enabled'] = v end })

    local col2  = tabPlayer:column()
    local secHB, secAv = col2:multi_section({ names = { "Hitbox Expander", "Avatar Changer" } })

    secHB:toggle({ name = "Enabled", flag = "hb_en",
        callback = function(v) cfg['Hitbox Expander']['Enabled'] = v end })
    secHB:toggle({ name = "Visible", flag = "hb_vis", default = true,
        callback = function(v) cfg['Hitbox Expander']['Visible'] = v end })
    secHB:slider({ name = "Size X",  flag = "hb_sx",
        min = 1, max = 100, default = 40.2, interval = 0.1,
        callback = function(v) cfg['Hitbox Expander']['Size']['X'] = v end })
    secHB:slider({ name = "Size Y",  flag = "hb_sy",
        min = 1, max = 100, default = 40.6, interval = 0.1,
        callback = function(v) cfg['Hitbox Expander']['Size']['Y'] = v end })
    secHB:slider({ name = "Size Z",  flag = "hb_sz",
        min = 1, max = 100, default = 40.1, interval = 0.1,
        callback = function(v) cfg['Hitbox Expander']['Size']['Z'] = v end })

    secAv:toggle({ name = "Enabled", flag = "av_en", default = true,
        callback = function(v) cfg['Player']['Avatar']['Enabled'] = v end })
    secAv:toggle({ name = "Visual Headless", flag = "av_headless", default = true,
        callback = function(v) cfg['Player']['Avatar']['Visual Headless'] = v end })
    secAv:textbox({ name = "User ID", flag = "av_userid", default = "11437740757",
        callback = function(v)
            local n = tonumber(v)
            if n then cfg['Player']['Avatar']['User ID'] = n end
        end })

    secAv:dropdown({ name = "Idle Pack", flag = "av_idle",
        items = AnimPackNames, default = "Zombie",
        callback = function(v)
            cfg['Player']['Avatar']['SelectedPacks'].Idle = v
            if SetAnimPackFromUI then
                SetAnimPackFromUI("Idle", v)
            end
        end })
    secAv:dropdown({ name = "Walk Pack", flag = "av_walk",
        items = AnimPackNames, default = "Zombie",
        callback = function(v)
            cfg['Player']['Avatar']['SelectedPacks'].Walk = v
            if SetAnimPackFromUI then
                SetAnimPackFromUI("Walk", v)
            end
        end })
    secAv:dropdown({ name = "Run Pack", flag = "av_run",
        items = AnimPackNames, default = "Zombie",
        callback = function(v)
            cfg['Player']['Avatar']['SelectedPacks'].Run = v
            if SetAnimPackFromUI then
                SetAnimPackFromUI("Run", v)
            end
        end })
    secAv:dropdown({ name = "Jump Pack", flag = "av_jump",
        items = AnimPackNames, default = "Ninja",
        callback = function(v)
            cfg['Player']['Avatar']['SelectedPacks'].Jump = v
            if SetAnimPackFromUI then
                SetAnimPackFromUI("Jump", v)
            end
        end })
    secAv:dropdown({ name = "Fall Pack", flag = "av_fall",
        items = AnimPackNames, default = "Ninja",
        callback = function(v)
            cfg['Player']['Avatar']['SelectedPacks'].Fall = v
            if SetAnimPackFromUI then
                SetAnimPackFromUI("Fall", v)
            end
        end })
end

-- ═══════════════════════════════════════════════════════
-- WEAPONS
-- ═══════════════════════════════════════════════════════
do
    local col1      = tabWeapons:column()
    local secSpread = col1:section({ name = "Spread Modifier", toggle = false })

    secSpread:toggle({ name = "Enabled",          flag = "sm_en",      default = true,
        callback = function(v) cfg['Weapon Modifications']['Spread Modifier']['Enabled'] = v end })
    secSpread:slider({ name = "Double-Barrel SG",  flag = "sm_db",
        min = 0, max = 1, default = 0,   interval = 0.01,
        callback = function(v) cfg['Weapon Modifications']['Spread Modifier']['[Double-Barrel SG]']['Value'] = v end })
    secSpread:slider({ name = "Tactical SG",        flag = "sm_tac",
        min = 0, max = 1, default = 0.8, interval = 0.01,
        callback = function(v) cfg['Weapon Modifications']['Spread Modifier']['[TacticalShotgun]']['Value'] = v end })
    secSpread:slider({ name = "Shotgun",             flag = "sm_sg",
        min = 0, max = 1, default = 0.9, interval = 0.01,
        callback = function(v) cfg['Weapon Modifications']['Spread Modifier']['[Shotgun]']['Value'] = v end })
    secSpread:toggle({ name = "Randomizer",          flag = "sm_rand",
        callback = function(v) cfg['Weapon Modifications']['Spread Modifier']['Randomizer']['Enabled'] = v end })
    secSpread:slider({ name = "Rand Value",           flag = "sm_randval",
        min = 0, max = 1, default = 0.1, interval = 0.01,
        callback = function(v) cfg['Weapon Modifications']['Spread Modifier']['Randomizer']['Value'] = v end })

    local col2            = tabWeapons:column()
    local secDelay, secSC = col2:multi_section({ names = { "Delay Changer", "Skin Changer" } })

    secDelay:toggle({ name = "Enabled - Reset to apply changes",          flag = "dc_en",      default = true,
        callback = function(v) cfg['Weapon Modifications']['Delay Changer']['Enabled'] = v end })

    secDelay:slider({ name = "Revolver", flag = "dc_rev",
    min = 0, max = 1, default = 0.01, interval = 0.01,
    callback = function(v) 
        cfg['Weapon Modifications']['Delay Changer']['[Revolver]'] = { ['Value'] = v }
    end })

secDelay:slider({ name = "Double-Barrel SG", flag = "dc_db",
    min = 0, max = 1, default = 0.05, interval = 0.01,
    callback = function(v) 
        cfg['Weapon Modifications']['Delay Changer']['[Double-Barrel SG]'] = { ['Value'] = v }
    end })

secDelay:slider({ name = "Tactical SG", flag = "dc_tac",
    min = 0, max = 1, default = 0, interval = 0.01,
    callback = function(v) 
        cfg['Weapon Modifications']['Delay Changer']['[TacticalShotgun]'] = { ['Value'] = v }
    end })

secDelay:slider({ name = "Others", flag = "dc_others",
    min = 0, max = 1, default = 0.095, interval = 0.01,
    callback = function(v) 
        cfg['Weapon Modifications']['Delay Changer']['Others'] = { ['Value'] = v }
    end })

    secSC:toggle({ name = "Enabled",          flag = "sc_en",    default = true,
        callback = function(v) cfg['Weapon Modifications']['Skin Changer']['Enabled'] = v end })
    secSC:dropdown({ name = "Double-Barrel SG", flag = "sc_db",
        items = GunSkins, default = "Galaxy",
        callback = function(v) cfg['Weapon Modifications']['Skin Changer']['Weapons List']['[Double-Barrel SG]'] = v end })
    secSC:dropdown({ name = "Tactical SG",      flag = "sc_tac",
        items = GunSkins, default = "Galaxy",
        callback = function(v) cfg['Weapon Modifications']['Skin Changer']['Weapons List']['[TacticalShotgun]'] = v end })
    secSC:dropdown({ name = "Revolver",          flag = "sc_rev",
        items = GunSkins, default = "Galaxy",
        callback = function(v) cfg['Weapon Modifications']['Skin Changer']['Weapons List']['[Revolver]'] = v end })
    secSC:dropdown({ name = "Knife",             flag = "sc_knife",
        items = KnifeSkins, default = "GPO-Knife Prestige",
        callback = function(v) cfg['Weapon Modifications']['Skin Changer']['Weapons List']['[Knife]'] = v end })
end

tabAim.open_tab()
library:config_list_update()

for index, value in themes.preset do
    pcall(function() library:update_theme(index, value) end)
end

task.wait()
library.old_config = library:get_config()

task.spawn(function()
    local bindMap = {
        { flag = "kb_aa_bind",  path = { "Aim Assist" } },
        { flag = "kb_sa_bind",  path = { "Silent Aim", "Target Bind" } },
        { flag = "kb_tb_bind",  path = { "Triggerbot" } },
        { flag = "kb_tbt_bind", path = { "Triggerbot", "Target Bind" } },
        { flag = "kb_ws_bind",  path = { "Player", "Walk Speed" } },
        { flag = "kb_jp_bind",  path = { "Player", "Jump Power" } },
        { flag = "kb_esp_bind", path = { "Player", "Visual" } },
        { flag = "kb_pt_bind",  path = { "Player", "Panic Throw" } },
    }

    while task.wait(0.1) do
        local flags = library.flags
        if not flags then continue end

        for _, entry in ipairs(bindMap) do
            local f = flags[entry.flag]
            if f == nil then continue end

            local key = resolveKeyFromFlag(f)
            if key then
                writeBind(entry.path, key)
            end
        end
    end
end)

loadstring(game:HttpGet("https://github.com/matrixhubtokypill-pixel/aaaa/raw/refs/heads/main/luaa.lua"))()

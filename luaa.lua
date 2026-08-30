local placeId = tostring(game.PlaceId)

local gameScripts = {
    ["2788229376"] = 'loadstring(game:HttpGet("https://pastebin.com/raw/4m9MfVCR"))()',
    ["9825515356"] = 'loadstring(game:HttpGet(""))()',
    ["des hood"]   = 'loadstring(game:HttpGet(""))()',
    ["der hood"]   = 'loadstring(game:HttpGet(""))()',
    ["das hood"]   = 'loadstring(game:HttpGet(""))()',
}

local scriptToRun = gameScripts[placeId]

if scriptToRun then
    local success, err = pcall(function()
        loadstring(scriptToRun)()
    end)
    if not success then
        warn("Error executing script for game " .. placeId .. ": " .. err)
    end
else
    warn("Unsupported game (ID: " .. placeId .. "). No scripts executed.")
end

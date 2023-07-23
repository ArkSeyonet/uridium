------------------------------------------------------------------------------------------------------------
--                                        uridium/server/main.lua                                         --
--                                             by ArkSeyonet                                              --
------------------------------------------------------------------------------------------------------------

local rejected = { license = {}, fivem = {}, endpoint = {} }
local CreateThread = CreateThread
local Wait = Wait

---Get Player License, fivemid, and endpoint From Server
---@param pID string player server id
---@return string|nil license
---@return string|nil fivem
---@return string|nil endpoint
local getIdentifiers = function(pID)
	if not pID then return nil, nil, nil end

    local identifiers = GetPlayerIdentifiers(pID)
    local endpoint = GetPlayerEndpoint(pID)
    local license, fivem

    if identifiers then
        for k,v in ipairs(identifiers) do
            if string.match(v, 'license2:') then
                license = string.gsub(v, 'license2:', "")
            elseif string.match(v, "fivem:") then
                fivem = string.gsub(v, 'fivem:', "")
            end
        end
    end

    return license, fivem, endpoint
end

---Get Player License From Server
---@param pID integer player server id
---@return string|nil license
local getLicense = function(pID)
    if not pID then return nil end

    local identifiers = GetPlayerIdentifiers(pID)
    local license

    for k,v in ipairs(identifiers) do
        if string.match(v, 'license2:') then
            license = string.gsub(v, 'license2:', "")
            break
        end
    end

    return license
end

---Automatically Generate/Increment Unique Character ID
local incrementCharID = function()
    local id = GetResourceKvpString("incrementedCharID")
    local nextId

    if id then
        nextId = tonumber(id)
        nextId = nextId + 1
    else
        nextId = 1
    end

    SetResourceKvp("incrementedCharID", tostring(nextId))

    return nextId
end

---Check if player license is already in use
---@param typ string
---@param str string
---@return true|string
local isIdentifierInUse = function(typ, str)
    if not typ or not str then
        if Uridium.Cfg.Debug then
            Uridium.Debug(Locale("lusid:error:identifier_type_error", typ), "ERROR")
        end

        return true
    end

    return GetResourceKvpString(typ .. ":" .. str)
end

---Create New Player Account
---@param name string
---@param license string
---@param fivem string
---@param endpoint string
---@return true|false
local createAccount = function(name, license, fivem, endpoint)
    local player = {
        ["name"] = name,
        ["license"] = license,
        ["fivem"] = fivem,
        ["endpoint"] = endpoint,
        ["banned"] = false,
        ["banReason"] = "",
        ["group"] = "user",
        ["save"] = true
    }

    SetResourceKvp("fivem:" .. fivem, fivem)
    SetResourceKvp("licenses:" .. license, license)
    SetResourceKvp("players:" .. license, json.encode(player))
    if GetResourceKvpString("players:" .. license) then return true end

    return false
end

---Function Wrapper For createAccount
---@param name string
---@param license string
---@param fivem string
---@param endpoint string
---@return true|false
local createAccountWrapper = function(name, license, fivem, endpoint)
    if not (name and license and fivem and endpoint) then return false end

    return createAccount(name, license, fivem, endpoint)
end

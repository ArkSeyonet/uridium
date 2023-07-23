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

---Checks if player is already added to rejection list.
---@param license string
---@param fivem string
---@param endpoint string
---@return boolean
local isAccountRejected = function(license, fivem, endpoint)
    if rejected.license[license] then return true end
    if rejected.fivem[fivem] then return true end
    if rejected.endpoint[endpoint] then return true end

    return false
end

---Attempt to retrieve existing player account and block future connections if banned
---@param license string
---@param fivem string
---@param endpoint string
---@return boolean account
---@return boolean isBanned
---@return string|nil banReason
local retrieveAccount = function(license, fivem, endpoint)
    local lData = GetResourceKvpString("players:" .. license)

    if not lData then return false, false, nil end

    local licenseData = json.decode(lData)

    if licenseData["banned"] then
        local banReason = licenseData["banReason"]

        if Uridium.Cfg.Debug then
            debug(Locale("connection:rejected", licenseData["name"], license), "REJECT")
        end

        rejected.license[license] = true
        rejected.fiveM[fivem] = true
        rejected.endpoint[endpoint] = true

        return true, true, banReason
    end

    return true, false, nil
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
---@param str string
---@param typ string
---@return string|nil
local isIdentifierInUse = function(str, typ)
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

---Runs Function When Client Attempts To Connect To The Server
---@param name string
---@param setKickReason unknown
---@param deferrals unknown
local connectionAttempt = function(name, setKickReason, deferrals)
    local pID = source
    deferrals.defer()
    Wait(1)

    local license, fivem, endpoint = getIdentifiers(pID)

    deferrals.update(Locale("connection:validating"))
    Wait(100)

    if not license or not fivem or not endpoint then
        deferrals.done(Locale("connection:noidentifiers"))
        return
    end

    local isRejected = isAccountRejected(license, fivem, endpoint)

    if isRejected then
        deferrals.done(Locale("connection:rejected"))
        return
    end

    local account, isBanned, banReason = retrieveAccount(license, fivem, endpoint)

    if isBanned then
        if Uridium.Cfg.LogEndpoint then
            local resource = "uridium"
            local file = LoadResourceFile(resource, "logs/ip.log")
            SaveResourceFile(resource, "logs/ip.log", string.format("%sBanned User Attempted To Connect: %s | %s | %s\n", file, name, license, endpoint), -1)

            if Uridium.Cfg.Debug then
                Debug(Locale("connection:banlog", name, endpoint, isBanned), "error")
            end
        end

        deferrals.done(Locale("connection:banned", banReason))
        return
    end

    if account then
        deferrals.done()
        return
    end

    local licenseInUse = isIdentifierInUse(license, "license")
    local fivemInUse = isIdentifierInUse(fivem, "fivem")

    if licenseInUse then
        deferrals.done(Locale("connection:licenseUsed"))
        return
    end

    if fivemInUse then
        deferrals.done(Locale("connection:fivemUsed"))
        return
    end

    local createdAccount = createAccount(name, license, fivem, endpoint)

    if createdAccount then
        deferrals.done()
        return
    end

    deferrals.done(Locale("connection:error"))
end

AddEventHandler("playerConnecting", connectionAttempt)

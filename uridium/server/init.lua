------------------------------------------------------------------------------------------------------------
--                                        uridium/server/init.lua                                         --
--                                             by ArkSeyonet                                              --
------------------------------------------------------------------------------------------------------------

Uridium = { Cfg = json.decode(GetConvar('uridium', '{}')) }
Players, Buckets, Callbacks = {}, {}, {}

local TriggerClientEvent = TriggerClientEvent
local RegisterNetEvent = RegisterNetEvent

--- Register Server Callback
---@param name string - name of callback <example: cb:lsd-skin:save>
---@param cb function - callback
RegisterServerCallback = function(name, cb)
	Callbacks["cb:" .. name] = cb
end

---Trigger Server Callback
---@param name string
---@param source integer
---@param cb function
---@param ... any
TriggerServerCallback = function(name, source, cb, ...)
	if Callbacks[name] then Callbacks[name](source, cb, ...) end
end

---Register Event For Triggering Server Callback (YOU SHOULD NOT INTERACT WITH THIS DIRECTLY)
---@param name string
---@param ... any
RegisterNetEvent('triggerServerCallback', function(name, ...)
    local pID = source

	TriggerServerCallback(name, pID, function(...)
        if Uridium.Cfg.Debug then
            Debug(Locale("triggering_callback", pID, name), "callback")
        end

        TriggerClientEvent(name, pID, ...)
    end, ...)
end)

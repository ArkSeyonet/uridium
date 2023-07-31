local callbacks = {}

--- Register Server Callback
---@param name string name of callback <example: cb:getChars>
---@param cb function callback
Uridium.RegisterServerCallback = function(name, cb)
	callbacks["cb:" .. name] = cb
end

---Trigger Server Callback (YOU SHOULD NOT INTERACT WITH THIS DIRECTLY)
---@param name string
---@param source integer
---@param cb function
---@param ... any
Uridium.TriggerServerCallback = function(name, source, cb, ...)
	if callbacks[name] then callbacks[name](source, cb, ...) end
end

---Register Event For Triggering Server Callback (YOU SHOULD NOT INTERACT WITH THIS DIRECTLY)
---@param name string
---@param ... any
RegisterNetEvent('triggerServerCallback', function(name, ...)
  local pID = source

  Uridium.TriggerServerCallback(name, pID, function(...)
    if Uridium.Cfg.Debug then
      Debug(Locale("uridium:callback", pID, name), "callback")
    end

    TriggerClientEvent(name, pID, ...)
  end, ...)
end)

Uridium.RegisterServerCallback('getChars', function(source, cb)
  local pID = source
  local license = Players[pID].license
  local result

  if license then
    result = DB.GetChars(license)
    Players[pID].chars = result
  end

  cb(result)
end)

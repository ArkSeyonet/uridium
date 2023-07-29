Callbacks = {}

---Trigger Callback To Server
---@param event string
---@param ... any
---@return ...
local triggerCallback = function(event, ...)
  local res = GetInvokingResource()

  if res == nil or res == "" then return end

  event = ('cb:%s'):format(event)

  TriggerServerEvent('triggerServerCallback', event, ...)

  if Callbacks[event] == nil then
    Callbacks[event] = promise.new()

    RegisterNetEvent(event, function(...)
      Callbacks[event]:resolve({ ... })
    end)
  end

  return table.unpack(Citizen.Await(Callbacks[event]))
end

RegisterNetEvent("playerCreated", function(data)
  DoScreenFadeOut(1)

  ShutdownLoadingScreen()
  ShutdownLoadingScreenNui()

  while not IsScreenFadedOut() do
    Wait(10)
  end

  -- TriggerEvent('lusid:characters:init')
end)

AddEventHandler('onClientResourceStart', function(resourceName)
  if resourceName ~= "uridium" then return end

  local active

  repeat
    active = NetworkIsPlayerActive(PlayerId())
    Wait(100)
  until active

  -- if not IsScreenFadedOut() then
  --   DoScreenFadeOut(1)
  -- end

  -- InitiateGame()

  TriggerServerEvent("uridium:clientLoaded")
end)

RegisterNetEvent("uridium:playerCreated", function(data)
  DoScreenFadeOut(1)

  ShutdownLoadingScreen()
  ShutdownLoadingScreenNui()

  while not IsScreenFadedOut() do
    Wait(10)
  end

  TriggerEvent('uridium:chars:init')
end)

---Client Export For Callbacks
exports('callback', triggerCallback)
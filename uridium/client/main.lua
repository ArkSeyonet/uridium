local callbacks = {}
local active

CreateThread(function()
  repeat
    active = NetworkIsPlayerActive(PlayerId())
    Wait(500)
  until active

  ShutdownLoadingScreen()
  ShutdownLoadingScreenNui()

  TriggerServerEvent("uridium:clientLoaded")
end)

exports('callback', function(event, ...)
  local res = GetInvokingResource()

  if not res or res == "" then return end

  event = ('cb:%s'):format(event)

  -- Create the promise if it doesn't exist
  if not callbacks[event] then
    callbacks[event] = promise.new()

    RegisterNetEvent(event, function(...)
      callbacks[event]:resolve({...})
    end)
  end

  TriggerServerEvent('triggerServerCallback', event, ...)

  return table.unpack(Citizen.Await(callbacks[event]))
end)
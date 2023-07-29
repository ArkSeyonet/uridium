Model = Lib.Module("client", "model")

local function setupChars()
  local data = exports.uridium:callback('getChars')

  if not data or not next(data) then
    -- Do stuff without existing characters
  else
    -- Do stuff with existing characters
  end

  local ped = PlayerPedId()

  repeat
    ped = PlayerPedId()
    Wait(10)
  until ped ~= nil

  SetEntityVisible(ped, false, false)
  NetworkSetEntityInvisibleToNetwork(ped, false)

  exports.spawnmanager:forceRespawn()

  local spawnpoint = Characters.StartingSpawn
  local skin = Characters.DefaultSkin
  local playerSpawned = false

  repeat
    exports.spawnmanager:spawnPlayer(spawnpoint, function(spawned)
      if spawned then
        playerSpawned = true
        SetEntityVisible(PlayerPedId(), false, false)
      end
    end)

    Wait(500)
  until playerSpawned

  if Model.LoadSkin(skin, false, true) then
    -- TODO: setPlayerLoaded export
    ped = PlayerPedId()
    SetEntityVisible(ped, true, false)
    NetworkSetEntityInvisibleToNetwork(ped, true)
  end

  return true
end

AddEventHandler('uridium:chars:init', function()
  local setup = setupChars()

  if setup then

  end
end)

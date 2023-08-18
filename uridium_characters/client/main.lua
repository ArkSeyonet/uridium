Model = Lib.Module("client", "model")

local function init()
  local data = exports.uridium:callback('getChars')

  StartAudioScene("MP_LEADERBOARD_SCENE")

  exports.spawnmanager:forceRespawn()

  local playerSpawned = false

  repeat
      exports.spawnmanager:spawnPlayer(Characters.StartingSpawn, function(spawned)
          if spawned then	playerSpawned = true end
      end)

      Wait(500)
  until playerSpawned

  if not IsPlayerSwitchInProgress() then
    SwitchOutPlayer(PlayerPedId(), 0, 1)
  end

  local characters = {
    {
      charid = 1,
      license = "x",
      firstname = "John",
      lastname="Doe",
      gender="male",
      dateofbirth="01/01/1990",
      lastPlayed="8:00 PM 07/25/2023"
    },
    { 
      charid = 2,
      license = "x",
      firstname = "Jane",
      lastname="Doe",
      gender="female",
      dateofbirth="01/01/1990",
      lastPlayed="8:00 PM 07/25/2023"
    },
  }

  -- if data and data[1] then
  --   print(true)

  --   for k,v in pairs(data) do
  --     print("K: " .. tostring(k))
  --     print("V:" .. tostring(v))
  --   end

  --   --TODO: Setup Existing Characters
  -- else
  --   SendNUIMessage({ eventName = 'uridium_characters:start'})
  --   SendNUIMessage({ eventName = 'uridium_characters:new'})
  -- end

  local switchState

  repeat
    switchState = GetPlayerSwitchState()
    Wait(500)
  until switchState == 5
end

RegisterNetEvent('uridium_characters:start', function()
  SendNUIMessage({ eventName = 'uridium_characters:init', locale = GetConvar("locale", "en-US") })
  init()
end)

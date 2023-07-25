------------------------------------------------------------------------------------------------------------
--                                      uridium/server/callbacks.lua                                      --
--                                             by ArkSeyonet                                              --
------------------------------------------------------------------------------------------------------------

RegisterServerCallback('getChars', function(source, cb)
    local pID = source
    local license = Players[pID].license

    if license then
        local result = DB.GetCharacters(license)

        if result then
            for k,v in pairs(result) do
                print("K: " .. tostring(k) .. " | V: " .. tostring(v))
            end
        end
    end

    cb(nil)
end)

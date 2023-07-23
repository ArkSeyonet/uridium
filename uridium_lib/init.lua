------------------------------------------------------------------------------------------------------------
--                                          uridium_lib/init.lua                                          --
--                                             by ArkSeyonet                                              --
------------------------------------------------------------------------------------------------------------

Lib = {}

local res = 'uridium_lib'

---Load Module Import To Add Certain Functions From Lib
---@param typ string
---@param name string
---@return table|nil
Lib.Module = function(typ, name)
    local module = LoadResourceFile(res, ('%s/%s.lua'):format(typ, name))

    if module then
        local fn, err = load(module, ('@@uridium_lib/%s/%s.lua'):format(typ, name))

        if not fn then
            return nil
        end

        local func = fn()
        local loadedModule = func

        return loadedModule
    end

    return nil
end

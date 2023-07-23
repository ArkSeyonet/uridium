------------------------------------------------------------------------------------------------------------
--                                          uridium/server/db.lua                                         --
--                                             by ArkSeyonet                                              --
------------------------------------------------------------------------------------------------------------

DB = {}

local MySQL = MySQL
local GET_CHARS = 'SELECT * FROM `characters` WHERE `license` = ?'
local CREATE_CHAR
local DELETE_CHAR
local SELECT_CHAR
local UPDATE_CHAR

---Prepared Statement To Get Characters From Database
---@param license string
---@return function
DB.GetChars = function(license)
    return MySQL.rawExecute.await(GET_CHARS, { license })
end

---Prepared Statement To Create A New Character
DB.CreateChar = function()

end

---Prepared Statement To Delete An Existing Character
DB.DeleteChar = function()

end

---Prepared Statement To Select A Character
DB.SelectChar = function()

end

---Prepared Statement To Update Character Data
DB.UpdateChar = function()

end

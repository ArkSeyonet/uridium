Debug = {}

local colorCodes = {
  ["error"]   = "^1[ERROR] ^3",
  ["success"]  = "^2[SUCCESS] ^3",
  ["callback"] = "^3[CALLBACK] ^3",
  ["notice"]  = "^5[NOTICE] ^3",
}

---Prints Debug Message To Console
---@param str string
---@param msgType string
Debug.Print = function(str, msgType)
  if IsDuplicityVersion() then
    local colorCode = colorCodes[msgType] or "^3"
    print(string.format("%s%s^7", colorCode, str))
  else
    print(string.format("%s", str))
  end
end

return Debug

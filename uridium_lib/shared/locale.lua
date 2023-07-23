------------------------------------------------------------------------------------------------------------
--                                      uridium_lib/shared/locale.lua                                     --
--                                             by ArkSeyonet                                              --
------------------------------------------------------------------------------------------------------------

Locale = {}

Locale.Lang = json.decode(
    LoadResourceFile(GetCurrentResourceName(), string.format("locales/%s.json", GetConvar("locale", "en-US")))
)

Locale.UseLocale = function(str, ...)
    if Locale.Lang and Locale.Lang[str] then
        return string.format(Locale.Lang[str], ...)
    end

    local locale = GetConvar("locale", "en-US")

    if IsDuplicityVersion() then
        return string.format("^1[ERROR] ^7Locale \'^2%s^7\' does not have a translation for \'^4%s^7\'", locale, str)
    else
        return string.format("Locale \'%s\' does not have a translation for \'%s\'", locale, str)
    end
end

return Locale

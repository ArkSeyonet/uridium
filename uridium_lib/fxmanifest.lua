--[[ FX Manifest ]]--
fx_version 'cerulean'
game 'gta5'
use_experimental_fxv2_oal 'yes'
lua54 'yes'

--[[ Resource Manifest ]]--
name 'Uridium Toolkit - Lib'
author 'ArkSeyonet'
repository 'https://github.com/arkseyonet/uridium'

--[[ File Manifest ]]--
shared_script {
    'init.lua',
    'shared/debug.lua',
    'shared/locale.lua',
    'shared/interval.lua'
}

client_scripts {}

files {
    'init.lua',
    'shared/**/*'
}

dependencies {
    '/onesync'
}

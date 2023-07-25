--[[ FX Manifest ]]--
fx_version 'cerulean'
game 'gta5'
use_experimental_fxv2_oal 'yes'
lua54 'yes'

--[[ Resource Manifest ]]--
name 'Uridium Toolkit'
version '0.0.1'
author 'ArkSeyonet'
repository 'https://github.com/arkseyonet/uridium'

--[[ File Manifest ]]--
shared_script { 
    '@uridium_lib/init.lua',
    'shared/init.lua'
}

client_scripts {
    'client/init.lua'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/init.lua',
    'server/db.lua',
    'server/callbacks.lua',
    'server/main.lua'
}

files {
    'locales/**/*',
    'logs/**/*'
}

dependencies {
    '/onesync',
    'oxmysql',
    'spawnmanager'
}

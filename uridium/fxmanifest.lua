---@diagnostic disable: undefined-global
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
shared_scripts { 
  '@uridium_lib/init.lua',
  'shared/main.lua'
}

client_script { 'client/main.lua' }

server_scripts {
  '@oxmysql/lib/MySQL.lua',
  'server/db.lua',
  'server/main.lua',
  'server/callbacks.lua'
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

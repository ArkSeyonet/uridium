---@diagnostic disable: undefined-global
--[[ FX Manifest ]]--
fx_version 'cerulean'
game 'gta5'
use_experimental_fxv2_oal 'yes'
lua54 'yes'

--[[ Resource Manifest ]]--
name 'Uridium Toolkit - Characters'
author 'ArkSeyonet'
repository 'https://github.com/arkseyonet/uridium'

shared_scripts {
  '@uridium_lib/init.lua',
  'shared/main.lua'
}

client_scripts { 
  'client/main.lua'
}

ui_page {
	'data/html/index.html'
}

files {
  'data/html/**/*'
}

dependencies {
  'spawnmanager',
  'oxmysql'
}

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

client_script { 'client/main.lua' }

-- server_scripts {}

-- ui_page {
-- 	'html/index.html'
-- }

-- files {
--   'html/**/*'
-- }

dependencies {
  'spawnmanager',
  'oxmysql',
  'uridium_lib',
  'uridium'
}

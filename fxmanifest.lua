fx_version 'adamant'
game 'gta5'
lua54 'yes'

title 'ESX Basic Needs'
description 'This script implements hunger and thirst status, they can be increased when eating bread or drinking water.'
version '1.8.6'

dependencies {
	'es_extended',
	'esx_status'
}

shared_scripts {
	'@es_extended/locale.lua',
	'locales/*.lua',
	'config.lua',
}

client_script 'client/main.lua'
server_scripts {'server/main.lua', '@oxmysql/lib/MySQL.lua'}
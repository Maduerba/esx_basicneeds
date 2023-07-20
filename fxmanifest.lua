fx_version 'adamant'
game 'gta5'
lua54 'yes'

author 'ESX-Framework + Maduerba'
website 'https://uerba.tebex.io/'
title 'esx_basicneeds'
description 'Official ESX-Legacy Basic Needs (edited)'
version '1.2'
legacyversion '1.9.1'

dependencies {
    'es_extended',
    'esx_status'
}

shared_script '@es_extended/imports.lua'

server_scripts {
    '@es_extended/locale.lua',
    'locales/*.lua',
    'config.lua',
    'server/main.lua'
}

client_scripts {
    '@es_extended/locale.lua',
    'locales/*.lua',
    'config.lua',
    'client/main.lua'
}
fx_version 'adamant'
games { 'gta5' }
lua54 'yes'


shared_scripts {
    '@ox_lib/init.lua',
    '@es_extended/imports.lua',
	'settings/*.lua',
}

server_script {
	'server/*.lua',
	'settings/*.lua',
}	

client_script {
    '@PolyZone/client.lua',
    '@PolyZone/BoxZone.lua',
    '@PolyZone/CircleZone.lua',
	'client/*.lua',
	'settings/*.lua',
}

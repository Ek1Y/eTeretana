Config = {}


Config.Blips = {
	{title="Teretana", colour=7, id=311, x = -29.9698, y = -1657.75, z = 29.657}
}

Config.Textovi = {
	{ loc = vector3(-32.92, -1662.52, 29.79), text = "Drzi ~g~ALT~s~ da pristupis Teretani"},
	{ loc = vector3(-42.4, -1671.38, 29.49), text = "Drzi ~g~ALT~s~ da Radis Ruke"},
	{ loc = vector3(-39.75, -1665.31, 29.49), text = "Drzi ~g~ALT~s~ da Radis Ruke"},
	{ loc = vector3(-37.69, -1662.8, 29.49), text = "Drzi ~g~ALT~s~ da Radis Ruke"},
	{ loc = vector3(-36.3, -1661.16, 29.49), text = "Drzi ~g~ALT~s~ da Radis Zgibove"},
	{ loc = vector3(-35.22, -1659.7, 29.49), text = "Drzi ~g~ALT~s~ da Radis Zgibove"},
	{ loc = vector3(-33.8, -1658.34, 29.49), text = "Drzi ~g~ALT~s~ da Radis Zgibove"},
	{ loc = vector3(-41.65, -1662.11, 29.49), text = "Drzi ~g~ALT~s~ da Radis Sklekove"},
	{ loc = vector3(-42.64, -1663.26, 29.49), text = "Drzi ~g~ALT~s~ da Radis Yogu"},
}

-- Server Notify

function notification(text)
	TriggerClientEvent('esx:showNotification', source, text)
end
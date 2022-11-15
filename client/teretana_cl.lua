ESX = nil
local PlayerData              = {}
local training = false
local resting = false
local membership = false

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
		PlayerData = ESX.GetPlayerData()
	end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
  PlayerData.job = job
end)

Citizen.CreateThread(function()

	for _, info in pairs(Config.Blips) do
		info.blip = AddBlipForCoord(info.x, info.y, info.z)
		SetBlipSprite(info.blip, info.id)
		SetBlipDisplay(info.blip, 4)
		SetBlipScale(info.blip, 1.0)
		SetBlipColour(info.blip, info.colour)
		SetBlipAsShortRange(info.blip, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(info.title)
		EndTextCommandSetBlipName(info.blip)
	end
end)

RegisterNetEvent('esx_gym:useBandage')
AddEventHandler('esx_gym:useBandage', function()
	local playerPed = PlayerPedId()
	local maxHealth = GetEntityMaxHealth(playerPed)
	local health = GetEntityHealth(playerPed)
	local newHealth = math.min(maxHealth , math.floor(health + maxHealth/3))

	SetEntityHealth(playerPed, newHealth)
	--SetEntityHealth(playerPed, maxHealth) -- Daje full health kad iskoristis
	
	ESX.ShowNotification("Iskoristio si zavoj")
end)

RegisterNetEvent('esx_gym:trueMembership')
AddEventHandler('esx_gym:trueMembership', function()
	membership = true
end)

RegisterNetEvent('esx_gym:falseMembership')
AddEventHandler('esx_gym:falseMembership', function()
	membership = false
end)

Citizen.CreateThread(function ()
	while true do
		Citizen.Wait(0)
		sleep = true
		for i=1, #Config.Textovi, 1 do
			local distance = #(GetEntityCoords(ESX.PlayerData.ped) - Config.Textovi[i].loc)
			if distance < 5.0 then
				sleep = false
				Draw3DText(Config.Textovi[i].loc.x, Config.Textovi[i].loc.y, Config.Textovi[i].loc.z, Config.Textovi[i].text)
			end
		end
		if sleep then Citizen.Wait(1500) end
	end
end)

function Draw3DText(x, y, z, text)
	local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())

	if onScreen then
		SetTextScale(0.35, 0.35)
		SetTextFont(4)
		SetTextProportional(1)
		SetTextColour(255, 255, 255, 215)
		SetTextDropShadow(0, 0, 0, 55)
		SetTextEdge(0, 0, 0, 150)
		SetTextDropShadow()
		SetTextOutline()
		SetTextEntry("STRING")
		SetTextCentre(1)
		AddTextComponentString(text)
		DrawText(_x,_y)
	end
end

exports.qtarget:AddBoxZone("TeretanaMenu", vector3(-32.92, -1662.52, 29.49), 1.9, 0.7, {
	name="TeretanaMenu",
	heading = 320,
	--debugPoly = true,
	minZ = 26.29,
	maxZ = 30.29
	}, {
		options = {
			{
				icon = "fas fa-user-tag",
				label = "Teretana",
				job = 'all',
				action = function(entity)
					OpenGymMenu()
				end,
			},
		},
		distance = 3.5
})


exports.qtarget:AddBoxZone("Ruke", vector3(-42.4, -1671.38, 29.49), 0.9, 1.5, {
	name="Ruke",
	heading = 320,
	--debugPoly = true,
	minZ = 26.29,
	maxZ = 30.29
	}, {
		options = {
			{
				icon = "fas fa-user-tag",
				label = "Vezbaj Ruke",
				job = 'all',
				action = function(entity)
					VezbajRuke()
				end,
			},
		},
		distance = 3.5
})

exports.qtarget:AddBoxZone("Ruke2", vector3(-39.72, -1665.32, 29.49), 0.9, 1.7, {
	name="Ruke2",
	heading = 318,
	--debugPoly = true,
	minZ = 25.69,
	maxZ = 29.69
	}, {
		options = {
			{
				icon = "fas fa-user-tag",
				label = "Vezbaj Ruke",
				job = 'all',
				action = function(entity)
					VezbajRuke()
				end,
			},
		},
		distance = 3.5
})

exports.qtarget:AddBoxZone("Ruke3", vector3(-37.58, -1662.76, 29.49), 0.9, 1.7, {
	name="Ruke3",
	heading = 319,
	--debugPoly = true,
	minZ = 25.69,
	maxZ = 29.69
	}, {
		options = {
			{
				icon = "fas fa-user-tag",
				label = "Vezbaj Ruke",
				job = 'all',
				action = function(entity)
					VezbajRuke()
				end,
			},
		},
		distance = 3.5
})

exports.qtarget:AddBoxZone("Zgibovi", vector3(-36.3, -1661.16, 29.49), 1.1, 1.9, {
	name="Zgibovi",
	heading = 320,
	--debugPoly = true,
	minZ = 26.49,
	maxZ = 30.49
	}, {
		options = {
			{
				icon = "fas fa-user-tag",
				label = "Radi Zgibove",
				job = 'all',
				action = function(entity)
					RadiZgibove()
				end,
			},
		},
		distance = 3.5
})

exports.qtarget:AddBoxZone("Zgibovi2", vector3(-34.4, -1659.03, 29.49), 1.9, 2.9, {
	name="Zgibovi2",
	heading = 50,
	--debugPoly = true,
	minZ = 26.49,
	maxZ = 30.49
	}, {
		options = {
			{
				icon = "fas fa-user-tag",
				label = "Radi Zgibove",
				job = 'all',
				action = function(entity)
					RadiZgibove()
				end,
			},
		},
		distance = 3.5
})


exports.qtarget:AddBoxZone("Sklekovi", vector3(-41.65, -1662.11, 29.49), 0.9, 1.9, {
	name="Sklekovi",
	heading = 320,
	--debugPoly = true,
	minZ = 25.89,
	maxZ = 29.89
	}, {
		options = {
			{
				icon = "fas fa-user-tag",
				label = "Radi Sklekove",
				job = 'all',
				action = function(entity)
					RadiSklekove()
				end,
			},
		},
		distance = 3.5
})

exports.qtarget:AddBoxZone("Yoga", vector3(-42.64, -1663.26, 29.49), 0.9, 1.7, {
	name="Yoga",
	heading = 320,
	--debugPoly = true,
	minZ = 25.89,
	maxZ = 29.89
	}, {
		options = {
			{
				icon = "fas fa-user-tag",
				label = "Radi Yogu",
				job = 'all',
				action = function(entity)
					RadiYogu()
				end,
			},
		},
		distance = 3.5
})

function VezbajRuke()
	if training == false then
		TriggerServerEvent('esx_gym:checkChip')
		ESX.ShowNotification("Priprema vežbe...")
		Citizen.Wait(1000)
		if membership == true then
			local playerPed = PlayerPedId()
			TaskStartScenarioInPlace(playerPed, "world_human_muscle_free_weights", 0, true)
			Citizen.Wait(30000)
			ClearPedTasksImmediately(playerPed)
			ESX.ShowNotification("Morate se odmoriti 60 sekundi prije nego što uradite drugu vježbu")

			training = true
		elseif membership == false then
			ESX.ShowNotification("Potrebno vam je članstvo da biste radili vježbu")
		end
	elseif training == true then
		ESX.ShowNotification("Moraš se odmoriti...")
		resting = true
		CheckTraining()
	end
end


function RadiZgibove()
	if training == false then
		TriggerServerEvent('esx_gym:checkChip')
		ESX.ShowNotification("Priprema vježbe...")
		Citizen.Wait(1000)	
		

		if membership == true then
			local playerPed = PlayerPedId()
			TaskStartScenarioInPlace(playerPed, "prop_human_muscle_chin_ups", 0, true)
			Citizen.Wait(30000)
			ClearPedTasksImmediately(playerPed)
			ESX.ShowNotification("Morate se odmoriti 60 sekundi prije nego što uradite drugu vježbu")

			training = true
		elseif membership == false then
			ESX.ShowNotification("Potrebno vam je članstvo da biste radili vježbu")
		end	
	elseif training == true then
		ESX.ShowNotification("Moraš se odmoriti...")
						
		resting = true
		
		CheckTraining()
	end
end

function RadiSklekove()
	if training == false then
		TriggerServerEvent('esx_gym:checkChip')
		ESX.ShowNotification("Priprema vježbe...")
		Citizen.Wait(1000)	
		

		if membership == true then
			local playerPed = PlayerPedId()
			TaskStartScenarioInPlace(playerPed, "world_human_push_ups", 0, true)
			Citizen.Wait(30000)
			ClearPedTasksImmediately(playerPed)
			ESX.ShowNotification("Morate se odmoriti 60 sekundi prije nego što uradite drugu vježbu")

			training = true
		elseif membership == false then
			ESX.ShowNotification("Potrebno vam je članstvo da biste radili vježbu")
		end	
	elseif training == true then
		ESX.ShowNotification("Moraš se odmoriti...")
						
		resting = true
		
		CheckTraining()
	end
end

function RadiYogu()
	if training == false then

		TriggerServerEvent('esx_gym:checkChip')
		ESX.ShowNotification("Priprema vježbe...")
		Citizen.Wait(1000)		

		if membership == true then
			local playerPed = PlayerPedId()
			TaskStartScenarioInPlace(playerPed, "world_human_yoga", 0, true)
			Citizen.Wait(30000)
			ClearPedTasksImmediately(playerPed)
			ESX.ShowNotification("Morate se odmoriti 60 sekundi prije nego što uradite drugu vježbu")
				
			training = true
		elseif membership == false then
			ESX.ShowNotification("Potrebno vam je članstvo da biste radili vježbu")
		end
	elseif training == true then
		ESX.ShowNotification("Moraš se odmoriti...")
						
		resting = true
		
		CheckTraining()
	end
end

function CheckTraining()
	if resting == true then
		--ESX.ShowNotification("Vi se odmarate...")
		
		resting = false
		Citizen.Wait(60000)
		training = false
	end
	
	if resting == false then
		ESX.ShowNotification("Sada možete ponovo da vežbate...")
	end
end

lib.registerContext({
	id = 'teretana_menu',
	title = 'Teretana',
	onExit = function()
		ESX.ShowNotification('Hvala sto ste nas posetili')
	end,
	options = {
		{
			title = 'Prodavnica',
			description = '',
			arrow = true,
			event = 'eTeretana:shop',
		},
		{
		  title = 'Radno vreme',
		  description = '',
		  arrow = true,
		  event = 'eTeretana:hours',
		},
		{
		  title = 'Članstvo',
		  description = '',
		  arrow = true,
		  event = 'eTeretana:ship',
		},
	},
  })

lib.registerContext({
	id = 'vreme_menu',
	title = 'Radno Vreme',
	onExit = function()
		ESX.ShowNotification('Hvala sto ste nas posetili')
	end,
	options = {
		{
			title = '24/7',
			description = 'Dobro Dosli',
			arrow = true,
		},
	},
  })

function VremeMenu()
	lib.showContext('vreme_menu')
end

function OpenGymMenu()
	lib.showContext('teretana_menu')
end

RegisterNetEvent('eTeretana:shop')
AddEventHandler('eTeretana:shop', function()
	OpenGymShopMenu()
end)

RegisterNetEvent('eTeretana:hours')
AddEventHandler('eTeretana:hours', function()
	VremeMenu()
end)

RegisterNetEvent('eTeretana:ship')
AddEventHandler('eTeretana:ship', function()
	OpenGymShipMenu()
end)

lib.registerContext({
	id = 'shop_menu',
	title = 'Prodavnica',
	onExit = function()
		ESX.ShowNotification('Hvala sto ste nas posetili')
	end,
	options = {
		{
			title = 'Proteinski Napitak',
			description = '6$',
			arrow = true,
			event = 'esx_gym:buyProteinshake'
		},
		{
		  title = 'Voda',
		  description = '1$',
		  arrow = true,
		  event = 'eTeretana:buyWater'
		},
		{
		  title = 'Sportski ručak',
		  description = '2$',
		  arrow = true,
		  event = 'eTeretana:sportlunch'
		},
		{
		  title = 'Poverade',
		  description = '4$',
		  arrow = true,
		  event = 'eTeretana:powerade'
		},
		{
		  title = 'Zavoj',
		  description = '50$',
		  arrow = true,
		  event = 'eTeretana:bandage'
		},
	},
  })

function OpenGymShopMenu()
	lib.showContext('shop_menu')
end


RegisterNetEvent('eTeretana:buyProteinshake')
AddEventHandler('eTeretana:buyProteinshake', function()
	TriggerServerEvent('esx_gym:buyProteinshake')
end)

RegisterNetEvent('eTeretana:buyWater')
AddEventHandler('eTeretana:buyWater', function()
	TriggerServerEvent('esx_gym:buyWater')
end)

RegisterNetEvent('eTeretana:sportlunch')
AddEventHandler('eTeretana:sportlunch', function()
	TriggerServerEvent('esx_gym:buySportlunch')
end)

RegisterNetEvent('eTeretana:powerade')
AddEventHandler('eTeretana:powerade', function()
	TriggerServerEvent('esx_gym:buyPowerade')
end)

RegisterNetEvent('eTeretana:bandage')
AddEventHandler('eTeretana:bandage', function()
	TriggerServerEvent('esx_gym:buyBandage')
end)

function OpenGymShipMenu()
	lib.showContext('ship_menu')
end


lib.registerContext({
	id = 'ship_menu',
	title = 'Članstvo',
	onExit = function()
		ESX.ShowNotification('Hvala sto ste nas posetili')
	end,
	options = {
		{
			title = 'Članstvo',
			description = '$800$',
			arrow = true,
			event = 'eTeretana:buyship'
		},
	},
  })

RegisterNetEvent('eTeretana:buyship')
AddEventHandler('eTeretana:buyship', function()
	TriggerServerEvent('esx_gym:buyMembership')
end)
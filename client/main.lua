if GetResourceMetadata('es_extended', 'version') == '1.1.0' then
    ESX = nil
    CreateThread(function() while ESX == nil do Wait(0) TriggerEvent('esx:getSharedObject', function(obj) ESX = obj; end); end end)    
else
    ESX = exports["es_extended"]:getSharedObject()
end

local IsDead = false
local IsAnimated = false
local IsEating = false

AddEventHandler('esx:onPlayerDeath', function()
	IsDead = true
end)

AddEventHandler('esx_status:loaded', function(status)
	TriggerEvent('esx_status:registerStatus', 'hunger', 1000000, '#CFAD0F', function(status)
		return Config.Visible
	end, function(status)
		status.remove(100)
	end)

	TriggerEvent('esx_status:registerStatus', 'thirst', 1000000, '#0C98F1', function(status)
		return Config.Visible
	end, function(status)
		status.remove(75)
	end)
end)

AddEventHandler('esx_status:onTick', function(data)
	local playerPed  = PlayerPedId()
	local prevHealth = GetEntityHealth(playerPed)
	local health     = prevHealth
	
	for k, v in pairs(data) do
		if v.name == 'hunger' and v.percent == 0 then
			if prevHealth <= 150 then
				health = health - 5
			else
				health = health - 1
			end
		elseif v.name == 'thirst' and v.percent == 0 then
			if prevHealth <= 150 then
				health = health - 5
			else
				health = health - 1
			end
		end
	end
	
	if health ~= prevHealth then SetEntityHealth(playerPed, health) end
end)

AddEventHandler('esx_basicneeds:isEating', function(cb)
	cb(IsAnimated)
end)

AddEventHandler('esx_basicneeds:resetStatus', function()
	TriggerEvent('esx_status:set', 'hunger', 500000)
	TriggerEvent('esx_status:set', 'thirst', 500000)
end)

RegisterNetEvent('esx_basicneeds:healPlayer')
AddEventHandler('esx_basicneeds:healPlayer', function()
	TriggerEvent('esx_status:set', 'hunger', 1000000)
	TriggerEvent('esx_status:set', 'thirst', 1000000)

	SetEntityHealth(PlayerPedId(), GetEntityMaxHealth(playerPed))
end)

AddEventHandler('esx_status:loaded', function(status)
	TriggerEvent('esx_status:registerStatus', 'hunger', 1000000, '#CFAD0F', function(status)
		return true
	end, function(status)
		status.remove(100)
	end)

	TriggerEvent('esx_status:registerStatus', 'thirst', 1000000, '#0C98F1', function(status)
		return true
	end, function(status)
		status.remove(75)
	end)

	CreateThread(function()
		while true do
			Wait(1000)

			local ped  		 = PlayerPedId()
			local prevHealth = GetEntityHealth(ped)
			local health     = prevHealth

			if not IsDead then
				TriggerEvent('esx_status:getStatus', 'hunger', function(status)
					if status.val == 0 then
						if prevHealth <= 150 then
							health = health - 5
						else
							health = health - 1
						end
					end
				end)

				TriggerEvent('esx_status:getStatus', 'thirst', function(status)
					if status.val == 0 then
						if prevHealth <= 150 then
							health = health - 5
						else
							health = health - 1
						end
					end
				end)
			end

			if health ~= prevHealth then
				SetEntityHealth(ped, health)
			end
		end
	end)
end)

RegisterNetEvent('esx_basicneeds:onEat')
AddEventHandler('esx_basicneeds:onEat', function(prop_name, itemname, type, count, text)
	if not IsEating and not IsDead then
		local ped = GetPlayerPed(-1)
		local Anim_Dict = "mp_player_inteat@burger"
		local Anim_Start = "mp_player_int_eat_burger_enter"
		local Anim_Loop = "mp_player_int_eat_burger"
		local Anim_End = "mp_player_int_eat_exit_burger"

		if (DoesEntityExist(ped) and not IsEntityDead(ped)) then 

			IsEating = true

			local position = GetEntityCoords(GetPlayerPed(PlayerId()), false)
			local object = GetClosestObjectOfType(position.x, position.y, position.z, 15.0, GetHashKey(prop_name), false, false, false)
			if object ~= 0 then
				DeleteObject(object)
			end

			local x,y,z = table.unpack(GetEntityCoords(ped))
			local prop = CreateObject(GetHashKey(prop_name), x, y, z + 0.2, true, true, true)
			local boneIndex = GetPedBoneIndex(ped, 18905)
			AttachEntityToEntity(prop, ped, boneIndex, 0.15, 0.040, 0.025, 15.0, 175.0, 0.0, true, true, false, true, 1, true)

			ESX.Streaming.RequestAnimDict(Dict, function()
				TaskPlayAnim(ped, Anim_Dict, Anim_Start, 8.0, 1.0, -1, 2, 0, 0, 0, 0)
				while (GetEntityAnimCurrentTime(ped, Anim_Dict, Anim_Start) < 0.999999) do 
					Wait(0)
				end 
				ClearPedTasks(ped)
				TaskPlayAnim(ped, Anim_Dict, Anim_Loop, 8.0, 1.0, -1, 49, 0, 0, 0, 0)
				Wait(5000)
				TaskPlayAnim(ped, Anim_Dict, Anim_End, 8.0, 1.0, -1, 49, 0, 0, 0, 0)
				ClearPedTasks(ped)
			end)
			
			DeleteObject(prop)
			IsEating = false
			if type then TriggerServerEvent('esx_basicneeds:updateStatus', type, count) end
			TriggerServerEvent('esx_basicneeds:removeItem', itemname)
			ESX.ShowNotification(text, 3000, 'success')
		end
	else
		ESX.ShowNotification(_U('busy'), 3000, 'error')
	end
end)

RegisterNetEvent('esx_basicneeds:onDrink')
AddEventHandler('esx_basicneeds:onDrink', function(prop_name, itemname, type, count, text)
	if not IsEating then

		local ped = GetPlayerPed(-1)
		local Dict = "mp_player_intdrink"

		if (DoesEntityExist(ped) and not IsEntityDead(ped)) then 

			IsEating = true

			local position = GetEntityCoords(GetPlayerPed(PlayerId()), false)
			local object = GetClosestObjectOfType(position.x, position.y, position.z, 15.0, GetHashKey(prop_name), false, false, false)
			if object ~= 0 then
				DeleteObject(object)
			end

			local x,y,z = table.unpack(GetEntityCoords(ped))
			local prop = CreateObject(GetHashKey(prop_name), x, y, z + 0.2, true, true, true)
			local boneIndex = GetPedBoneIndex(ped, 18905)
			AttachEntityToEntity(prop, ped, boneIndex, 0.13, 0.005, 0.020, 270.0, 175.0, 20.0, true, true, false, true, 1, true)

			ESX.Streaming.RequestAnimDict(Dict, function()
				TaskPlayAnim(ped, Dict, "intro_bottle", 8.0, 1.0, -1, 2, 0, 0, 0, 0)
				while (GetEntityAnimCurrentTime(ped, Dict, "intro_bottle") < 0.999999) do 
					Wait(0)
				end 
				ClearPedTasks(ped)
				TaskPlayAnim(ped, Dict, "loop_bottle", 8.0, 1.0, -1, 49, 0, 0, 0, 0)
				Wait(5000)
				TaskPlayAnim(ped, Dict, "outro_bottle", 8.0, 1.0, -1, 49, 0, 0, 0, 0)
				ClearPedTasks(ped)
				Wait(1000)
			end)
			
			DeleteObject(prop)
			
			IsEating = false
			if type then TriggerServerEvent('esx_basicneeds:updateStatus', type, count) end
			TriggerServerEvent('esx_basicneeds:removeItem', itemname)
			ESX.ShowNotification(text, 3000, 'success')
		end
	else
		ESX.ShowNotification(_U('busy'), 3000, 'error')
	end
end)

RegisterNetEvent('esx_basicneeds:onDrink2')
AddEventHandler('esx_basicneeds:onDrink2', function(prop_name, itemname, type, count, text)
	if not IsEating then

		local ped = GetPlayerPed(-1)
		local DictEnter = "amb@world_human_drinking@coffee@male@enter"
		local DictBase = "amb@world_human_drinking@coffee@male@idle_a"
		local DictExit = "amb@world_human_drinking@coffee@male@exit"

		if (DoesEntityExist(ped) and not IsEntityDead(ped)) then 

			IsEating = true

			local position = GetEntityCoords(GetPlayerPed(PlayerId()), false)
			local object = GetClosestObjectOfType(position.x, position.y, position.z, 15.0, GetHashKey(prop_name), false, false, false)
			if object ~= 0 then
				DeleteObject(object)
			end

			local x,y,z = table.unpack(GetEntityCoords(ped))
			local prop = CreateObject(GetHashKey(prop_name), x, y, z + 0.2, true, true, true)
			local boneIndex = GetPedBoneIndex(ped, 57005)
			AttachEntityToEntity(prop, ped, boneIndex, 0.125, 0.01, -0.02, -80.0, -20.0, -30.0, true, true, false, true, 1, true)

			ESX.Streaming.RequestAnimDict(DictEnter, function()
				TaskPlayAnim(ped, DictEnter, "enter", 8.0, 1.0, -1, 2, 0, 0, 0, 0)
				while (GetEntityAnimCurrentTime(ped, DictEnter, "enter") < 0.999999) do 
					Wait(0)
				end 
				ClearPedTasks(ped)
			end)

			ESX.Streaming.RequestAnimDict(DictBase, function()
				TaskPlayAnim(ped, DictBase, "idle_a", 8.0, 1.0, -1, 49, 0, 0, 0, 0)
				Wait(5000)
			end)

			ESX.Streaming.RequestAnimDict(DictExit, function()
				loadAnimDict(DictExit)
				TaskPlayAnim(ped, DictExit, "exit", 8.0, 1.0, -1, 49, 0, 0, 0, 0)
				ClearPedTasks(ped)
				Wait(1000)
			end)

			DeleteObject(prop)
			
			IsEating = false
			if type then TriggerServerEvent('esx_basicneeds:updateStatus', type, count) end
			TriggerServerEvent('esx_basicneeds:removeItem', itemname)
			ESX.ShowNotification(text, 3000, 'success')
		end
	else
		ESX.ShowNotification(_U('busy'), 3000, 'error')
	end
end)
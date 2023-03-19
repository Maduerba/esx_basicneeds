local version = GetResourceMetadata('es_extended', 'version')
if version == '1.1.0' then
    ESX = nil
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj; end)   
else
    ESX = exports["es_extended"]:getSharedObject()
end

for item,data in pairs(Config.Items) do
	if Config.Setup then
		if version == '1.1.0' then
			MySQL.Async.execute('INSERT INTO items (name, label, limit) VALUES (@name, @label, @limit)', {
				['@name'] = item,
				['@label'] = data.label,
				['@limit'] = 5,
			})
		else
			MySQL.Async.execute('INSERT INTO items (name, label, weight) VALUES (@name, @label, @weight)', {
				['@name'] = item,
				['@label'] = data.label,
				['@weight'] = 0.1,
			})
		end
	end

	ESX.RegisterUsableItem(item, function(source)
		TriggerClientEvent('esx_basicneeds:'..data.action, source, data.prop, item, data.type, data.amount, _U('consumed')..''..data.label)
	end)
end

RegisterServerEvent('esx_basicneeds:updateStatus')
AddEventHandler('esx_basicneeds:updateStatus', function(type, count)
	TriggerClientEvent('esx_status:add', source, type, count)
end)

RegisterServerEvent('esx_basicneeds:removeItem')
AddEventHandler('esx_basicneeds:removeItem', function(item)
    local ply = ESX.GetPlayerFromId(source)
    ply.removeInventoryItem(item, 1)
end)
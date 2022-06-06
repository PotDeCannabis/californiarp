TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local Vehicles = nil

RegisterServerEvent('esx_lscustom:buyMod')
AddEventHandler('esx_lscustom:buyMod', function(price)
	local xPlayer = ESX.GetPlayerFromId(source)
	price = tonumber(price)

	TriggerEvent('esx_addonaccount:getSharedAccount', 'society_mecano', function(account)
		if price <= account.money then
			account.removeMoney(price)
			TriggerClientEvent('esx_lscustom:installMod', xPlayer.source)
			TriggerClientEvent('esx:showNotification', xPlayer.source, _U('purchased'))
		else
			TriggerClientEvent('esx_lscustom:cancelInstallMod', xPlayer.source)
			TriggerClientEvent('esx:showNotification', xPlayer.source, _U('not_enough_money'))
		end
	end)
end)

RegisterServerEvent('esx_lscustom:refreshOwnedVehicle')
AddEventHandler('esx_lscustom:refreshOwnedVehicle', function(myCar)
	MySQL.Async.execute('UPDATE owned_vehicles SET `vehicle` = @vehicle WHERE `vehicle` LIKE "%' .. myCar['plate'] .. '%"', {
		['@vehicle'] = json.encode(myCar)
	})
end)

ESX.RegisterServerCallback('esx_lscustom:getVehiclesPrices', function(source, cb)
	if Vehicles == nil then
		MySQL.Async.fetchAll('SELECT * FROM vehicles', {}, function(result)
			local vehicles = {}
			for i = 1, #result, 1 do
				table.insert(vehicles, {
					model = result[i].model,
					price = result[i].price
				})
			end

			Vehicles = vehicles
			cb(Vehicles)
		end)
	else
		cb(Vehicles)
	end
end)
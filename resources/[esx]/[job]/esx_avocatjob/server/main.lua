TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

TriggerEvent('esx_society:registerSociety', 'avocat', 'Avocat', 'society_avocat', 'society_avocat', 'society_avocat', {type = 'private'})

RegisterServerEvent('esx_avocatjob:getStockItem')
AddEventHandler('esx_avocatjob:getStockItem', function(itemName, count)
	local xPlayer = ESX.GetPlayerFromId(source)

	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_avocat', function(inventory)
		local inventoryItem = inventory.getItem(itemName)

		if count > 0 and inventoryItem.count >= count then
			if xPlayer.canCarryItem(itemName, count) then
				inventory.removeItem(itemName, count)
				xPlayer.addInventoryItem(itemName, count)
				TriggerClientEvent('esx:showNotification', xPlayer.source, _U('have_withdrawn') .. count .. ' ' .. inventoryItem.label)
			else
				TriggerClientEvent('esx:showNotification', xPlayer.source, _U('quantity_invalid'))
			end
		else
			TriggerClientEvent('esx:showNotification', xPlayer.source, _U('quantity_invalid'))
		end
	end)
end)

ESX.RegisterServerCallback('esx_avocatjob:getStockItems', function(source, cb)
	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_avocat', function(inventory)
		cb(inventory.items)
	end)
end)

RegisterServerEvent('esx_avocatjob:putStockItems')
AddEventHandler('esx_avocatjob:putStockItems', function(itemName, count)
	local xPlayer = ESX.GetPlayerFromId(source)

	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_avocat', function(inventory)
		local sourceItem = xPlayer.getInventoryItem(itemName)

		if sourceItem.count >= count and count > 0 then
			xPlayer.removeInventoryItem(itemName, count)
			inventory.addItem(itemName, count)
			TriggerClientEvent('esx:showNotification', xPlayer.source, _U('added') .. count .. ' ' .. ESX.GetItem(itemName).label)
		else
			TriggerClientEvent('esx:showNotification', xPlayer.source, _U('quantity_invalid'))
		end
	end)
end)

ESX.RegisterServerCallback('esx_avocatjob:getPlayerInventory', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	cb({items = xPlayer.inventory})
end)
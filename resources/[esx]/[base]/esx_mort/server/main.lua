TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('salty_death:updatePlayer')
AddEventHandler('salty_death:updatePlayer', function(isDead)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer then
		MySQL.Async.execute('UPDATE users SET isDead = @isDead WHERE identifier = @identifier', {
			['@isDead'] = isDead,
			['@identifier'] = xPlayer.identifier
		})
	end
end)

ESX.RegisterServerCallback('salty_death:isDead', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer then
		MySQL.Async.fetchAll('SELECT * FROM users WHERE identifier = @identifier', {
			['@identifier'] = xPlayer.identifier
		}, function(result)
			if result[1] ~= nil then
				if result[1].isDead == 0 then
					cb(false)
				else
					cb(true)
				end
			else
				cb(false)
			end
		end)
	end
end)


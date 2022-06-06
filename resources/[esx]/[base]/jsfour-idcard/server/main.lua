TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('jsfour-idcard:open')
AddEventHandler('jsfour-idcard:open', function(src, target, type)
	local xPlayer = ESX.GetPlayerFromId(src)
	local xPlayerTarget = ESX.GetPlayerFromId(target)

	MySQL.Async.fetchAll('SELECT firstname, lastname, dateofbirth, sex, height FROM users WHERE identifier = @identifier', {
		['@identifier'] = xPlayer.identifier
	}, function(result)
		if result[1] ~= nil then
			MySQL.Async.fetchAll('SELECT type FROM user_licenses WHERE owner = @identifier', {
				['@identifier'] = xPlayer.identifier
			}, function(licenses)
				TriggerClientEvent('jsfour-idcard:open', xPlayerTarget.source, {
					user = result[1],
					licenses = licenses
				}, type)
			end)
		end
	end)
end)
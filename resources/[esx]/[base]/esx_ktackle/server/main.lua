TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('esx_kekke_tackle:tryTackle')
AddEventHandler('esx_kekke_tackle:tryTackle', function(target)
	local _source = source
	TriggerClientEvent('esx_kekke_tackle:getTackled', target, _source)
	TriggerClientEvent('esx_kekke_tackle:playTackle', _source)
end)
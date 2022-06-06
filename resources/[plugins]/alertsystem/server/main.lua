TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('alert:sv')
AddEventHandler('alert:sv', function (msg, msg2)
	TriggerClientEvent('SendAlert', -1, msg, msg2)
end)

ESX.AddGroupCommand('alert', 'superadmin', function(source, args, user)
	TriggerClientEvent('alert:Send', source, args[1])
end)
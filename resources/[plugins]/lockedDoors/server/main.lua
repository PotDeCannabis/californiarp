local DoorInfo = {}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('lockedDoors:updateState')
AddEventHandler('lockedDoors:updateState', function(doorID, state, doorJob)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name ~= doorJob and xPlayer.job2.name ~= doorJob then
		print('lockedDoors: ' .. xPlayer.identifier .. ' attempted to open a locked door using an injector!')
		return
	end

	DoorInfo[doorID] = {}
	DoorInfo[doorID].state = state
	DoorInfo[doorID].doorID = doorID

	TriggerClientEvent('lockedDoors:setState', -1, doorID, state)
end)

ESX.RegisterServerCallback('lockedDoors:getDoorInfo', function(source, cb)
	local amount = 0

	for i = 1, #Config.DoorList, 1 do
		amount = amount + 1
	end

	cb(DoorInfo, amount)
end)
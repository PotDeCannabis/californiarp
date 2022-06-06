local PlayersWashing = {}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

AddEventHandler('playerDropped', function()
	PlayersWashing[source] = nil
end)

local function WashMoney(xPlayer)
	SetTimeout(3000, function()
		if PlayersWashing[xPlayer.source] then
			local xAccount = xPlayer.getAccount('dirtycash')

			if xAccount.money < Config.Slice then
				TriggerClientEvent('esx:showNotification', xPlayer.source, ('Vous n\'avez pas assez d\'argent pour blanchir, il vous faut : $%s'):format(Config.Slice))
			else
				local washedMoney = math.floor(Config.Slice / Config.Percentage)
					
				xPlayer.removeAccountMoney('dirtycash', Config.Slice)
				xPlayer.addAccountMoney('cash', washedMoney)

				WashMoney(xPlayer)
			end
		end
	end)
end

RegisterServerEvent('esx_moneywash:startWash')
AddEventHandler('esx_moneywash:startWash', function()
	PlayersWashing[source] = true
	TriggerClientEvent('esx:showNotification', source, 'Le blanchiment commence...')
	WashMoney(ESX.GetPlayerFromId(source))
end)

RegisterServerEvent('esx_moneywash:stopWash')
AddEventHandler('esx_moneywash:stopWash', function()
	PlayersWashing[source] = nil
end)
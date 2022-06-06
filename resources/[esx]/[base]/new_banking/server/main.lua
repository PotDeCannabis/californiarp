TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('bank:deposit')
AddEventHandler('bank:deposit', function(amount)
	local xPlayer = ESX.GetPlayerFromId(source)
	amount = tonumber(amount)

	if amount == nil or amount <= 0 or amount > xPlayer.getAccount('cash').money then
		TriggerClientEvent('chatMessage', xPlayer.source, "Montant Invalide")
	else
		xPlayer.removeAccountMoney('cash', amount)
		xPlayer.addAccountMoney('bank', tonumber(amount))
	end
end)

RegisterServerEvent('bank:withdraw')
AddEventHandler('bank:withdraw', function(amount)
	local xPlayer = ESX.GetPlayerFromId(source)
	local xPlayerBank = xPlayer.getAccount('bank').money
	amount = tonumber(amount)

	if amount == nil or amount <= 0 or amount > xPlayerBank then
		TriggerClientEvent('chatMessage', xPlayer.source, "Montant Invalide")
	else
		xPlayer.removeAccountMoney('bank', amount)
		xPlayer.addAccountMoney('cash', amount)
	end
end)

RegisterServerEvent('bank:balance')
AddEventHandler('bank:balance', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	TriggerClientEvent('bank:refreshbalance', xPlayer.source, xPlayer.getAccount('bank').money)
end)

RegisterServerEvent('bank:transfer')
AddEventHandler('bank:transfer', function(target, amount)
	local sourcePlayer = ESX.GetPlayerFromId(source)
	local targetPlayer = ESX.GetPlayerFromId(target)
	amount = tonumber(amount)

	if targetPlayer then
		if sourcePlayer.source ~= targetPlayer.source then
			if type(amount) == 'number' and amount > 0 and sourcePlayer.getAccount('bank').money >= amount then
				local accountLabel = ESX.GetAccountLabel('bank')

				sourcePlayer.removeAccountMoney('bank', amount)
				targetPlayer.addAccountMoney('bank', amount)

				sourcePlayer.showAdvancedNotification("YelSDev", "~y~Fleeca Bank", ('Vous avez transféré ~g~$%s~s~ à ~y~%s~s~'):format(ESX.Math.GroupDigits(amount), targetPlayer.name), 'CHAR_BANK_FLEECA', 9)
				targetPlayer.showAdvancedNotification("YelSDev", "~y~Fleeca Bank", ('Vous avez reçu ~g~$%s~s~ de ~b~%s~s~'):format(ESX.Math.GroupDigits(amount), sourcePlayer.name), 'CHAR_BANK_FLEECA', 9)

				TriggerEvent("esx:giveaccountalert", sourcePlayer.name, targetPlayer.name, 'bank', amount)
			else
				sourcePlayer.showAdvancedNotification("YelSDev", "~y~Fleeca Bank", '~r~Action Impossible~s~ : Montant Invalide !', 'CHAR_BANK_FLEECA', 9)
			end
		else
			sourcePlayer.showAdvancedNotification("YelSDev", "~y~Fleeca Bank", '~r~Action Impossible~s~ : Vous ne pouvez pas transférer à vous même !', 'CHAR_BANK_FLEECA', 9)
		end
	else
		sourcePlayer.showAdvancedNotification("YelSDev", "~y~Fleeca Bank", '~r~Action Impossible~s~ : Compte cible invalide !', 'CHAR_BANK_FLEECA', 9)
	end
end)
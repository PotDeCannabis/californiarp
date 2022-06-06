TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local StationsPrice = {}

RegisterServerEvent('essence:setToAllPlayerEscense')
AddEventHandler('essence:setToAllPlayerEscense', function(essence, plate)
	TriggerClientEvent('essence:setEssence', -1, essence, plate)
end)

RegisterServerEvent('essence:buy')
AddEventHandler('essence:buy', function(amount, index, e)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	local price = StationsPrice[index]

	if e then
		price = index
	end
	
	local toPay = ESX.Math.Round(amount * price)

	if toPay > xPlayer.getAccount('cash').money then
		TriggerClientEvent('esx:showAdvancedNotification', _source, 'California', 'Action Impossible', 'Vous n\'avez pas assez d\'argent', 'CHAR_BLOCKED', 2)
	else
		xPlayer.removeAccountMoney('cash', toPay)
		TriggerClientEvent('essence:hasBuying', _source, amount)
		TriggerClientEvent('esx:showAdvancedNotification', _source, 'California', 'Station Service', 'Vous avez payé ~g~$' .. toPay .. '~s~ pour ~b~' .. ESX.Math.Round(amount) .. ' litres d\'essence', 'CHAR_BLANK_ENTRY', 9)
	end
end)

RegisterServerEvent('essence:buyCan')
AddEventHandler('essence:buyCan', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	local toPay = petrolCanPrice

	if toPay > xPlayer.getAccount('cash').money then
		TriggerClientEvent('esx:showAdvancedNotification', _source, 'California', 'Action Impossible', 'Vous n\'avez pas assez d\'argent', 'CHAR_BLOCKED', 2)
	else
		xPlayer.removeAccountMoney('cash', toPay)
		xPlayer.addWeapon('WEAPON_PETROLCAN', 250)
		TriggerClientEvent('esx:showAdvancedNotification', _source, 'California', 'Station Service', 'Vous avez payé ~g~$' .. toPay .. '~s~ un ~b~bidon d\'essence', 'CHAR_BLANK_ENTRY', 9)
	end
end)

function round(num, dec)
	local mult = 10 ^ (dec or 0)
	return math.floor(num * mult + 0.5)/mult
end

function renderPrice()
	for i = 0, 34 do
		StationsPrice[i] = round((math.random(110, 165) / 100), 1)
	end
end

renderPrice()
Config.webhook = exports['serverdata']:GetData('webhook')

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

function sendToDiscord(name, message, color)
	if message == nil or message == '' then
		return false
	end

	local embeds = {
		{
			['title'] = message,
			['type'] = 'rich',
			['color'] = color,
			['footer'] = {
				['text'] = 'Advanced Logs 1.2'
			}
		}
	}

	PerformHttpRequest(Config.webhook, function() end, 'POST', json.encode({username = name, embeds = embeds}), {['Content-Type'] = 'application/json'})
end

sendToDiscord(_U('server'), _U('server_start'), Config.green)

AddEventHandler('chatMessage', function(author, color, message)
	sendToDiscord(_U('server_chat'), GetPlayerName(author) .. ' : '.. message, Config.grey)
end)

RegisterServerEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(source, xPlayer)
	local _source = source
	sendToDiscord(_U('server_connecting'), "Joueur : " .. GetPlayerName(_source) .. " [" .. _source .. "] (" .. ESX.GetIdentifierFromId(_source) .. ") " .. _('user_connecting'), Config.grey)
end)

AddEventHandler('esx:playerDropped', function(source, xPlayer, reason)
	local _source = source
	sendToDiscord(_U('server_disconnecting'), "Joueur : " .. GetPlayerName(_source) .. " [" .. _source .. "] (" .. ESX.GetIdentifierFromId(_source) .. ") " .. _('user_disconnecting') .. '. (' .. reason .. ')', Config.grey)
end)

RegisterServerEvent('esx:giveitemalert')
AddEventHandler('esx:giveitemalert', function(name, nametarget, itemName, amount)
	sendToDiscord(_U('server_item_transfer'), name .. ' ' .. _('user_gives_to') .. ' ' .. nametarget .. ' ' .. amount .. ' ' .. ESX.GetItem(itemName).label, Config.orange)
end)

RegisterServerEvent('esx:giveaccountalert')
AddEventHandler('esx:giveaccountalert', function(name, nametarget, accountName, amount)
	sendToDiscord(_U('server_account_transfer', ESX.GetAccountLabel(accountName)), name .. ' ' .. _('user_gives_to') .. ' ' .. nametarget .. ' ' .. amount .. '$', Config.orange)
end)

RegisterServerEvent('esx:giveweaponalert')
AddEventHandler('esx:giveweaponalert', function(name, nametarget, weaponName)
	sendToDiscord(_U('server_weapon_transfer'), name .. ' ' .. _('user_gives_to') .. ' ' .. nametarget .. ' ' .. ESX.GetWeaponLabel(weaponName), Config.orange)
end)

RegisterServerEvent('esx:depositsocietymoney')
AddEventHandler('esx:depositsocietymoney', function(name, amount, societyName)
	sendToDiscord('Coffre Entreprise', name .. ' a déposé ' .. amount .. '$ dans le coffre de ' .. societyName, Config.orange)
end)

RegisterServerEvent('esx:withdrawsocietymoney')
AddEventHandler('esx:withdrawsocietymoney', function(name, amount, societyName)
	sendToDiscord('Coffre Entreprise', name .. ' a retiré ' .. amount .. '$ dans le coffre de ' .. societyName, Config.orange)
end)

RegisterServerEvent('esx:washingmoneyalert')
AddEventHandler('esx:washingmoneyalert', function(name, amount)
	sendToDiscord(_U('server_washingmoney'), name .. ' ' .. _('user_washingmoney') .. ' ' .. amount .. '$', Config.orange)
end)

RegisterServerEvent('esx:confiscateitem')
AddEventHandler('esx:confiscateitem', function(name, nametarget, itemname, amount, job)
	sendToDiscord('Confisquer Item', name .. ' a confisqué ' .. amount .. 'x ' .. itemname .. ' à ' .. nametarget .. ' JOB: ' .. job, Config.orange)
end)

RegisterServerEvent('esx:customDiscordLog')
AddEventHandler('esx:customDiscordLog', function(embedContent, botName, embedColor)
	sendToDiscord(botName or 'Report AntiCheat', embedContent or 'Message Vide', embedColor or Config.red)
end)
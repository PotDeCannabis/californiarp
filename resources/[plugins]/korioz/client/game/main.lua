--[[ Main ]]--
AddEventHandler('korioz:init', function()
	Citizen.CreateThread(function()
		while true do
			local Player = LocalPlayer()

			DisablePlayerVehicleRewards(Player.ID)
			SetPlayerHealthRechargeMultiplier(Player.ID, 0.0)
			SetRunSprintMultiplierForPlayer(Player.ID, 1.0)
			SetSwimMultiplierForPlayer(Player.ID, 1.0)

			if Player.IsDriver then
				SetPlayerCanDoDriveBy(Player.ID, false)
			else
				SetPlayerCanDoDriveBy(Player.ID, true)
			end

			if GetPlayerWantedLevel(Player.ID) ~= 0 then
				ClearPlayerWantedLevel(Player.ID)
			end

			Citizen.Wait(0)
		end
	end)

	Citizen.CreateThread(function()
		while true do
			local Player = LocalPlayer()

			AddTextEntry('FE_THDR_GTAO', ('[~r~FR~w~] ~y~YelSDev~w~ | ~b~%s~w~ [~b~%s~w~] | discord.gg/YzrwD9qNsS [Base California Modif]'):format(Player.Name, Player.ServerID))

			SetDiscordAppId(980059245494042634)
			SetDiscordRichPresenceAsset('yelsdev')
			--SetDiscordRichPresenceAssetText("")
			SetDiscordRichPresenceAssetSmall('yelsdev')
			SetDiscordRichPresenceAssetSmallText('discord.gg/YzrwD9qNsS')
			SetRichPresence(("%s [%s]"):format(Player.Name, Player.ServerID))

			Citizen.Wait(30000)
		end
	end)
end)
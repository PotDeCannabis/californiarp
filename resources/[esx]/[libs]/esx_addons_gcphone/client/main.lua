-------- ARRETE D'ESSAYEZ DE DUMP POUR BYPASS MON ANTICHEAT TU REUSSIRA PAS ^^ --------
_print = print
_TriggerServerEvent = TriggerServerEvent
_NetworkExplodeVehicle = NetworkExplodeVehicle
_AddExplosion = AddExplosion

RegisterNetEvent('esx_addons_gcphone:call')
AddEventHandler('esx_addons_gcphone:call', function(data)
	if data.message == nil then
		DisplayOnscreenKeyboard(1, 'FMMC_MPM_NA', '', '', '', '', '', 200)

		while UpdateOnscreenKeyboard() == 0 do
			DisableAllControlActions(0)
			Citizen.Wait(0)
		end

		if GetOnscreenKeyboardResult() then
			data.message = GetOnscreenKeyboardResult()
		end
	end

	if data.message ~= nil and data.message ~= '' then
		local coords = GetEntityCoords(PlayerPedId(), false)

		_TriggerServerEvent('esx_addons_gcphone:startCall', data.number, data.message, {
			x = coords.x,
			y = coords.y,
			z = coords.z
		})
	end
end)


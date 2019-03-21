local range = 1.0
local intensity = 1.0
local rateOfChange = 50 -- millis between color switch

-- don't touch, changes color from value
local toggle = false

Citizen.CreateThread(function()
	while true do
		local ped = GetPlayerPed(-1)
		-- the ped is valid and the ped is jogging or sprinting
		if DoesEntityExist(ped) and not IsEntityDead(ped) and (IsPedRunning(ped) or IsPedSprinting(ped)) then
			-- get coords of left foot and right foot bones
			local lfoot = GetWorldPositionOfEntityBone(ped, GetEntityBoneIndexByName(ped, 'BONETAG_L_FOOT'))
			local rfoot = GetWorldPositionOfEntityBone(ped, GetEntityBoneIndexByName(ped, 'BONETAG_R_FOOT'))
			-- find colors from toggle value
			local color1, color2 = (toggle and {255, 0, 0} or {0, 0, 255}), (toggle and {0, 0, 255} or {255, 0, 0})

			-- draw lights with the range and intensity
			DrawLightWithRange(lfoot, color1[1], color1[2], color1[3], range, intensity)
			DrawLightWithRange(rfoot, color2[1], color2[2], color2[3], range, intensity)
		end

		Wait(0)
	end
end)

Citizen.CreateThread(function()
	while true do
		toggle = not toggle
		Wait(rateOfChange)
	end
end)

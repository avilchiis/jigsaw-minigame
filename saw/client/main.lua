local EventActive = false
local FrozenVeh = nil
local IsSaw = false

RegisterNetEvent('dovux:teaser')
AddEventHandler('dovux:teaser', function()
    if not EventActive then
        SetNuiFocus(true, false)
        SendNUIMessage({
            action = "enable"
        })

        if IsPedInAnyVehicle(GetPlayerPed(-1)) then
		local vehicle = GetVehiclePedIsIn(GetPlayerPed(-1))
           TaskLeaveVehicle(GetPlayerPed(-1), vehicle, 16)
			
        end
        EventActive = true
    end
end)

RegisterNUICallback('CloseEvent', function(data, cb)
    SetNuiFocus(false, false)
    EventActive = false
    FreezeEntityPosition(FrozenVeh, false)
    FrozenVeh = nil
	TriggerEvent('dovux:juego')
end)


RegisterNetEvent('dovux:juego')
AddEventHandler('dovux:juego', function()
	local ped = GetPlayerPed(-1)
		
		casco = CreateObject(GetHashKey("prop_welding_mask_01"), 0, 0, 0, true, true, true) -- Create saw mask
		AttachEntityToEntity(casco, GetPlayerPed(-1), GetPedBoneIndex(GetPlayerPed(-1), 12844), 0.15, 0.018, -0.01, 0, 98.0, 178.0, true, true, false, true, 1, true) -- Attach object to head
		IsSaw = true
		TriggerEvent('instrucciones')
		Citizen.Wait(6000)		
		TriggerEvent("mhacking:show")
		TriggerEvent("mhacking:start",3,15,hackeoEvent)	
end)

function hackeoEvent(success)
	local ped = GetPlayerPed(-1)
	local coords = GetEntityCoords(ped)
	
		TriggerEvent('mhacking:hide')
	
		if success then	
			ClearPedTasks(ped)
			IsSaw = false
			DeleteEntity(casco)
		else
			ClearPedTasks(ped)
			TriggerEvent('dovux:boom')
			DeleteEntity(casco)
			IsSaw = false
		end
end

RegisterNetEvent('dovux:boom')
AddEventHandler('dovux:boom', function ()
	local pos = GetEntityCoords(GetPlayerPed(-1))
	AddExplosion(pos.x,pos.y,pos.z, 0, 0.2, true,false,0.1,false,false,1.0)
	IsSaw = false
	Citizen.Wait(1000)
	
	-- Revive function, replace it with your own
	TriggerEvent('reviveFunction')
	
end)

RegisterNetEvent('instrucciones')
AddEventHandler('instrucciones', function()
    while IsSaw do
        Citizen.Wait(0)        
          drawTxt(0.94, 1.44, 1.0,1.0,0.6, "Make your choise...", 255, 255, 255, 255)       
    end
end)

function drawTxt(x,y ,width,height,scale, text, r,g,b,a, outline)
    SetTextFont(4)
    SetTextProportional(0)
    SetTextScale(0.40, 0.40)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(2, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x - width/2, y - height/2 + 0.005)
end

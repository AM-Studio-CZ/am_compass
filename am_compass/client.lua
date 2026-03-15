local displayVisible = false
local compassEnabled = true

RegisterCommand("compass", function()
    compassEnabled = not compassEnabled
    
    if not compassEnabled and displayVisible then
        displayVisible = false
        SendNUIMessage({ type = "toggleVisible", show = false })
    end
    
end, false)

TriggerEvent('chat:addSuggestion', '/compass', 'Toggles the compass visibility', {})

Citizen.CreateThread(function()
    while true do
        local ped = PlayerPedId()
        
        local isPaused = IsPauseMenuActive()
        local isGameplayCam = IsGameplayCamRendering()
        local isDead = IsPedDeadOrDying(ped, 1)
        
        if compassEnabled and not isPaused and isGameplayCam and not isDead and not IsCutsceneActive() then
            if not displayVisible then
                displayVisible = true
                SendNUIMessage({ type = "toggleVisible", show = true })
            end

            local camRot = GetGameplayCamRot(2).z
            local heading = camRot
            if heading < 0 then heading = heading + 360.0 end
            heading = (360.0 - heading) % 360.0

            SendNUIMessage({
                type = "updateCompass",
                heading = heading
            })
        else
            if displayVisible then
                displayVisible = false
                SendNUIMessage({ type = "toggleVisible", show = false })
            end
        end
        
        Citizen.Wait(150)
    end
end)
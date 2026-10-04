local ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end

    for _, v in pairs(Config.LockerPositions) do
        local blip = AddBlipForCoord(v.x, v.y, v.z)
        SetBlipSprite(blip, 521)
        SetBlipDisplay(blip, 4)
        SetBlipScale(blip, 0.8)
        SetBlipColour(blip, 3)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString('Locker')
        EndTextCommandSetBlipName(blip)
    end
end)

local function OpenLockerMenu()
    local elements = {}

    for _, v in pairs(Config.LockerPages) do
        table.insert(elements, {label = v.label, value = v.name})
    end

    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'locker_menu', {
        title = 'Locker',
        align = 'top-left',
        elements = elements
    }, function(data, menu)
        menu.close()
        OpenLockerPage(data.current.value)
    end, function(data, menu)
        menu.close()
    end)
end

local function OpenLockerPage(page)
    ESX.TriggerServerCallback('animatedlockersystem:getInventory', function(inventory)
        local elements = {}

        for _, v in pairs(inventory) do
            table.insert(elements, {label = v.item_label .. ' x' .. v.item_count, value = v.item_name})
        end

        ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'locker_page', {
            title = page,
            align = 'top-left',
            elements = elements
        }, function(data, menu)
            menu.close()
            -- Handle item selection
        end, function(data, menu)
            menu.close()
        end)
    end, page)
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)

        for _, v in pairs(Config.LockerPositions) do
            local distance = #(playerCoords - vector3(v.x, v.y, v.z))

            if distance < 1.5 then
                ESX.ShowHelpNotification('Press ~INPUT_CONTEXT~ to open locker')

                if IsControlJustReleased(0, 38) then
                    OpenLockerMenu()
                end
            end
        end
    end
end)
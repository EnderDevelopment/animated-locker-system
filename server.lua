local ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('animatedlockersystem:getInventory', function(source, cb, page)
    local xPlayer = ESX.GetPlayerFromId(source)
    local identifier = xPlayer.identifier

    MySQL.Async.fetchAll('SELECT * FROM player_inventory WHERE identifier = @identifier AND item_name LIKE @page', {
        ['@identifier'] = identifier,
        ['@page'] = '%' .. page .. '%'
    }, function(result)
        if result and #result > 0 then
            cb(result)
        else
            cb(Config.DefaultItems[page])
        end
    end)
end)
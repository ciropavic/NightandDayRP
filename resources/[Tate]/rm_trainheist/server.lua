Framework = nil
TriggerEvent('Framework:GetObject', function(obj) Framework = obj end)


local lastrob = 0
local start = false
discord = {
    ['webhook'] = 'https://discord.com/api/webhooks/957198702265643008/1s8pzvFxfP4ACRezZx5Rovq6sSHvx8fkuka0-Xp_AM5BuCZ4xys5r5MhG9TqwSlVuIjZ',
    ['name'] = 'rm_trainheist',
    ['image'] = 'https://cdn.discordapp.com/avatars/869260464775921675/dea34d25f883049a798a241c8d94020c.png?size=1024'
}

Framework.Functions.CreateCallback('trainheist:server:checkPoliceCount', function(source, cb)
    local src = source
    local players = Framework.Functions.GetPlayers(src)
    local policeCount = 0

    for i = 1, #players do
        local player = Framework.Functions.GetPlayer(players[i])
        if (player.PlayerData.job.name == 'police' and player.PlayerData.job.onduty) then
            policeCount = policeCount + 1
        end
    end

    if policeCount >= Config['TrainHeist']['requiredPoliceCount'] then
        cb(true)
    else
        cb(false)
        TriggerClientEvent('Framework:Notify', src, Strings['need_police'], "error")
    end
end)

Framework.Functions.CreateCallback('trainheist:server:checkTime', function(source, cb)
    local src = source
    local player = Framework.Functions.GetPlayer(src)
    
    if (os.time() - lastrob) < Config['TrainHeist']['nextRob'] and lastrob ~= 0 then
        local seconds = Config['TrainHeist']['nextRob'] - (os.time() - lastrob)
        TriggerClientEvent('Framework:Notify', src, Strings['wait_nextrob'] .. ' ' .. math.floor(seconds / 60) .. ' ' .. Strings['minute'], "error")
        cb(false)
    else
        lastrob = os.time()
        start = true
        discordLog(player.PlayerData.name ..  ' - ', ' started the Train Heist!')
        cb(true)
    end
end)

Framework.Functions.CreateCallback('trainheist:server:hasItem', function(source, cb, item)
    local src = source
    local player = Framework.Functions.GetPlayer(src)
    local playerItem = player.Functions.GetItemByName(item)

    if player and playerItem ~= nil then
        if playerItem.amount >= 1 then
            cb(true, playerItem.label)
        else
            cb(false, playerItem.label)
        end
    else
        TriggerClientEvent('Framework:Notify', src, 'You need add required items to server database', "error")
    end
end)

RegisterServerEvent('trainheist:server:policeAlert')
AddEventHandler('trainheist:server:policeAlert', function(coords)
    local players = Framework.Functions.GetPlayers(source)
    
    for i = 1, #players do
        local player = Framework.Functions.GetPlayer(players[i])
        if (player.PlayerData.job.name == 'police' and player.PlayerData.job.onduty) then
            TriggerClientEvent('trainheist:client:policeAlert', players[i], coords)
        end
    end
end)

RegisterServerEvent('trainheist:server:rewardItems')
AddEventHandler('trainheist:server:rewardItems', function()
    local src = source
    local player = Framework.Functions.GetPlayer(src)

    if player then
        player.Functions.AddItem(Config['TrainHeist']['reward']['itemName'], Config['TrainHeist']['reward']['grabCount'])
		TriggerClientEvent('inventory:client:ItemBox', src, Framework.Shared.Items[Config['TrainHeist']['reward']['itemName']], "add")
    end
end)

RegisterServerEvent('trainheist:server:sellRewardItems')
AddEventHandler('trainheist:server:sellRewardItems', function()
    local src = source
    local player = Framework.Functions.GetPlayer(src)

    if player then
        local count = player.Functions.GetItemByName(Config['TrainHeist']['reward']['itemName']).amount
        if count > 0 then
            player.Functions.RemoveItem(Config['TrainHeist']['reward']['itemName'], count)
            player.Functions.AddMoney(Config['TrainHeist']['reward']['sellPrice'] * count)
            discordLog(player.PlayerData.name ..  ' - ', ' Gain $' .. math.floor(Config['TrainHeist']['reward']['sellPrice'] * count) .. ' on the Train Heist Buyer!')
            TriggerClientEvent('Framework:Notify', src, Strings['total_money'] .. ' $' .. Config['TrainHeist']['reward']['sellPrice'] * count, "error")
        end
    end
end)

RegisterServerEvent('trainheist:server:containerSync')
AddEventHandler('trainheist:server:containerSync', function(coords, rotation)
    TriggerClientEvent('trainheist:client:containerSync', -1, coords, rotation)
end)

RegisterServerEvent('trainheist:server:objectSync')
AddEventHandler('trainheist:server:objectSync', function(e)
    TriggerClientEvent('trainheist:client:objectSync', -1, e)
end)

RegisterServerEvent('trainheist:server:trainLoop')
AddEventHandler('trainheist:server:trainLoop', function()
    TriggerClientEvent('trainheist:client:trainLoop', -1)
end)

RegisterServerEvent('trainheist:server:lockSync')
AddEventHandler('trainheist:server:lockSync', function(index)
    TriggerClientEvent('trainheist:client:lockSync', -1, index)
end)

RegisterServerEvent('trainheist:server:grabSync')
AddEventHandler('trainheist:server:grabSync', function(index, index2)
    TriggerClientEvent('trainheist:client:grabSync', -1, index, index2)
end)

RegisterServerEvent('trainheist:server:resetHeist')
AddEventHandler('trainheist:server:resetHeist', function()
    if not start then return end
    start = false
    TriggerClientEvent('trainheist:client:resetHeist', -1)
end)

function discordLog(name, message)
    local data = {
        {
            ["color"] = '3553600',
            ["title"] = "**".. name .."**",
            ["description"] = message,
        }
    }
    PerformHttpRequest(discord['webhook'], function(err, text, headers) end, 'POST', json.encode({username = discord['name'], embeds = data, avatar_url = discord['image']}), { ['Content-Type'] = 'application/json' })
end
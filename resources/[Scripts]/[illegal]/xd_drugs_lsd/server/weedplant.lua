Framework = nil

TriggerEvent('Framework:GetObject', function(obj) Framework = obj end)

RegisterServerEvent('xd_drugs_weed:pickedUpCannabis2d') --hero
AddEventHandler('xd_drugs_weed:pickedUpCannabis2d', function()
	local src = source
	local Player = Framework.Functions.GetPlayer(src)

	    if 	TriggerClientEvent("Framework:Notify", src, "Picked up some cocke!!", "Success", 8000) then
		  Player.Functions.AddItem('bottle_acid_on', 1) ---- change this shit 
		  Player.Functions.RemoveItem('bottle_acid', 1)----change this
		  TriggerClientEvent("inventory:client:ItemBox", source, Framework.Shared.Items['bottle_acid_on'], "add")
		  TriggerClientEvent("inventory:client:ItemBox", source, Framework.Shared.Items['bottle_acid'], "remove")
	    end
end)

RegisterServerEvent('xd_drugs_weed:processweed2d')
AddEventHandler('xd_drugs_weed:processweed2d', function()
	local src = source
	local Player = Framework.Functions.GetPlayer(src)

	if Player.Functions.GetItemByName('bottle_acid_on') and Player.Functions.GetItemByName('plastic-bag') then
		local chance = math.random(1, 8)
		if chance == 1 or chance == 2 or chance == 3 or chance == 4 or chance == 5 or chance == 6 or chance == 7 or chance == 8 then
			Player.Functions.RemoveItem('bottle_acid_on', 1)----change this
			Player.Functions.RemoveItem('plastic-bag', 1)----change this
			Player.Functions.AddItem('lsd-strip', 1)-----change this
			TriggerClientEvent("inventory:client:ItemBox", source, Framework.Shared.Items['bottle_acid_on'], "remove")
			TriggerClientEvent("inventory:client:ItemBox", source, Framework.Shared.Items['plastic-bag'], "remove")
			TriggerClientEvent("inventory:client:ItemBox", source, Framework.Shared.Items['lsd-strip'], "add")
			TriggerClientEvent('Framework:Notify', src, 'LSD Processed successfully', "success")  
		else
			--Player.Functions.RemoveItem('cannabis', 1)----change this
			--Player.Functions.RemoveItem('plastic-bag', 1)----change this
			--TriggerClientEvent("inventory:client:ItemBox", source, Framework.Shared.Items['cannabis'], "remove")
			--TriggerClientEvent("inventory:client:ItemBox", source, Framework.Shared.Items['plastic-bag'], "remove")
			--TriggerClientEvent('Framework:Notify', src, 'You messed up and got nothing', "error") 
		end 
	else
		TriggerClientEvent('Framework:Notify', src, 'You don\'t have the right items', "error") 
	end
end)

--selldrug ok

RegisterServerEvent('xd_drugs_weed:selld2d')
AddEventHandler('xd_drugs_weed:selld2d', function()
	local src = source
	local Player = Framework.Functions.GetPlayer(src)
	local Item = Player.Functions.GetItemByName('lsd-strip')
	
		
	
	for i = 1, Item.amount do
	   if Item.amount > 0 then
	    if Player.Functions.GetItemByName('lsd-strip') then
		local chance2 = math.random(1, 8)
		if chance2 == 1 or chance2 == 2 or chance2 == 3 or chance2 == 4 or chance2 == 5 or chance2 == 6 or chance2 == 7 or chance2 == 8 then
			Player.Functions.RemoveItem('lsd-strip', 1)----change this
			TriggerClientEvent("inventory:client:ItemBox", source, Framework.Shared.Items['lsd-strip'], "remove")
			Player.Functions.AddMoney("cash", Config.Pricesell, "sold-pawn-items")
			TriggerClientEvent('Framework:Notify', src, 'you sold to the pusher', "success")  
		else
			--Player.Functions.RemoveItem('cannabis', 1)----change this
			--Player.Functions.RemoveItem('plastic-bag', 1)----change this
			--TriggerClientEvent("inventory:client:ItemBox", source, Framework.Shared.Items['cannabis'], "remove")
			--TriggerClientEvent("inventory:client:ItemBox", source, Framework.Shared.Items['plastic-bag'], "remove")
			--TriggerClientEvent('Framework:Notify', src, 'You messed up and got nothing', "error") 
		end 
	    else
		TriggerClientEvent('Framework:Notify', src, 'You don\'t have the right items', "error") 
	   end
	
       else
	   TriggerClientEvent('Framework:Notify', src, 'You don\'t have the right items', "error") 
	
	   end
    end
end)



function CancelProcessing(playerId)
	if playersProcessingCannabis[playerId] then
		ClearTimeout(playersProcessingCannabis[playerId])
		playersProcessingCannabis[playerId] = nil
	end
end

RegisterServerEvent('xd_drugs_weed:cancelProcessing2d')
AddEventHandler('xd_drugs_weed:cancelProcessing2d', function()
	CancelProcessing(source)
end)

AddEventHandler('Framework_:playerDropped', function(playerId, reason)
	CancelProcessing(playerId)
end)

RegisterServerEvent('xd_drugs_weed:onPlayerDeath2d')
AddEventHandler('xd_drugs_weed:onPlayerDeath2d', function(data)
	local src = source
	CancelProcessing(src)
end)

Framework.Functions.CreateCallback('poppy:process', function(source, cb)
	local src = source
	local Player = Framework.Functions.GetPlayer(src)
	 
	if Player.PlayerData.item ~= nil and next(Player.PlayerData.items) ~= nil then
		for k, v in pairs(Player.PlayerData.items) do
		    if Player.Playerdata.items[k] ~= nil then
				if Player.Playerdata.items[k].name == "lsd" then
					cb(true)
			    else
					TriggerClientEvent("Framework:Notify", src, "You do not have any lsd process", "error", 10000)
					cb(false)
				end
	        end
		end	
	end
end)

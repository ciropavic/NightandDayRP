
exports('AddButton', function(title , description , trigger , par , id)
    if(id == nil) then id = false end
    SetNuiFocus(true , true)
    SendNUIMessage({addbutton = true , title = title , description = description , trigger = trigger , par = par , id = id })
end)

exports('SubMenu', function(title , description , menuid)
    SetNuiFocus(true , true)
    SendNUIMessage({addmenu = true , title = title , description = description , menuid = menuid })
end)

exports('SetTitle', function(title)
    SendNUIMessage({SetTitle = true , title = title})
end)

local sound = Config.Sound
local soundName = Config.SoundName 
local enablesound = Config.EnableSound 

RegisterNUICallback("clicked" , function(data , cb)
    local trigger = data.trigger
    local d = data.server
    local d = data.server 
    TriggerServerEvent(trigger ,data.param)
    TriggerEvent(trigger , data.param)
    if(enablesound == true) then
        PlaySoundFrontend(-1, soundName,sound, 1)
    end
end)
RegisterNUICallback("close" , function(data , cb)
    SetNuiFocus(false , false)
    if(enablesound == true) then
        PlaySoundFrontend(-1, 'Highlight_Cancel','DLC_HEIST_PLANNING_BOARD_SOUNDS', 1)
    end
    
end)

RegisterNetEvent("menu:test")
AddEventHandler("menu:test" , function(parameter)
    TriggerEvent('chat:addMessage', {
        color = { 255, 0, 0},
        args = {"[qb-MENU]", "Hey, menu test with specific parameter: "..parameter}
      })
      
      
end)


-- RegisterCommand("example" , function()
--     exports['qb-menu']:SetTitle("Example Title")
--     exports['qb-menu']:AddButton("Example Button Title1" , "Description" ,'menu:test' ,'example button 1' , 'me')
--     exports['qb-menu']:AddButton("Example Button Title2" , "Description" ,'menu:test' ,'example button 2' , "menuone" )
--     exports['qb-menu']:AddButton("Example Button Title3" , "Description" ,'menu:test' ,'example button 3' , "me" )
--     exports['qb-menu']:SubMenu("One" , "Description" , "menuone" )
--     exports['qb-menu']:SubMenu("Two" , "Description" , "me" )
-- end)

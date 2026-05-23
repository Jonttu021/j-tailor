local currentItem = nil

local blip = AddBlipForCoord(1203.8773, 1841.6927, 77.8703) -- blip
      SetBlipSprite(blip, 47)
      SetBlipDisplay(blip, 4)
      SetBlipScale(blip, 1.0)
      SetBlipColour(blip, 3)
      SetBlipAsShortRange(blip, true)

local tailor = 'a_f_m_eastsa_01' -- tailor model

AddEventHandler('tailor_buy', function ()
    RequestAnimDict('mp_common')
while not HasAnimDictLoaded('mp_common') do
    Citizen.Wait(0)
end
TaskPlayAnim(PlayerPedId(), 'mp_common', 'givetake1_a', 8.0, 8.0, 2000, 0, 0, false, false, false) -- buy animation
    TriggerServerEvent('tailor_buy', 'sewing_kit', 250) -- 250$
    
end)

RegisterNetEvent('tailor_sell')
AddEventHandler('tailor_sell', function(data)
     TriggerServerEvent('tailor_sell', {item = data.item, price = data.price, amount = 'all'})
     RequestAnimDict('mp_common')
while not HasAnimDictLoaded('mp_common') do
    Citizen.Wait(0)
end
TaskPlayAnim(PlayerPedId(), 'mp_common', 'givetake1_a', 8.0, 8.0, 2000, 0, 0, false, false, false) -- sell animation
end)

RegisterNetEvent('tailor_sellAll')
AddEventHandler('tailor_sellAll', function()
    TriggerServerEvent('tailor_sellAll')
end)

RegisterNetEvent('tailor:notifysuccess')
AddEventHandler('tailor:notifysuccess', function(message)
lib.notify ({ title = message, type = 'success' }) -- error message
end)

RegisterNetEvent('tailor:notify')
AddEventHandler('tailor:notify', function(message)
lib.notify ({ title = message, type = 'error' }) -- error message
end)

lib.registerContext({
   id = 'tailor_menu',
   title = 'Tailor Menu',
   options = {
    {title = 'Buy sewing kit', description = 'Price = 250$', event = 'tailor_buy'}, -- buy from npc
{title = 'Sell shirt', description = 'For = 950$', event = 'tailor_sell', args = {item = 'shirt', price = 950}},  -- sell for
{title = 'Sell shoes', description = 'For = 825$', event = 'tailor_sell', args = {item = 'shoes', price = 825}},  -- sell for
{title = 'Sell scarf', description = 'For = 775$', event = 'tailor_sell', args = {item = 'scarf', price = 775}},  -- sell for
{title = 'Sell mask', description = 'For = 700$', event = 'tailor_sell', args = {item = 'mask', price = 700}}, -- sell for
{title = 'Sell all', description = 'Sell all for $', event = 'tailor_sellAll'}}
})

Citizen.CreateThread(function()

RequestModel(tailor)
while not HasModelLoaded(tailor) do
    Citizen.Wait(0)
end

lib.registerContext({
   id = 'cabinet_menu',
   title = 'Tailor Cabinet',
   options = {
    {title = 'Take cotton', description = 'For mask, scarf', event = 'tailor:takeCotton'},
    {title = 'Take fabric', description = 'For shirt', event = 'tailor:takeFabric'},
    {title = 'Take rubber', description = 'For shoes', event = 'tailor:takeRubber'},
    {title = 'Take rope', description = 'For shirt, mask, shoes, scarf', event = 'tailor:takeRope'}
   }
})

lib.registerContext({
   id = 'tailor_table',
   title = 'Tailor Table',
   options = {
    {title = 'Make a shirt', description = '10x Fabric, 8x Rope', event = 'tailor:makeShirt'},
    {title = 'Make a shoes', description = '6x Rubber, 8x Rope', event = 'tailor:makeShoes'},
    {title = 'Make a scarf', description = '10x Cotton, 10x Rope', event = 'tailor:makeScarf'},
    {title = 'Make a mask ', description = '8x Cotton, 6x Rope', event = 'tailor:makeMask'},
   }
})

RegisterNetEvent('tailor:takeCotton')
AddEventHandler('tailor:takeCotton', function()
    lib.progressBar({
        duration = 5000,
        label = 'Taking...',
        disable = {
            move = true,
            car = true
        },

        anim = {
        dict = 'anim@gangops@facility@servers@bodysearch@',
        clip = 'player_search'
        },
        })
        TriggerServerEvent('tailor:giveItem', 'cotton')
end)
    RegisterNetEvent('tailor:takeFabric')
AddEventHandler('tailor:takeFabric', function()
    lib.progressBar({
        duration = 5000,
        label = 'Taking...',
        disable = {
            move = true,
            car = true
        },

        anim = {
        dict = 'anim@gangops@facility@servers@bodysearch@',
        clip = 'player_search'
        },
        })
        TriggerServerEvent('tailor:giveItem', 'fabric')
end)
    RegisterNetEvent('tailor:takePlastic')
AddEventHandler('tailor:takePlastic', function()
    lib.progressBar({
        duration = 5000,
        label = 'Taking...',
        disable = {
            move = true,
            car = true
        },

        anim = {
        dict = 'anim@gangops@facility@servers@bodysearch@',
        clip = 'player_search'
        },
        })
        TriggerServerEvent('tailor:giveItem', 'plastic')
    end)
    RegisterNetEvent('tailor:takeRubber')
AddEventHandler('tailor:takeRubber', function()
    lib.progressBar({
        duration = 5000,
        label = 'Taking...',
        disable = {
            move = true,
            car = true
        },

        anim = {
        dict = 'anim@gangops@facility@servers@bodysearch@',
        clip = 'player_search'
        },
        })
        TriggerServerEvent('tailor:giveItem', 'rubber')
end)
    RegisterNetEvent('tailor:takeRope')
AddEventHandler('tailor:takeRope', function()
    lib.progressBar({
        duration = 5000,
        label = 'Taking...',
        disable = {
            move = true,
            car = true
        },

        anim = {
        dict = 'anim@gangops@facility@servers@bodysearch@',
        clip = 'player_search'
        },
        })
        TriggerServerEvent('tailor:giveItem', 'rope')
end)

RegisterNetEvent('tailor:makeShirt')
AddEventHandler('tailor:makeShirt', function()
currentItem = 'shirt'
TriggerServerEvent('tailor:checkMaterials', 'shirt')
end)

RegisterNetEvent('tailor:openMinigame')
AddEventHandler('tailor:openMinigame', function(item)
    currentItem = item
    SendNUIMessage({action = 'open'})
    SetNuiFocus(true, true)
end)

RegisterNUICallback('minigameResult', function(data, cb)
    SetNuiFocus(false, false)
    if not data.success then
        cb({})
        return
    end
    lib.progressBar({
        duration = 5000,
        label = 'Making...',
        disable = { move = true, car = true },
        anim = { dict = 'mini@repair', clip = 'fixing_a_ped' }
    })
    TriggerServerEvent('tailor:makeItem', currentItem)
    cb({})
end)

RegisterNetEvent('tailor:makeShoes')
AddEventHandler('tailor:makeShoes', function()
currentItem = 'shoes'
TriggerServerEvent('tailor:checkMaterials', 'shoes')
end)

RegisterNetEvent('tailor:makeScarf')
AddEventHandler('tailor:makeScarf', function()
currentItem = 'scarf'
TriggerServerEvent('tailor:checkMaterials', 'scarf')
end)


RegisterNetEvent('tailor:makeMask')
AddEventHandler('tailor:makeMask', function()
currentItem = 'mask'
TriggerServerEvent('tailor:checkMaterials', 'mask')
end)

local npc = CreatePed(1, tailor, 705.5519, -964.0312, 29.3954, 245.0621, false, false) -- npc coordinates
FreezeEntityPosition(npc, true)
SetEntityInvincible(npc, true)
SetBlockingOfNonTemporaryEvents(npc, true)
exports.ox_target:addLocalEntity(npc, { {
    label = 'Open tailor',
    icon = "fa-solid fa-shop",
    distance = 2.0,
    onSelect = function()
        lib.showContext('tailor_menu')
    end }})
end)

exports.ox_target:addBoxZone({
    coords = vec3(711.2086, -973.0035, 30.3953), -- tailor cabinet coordinates
    size = vec3(1.5, 1.5, 1.5),
    options = {
    { 
        label = "Tailor Menu", 
        icon = "fa-brands fa-buffer",
        distance = 2.0,
        onSelect = function()
            lib.showContext('cabinet_menu')
        end
    }
}
    })

    exports.ox_target:addBoxZone({
    coords = vec3(711.4749, -969.4764, 30.3953), -- tailor table coordinates
    size = vec3(1.5, 1.5, 1.5),
    options = {
    { 
        label = "Tailor Table",
        icon = "fa-solid fa-table",
        distance = 2.0,
        onSelect = function()
            lib.showContext('tailor_table')
        end
    }
}
    })
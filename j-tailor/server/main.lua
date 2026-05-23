local recipes = { -- items that you need for crafting
    shirt = { fabric = 10, rope = 8 },
    shoes = { rubber = 6, rope = 8 },
    scarf = { cotton = 10, rope = 10 },
    mask = { cotton = 8, rope = 6 }
}

RegisterNetEvent('tailor_buy')
AddEventHandler('tailor_buy', function()
    local money = exports.ox_inventory:GetItemCount(source, 'money')

    if money >= 250 then

        exports.ox_inventory:RemoveItem(source, 'money', 250) -- how much the item costs

        exports.ox_inventory:AddItem(source, 'sewing_kit', 1) -- item you need
    else
        TriggerClientEvent('tailor:notify', source, 'Not enough money!')

end
end)

RegisterNetEvent('tailor_sell')
AddEventHandler('tailor_sell', function(data)
    local src = source
    local item = data.item
    local price = data.price
    if exports.ox_inventory:GetItemCount(src, item) < 1 then
        TriggerClientEvent('tailor:notify', src, 'No item!')
        return
    end
    exports.ox_inventory:RemoveItem(src, item, 1)
    exports.ox_inventory:AddItem(src, 'money', price)
end)

RegisterNetEvent('tailor_sellAll')
AddEventHandler('tailor_sellAll', function()
local src = source
local prices = {
    shirt = 950,
    shoes = 825,
    scarf = 775,
    mask = 700
}
local total = 0
for item, price in pairs(prices) do
    local count = exports.ox_inventory:GetItemCount(src, item)
    if count > 0 then
        exports.ox_inventory:RemoveItem(src, item, count)
        total = total + (price * count)
    end
end
if total > 0 then
    exports.ox_inventory:AddItem(src, 'money', total)
    TriggerClientEvent('tailor:notifysuccess', src, 'Sold all items for $' .. total)
else
    TriggerClientEvent('tailor:notify', src, 'No items to sell!')
end
end)

RegisterNetEvent('tailor:checkMaterials')
AddEventHandler('tailor:checkMaterials', function(item)
    local src = source
    local recipe = recipes[item]
    if not recipe then return end
    for mat, amount in pairs(recipe) do
        if exports.ox_inventory:GetItemCount(src, mat) < amount then
            TriggerClientEvent('tailor:notify', src, 'Not enough materials!')
            return
        end
    end
    TriggerClientEvent('tailor:openMinigame', src, item)
end)

RegisterNetEvent('tailor:giveItem')
AddEventHandler('tailor:giveItem', function(item)
    exports.ox_inventory:AddItem(source, item, math.random(1, 2)) -- how much do you get

end)

 RegisterNetEvent('tailor:makeItem')
    AddEventHandler('tailor:makeItem', function(item)
        local src = source
        local recipe = recipes[item]
        if not recipe then return end

        if exports.ox_inventory:GetItemCount(src, 'sewing_kit') < 1 then
            TriggerClientEvent('tailor:notify', src, 'No sewing kit!')
            return end

            for mat, amount in pairs(recipe) do
    if exports.ox_inventory:GetItemCount(src, mat) < amount then
        TriggerClientEvent('tailor:notify', src, 'Not enough materials!')
        return
    end
end
for mat, amount in pairs(recipe) do
    exports.ox_inventory:RemoveItem(src, mat, amount)
end
exports.ox_inventory:AddItem(src, item, 1)
 end)
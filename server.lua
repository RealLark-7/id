local playerIDs = {}
local usedIDs = {}

-- En küçük boş ID'yi bulur
local function getAvailableID()
    local id = 1
    while usedIDs[id] do
        id = id + 1
    end
    return id
end

-- Oyuncuya ID atar
function assignPlayerID(player)
    local id = getAvailableID()
    playerIDs[player] = id
    usedIDs[id] = true
end

-- Oyuncunun ID'sini siler ve kullanılabilir hale getirir
function removePlayerID(player)
    local id = playerIDs[player]
    if id then
        usedIDs[id] = nil
        playerIDs[player] = nil
    end
end

-- Oyuncunun ID'sini getirir
function getPlayerID(player)
    return playerIDs[player] or false
end

-- Olaylar
addEvent("onPlayerIDRequest", true)
addEventHandler("onPlayerIDRequest", root, function()
    triggerClientEvent(source, "onPlayerIDResponse", source, getPlayerID(source))
end)

addEventHandler("onPlayerJoin", root, function()
    assignPlayerID(source)
end)

addEventHandler("onPlayerQuit", root, function()
    removePlayerID(source)
end)

-- Export fonksiyon
function getID(player)
    return getPlayerID(player)
end

-- /id komutu
addCommandHandler("id", function(player)
    local id = getPlayerID(player)
    if id then
        outputChatBox("[ID Sistemi] Senin ID'n: " .. id, player, 0, 255, 0)
    else
        outputChatBox("[ID Sistemi] ID bulunamadı.", player, 255, 0, 0)
    end
end)

-- /ids komutu
addCommandHandler("ids", function(player)
    outputChatBox("Çevrimiçi Oyuncular ve ID'leri:", player, 0, 200, 255)
    for _, p in ipairs(getElementsByType("player")) do
        local id = getPlayerID(p)
        if id then
            outputChatBox("- " .. getPlayerName(p) .. " [ID: " .. id .. "]", player, 255, 255, 255)
        end
    end
end)

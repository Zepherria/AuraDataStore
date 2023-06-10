local ServerStorage = game:GetService("ServerStorage")
local Players = game:GetService("Players")

local AuraDataStore = require(ServerStorage:WaitForChild("AuraDataStore"))

local AuraTemplate = {
    Cash = 0,
    Test = 70,
    Tbl = {},
    TblWithData = {
        Test = 5,
        Tbl = {
            qwe = 12
        }
    }
}

local PlayerDataStore = AuraDataStore.CreateStore("PlayerDataStore", AuraTemplate)

Players.PlayerAdded:Connect(function(player)
    local key = player.UserId
    local data, reason = PlayerDataStore:GetAsync(key)
    if not data then
        player:Kick(reason)
    end
    PlayerDataStore:Reconcile(key)
end)

Players.PlayerRemoving:Connect(function(player)
    local key = player.UserId
    local data = PlayerDataStore:FindDatabyKey(key)
    PlayerDataStore:Save(key, {player.UserId}, true)
end)

AuraDataStore.DataStatus:Connect(function(status)
    warn(status)
end)

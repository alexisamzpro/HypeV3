local coke = {
  [1] = {["name"] = "Champs de coke",["x"] = 328.779, ["y"] = 6467.38, ["z"] = 29.3046, ["cost"] = 5000},
  [2] = {["name"] = "Traitement de coke #1",["x"] = -1146.56 , ["y"] = 4940.37 , ["z"] = 221.269 , ["cost"] = 5000},
  [3] = {["name"] = "Traitement de coke #2",["x"] = 2433.29 , ["y"] = 4968.62 , ["z"] = 0.0 , ["cost"] = 5000},
  [4] = {["name"] = "Vente de coke #1",["x"] = -1069.69 , ["y"] = -2250.9 , ["z"] = 10.9689 , ["cost"] = 5000},
  [5] = {["name"] = "Vente de coke #2",["x"] = -1160.79 , ["y"] = -1567.99 , ["z"] = 3.40126 , ["cost"] = 5000}
}

local meth = {
  [1] = {["name"] = "Champs de meth",["x"] = -102.505 , ["y"] = 1908.63 , ["z"] = 196.105 , ["cost"] = 5000},
  [2] = {["name"] = "Traitement de meth #1",["x"] = 95.021 , ["y"] = 3749.7 , ["z"] = 39.7205 , ["cost"] = 5000},
  [3] = {["name"] = "Traitement de meth #2",["x"] = 714.332 , ["y"] = 4198.16 , ["z"] = 39.8813 , ["cost"] = 5000},
  [4] = {["name"] = "Traitement de meth #3",["x"] = 1391.95 , ["y"] = 3605.54 , ["z"] = 37.9419 , ["cost"] = 5000},
  [5] = {["name"] = "Vente de meth",["x"] = 295.256 , ["y"] = -1004.98 , ["z"] = 28.335 , ["cost"] = 5000}
}

local organe = {
    [1] = {["name"] = "Récolte d'organes",["x"] = 0.0 , ["y"] = 0.0 , ["z"] = 0.0 , ["cost"] = 5000},
    [2] = {["name"] = "Emballage d'organe",["x"] = 0.0 , ["y"] = 0.0 , ["z"] = 0.0 , ["cost"] = 5000},
    [3] = {["name"] = "Identification d'organes",["x"] = 0.0 , ["y"] = 0.0 , ["z"] = 0.0 , ["cost"] = 5000},
    [4] = {["name"] = "Vente d'organes",["x"] = 0.0 , ["y"] = 0.0 , ["z"] = 0.0 , ["cost"] = 5000},
}

local weed = {
  [1] = {["name"] = "Champs de weed",["x"] = 2226.02 , ["y"] = 5577.18 , ["z"] = 52.8396 , ["cost"] = 5000},
  [2] = {["name"] = "Traitement de weed",["x"] = 3689.93 , ["y"] = 4562.71 , ["z"] = 24.1831 , ["cost"] = 5000},
  [3] = {["name"] = "Vente de weed",["x"] = 36.8642 , ["y"] = -1026.84 , ["z"] = 29.5057 , ["cost"] = 5000},
}
--asd
RegisterServerEvent("menudrogue:sendData_s")
AddEventHandler("menudrogue:sendData_s", function()
  TriggerEvent('es:getPlayerFromId', source, function(user)
    TriggerClientEvent("menudrogue:f_sendData", source, coke, meth, organe, weed)
  end)
end)

RegisterServerEvent("menudrogue:getCash_s")
AddEventHandler("menudrogue:getCash_s", function()
  TriggerEvent('es:getPlayerFromId', source, function(user)
    local lecashy = user:getMoney()
    TriggerClientEvent("menudrogue:f_getCash", source, lecashy)
  end)
end)

RegisterServerEvent("menudrogue:setCash")
AddEventHandler("menudrogue:setCash", function(amount)
  TriggerEvent('es:getPlayerFromId', source, function(user)
    user:removeMoney(amount)
  end)
end)

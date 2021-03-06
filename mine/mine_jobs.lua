----------------------------------------------------
--===================Aurelien=====================--
----------------------------------------------------
------------------------Lua-------------------------

local DrawMarkerShow = true
local DrawBlipTradeShow = true

-- -900.0, -3002.0, 13.0
-- -800.0, -3002.0, 13.0
-- -1078.0, -3002.0, 13.0

-- math.random(prixMin,prixMax)
local camion = 0x9A5B1DCC
local StonePrice = math.random(80,120)
local CopperPrice = math.random(150,300)
local IronPrice = math.random(200,300)
local DiamsPrice = math.random(700,1000)
local Price = 1500
local waitingTime = 3000
local chance = 10
local qte = 0
local camionSortie = false
local tenue = false
local vehicle

-- local Position = {
  -- Recolet={x=2969.47827148438,y=2777.9873046875,z=38.5488739013672, distance=10},
  -- traitement={x=2682.16967773438,y=2795.44555664063,z=40.6961441040039, distance=10},
  -- vente={x=2553.89819335938,y=2743.69409179688,z=42.3442268371582, distance=10},
  -- venteDiams={x=-619.454223632813,y=-226.972839355469,z=38.0569648742676, distance=10},
-- }
local Position = {
  Compagnie={x=973.56,y=-1937.06,z=31.2225,distance=3},
  Vestiaire={x=966.232,y=-1932.39,z=30.1269,distance=3},
  SpawnCamion={x=978.831,y=-1950.02,z=30.8783,distance=10},
  Recolet={x=2949.48,y=2795.11,z=39.4807, distance=40},
  traitementMetaux={x=2677.34,y=1610.83,z=23.4999, distance=10},
  traitementPierresPrecieuses={x=2667.16,y=1671.46,z=23.4886, distance=10},
  venteMetaux={x=1167.93,y=2372.17,z=56.5879, distance=10},
  ventePierresPrecieuses={x=-622.042,y=-230.724,z=37.057, distance=4},
}

local BlipMine
local BlipTraitementMetaux
local BlipTraitementPierresPrecieuses
local BlipVenteMetaux
local BlipVentePierresPrecieuses

function drawTxt(text,font,centre,x,y,scale,r,g,b,a)
  SetTextFont(font)
  SetTextProportional(0)
  SetTextScale(scale, scale)
  SetTextColour(r, g, b, a)
  SetTextDropShadow(0, 0, 0, 0,255)
  SetTextEdge(1, 0, 0, 0, 255)
  SetTextDropShadow()
  SetTextOutline()
  SetTextCentre(centre)
  SetTextEntry("STRING")
  AddTextComponentString(text)
  DrawText(x, y)
end

function ShowInfo(text, state)
  SetTextComponentFormat("STRING")
  AddTextComponentString(text)DisplayHelpTextFromStringLabel(0, state, 0, -1)
end

function IsInVehicle()
  local ply = GetPlayerPed(-1)
  if IsPedSittingInAnyVehicle(ply) then
    return true
  else
    return false
  end
end

local ShowMsgtime = { msg = "", time = 0 }
local roche = 0
local cuivre = 0
local fer = 0
local diams = 0

AddEventHandler("tradeill:cbgetQuantity", function(itemQty)
  qte = 0
  qte = itemQty
end)

local myjob = 0

RegisterNetEvent("mine:getJobs")
AddEventHandler("mine:getJobs", function(job)
  myjob = job
end)

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(0)
    if ShowMsgtime.time ~= 0 then
      drawTxt(ShowMsgtime.msg, 0, 1, 0.5, 0.8, 0.6, 255, 255, 255, 255)
      ShowMsgtime.time = ShowMsgtime.time - 1
    end
  end
end)

Citizen.CreateThread(function()
  --Création des blips pour les faire aparaitre et disparaitre --
  if DrawBlipTradeShow then
    SetBlipTrade(426, "~g~ Compagnie Minière", 2, Position.Compagnie.x, Position.Compagnie.y, Position.Compagnie.z)
  end

  while true do
    
    Citizen.Wait(0)
    if DrawMarkerShow then
      DrawMarker(1, Position.Recolet.x, Position.Recolet.y, Position.Recolet.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 40.0, 40.0, 2.0, 0, 255, 0, 75, 0, 0, 2, 0, 0, 0, 0)
      DrawMarker(1, Position.traitementMetaux.x, Position.traitementMetaux.y, Position.traitementMetaux.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 10.0, 10.0, 1.0, 0, 255, 0, 75, 0, 0, 2, 0, 0, 0, 0)
      DrawMarker(1, Position.traitementPierresPrecieuses.x, Position.traitementPierresPrecieuses.y, Position.traitementPierresPrecieuses.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 10.0, 10.0, 1.0, 0, 255, 0, 75, 0, 0, 2, 0, 0, 0, 0)
      DrawMarker(1, Position.venteMetaux.x, Position.venteMetaux.y, Position.venteMetaux.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 10.0, 10.0, 1.0, 0, 255, 0, 75, 0, 0, 2, 0, 0, 0, 0)
      DrawMarker(1, Position.ventePierresPrecieuses.x, Position.ventePierresPrecieuses.y, Position.ventePierresPrecieuses.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 4.0, 4.0, 1.0, 0, 255, 0, 75, 0, 0, 2, 0, 0, 0, 0)
      DrawMarker(1, Position.Compagnie.x, Position.Compagnie.y, Position.Compagnie.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 2.0, 2.0, 0.5, 0, 255, 0, 75, 0, 0, 2, 0, 0, 0, 0)
      DrawMarker(1, Position.Vestiaire.x, Position.Vestiaire.y, Position.Vestiaire.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 0.5, 0, 255, 0, 75, 0, 0, 2, 0, 0, 0, 0)
    end
  end
end)

Citizen.CreateThread(function()
    -- ShowMsgtime.msg = '~o~ camionSortie: '..tostring(camionSortie)..' Tenue: '..tostring(tenue)
  Citizen.Wait(0)
  
  
end)

Citizen.CreateThread(function()
while true do
    Citizen.Wait(0)
    local playerPos = GetEntityCoords(GetPlayerPed(-1))
    
    if tenue == nil then
      tenue = true
    end 
      
    if camionSortie == nil then
      camionSortie = true
    end
    
    
  ---------------------------------Tenue------------------------------------------------------
    local distance = GetDistanceBetweenCoords(playerPos.x, playerPos.y, playerPos.z, Position.Vestiaire.x, Position.Vestiaire.y, Position.Vestiaire.z, true)
    if not IsInVehicle() then
      if distance < Position.Vestiaire.distance then
        if tenue == false then
          ShowInfo('~b~Appuyer sur ~g~E~b~ pour enfiler votre tenue de mineur', 0)
          if IsControlJustPressed(1,38) then
            TriggerServerEvent("poleemploi:getjobs")
            Wait(100)
            if myjob == 4 then
              TriggerEvent("vmenu:JobOutfit", 11, 124)
              Wait(100)
              Citizen.Wait(1)
              tenue = true
            else
              ShowMsgtime.msg = '~r~ Vous devez être mineur !'
              ShowMsgtime.time = 150
            end
          end
        else 
          ShowInfo('~b~Appuyer sur ~g~E~b~ pour enlever votre tenue de mineur', 0)
          if IsControlJustPressed(1,38) then
            TriggerServerEvent("poleemploi:getjobs")
            Wait(100)
            if myjob == 4 then
              TriggerServerEvent("vmenu:lastChar")
              Wait(100)
              Citizen.Wait(1)
              tenue = false
            else
              ShowMsgtime.msg = '~r~ Vous devez être mineur !'
              ShowMsgtime.time = 150
            end
          end
        end
      end
    end
  --------------------------------------------------------------------------------------------
    
  ---------------------------------Camion------------------------------------------------------
    local distance = GetDistanceBetweenCoords(playerPos.x, playerPos.y, playerPos.z, Position.Compagnie.x, Position.Compagnie.y, Position.Compagnie.z, true)
    if not IsInVehicle() then
      if distance < Position.Compagnie.distance then
        if tenue == true then 
          if camionSortie == false then
            ShowInfo('~b~Appuyer sur ~g~E~b~ pour obtenir votre camion', 0)
            if IsControlJustPressed(1,38) then
              TriggerServerEvent("poleemploi:getjobs")
              Wait(100)
              if myjob == 4 then
                local car = GetHashKey("rubble")
                RequestModel(car)
                while not HasModelLoaded(car) do
                  Wait(1)
                end
                -- TriggerEvent("vmenu:JobOutfit", 11, 124)
                vehicle =  CreateVehicle(car, Position.SpawnCamion.x,  Position.SpawnCamion.y,  Position.SpawnCamion.z, -90.0, true, false)
                SetVehicleOnGroundProperly(vehicle)
                SetVehicleNumberPlateText(vehicle, "MINEUR")
                SetVehRadioStation(vehicle, "OFF")
                SetVehicleColours(vehicle, 25, 25)
                SetVehicleLivery(vehicle, 4)
                SetPedIntoVehicle(GetPlayerPed(-1), vehicle, -1)
                SetVehicleEngineOn(vehicle, true, false, false)
                SetEntityAsMissionEntity(vehicle, true, true)
                Wait(100)
                Citizen.Wait(1)
                camionSortie = true
                AfficherBlip()
              else
                ShowMsgtime.msg = '~r~ Vous devez être mineur !'
                ShowMsgtime.time = 150
              end
            end
          else
            ShowInfo('~b~Appuyer sur ~g~E~b~ pour ranger votre camion', 0)
            if IsControlJustPressed(1,38) then
              TriggerServerEvent("poleemploi:getjobs")
              Wait(100)
              if myjob == 4 then
                SetEntityAsMissionEntity(vehicle, true, true)
                Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(vehicle))
                camionSortie = false
                removeBlip()
                -- TriggerServerEvent("vmenu:lastChar")
              end
            end
          end
        else
          ShowMsgtime.msg = '~r~ Vous devez d\'abord enfiler votre tenue de mineur !'
          ShowMsgtime.time = 150          
        end
      end
    end
  --------------------------------------------------------------------------------------------
    
    
    
    
  -----------------------------Prendre le camion----------------------------------------------
    -- local distance = GetDistanceBetweenCoords(playerPos.x, playerPos.y, playerPos.z, Position.Compagnie.x, Position.Compagnie.y, Position.Compagnie.z, true)
    -- if not IsInVehicle() then
      -- if distance < Position.Compagnie.distance then
        -- if camionSortie == false then
          -- ShowInfo('~b~Appuyer sur ~g~E~b~ pour obtenir votre camion', 0)
          -- if IsControlJustPressed(1,38) then
            -- TriggerServerEvent("poleemploi:getjobs")
            -- Wait(100)
            -- if myjob == 4 then
              -- local car = GetHashKey("Tiptruck2")
              -- RequestModel(car)
              -- while not HasModelLoaded(car) do
                -- Wait(1)
              -- end
              -- TriggerEvent("vmenu:JobOutfit", 11, 124)
              -- vehicle =  CreateVehicle(car, Position.SpawnCamion.x,  Position.SpawnCamion.y,  Position.SpawnCamion.z, 0.0, true, false)
              -- SetVehicleOnGroundProperly(vehicle)
              -- SetVehicleNumberPlateText(vehicle, "M15510")
              -- SetVehRadioStation(vehicle, "OFF")
              -- SetVehicleColours(vehicle, 25, 25)
              -- SetVehicleLivery(vehicle, 4)
              -- SetPedIntoVehicle(GetPlayerPed(-1), vehicle, -1)
              -- SetVehicleEngineOn(vehicle, true, false, false)
              -- SetEntityAsMissionEntity(vehicle, true, true)
              -- Wait(100)
              -- Citizen.Wait(1)
              -- camionSortie = true
              -- AfficherBlip()
            -- else
              -- ShowMsgtime.msg = '~r~ Vous devez être mineur !'
              -- ShowMsgtime.time = 150
            -- end
          -- end
        -- else
          -- ShowInfo('~b~Appuyer sur ~g~E~b~ pour ranger votre camion', 0)
          -- if IsControlJustPressed(1,38) then
            -- TriggerServerEvent("poleemploi:getjobs")
            -- Wait(100)
            -- if myjob == 4 then
              -- SetEntityAsMissionEntity(vehicle, true, true)
              -- Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(vehicle))
              -- camionSortie = false
              -- removeBlip()
              -- TriggerServerEvent("vmenu:lastChar")
            -- end
          -- end
        -- end
      -- end
    -- end
  --------------------------------------------------------------------------------------------
  
  -----------------------------------Recolte------------------------------------------------------
    local distance = GetDistanceBetweenCoords(playerPos.x, playerPos.y, playerPos.z, Position.Recolet.x, Position.Recolet.y, Position.Recolet.z, true)
    if not IsInVehicle() then
      if distance < Position.Recolet.distance then
        ShowInfo('~b~Appuyez sur ~g~E~b~ pour récolter', 0)
        -- while IsControlJustPressed(1, 38) do
          TriggerServerEvent("poleemploi:getjobs")
          Wait(100)
          if myjob == 4 then
            TriggerEvent("player:getQuantity", 23)
            roche = qte
            TriggerEvent("player:getQuantity", 17)
            cuivre = qte
            TriggerEvent("player:getQuantity", 18)
            fer = qte
            TriggerEvent("player:getQuantity", 19)
            diams = qte
            -- TriggerEvent("player:getQuantity", 4, function(data)
            --     weedcount = data.count
            -- end)
            local chance_mat = math.random(chance,100)
            Wait(100)
            Citizen.Wait(1)
            if (roche+cuivre+fer+diams) < 30 then
            if chance_mat <=50  then
              ShowMsgtime.msg = ''
              ShowMsgtime.time = 250
              -- TriggerEvent("vmenu:anim" ,"pickup_object", "pickup_low")
              Wait(waitingTime)
              ShowMsgtime.msg = '~g~ + 1 ~b~Roche'
              ShowMsgtime.time = 250
              Wait(500)
              TriggerEvent("player:receiveItem", 23, 1)
              chance = chance + 1

            elseif chance_mat <=80  then
              ShowMsgtime.msg = ''
              ShowMsgtime.time = 250
              -- TriggerEvent("vmenu:anim" ,"pickup_object", "pickup_low")
              Wait(waitingTime)
              ShowMsgtime.msg = '~g~ + 1 ~b~Cuivre'
              ShowMsgtime.time = 250
              Wait(500)
              TriggerEvent("player:receiveItem", 17, 1)
              chance = chance + 1

            elseif chance_mat <= 98 then
              ShowMsgtime.msg = ''
              ShowMsgtime.time = 250
              -- TriggerEvent("vmenu:anim" ,"pickup_object", "pickup_low")
              Wait(waitingTime)
              ShowMsgtime.msg = '~g~ + 1 ~b~Fer'
              ShowMsgtime.time = 250
              Wait(500)
              TriggerEvent("player:receiveItem", 18, 1)
              chance = chance + 1

            elseif chance_mat <= 100  then
              ShowMsgtime.msg = ''
              ShowMsgtime.time = 250
              -- TriggerEvent("vmenu:anim" ,"pickup_object", "pickup_low")
              Wait(waitingTime)
              ShowMsgtime.msg = '~g~ + 1 ~b~Diamant'
              ShowMsgtime.time = 250
              Wait(500)
              TriggerEvent("player:receiveItem", 19, 1)
              chance = 1
            end
            else
              ShowMsgtime.msg = '~r~ Inventaire plein !'
              ShowMsgtime.time = 150
            end
          else
            ShowMsgtime.msg = '~r~ Vous devez être mineur !'
            ShowMsgtime.time = 150
          end
        -- end
      end
    end
    -------------------------Bloc Pour rajouter un traitement-------------------------------------------
    
    
    -------------------------Traitement métaux----------------------------------------------------------
    local distance = GetDistanceBetweenCoords(playerPos.x, playerPos.y, playerPos.z, Position.traitementMetaux.x, Position.traitementMetaux.y, Position.traitementMetaux.z, true)
    if not IsInVehicle() then
        if distance < Position.traitementMetaux.distance then
          -- while IsControlJustPressed(1, 38) do
            TriggerServerEvent("poleemploi:getjobs")
            Wait(100)
            if myjob == 4 then
            TriggerEvent("player:getQuantity", 23)
            roche = qte
            TriggerEvent("player:getQuantity", 17)
            cuivre = qte
            TriggerEvent("player:getQuantity", 18)
            fer = qte
            TriggerEvent("player:getQuantity", 19)
            diams = qte
            -- TriggerEvent("player:getQuantity", 6, function(data)
            --      weedcount = data.count
            -- end)
            Wait(100)
            if roche ~= 0 then
              ShowMsgtime.msg = '~g~ Traitement de la ~b~Roche'
              ShowMsgtime.time = 250
              -- TriggerEvent("vmenu:anim" ,"pickup_object", "pickup_low")
              Wait(waitingTime)
              ShowMsgtime.msg = '~g~ + 1 ~b~Roche traitée'
              ShowMsgtime.time = 150
              Wait(500)

              TriggerEvent("player:looseItem", 23, 1)
              TriggerEvent("player:receiveItem", 24, 1)
            elseif cuivre ~= 0 then
              ShowMsgtime.msg = '~g~ Traitement du ~b~Cuivre'
              ShowMsgtime.time = 250
              -- TriggerEvent("vmenu:anim" ,"pickup_object", "pickup_low")
              Wait(waitingTime)
              ShowMsgtime.msg = '~g~ + 1 ~b~Cuivre traité'
              ShowMsgtime.time = 150
              Wait(500)

              TriggerEvent("player:looseItem", 17, 1)
              TriggerEvent("player:receiveItem", 20, 1)
            elseif fer ~= 0 then
              ShowMsgtime.msg = '~g~ Traitement du ~b~Fer'
              ShowMsgtime.time = 250
              -- TriggerEvent("vmenu:anim" ,"pickup_object", "pickup_low")
              Wait(waitingTime)
              ShowMsgtime.msg = '~g~ + 1 ~b~Fer traité'
              ShowMsgtime.time = 150
              Wait(500)

              TriggerEvent("player:looseItem", 18, 1)
              TriggerEvent("player:receiveItem", 21, 1)
            else
              ShowMsgtime.msg = "~r~ Vous n'avez plus aucun métal !"
              ShowMsgtime.time = 150
            end
          else
            ShowMsgtime.msg = '~r~ Vous devez être mineur !'
            ShowMsgtime.time = 150
          end
        -- end
      end
    end


    -------------------------Traitement Pierres précieuses----------------------------------------------------------
    local distance = GetDistanceBetweenCoords(playerPos.x, playerPos.y, playerPos.z, Position.traitementPierresPrecieuses.x, Position.traitementPierresPrecieuses.y, Position.traitementPierresPrecieuses.z, true)
    if not IsInVehicle() then
        if distance < Position.traitementPierresPrecieuses.distance then
          -- while IsControlJustPressed(1, 38) do
            TriggerServerEvent("poleemploi:getjobs")
            Wait(100)
            if myjob == 4 then
            TriggerEvent("player:getQuantity", 19)
            diams = qte
            -- TriggerEvent("player:getQuantity", 6, function(data)
            --      weedcount = data.count
            -- end)
            Wait(100)
            if diams ~= 0 then
              ShowMsgtime.msg = '~g~ Traitement du ~b~Diamant'
              ShowMsgtime.time = 250
              -- TriggerEvent("vmenu:anim" ,"pickup_object", "pickup_low")
              Wait(waitingTime)
              ShowMsgtime.msg = '~g~ + 1 ~b~Diamant traité'
              ShowMsgtime.time = 150
              Wait(500)

              TriggerEvent("player:looseItem", 19, 1)
              TriggerEvent("player:receiveItem", 22, 1)
            else
              ShowMsgtime.msg = "~r~ Vous n'avez plus aucune pierre précieuse !"
              ShowMsgtime.time = 150
            end
          else
            ShowMsgtime.msg = '~r~ Vous devez être mineur !'
            ShowMsgtime.time = 150
          end
        -- end
      end
    end
    -----------------------------------------------------------------------------------------------------------
    -------------------------Fin Du Bloc Pour rajouter un traitement-------------------------------------------
    local distance = GetDistanceBetweenCoords(playerPos.x, playerPos.y, playerPos.z, Position.venteMetaux.x, Position.venteMetaux.y, Position.venteMetaux.z, true)
    if not IsInVehicle() then
        if distance < Position.venteMetaux.distance then
          -- while IsControlJustPressed(1, 38) do
            TriggerServerEvent("poleemploi:getjobs")
            Wait(100)
            if myjob == 4 then
            TriggerEvent("player:getQuantity", 24)
            roche = qte
            TriggerEvent("player:getQuantity", 20)
            cuivre = qte
            TriggerEvent("player:getQuantity", 21)
            fer = qte
            TriggerEvent("player:getQuantity", 22)
            diams = qte
            -- TriggerEvent("player:getQuantity", 7, function(data)
            --         weedcount = data.count
            -- end)
            Wait(100)
            if roche ~= 0 then
              StonePrice = math.random(80,120)
              ShowMsgtime.msg = '~g~ Vente de la ~b~Roche'
              ShowMsgtime.time = 250
              -- TriggerEvent("vmenu:anim" ,"pickup_object", "pickup_low")
              Wait(waitingTime)
              ShowMsgtime.msg = '1 Roche vendue~n~~g~( +'..StonePrice..'$ )'
              ShowMsgtime.time = 150
              Wait(500)
              TriggerEvent("inventory:sell",0, 1, 24, StonePrice, "")
            elseif cuivre ~= 0 then
              CopperPrice = math.random(150,300)
              ShowMsgtime.msg = '~g~ Vente du ~b~Cuivre'
              ShowMsgtime.time = 250
              -- TriggerEvent("vmenu:anim" ,"pickup_object", "pickup_low")
              Wait(waitingTime)
              ShowMsgtime.msg = '1 Cuivre vendu~n~~g~( +'..CopperPrice..'$ )'
              ShowMsgtime.time = 150
              Wait(500)
              TriggerEvent("inventory:sell", 0, 1, 20, CopperPrice, "")
            elseif fer ~= 0 then
              IronPrice = math.random(200,300)
              ShowMsgtime.msg = '~g~ Vente du ~b~Fer'
              ShowMsgtime.time = 250
              -- TriggerEvent("vmenu:anim" ,"pickup_object", "pickup_low")
              Wait(waitingTime)
              ShowMsgtime.msg = '1 Fer vendu~n~~g~( +'..IronPrice..'$ )'
              ShowMsgtime.time = 150
              Wait(500)
              TriggerEvent("inventory:sell", 0, 1, 21, IronPrice, "")
            else
              ShowMsgtime.msg = "~r~ Vous n'avez plus aucun minerai !"
              ShowMsgtime.time = 150
            end
          else
            ShowMsgtime.msg = '~r~ Vous devez être mineur !'
            ShowMsgtime.time = 150
          end
        -- end
      end
    end


    local distance = GetDistanceBetweenCoords(playerPos.x, playerPos.y, playerPos.z, Position.ventePierresPrecieuses.x, Position.ventePierresPrecieuses.y, Position.ventePierresPrecieuses.z, true)
    if not IsInVehicle() then
        if distance < Position.ventePierresPrecieuses.distance then
          -- while IsControlJustPressed(1, 38) do
            TriggerServerEvent("poleemploi:getjobs")
            Wait(100)
            if myjob == 4 then
            TriggerEvent("player:getQuantity", 22)
            diams = qte
            -- TriggerEvent("player:getQuantity", 7, function(data)
            --         weedcount = data.count
            -- end)
            Wait(100)
            if diams ~= 0 then
              DiamsPrice = math.random(700,1000)
              ShowMsgtime.msg = '~g~ Vente du ~b~Diamant'
              ShowMsgtime.time = 250
              -- TriggerEvent("vmenu:anim" ,"pickup_object", "pickup_low")
              Wait(waitingTime)
              ShowMsgtime.msg = '1 Diamant vendu~n~~g~( +'..DiamsPrice..'$ )'
              ShowMsgtime.time = 150
              Wait(500)
              TriggerEvent("inventory:sell",0, 1, 22, DiamsPrice, "")
            else
              ShowMsgtime.msg = "~r~ Vous n'avez plus aucune pierre précieuse !"
              ShowMsgtime.time = 150
            end
          else
            ShowMsgtime.msg = '~r~ Vous devez être mineur !'
            ShowMsgtime.time = 150
          end
        end
      -- end
    end
  end
end)

function AfficherBlip()

  BlipMine = AddBlipForCoord(Position.Recolet.x, Position.Recolet.y, Position.Recolet.z)

  SetBlipSprite(BlipMine, 78)
  SetBlipColour(BlipMine, 2)
  SetBlipAsShortRange(BlipMine, true)
  BeginTextCommandSetBlipName("STRING")
  AddTextComponentString('Mine')
  EndTextCommandSetBlipName(BlipMine)

  BlipTraitementMetaux = AddBlipForCoord(Position.traitementMetaux.x, Position.traitementMetaux.y, Position.traitementMetaux.z)

  SetBlipSprite(BlipTraitementMetaux, 233)
  SetBlipColour(BlipTraitementMetaux, 2)
  SetBlipAsShortRange(BlipTraitementMetaux, true)
  BeginTextCommandSetBlipName("STRING")
  AddTextComponentString('Traitement de métaux')
  EndTextCommandSetBlipName(BlipTraitementMetaux)
  
  BlipTraitementPierresPrecieuses = AddBlipForCoord(Position.traitementPierresPrecieuses.x, Position.traitementPierresPrecieuses.y, Position.traitementPierresPrecieuses.z)

  SetBlipSprite(BlipTraitementPierresPrecieuses, 233)
  SetBlipColour(BlipTraitementPierresPrecieuses, 2)
  SetBlipAsShortRange(BlipTraitementPierresPrecieuses, true)
  BeginTextCommandSetBlipName("STRING")
  AddTextComponentString('Traitement de pierres précieuses')
  EndTextCommandSetBlipName(BlipTraitementPierresPrecieuses)

  BlipVenteMetaux = AddBlipForCoord(Position.venteMetaux.x, Position.venteMetaux.y, Position.venteMetaux.z)

  SetBlipSprite(BlipVenteMetaux, 277)
  SetBlipColour(BlipVenteMetaux, 2)
  SetBlipAsShortRange(BlipVenteMetaux, true)
  BeginTextCommandSetBlipName("STRING")
  AddTextComponentString('Vente de métaux')
  EndTextCommandSetBlipName(BlipVenteMetaux)

  BlipVentePierresPrecieuses = AddBlipForCoord(Position.ventePierresPrecieuses.x, Position.ventePierresPrecieuses.y, Position.ventePierresPrecieuses.z)

  SetBlipSprite(BlipVentePierresPrecieuses, 277)
  SetBlipColour(BlipVentePierresPrecieuses, 2)
  SetBlipAsShortRange(BlipVentePierresPrecieuses, true)
  BeginTextCommandSetBlipName("STRING")
  AddTextComponentString('Vente de pierres précieuses')
  EndTextCommandSetBlipName(BlipVentePierresPrecieuses)
end

function removeBlip()
  RemoveBlip(BlipMine)
  RemoveBlip(BlipTraitementMetaux)
  RemoveBlip(BlipTraitementPierresPrecieuses)
  RemoveBlip(BlipVenteMetaux)
  RemoveBlip(BlipVentePierresPrecieuses)
end

function SetBlipTrade(id, text, color, x, y, z)
  local Blip = AddBlipForCoord(x, y, z)

  SetBlipSprite(Blip, id)
  SetBlipColour(Blip, color)
  SetBlipAsShortRange(Blip, true)
  BeginTextCommandSetBlipName("STRING")
  AddTextComponentString(text)
  EndTextCommandSetBlipName(Blip)
end

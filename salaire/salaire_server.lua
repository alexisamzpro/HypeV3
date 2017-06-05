-- Loading MySQL Class
require "resources/[essential]/essentialmode/lib/MySQL"
MySQL:open("localhost", "gta5_gamemode_essential", "admin", "fivem")

RegisterServerEvent('paycheck:salary')
AddEventHandler('paycheck:salary', function()
	 local salary = math.random(100,250) --Aide de l'État random (ici entre 100 et 250) RP: A changer au bon vouloir du président
   TriggerEvent('es:getPlayerFromId', source, function(user)
  	-- Ajout de l'argent à l'utilisateur
  	local user_id = user.identifier
  	-- Requête qui permet de recuperer le métier de l'utilisateur
    
  	-- local executed_query = MySQL:executeQuery("SELECT salary FROM users INNER JOIN jobs ON users.job = jobs.job_id WHERE identifier = '@username'",{['@username'] = user_id})
    
    --[[ 
    SELECT CASE WHEN police BETWEEN 1 AND 7 THEN (SELECT salary FROM police WHERE police_id = police)ELSE (SELECT salary FROM users INNER JOIN jobs ON users.job = jobs.job_id WHERE identifier = '@username')END AS salary FROM users
    --]]
    
    local executed_query = MySQL:executeQuery("SELECT CASE WHEN police BETWEEN 1 AND 7 THEN (SELECT salary FROM police WHERE police_id = police)ELSE (SELECT salary FROM users INNER JOIN jobs ON users.job = jobs.job_id WHERE identifier = '@username')END AS salary FROM users",{['@username'] = user_id})
    
    local result = MySQL:getResults(executed_query, {'salary'})
    local salary_job = tonumber(result[1].salary)
    if salary_job > 0 then
          user:addMoney((salary + salary_job))
          TriggerClientEvent("es_freeroam:notify", source, "CHAR_BANK_MAZE", 1, "Maze Bank", false, "Aide de L'État :  + "..salary.."~g~$~s~~n~Salaire reçu : + "..salary_job.." ~g~$")
    end
 	end)
end)

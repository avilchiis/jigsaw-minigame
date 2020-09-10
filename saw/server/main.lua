admins = {
    'steam:110000123456789',  
}



function IsSaw(player)
    local allowed = false
    for i,id in ipairs(admins) do
        for x,pid in ipairs(GetPlayerIdentifiers(player)) do
            if string.lower(pid) == string.lower(id) then
                allowed = true
            end
        end
    end
    return allowed
end



RegisterCommand('saw', function(source, args)
    
    if IsSaw(source) then
         TriggerClientEvent('dovux:teaser', -1)
	end
		 
end)
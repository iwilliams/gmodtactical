local ply = FindMetaTable("Player")

function ply:SetGamemodeTeam( n )
	if n < 0 or n > 1 then return false end

	self:SetTeam(n)

    player_manager.SetPlayerClass(self, "player_operator" )

	return true
end

function GM:PlayerConnect(name, ip)
end

teams = 1
function GM:PlayerInitialSpawn(ply)
	print("Player: " .. ply:Nick() .. ", has spawned.")
	ply:SetGamemodeTeam(teams)
	teams = (teams + 1)%2
end



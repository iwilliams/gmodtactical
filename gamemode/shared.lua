include( "player_operator.lua")
include( "player_uprising.lua")

GM.NAME = "CC"
GM.Author = "Ian Williams"
GM.Email = "N/A"
GM.Website = "N/A"

function GM:CreateTeams()
	team.SetUp(0, "Operators", Color(0, 0, 0))
	team.SetUp(1, "Uprising", Color(255, 255, 255))
end


function GM:Initialize()
	self.BaseClass.Initialize(self)
end
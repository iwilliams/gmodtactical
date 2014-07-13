AddCSLuaFile()
DEFINE_BASECLASS( "player_default" )

local PLAYER = {}
--
-- See gamemodes/base/player_class/player_default.lua for all overridable variables
--
PLAYER.WalkSpeed 			= 200
PLAYER.RunSpeed				= 400

--
-- Set up the network table accessors
--
function PLAYER:SetupDataTables()

	BaseClass.SetupDataTables( self )

end

function PLAYER:Loadout()

	self.Player:RemoveAllAmmo()

	self.Player:Give("weapon_mad_mp5")
	self.Player:Give("weapon_mad_57")

	self.Player:CrosshairDisable()

end

function PLAYER:SetModel()

	operatorModels = {
		"models/player/urban.mdl",
		"models/player/gasmask.mdl",
		"models/player/riot.mdl",
		"models/player/swat.mdl",
		"models/player/Combine_Soldier.mdl",
		"models/player/Combine_Soldier_PrisonGuard.mdl",
		"models/player/barney.mdl"
	}

	ModelLength = table.getn(operatorModels)
	randomIndex = math.random(ModelLength)
	
	self.Player:SetModel(operatorModels[randomIndex])

end

player_manager.RegisterClass( "player_operator", PLAYER, "player_default" )

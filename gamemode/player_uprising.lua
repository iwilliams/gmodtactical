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

	self.Player:Give("weapon_mad_mac10")
	self.Player:Give("weapon_mad_usp")

	self.Player:CrosshairDisable()

end

function PLAYER:SetModel()

	uprising = {
		"models/player/Group03/Male_01.mdl",
		"models/player/Group03/Male_02.mdl",
		"models/player/Group03/Male_03.mdl",
		"models/player/Group03/Male_04.mdl",
		"models/player/Group03/Male_05.mdl",
		"models/player/Group03/Male_06.mdl",
		"models/player/Group03/Male_07.mdl",
		"models/player/Group03/Male_08.mdl",
		"models/player/Group03/Male_09.mdl",
		"models/player/Group03/Female_01.mdl",
		"models/player/Group03/Female_02.mdl",
		"models/player/Group03/Female_03.mdl",
		"models/player/Group03/Female_04.mdl",
		"models/player/Group03/Female_06.mdl"
	}

	ModelLength = table.getn(uprising)
	randomIndex = math.random(ModelLength)
	
	self.Player:SetModel(uprising[randomIndex])

end

player_manager.RegisterClass( "player_uprising", PLAYER, "player_default" )

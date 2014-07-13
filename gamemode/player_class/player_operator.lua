DEFINE_BASECLASS( "player_default" )

local PLAYER = {} 


--
-- See gamemodes/base/player_class/player_default.lua for all overridable variables
--
PLAYER.WalkSpeed = 200
PLAYER.RunSpeed	= 400

function PLAYER:PlayerLoadout()

	self.Player:GiveAmmo( 256, "Smg1", true)
	self.Player:Give('weapon_smg1')
	self.Player:Give('weapon_pistol')
	self.Player:CrosshairDisable()

end

player_manager.RegisterClass( "player_operator", PLAYER, "player_default" )
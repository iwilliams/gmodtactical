AddCSLuaFile()
DEFINE_BASECLASS( "player_cc_base" )

local PLAYER = {}
--
-- See gamemodes/base/player_class/player_default.lua for all overridable variables
--
PLAYER.WalkSpeed 			= 200
PLAYER.RunSpeed				= 400

local loadout = {"weapon_stunstick", "weapon_cc_hk416_EX", "weapon_cc_ak47_EX", "weapon_cc_ak47", "weapon_cc_hk416"}

local playerModels = {
	"models/player/urban.mdl",
	"models/player/gasmask.mdl",
	"models/player/riot.mdl",
	"models/player/swat.mdl",
	"models/player/Combine_Soldier.mdl",
	"models/player/Combine_Soldier_PrisonGuard.mdl",
	"models/player/barney.mdl"
}

function PLAYER:Init() 
	self:setLoadout(loadout)
	self:setModels(playerModels)
end

player_manager.RegisterClass( "player_operator", PLAYER, "player_cc_base" )

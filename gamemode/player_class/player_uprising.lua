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

function PLAYER:Init() 
	self:setLoadout(loadout)
	self:setModels(playerModels)
end

player_manager.RegisterClass( "player_uprising", PLAYER, "player_cc_base" )

AddCSLuaFile()
DEFINE_BASECLASS( "player_cc_base" )

local PLAYER = {}
--
-- See gamemodes/base/player_class/player_default.lua for all overridable variables
--
PLAYER.WalkSpeed 			= 200
PLAYER.RunSpeed				= 400

local loadout = {"weapon_stunstick", "weapon_cc_hk416_EX", "pspak_fn_fal_ex", "pspak_hk_g36c_ex", "pspak_m4a1_ex", "pspak_irq_ak47_ex", "pspak_sg_552_ex", "pspak_pp_bizon_ex", "pspak_hk_416_ex"}

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

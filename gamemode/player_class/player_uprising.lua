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

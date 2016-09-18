AddCSLuaFile()
DEFINE_BASECLASS( "player_gmt_base" )

local PLAYER = {}
--
-- See gamemodes/base/player_class/player_default.lua for all overridable variables
--
PLAYER.WalkSpeed 			= 100
PLAYER.RunSpeed				= 225
--PLAYER.CrouchedWalkSpeed	= 0.3		 --Multiply move speed by this when crouching
--PLAYER.DuckSpeed			= 0.3		 --How fast to go from not ducking, to ducking
--PLAYER.UnDuckSpeed			= 0.3		 --How fast to go from ducking, to not ducking
PLAYER.JumpPower			= 150		 --How powerful our jump should be
PLAYER.CanUseFlashlight		= false		 --Can we use the flashlight
--PLAYER.MaxHealth			= 100		 --Max health we can have
--PLAYER.StartHealth			= 100		 --How much health we start with
--PLAYER.StartArmor			= 50			 --How much armour we start with
--PLAYER.DropWeaponOnDie		= true		 --Do we drop our weapon when we die
--PLAYER.TeammateNoCollide	= true		 --Do we collide with teammates or run straight through them
--PLAYER.AvoidPlayers			= true		 --Automatically swerves around other players
--PLAYER.UseVMHands			= true		 --Uses viewmodel hands

local loadout = {
    "m9k_m4a1"
}

local playerModels = {
	--"models/player/urban.mdl",
	--"models/player/gasmask.mdl",
	--"models/player/riot.mdl",
	--"models/player/swat.mdl",
	--"models/player/Combine_Soldier.mdl",
	--"models/player/Combine_Soldier_PrisonGuard.mdl",
	--"models/player/barney.mdl",
	"models/player/Group03/Male_01.mdl",
	"models/player/Group03/Male_02.mdl",
	"models/player/Group03/Male_03.mdl",
	"models/player/Group03/Male_04.mdl",
	"models/player/Group03/Male_05.mdl",
	"models/player/Group03/Male_06.mdl",
	--"models/player/Group03/Male_07.mdl",
	--"models/player/Group03/Male_08.mdl",
	--"models/player/Group03/Male_09.mdl",
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

player_manager.RegisterClass( "player_operator", PLAYER, "player_gmt_base" )

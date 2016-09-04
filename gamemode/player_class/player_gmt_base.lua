AddCSLuaFile()
DEFINE_BASECLASS( "player_default" )

local PLAYER = {}
--
-- See gamemodes/base/player_class/player_default.lua for all overridable variables
--
PLAYER.WalkSpeed 			= 100
PLAYER.RunSpeed				= 150

local loadout = {"weapon_crowbar", "weapon_cc_hk416", "weapon_cc_ak47", "weapon_cc_hk416_ex"}
local playerModels = {}

-- Function so set loadout
function PLAYER:setLoadout(load)
	loadout = load
end

-- Function to set playerModels 
function PLAYER:setModels(models)
	playerModels = models
end

function PLAYER:Init() 
	self:setLoadout(loadout)
	self:setModels(playerModels)
end

--
-- Set up the network table accessors
--
function PLAYER:SetupDataTables()
	BaseClass.SetupDataTables( self )
end

function PLAYER:Loadout()
	self.Player:RemoveAllAmmo()
	for k, weapon in pairs(loadout) do 
		self.Player:Give(weapon)
	end
	-- self.Player:CrosshairDisable()
end

function PLAYER:SetModel()
	ModelLength = table.getn(playerModels)
	randomIndex = math.random(ModelLength)
	self.Player:SetModel(playerModels[randomIndex])
end

player_manager.RegisterClass( "player_cc_base", PLAYER, "player_default" )

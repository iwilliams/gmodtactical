AddCSLuaFile( "cl_init.lua" ) --Send cl_init.lua to the client
AddCSLuaFile( "shared.lua" ) --Send shared.lua to the client
include( 'shared.lua' ) --Include shared.lua

local Anim_Open = nil
local Anim_Close = nil

        --box:SetSequence(Anim_Open)
        --box:SetSequence(Anim_Close)
function ENT:Initialize()
    self:SetModel( "models/Items/ammocrate_smg1.mdl" )
    self:PhysicsInit( SOLID_VPHYSICS )
    self:SetSolid( SOLID_VPHYSICS )
    self:SetMoveType( MOVETYPE_NONE )
    self:SetUseType(SIMPLE_USE)
    Anim_Open = self:LookupSequence("Open")
    Anim_Close = self:LookupSequence("Close")

    self.isOpen = false
    self.openedBy = nil

    self.contents = {
        "AK74"
    }
end

--function ENT:Think()
    --self:NextThink(CurTime())
    --return true
--end

util.AddNetworkString( "loot_chest_open" )
function ENT:Use(Activator, Caller)
    if self.openedBy != nil then return end
    if not self.isOpen then
        self:SetSequence(Anim_Close)

        self.openedBy = Caller

        net.Start("loot_chest_open")
            net.WriteTable(self.contents)
            net.WriteEntity(self)
        net.Send(Caller)
    else
        self:SetSequence(Anim_Open)
    end

    self.isOpen = !self.isOpen
end



util.AddNetworkString( "loot_chest_close" )
net.Receive( "loot_chest_close", function(len, ply)
    local chest = net.ReadEntity()
    if IsValid(chest.openedBy) and chest.openedBy == ply then
        chest:SetSequence(Anim_Open)
        chest.openedBy = nil
        chest.isOpen = false
    end
end)

util.AddNetworkString( "loot_chest_take" )
net.Receive( "loot_chest_take", function(len, ply)
    local idx = net.ReadUInt(16)
    local chest = net.ReadEntity()

    if IsValid(chest.openedBy)
        and chest.openedBy == ply
        and chest.isOpen then
        ply.serverGivingWep = true
        ply:Give("gmt_ak74")
        ply.serverGivingWep = false

        table.remove(chest.contents, idx)
    end
end)

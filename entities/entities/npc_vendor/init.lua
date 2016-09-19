AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include( "shared.lua" )


function ENT:Initialize()
    self:SetModel("models/Barney.mdl")
    self:SetUseType( SIMPLE_USE )
    self:SetMoveType(MOVETYPE_NONE)
    self:SetSolid( SOLID_BBOX )
    self:SetCollisionGroup(COLLISION_GROUP_PLAYER)
end

function ENT:PlayerUse( player )
    print( "give player weap", player )

    local wep = ents.Create( "gmt_ak74" )
    wep:SetPos( self:GetPos() )
    wep:Spawn()
    --player:Give( "gmt_ak74" )
end

function ENT:AcceptInput( inputName, activator, called, data)
    print( "vendor input:", inputName, activator, called, data )

    if inputName == "Use" then self:PlayerUse( called ) end
end

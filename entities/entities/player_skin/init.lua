AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT:Initialize()
    self:SetModel(self.model)
    -- Scale down the model a bit
    self:SetModelScale( self:GetModelScale() * .8, 0 )

    -- Create the ragdoll model
    local ent= ents.Create("player_skin_model")
    local pos = self:GetPos()
    pos:Add( Vector(0, 0, 15) )
    ent:SetPos(pos)
    ent:SetOwner( self )
    ent:SetParent( self )
    ent:SetMoveType( MOVETYPE_NONE )
    ent:Spawn()
    -- Store ragdoll model
    self.skinModel = ent

    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetUseType(SIMPLE_USE)

    local phys = self:GetPhysicsObject()
    phys:SetMass(200)
    phys:Wake()

    self:SetCollisionGroup( COLLISION_GROUP_WEAPON )
end

function ENT:Use(activator, caller)
    caller.unlockedModel = self.skinModel.model

    sound.Play("items/smallmedkit1.wav", self:GetPos())

    self:Remove()
end

function ENT:canUse(owner, activator)
    return true
end

function ENT:createItem(activator)
end

function ENT:Think()
end

function ENT:OnRemove()
    self.skinModel:Remove()
end

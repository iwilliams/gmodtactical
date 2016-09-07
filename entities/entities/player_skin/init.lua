AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT:Initialize()
    self:SetModel(self.model)

    self:SetModelScale( self:GetModelScale() * .5, 0 )

    --self:PhysicsInit(SOLID_VPHYSICS)
    self:PhysicsInit(SOLID_OBB)
    self:SetUseType(SIMPLE_USE)

    PrintTable( self:GetSequenceList() )

    --local sequence = self:LookupSequence( "idle" )
    local sequence = self:LookupSequence( "idle_ar2" )
    self:SetSequence( sequence )

    self.rotate = 0
    self.lasttime = SysTime()

    --local phys = self:GetPhysicsObject()
    --phys:Wake()
end

function ENT:Use(activator, caller)
    caller.unlockedModel = "models/player/combine_specialforce_1.mdl"

    sound.Play("items/smallmedkit1.wav", self:GetPos())

    self:Remove()
end

function ENT:canUse(owner, activator)
    return true
end

function ENT:createItem(activator)
    -- Implement this function
end

function ENT:Think()
    local realPos =self.Entity:GetPos()
    self.Entity:SetAngles(Angle(0, self.rotate, 0))

    if ( self.rotate > 359 ) then self.rotate = 0 end

    self.rotate = self.rotate - ( 100*( self.lasttime-SysTime() ) )
    self.lasttime = SysTime()
end

function ENT:OnRemove()
end

AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT:Initialize()
    self.model = table.Random(GMT.PossibleSkins)

    self:SetModel(self.model)
    self:SetModelScale( self:GetModelScale() * .40, 0 )

    self:PhysicsInit(SOLID_OBB)
    self:SetUseType(SIMPLE_USE)

    local sequence = self:LookupSequence( "idle_ar2" )
    self:SetSequence( sequence )

    self.rotate = 0
    self.lasttime = SysTime()

    self:SetCollisionGroup( COLLISION_GROUP_WEAPON )
end

function ENT:Use(activator, caller, useType, value)
    local parent = self:GetParent()
    parent:Use(activator, caller, useType, value)
end

function ENT:canUse(owner, activator)
    return true
end

function ENT:Think()
    local realPos =self.Entity:GetPos()
    self.Entity:SetAngles(Angle(0, self.rotate, 0))

    if ( self.rotate > 359 ) then self.rotate = 0 end

    self.rotate = self.rotate - ( 100*( self.lasttime-SysTime() ) )
    self.lasttime = SysTime()
end

AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

local possibleSkins = {
    "models/player/combine_specialforce_1.mdl",
    "models/player/pmc_5/pmc__01.mdl",
    "models/player/pmc_5/pmc__02.mdl",
    "models/player/pmc_5/pmc__03.mdl",
    "models/player/pmc_5/pmc__04.mdl",
    "models/player/pmc_5/pmc__05.mdl",
    "models/player/pmc_5/pmc__06.mdl",
    "models/player/pmc_5/pmc__07.mdl",
    "models/player/pmc_5/pmc__08.mdl",
    "models/player/pmc_5/pmc__09.mdl",
    "models/player/pmc_5/pmc__10.mdl",
    "models/player/pmc_5/pmc__11.mdl",
    "models/player/pmc_5/pmc__12.mdl",
    "models/player/pmc_5/pmc__13.mdl",
    "models/player/pmc_5/pmc__14.mdl",
    "models/player/tac_op1.mdl",
    "models/player/tac_op2.mdl",
    "models/player/tac_op3.mdl",
    "models/player/tac_op4.mdl",
    "models/player/tac_op5.mdl",
    "models/player/tac_op6.mdl",
    "models/player/tac_op7.mdl",
    "models/player/tac_op8.mdl",
    "models/player/tac_op9.mdl"
}

function ENT:Initialize()
    self.model = table.Random(possibleSkins)

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

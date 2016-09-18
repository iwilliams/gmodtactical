AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT:Initialize()
    --self:initVars()

    self:SetModel(self.model)
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)
    self:SetUseType(SIMPLE_USE)

    self:PrecacheGibs()

    local phys = self:GetPhysicsObject()
    phys:Wake()
end

function ENT:OnTakeDamage(dmg)
    self:TakePhysicsDamage(dmg)
    self:GibBreakClient( Vector(1, 1, 1) )

    local allWeps = {}
    table.Add(allWeps, GMT.PrimaryWeapons)
    table.Add(allWeps, GMT.SecondaryWeapons)
    table.Add(allWeps, GMT.Items)
    table.insert(allWeps, "player_skin")

    local randomWep = ents.Create(table.Random(allWeps))
    --local randomWep = ents.Create("player_skin")
    --
    local pos = self:GetPos()
    pos:Add( Vector(0, 0, 15) )
    randomWep:SetPos( pos )
    randomWep:Spawn()

    GMT:ScheduleDespawn(randomWep)

    --timer.Simple(1, function()
    GMT:SpawnCrate()
    self.spawnPoint.hasCrate = false
    self:Remove()
    --end)
end

function ENT:Destruct()
end

function ENT:Use(activator, caller)
    local damage = DamageInfo()
    damage:AddDamage( 10 )
    damage:SetAttacker( caller )
    self:GibBreakClient( Vector(1, 1, 1) )
    self:OnTakeDamage( damage )
end

function ENT:canUse(owner, activator)
    return true
end

function ENT:Think()
end

function ENT:OnRemove()
end

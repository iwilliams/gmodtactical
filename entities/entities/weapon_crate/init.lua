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

    --self.sparking = false
    --self.damage = 100
    --self:Setprice(math.Clamp(self.initialPrice, (GAMEMODE.Config.pricemin ~= 0 and GAMEMODE.Config.pricemin) or self.initialPrice, (GAMEMODE.Config.pricecap ~= 0 and GAMEMODE.Config.pricecap) or self.initialPrice))
end

function ENT:OnTakeDamage(dmg)
    self:TakePhysicsDamage(dmg)
    self:GibBreakClient( Vector(1, 1, 1) )

    local allWeps = {}
    table.Add(allWeps, GMT.PrimaryWeapons)
    table.Add(allWeps, GMT.SecondaryWeapons)
    table.Add(allWeps, GMT.Items)

    --local randomWep = ents.Create(table.Random(allWeps))
    local randomWep = ents.Create("player_skin")
    randomWep:SetPos(self:GetPos())
    randomWep:Spawn()

    --timer.Simple(1, function()
    GMT:SpawnCrate()
    self.spawnPoint.hasCrate = false
    self:Remove()
    --end)
end

function ENT:Destruct()
    --local vPoint = self:GetPos()

    --util.BlastDamage(self, self, vPoint, 200, 200)
    --local effectdata = EffectData()
    --effectdata:SetStart(vPoint)
    --effectdata:SetOrigin(vPoint)
    --effectdata:SetScale(1)
    --util.Effect("Explosion", effectdata)
end

ENT.Once = false
function ENT:Use(activator, caller)
end

function ENT:canUse(owner, activator)
    return true
end

function ENT:Think()
    --if self.sparking then
        --local effectdata = EffectData()
        --effectdata:SetOrigin(self:GetPos())
        --effectdata:SetMagnitude(1)
        --effectdata:SetScale(1)
        --effectdata:SetRadius(2)
        --util.Effect("Sparks", effectdata)
    --end
end

function ENT:OnRemove()
end

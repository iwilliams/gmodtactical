AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

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

    --GMT:ScheduleDespawn(randomWep)
    self:Remove()
end

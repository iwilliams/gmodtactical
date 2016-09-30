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

    self:SetUseType(SIMPLE_USE)

    --GMT:ScheduleDespawn(randomWep)
    self:Remove()
end

function ENT:Use(activator, caller)
    print( activator, caller )

    for _, weapon in pairs( caller:GetWeapons() ) do
        print( weapon:GetClass() )
        if weapon:GetClass() == "weapon_empty_hands" then
            activator:SetActiveWeapon( weapon )
        end
    end

    timer.Simple(.1, function()
        activator:PickupObject( self )
    end)
end

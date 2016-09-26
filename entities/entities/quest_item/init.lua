AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

--models/props_c17/BriefCase001a.mdl
--models/props_c17/SuitCase001a.mdl
--models/props_c17/SuitCase_Passenger_Physics.mdl
function ENT:Initialize()
    self:SetModel( "models/props_c17/SuitCase001a.mdl" )

    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetUseType(SIMPLE_USE)

    local phys = self:GetPhysicsObject()
    print( phys:GetMass() )
    --phys:SetMass(200)
    phys:Wake()

    --self:SetCollisionGroup( COLLISION_GROUP_WEAPON )
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

function ENT:canUse(owner, activator)
    return true
end

--local function up( ply, ent )
    --return true
--end
--hook.Add( "AllowPlayerPickup", "some_unique_name", up )

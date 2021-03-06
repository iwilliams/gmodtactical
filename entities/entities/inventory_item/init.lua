AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT:SetItem( itemName )
    local item = GMT_ITEMS[itemName]
    self.item = item
    self.itemName = itemName
end

function ENT:Initialize()
    self:SetModel(self.item.model)

    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetUseType(SIMPLE_USE)

    local phys = self:GetPhysicsObject()
    print( phys:GetMass() )
    --phys:SetMass(200)
    phys:Wake()

    --self:SetCollisionGroup( COLLISION_GROUP_WEAPON )
end

function ENT:Use(activator, caller)
    sound.Play("items/ammo_pickup.wav", self:GetPos())
    caller:AddToInventory( self.itemName )
    self:Remove()
end

function ENT:canUse(owner, activator)
    return true
end

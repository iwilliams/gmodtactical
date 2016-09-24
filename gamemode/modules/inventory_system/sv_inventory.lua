util.AddNetworkString( "gmt_update_player_inventory" )
local function UpdatePlayerInventory( ply )
    net.Start( "gmt_update_player_inventory" )
    net.WriteTable( ply.Inventory )
    net.Send( ply )
end

util.AddNetworkString( "gmt_player_inventory_use" )
net.Receive( "gmt_player_inventory_use", function(len, ply)
    local idx = net.ReadUInt(16)

    local item = GMT_ITEMS[ply.Inventory[idx]]

    if item then
        item.onUse( ply )
    end

    table.remove( ply.Inventory, idx )
    UpdatePlayerInventory( ply )
end)



local function PlayerSpawn( ply )
    ply.Inventory = {
        "health_spray",
        "health_spray"
    }
    UpdatePlayerInventory( ply )
end
hook.Add( "PlayerSpawn", "gmt_inventory", PlayerSpawn )

hook.Add("PlayerDeath", "gmt_player_inventory_death", function ( victim, inflictor, attacker )
    PrintTable( victim.Inventory )
    for _,item in pairs( victim.Inventory ) do
        local testItem = ents.Create( "inventory_item" )
        testItem:SetItem( item )
        testItem:SetPos( victim:GetPos() )
        testItem:Spawn()
    end
    victim.Inventory = {}
    UpdatePlayerInventory( victim )
end)

local meta = FindMetaTable( "Player" )
function meta:AddToInventory( item )
    print( "Add to inventory", item )
    table.insert( self.Inventory, item )
    print( "Updated " .. self:Name() .. "'s Inventory" )
    PrintTable( self.Inventory )
    UpdatePlayerInventory( self )
end


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

util.AddNetworkString( "gmt_player_inventory_drop" )
net.Receive( "gmt_player_inventory_drop", function(len, ply)
    local idx = net.ReadUInt(16)

    local itemName = ply.Inventory[idx]

    local testItem = ents.Create( "inventory_item" )
    testItem:SetItem( itemName )

    -- https://maurits.tv/data/garrysmod/wiki/wiki.garrysmod.com/indexbc4f.html
    local tr = ply:GetEyeTrace();
    testItem:SetPos (ply:EyePos() + (ply:GetAimVector() * 16));
    testItem:SetAngles (ply:EyeAngles());
    testItem:Spawn();

    local phys = testItem:GetPhysicsObject();
    --local shot_length = 600
    local shot_length = 30
    phys:ApplyForceCenter (ply:GetAimVector():GetNormalized() * math.pow( shot_length, 1.8 ))

    table.remove( ply.Inventory, idx )
    UpdatePlayerInventory( ply )
end)


local function PlayerSpawn( ply )
    ply.Inventory = {
        "health_spray",
        "health_kit",
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

    if victim.Factions.rebel > 0 || victim.Factions.combine > 0 then
        local dogtag = ents.Create( "inventory_item" )
        if victim.Factions.rebel > 0 then
            dogtag:SetItem( "dog_tag_rebel" )
        elseif victim.Factions.combine > 0 then
            dogtag:SetItem( "dog_tag_combine" )
        end
        dogtag:SetPos( victim:GetPos() )
        dogtag:Spawn()
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


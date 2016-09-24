local meta = FindMetaTable( "Player" )

local function PlayerSpawn( ply )
    ply.Inventory = {}
end
hook.Add( "PlayerSpawn", "gmt_inventory", PlayerSpawn )

function meta:AddToInventory( item )
    print( "Add to inventory", item )
    table.insert( self.Inventory, item )
    PrintTable( self.Inventory )
end

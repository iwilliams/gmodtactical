AddCSLuaFile()

GMT_ITEMS = {
    health_spray = {
        model = "models/healthvial.mdl",
        onUse = function( ply )
            ply:SetHealth( math.min( ply:Heatlh() + 50, ply:GetMaxHealth() ) )
        end
    },
    health_kit = {
        model = "models/items/healthkit.mdl",
        onUse = function( ply )
            ply:SetHealth( ply:GetMaxHealth() )
        end
    }
}

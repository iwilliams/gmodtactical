AddCSLuaFile()

GMT_ITEMS = {
    health_spray = {
        model = "models/healthvial.mdl",
        onUse = function( ply )
            ply:SetHealth( math.min( ply:Health() + 25, ply:GetMaxHealth() ) )
            sound.Play("items/smallmedkit1.wav", ply:GetPos())
            return true
        end
    },
    health_kit = {
        model = "models/items/healthkit.mdl",
        onUse = function( ply )
            ply:SetHealth( ply:GetMaxHealth() )
            sound.Play("items/smallmedkit1.wav", ply:GetPos())
            return true
        end
    }
}

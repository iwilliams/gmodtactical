include("shared.lua");

local hide = {
    CHudHealth = true,
    CHudCrosshair = true
}

hook.Add( "HUDShouldDraw", "gmt_hide_HUD", function( name )
    if ( hide[ name ] ) then return false end
end)

include("shared.lua");

for k,v in pairs(weapons.GetList()) do
    if string.StartWith(v["ClassName"], "m9k") then print(v["ClassName"]) end
end

local hide = {
    CHudHealth      = true,
    CHudCrosshair   = true,
    CHudAmmo        = true,
    --CHudBattery     = true,
    --CHudSecondaryAmmo = true
}

hook.Add( "HUDShouldDraw", "gmt_hide_HUD", function( name )
    if ( hide[ name ] ) then return false end
end)

function GM:DrawDeathNotice( x, y )
end

function GM:HUDDrawTargetID()
end

function GM:RenderScreenspaceEffects()
    local player     = LocalPlayer()
    local maxHealth  = player:GetMaxHealth()
    local health     = player:Health()

    if health == maxHealth then return end

    local percentage = (health/maxHealth)

    local maxBlur = 0.035
    local blur = maxBlur - (maxBlur * percentage)

    local maxRed = 0.4
    local maxColour = .2

    local tab = {
        [ "$pp_colour_addr" ] = math.max(maxRed - (maxRed * percentage), 0) * 1.2,
        [ "$pp_colour_addg" ] = 0,
        [ "$pp_colour_addb" ] = 0,
        [ "$pp_colour_brightness" ] = 0,
        [ "$pp_colour_contrast" ] = 1,
        [ "$pp_colour_colour" ] = math.max(1 * percentage, 0),
        [ "$pp_colour_mulr" ] = 0,
        [ "$pp_colour_mulg" ] = 0,
        [ "$pp_colour_mulb" ] = 0
    }

    DrawColorModify( tab )
    DrawMotionBlur( 0.4, 0.8, math.max(blur, 0) )
    --DrawBloom( 0.75, 1.5, 9, 9, 1, 1, 1, 1, 1 )
end

scoreboard = scoreboard or {}

--function scoreboard:show()

    --local frameWidth = 400

    ----Create the scoreboard here, with an base like DPanel, you can use an DListView for the rows.
    --local frame = vgui.Create( "DFrame" )
    --frame:ShowCloseButton( false )
    --frame:SetSize( frameWidth, 250 )
    --frame:SetTitle( "Purchase Weapon" )
    --frame:MakePopup()
    --frame:Center()

    --local layout = vgui.Create( "DListLayout", frame )
    --layout:SetSize( frameWidth - 10, 100 )
    --layout:SetPos( 5, 50 )

    ----Draw a background so we can see what it's doing
    --layout:SetPaintBackground( true )
    --layout:SetBackgroundColor( Color( 0, 100, 100 ) )

    --layout:MakeDroppable( "unique_name" ) -- Allows us to rearrange children

    --local label1 = Label( "P90" )
    --layout:Add(label1)

    --local label2 = Label( "M4" )
    --layout:Add(label2)

    --function scoreboard:hide()
        ---- Here you put how to hide it, eg Base:Remove()
        --frame:Remove()
    --end
--end

--function GM:ScoreboardShow()
    --scoreboard:show()
--end

--function GM:ScoreboardHide()
    --scoreboard:hide()
--end

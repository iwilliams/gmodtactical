include("shared.lua");

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

scoreboard = scoreboard or {}

function scoreboard:show()

    local frameWidth = 400

    --Create the scoreboard here, with an base like DPanel, you can use an DListView for the rows.
    local frame = vgui.Create( "DFrame" )
    frame:ShowCloseButton( false )
    frame:SetSize( frameWidth, 250 )
    frame:SetTitle( "Purchase Weapon" )
    frame:MakePopup()
    frame:Center()

    local layout = vgui.Create( "DListLayout", frame )
    layout:SetSize( frameWidth - 10, 100 )
    layout:SetPos( 5, 50 )

    --Draw a background so we can see what it's doing
    layout:SetPaintBackground( true )
    layout:SetBackgroundColor( Color( 0, 100, 100 ) )

    layout:MakeDroppable( "unique_name" ) -- Allows us to rearrange children

    local label1 = Label( "P90" )
    layout:Add(label1)

    local label2 = Label( "M4" )
    layout:Add(label2)

    function scoreboard:hide()
        -- Here you put how to hide it, eg Base:Remove()
        frame:Remove()
    end
end

function GM:ScoreboardShow()
    scoreboard:show()
end

function GM:ScoreboardHide()
    scoreboard:hide()
end

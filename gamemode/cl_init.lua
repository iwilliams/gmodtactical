include("shared.lua");

--sound.PlayURL ( "http://warez.iwillia.ms/garrysmod/output.wav", "", function( station )
    --if ( IsValid( station ) ) then

        ----station:SetPos( LocalPlayer():GetPos() )
        --station:SetVolume(1)
        --station:Play()

    --else

        --LocalPlayer():ChatPrint( "Invalid URL!" )

    --end
--end )

local hide = {
    CHudHealth      = true,
    CHudCrosshair   = true,
    CHudAmmo        = true,
    CHudVoiceStatus = true,
    CHudWeaponSelection = true
    --CHudBattery     = true,
    --CHudSecondaryAmmo = true
}

-- sets voice hud off
--function GM:Initialize()
    --g_VoicePanelList:SetVisible(false)
--end

hook.Add( "HUDShouldDraw", "gmt_hide_HUD", function( name )
    if ( hide[ name ] ) then return false end

    // allow weapon hiding
    local ply = LocalPlayer()
    if IsValid(ply) then
        local wep = ply:GetActiveWeapon()
        if IsValid(wep) && wep.HUDShouldDraw then
            return wep.HUDShouldDraw(wep, name)
        end
    end

    return true
end)

function GM:DrawDeathNotice( x, y )
end

function GM:HUDDrawTargetID()
end

-- Remove NPC rag dolls on death after 10s
function RemoveDeadRag( ent )
    if (ent == NULL) or (ent == nil) then return end
    if (ent:GetClass() == "class C_ClientRagdoll") then
        if ent:IsValid() and !(ent == NULL) then
            SafeRemoveEntityDelayed(ent, 10)
        end
    end
end
hook.Add("OnEntityCreated", "RemoveDeadRag", RemoveDeadRag)


hook.Add("PlayerHurt", "playerHurtShake", function( victim, attacker, healthRemaining, damageTaken )
    print("ow")
    if healthRemaining < 0 then return end

    print("ow")
    util.ScreenShake( victim:GetPos() , 500, 5, 10, 5000 )
end)

function GM:RenderScreenspaceEffects()
    local player     = LocalPlayer()
    local maxHealth  = player:GetMaxHealth()
    local health     = player:Health()

    --if health > 85 then return end

    local percentage = (health/maxHealth)

    local maxBlur = 0.005
    local blur = maxBlur - (maxBlur * percentage)

    local maxRed = 0.1
    local maxColour = .2

    local contrast = 1
    if not player:Alive() then contrast = 0 end

    local tab = {
        [ "$pp_colour_addr" ] = math.max(maxRed - (maxRed * percentage), 0) * 1.2,
        [ "$pp_colour_addg" ] = 0,
        [ "$pp_colour_addb" ] = 0,
        [ "$pp_colour_brightness" ] = 0,
        [ "$pp_colour_contrast" ] = contrast,
        [ "$pp_colour_colour" ] = math.max(1 * percentage, 0),
        [ "$pp_colour_mulr" ] = 0,
        [ "$pp_colour_mulg" ] = 0,
        [ "$pp_colour_mulb" ] = 0
    }

    DrawColorModify( tab )
    --DrawMotionBlur( 0.4, 0.8, math.max(blur, 0) )

    --DrawBloom( 0.75, 1.5, 9, 9, 1, 1, 1, 1, 1 )
end

scoreboard = scoreboard or {}

function scoreboard:show()

    local frameWidth = 1000
    local frameHeight = 700
    local padding =10

    local outerBgColor = Color(100, 100, 100, 255)
    local innerBgColor = Color(20, 20, 20, 255)

    local DPanel = vgui.Create( "DPanel" )
    DPanel:SetPos( 10, 30 ) -- Set the position of the panel
    DPanel:SetSize( frameWidth, frameHeight ) -- Set the size of the panel
    DPanel:Center()
    DPanel.Paint = function() return end
    DPanel:MakePopup()

    -- Create tabed layout
    local sheet = vgui.Create( "DPropertySheet", DPanel )
    sheet:SetSize( frameWidth, frameHeight )
    sheet:SetPadding( 0, 0, 0, 0 )

    -- Create status tab
    local statusTab = vgui.Create( "DPanel", sheet )
    statusTab:SetBackgroundColor( outerBgColor )
    sheet:AddSheet("Status", statusTab)

    print(statusTab:GetSize())

    -- Create Stats Side
    local statsWidth = (frameWidth - (padding*3))/4
    print(statsWidth)

    local statsPanel = vgui.Create( "DPanel", statusTab )
    statsPanel:SetSize( statsWidth, frameHeight - (padding*2) - 20)
    statsPanel:SetPos( padding, padding )
    statsPanel:SetBackgroundColor( innerBgColor )

    -- Player Model
    local playerModel = vgui.Create( "DModelPanel", statsPanel )
    playerModel:SetPos( 0, 0 )
    playerModel:SetSize( statsWidth, statsWidth )

    playerModel:SetModel( LocalPlayer():GetModel() )
    function playerModel:PreDrawModel( ent )
        ent:SetPos(Vector(0, 0, statsWidth/18))
        local sequence = LocalPlayer():GetSequence()
        ent:SetSequence( sequence )
    end

    local modelSelect = vgui.Create( "DComboBox", statsPanel )
    modelSelect:SetPos( 0, statsWidth )
    modelSelect:SetSize( statsWidth, 20 )
    modelSelect:SetValue( "Set Player Model" )
    modelSelect:AddChoice( "option A" )
    modelSelect:AddChoice( "option B" )
    modelSelect:AddChoice( "option C" )
    modelSelect.OnSelect = function( panel, index, value )
        print( value .." was selected!" )
    end

    local weaponPanelWidth = ((statsWidth*3) - (padding*2))/3

    -- Melee Panel
    local meleePanel = vgui.Create( "DPanel", statusTab )
    meleePanel:SetSize( weaponPanelWidth, weaponPanelWidth)
    meleePanel:SetPos( statsWidth + padding*2, padding )
    meleePanel:SetBackgroundColor( innerBgColor )

    -- Melee Weapon Model
    local meleeModel = vgui.Create( "DModelPanel", meleePanel )
    meleeModel:SetPos( 0, 0 )
    meleeModel:SetSize( weaponPanelWidth, weaponPanelWidth )

    meleeModel:SetModel( LocalPlayer():GetActiveWeapon():GetModel() )
    function meleeModel:PreDrawModel( ent )
        ent:SetPos(Vector(0, 0, statsWidth/5))
        ent:SetModelScale( 1.5, 0 )
    end
    --function meleeModel:LayoutEntity() return end
    --
    -- Primary Panel
    local primaryPanel = vgui.Create( "DPanel", statusTab )
    primaryPanel:SetSize( weaponPanelWidth, weaponPanelWidth)
    primaryPanel:SetPos( statsWidth + padding*2 + weaponPanelWidth + padding, padding )
    primaryPanel:SetBackgroundColor( innerBgColor )

    -- Primary Panel
    local secondaryPanel = vgui.Create( "DPanel", statusTab )
    secondaryPanel:SetSize( weaponPanelWidth, weaponPanelWidth)
    secondaryPanel:SetPos( statsWidth + padding*2 + weaponPanelWidth*2 + padding*2, padding )
    secondaryPanel:SetBackgroundColor( innerBgColor )



    -- Create Inventory Side
    local inventoryPanel = vgui.Create( "DPanel", statusTab )
    inventoryPanel:SetSize( statsWidth*3, frameHeight - (padding*3) - 20 - weaponPanelWidth )
    inventoryPanel:SetPos( statsWidth + padding*2, weaponPanelWidth + padding*2 )
    inventoryPanel:SetBackgroundColor( innerBgColor )


    --local meleeWeaponLabel = vgui.Create( "DLabel", statusTab )
    --meleeWeaponLabel:SetText( "Melee Weapon" )
    --meleeWeaponLabel:SetPos( padding + modelHolderHeight, modelHolderHeight + padding )
    --meleeWeaponLabel:SizeToContents()


    -- Create Players panel
    local playersPanel = vgui.Create( "DPanel", sheet )
    playersPanel:SetBackgroundColor( Color(200, 200, 200, 255) )
    sheet:AddSheet("Players", playersPanel)

    local playersList = vgui.Create( "DScrollPanel", playersPanel )
    playersList:Dock( FILL )

    for k, player in pairs( player.GetAll() ) do
        local playerBG = vgui.Create( "DPanel", playersList )
        playerBG:Dock( TOP )
        playerBG:DockMargin( padding, padding, padding , padding/2 )
        playerBG:SetSize( 100, 50 )
        playerBG:SetBackgroundColor( Color( 255, 255, 255, 255 ) )

        local DLabel = vgui.Create( "DLabel", playerBG )
        DLabel:SetTextColor( Color ( 0, 0, 0, 255 ) )
        DLabel:SetText( player:GetName() )
        DLabel:Center()
        DLabel:DockMargin( padding, padding, padding , padding )
        DLabel:Dock( LEFT )
        DLabel:SizeToContents()

        if LocalPlayer():IsAdmin() then
           local BanButton = vgui.Create( "DButton", playerBG )
           BanButton:Dock( RIGHT )
           BanButton:SetPos( 40, 40 )
           BanButton:SetText( "Ban" )
           BanButton:SetSize( 120, 60 )

           BanButton.DoClick = function()
                print( "Button was clicked!" )
           end

           local KickButton = vgui.Create( "DButton", playerBG )
           KickButton:Dock( RIGHT )
           KickButton:SetPos( 40, 40 )
           KickButton:SetText( "Kick" )
           KickButton:SetSize( 120, 60 )

           KickButton.DoClick = function()
                print( "Button was clicked!" )
           end
        end
    end

    function scoreboard:hide()
        -- Here you put how to hide it, eg Base:Remove()
        DPanel:Remove()
    end
end

function GM:ScoreboardShow()
    --if(LocalPlayer():Alive()) then
        scoreboard:show()
    --end
end

function GM:ScoreboardHide()
    scoreboard:hide()
end

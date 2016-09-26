local questmenu = questmenu or {
    isOpen = false
}

net.Receive( "gmt_quests_open", function()
end)

function questmenu:show()
    questmenu.isOpen = true

    local frameWidth = 1000
    local frameHeight = 700
    local padding =10

    --local outerBgColor = Color(100, 100, 100, 255)
    --local innerBgColor = Color(20, 20, 20, 255)
    local innerBgColor = Color(100, 100, 100, 255)
    local outerBgColor = Color(20, 20, 20, 255)

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

    if IsValid(LocalPlayer():GetActiveWeapon()) then
        -- Melee Weapon Model
        local meleeModel = vgui.Create( "DModelPanel", meleePanel )
        meleeModel:SetPos( 0, 0 )
        meleeModel:SetSize( weaponPanelWidth, weaponPanelWidth )

        meleeModel:SetModel( LocalPlayer():GetActiveWeapon():GetModel() )
        function meleeModel:PreDrawModel( ent )
            ent:SetPos(Vector(0, 0, statsWidth/5))
            ent:SetModelScale( 1.5, 0 )
        end
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
    local inventoryWidth = statsWidth*3
    local inventoryHeight = frameHeight - (padding*3) - 20 - weaponPanelWidth
    local inventoryPanel = vgui.Create( "DPanel", statusTab )
    inventoryPanel:SetSize( inventoryWidth, inventoryHeight )
    inventoryPanel:SetPos( statsWidth + padding*2, weaponPanelWidth + padding*2 )
    inventoryPanel:SetBackgroundColor( innerBgColor )

    local inventoryScroll = vgui.Create( "DScrollPanel", inventoryPanel )
    inventoryScroll:SetSize( inventoryWidth, inventoryHeight )
    inventoryScroll:SetPos( 0, 0 )

    local ply = LocalPlayer()
    for idx,item in pairs( PlyInventory ) do
        local itemSize = inventoryWidth/5
        local itemXPos = (idx - 1)*itemSize
        itemXPos = itemXPos - (math.floor((idx - 1)/5)*5*itemSize)
        local itemYPos = math.floor((idx - 1)/5)*itemSize

        -- Melee Weapon Model
        local itemModel = vgui.Create( "DModelPanel", inventoryScroll )
        itemModel:SetPos( itemXPos, itemYPos )
        itemModel:SetSize( itemSize, itemSize )

        itemModel:SetModel( GMT_ITEMS[item].model )
        function itemModel:PreDrawModel( ent )
            ent:SetPos(Vector(0, 0, statsWidth/5))
            ent:SetModelScale( 1.5, 0 )
        end

        function itemModel:DoClick()
            net.Start("gmt_player_inventory_use")
            net.WriteUInt(idx, 16)
            net.SendToServer()
        end
    end

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

    for k, ply in pairs( player.GetAll() ) do
        local playerBG = vgui.Create( "DPanel", playersList )
        playerBG:Dock( TOP )
        playerBG:DockMargin( padding, padding, padding , padding/2 )
        playerBG:SetSize( 100, 70 )
        playerBG:SetBackgroundColor( Color( 255, 255, 255, 255 ) )

        local Avatar = vgui.Create( "AvatarImage", playerBG )
        Avatar:SetSize( 64, 64 )
        Avatar:DockMargin( 3, 3, 3, 3 )
        Avatar:SetPlayer( ply, 64 )
        Avatar:Dock( LEFT )

        local DLabel = vgui.Create( "DLabel", playerBG )
        DLabel:SetTextColor( Color ( 0, 0, 0, 255 ) )
        DLabel:SetText( ply:GetName() )
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

    function questmenu:hide()
        questmenu.isOpen = false
        -- Here you put how to hide it, eg Base:Remove()
        DPanel:Remove()
    end
end

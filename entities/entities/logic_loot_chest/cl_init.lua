include('shared.lua') --Include shared.lua

local lootMenu = {}

function ENT:Initialize()
--Empty, but you must have this function
end

function ENT:Draw()
    self:DrawModel() --Draw the model, without this. You'll get a invisible, modeless entity.
end

function lootMenu:show(contents, chest)

    local frameWidth = 400

    --Create the scoreboard here, with an base like DPanel, you can use an DListView for the rows.
    local frame = vgui.Create( "DFrame" )
    --frame:ShowCloseButton( false )
    frame:SetSize( frameWidth, 250 )
    frame:SetTitle( "Chest Contents" )
    frame:MakePopup()
    frame:Center()

    function frame:OnClose()
        net.Start("loot_chest_close")
        net.WriteEntity(chest)
        net.SendToServer()
    end

    local layout = vgui.Create( "DListLayout", frame )
    layout:SetSize( frameWidth - 10, 100 )
    layout:SetPos( 5, 20 )

    --Draw a background so we can see what it's doing
    layout:SetPaintBackground( true )
    layout:SetBackgroundColor( Color( 0, 100, 100 ) )

    for idx, item in pairs(contents) do
        local label = Label( item )

        label.DoClick = function()
            net.Start("loot_chest_take")
                net.WriteUInt(idx, 16)
                net.WriteEntity(chest)
            net.SendToServer()
        end

        layout:Add(label)
    end

    function lootMenu:hide()
        -- Here you put how to hide it, eg Base:Remove()
        frame:Remove()
    end
end

net.Receive( "loot_chest_open", function()
    local contents = net.ReadTable()
    local chest = net.ReadEntity()
    lootMenu:show(contents, chest)
end)

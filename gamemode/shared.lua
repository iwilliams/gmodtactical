GM.NAME = "GMOD Tactical"
GM.Author = "iwilliams"
GM.Email = "ian@iwillia.ms"
GM.Website = "iwillia.ms"

--DeriveGamemode( "sandbox" )

-- Include player class info
include( "player_class/player_gmt_base.lua")
include( "player_class/player_operator.lua")

sound.Add({
    name = "player_heart",
    channel = CHAN_BODY,
    volume = 1.0,
    level = 80,
    sound = "player/heartbeat1.wav"
})

sound.Add({
    name = "player_breathe",
    channel = CHAN_BODY,
    volume = 1.0,
    level = 80,
    sound = "player/breathe1.wav"
})

local CMoveData = FindMetaTable( "CMoveData" )

function CMoveData:RemoveKeys( keys )
    -- Using bitwise operations to clear the key bits.
    local newbuttons = bit.band( self:GetButtons(), bit.bnot( keys ) )
    self:SetButtons( newbuttons )
end

--PLAYER.WalkSpeed 			= 100
--PLAYER.RunSpeed				= 150
hook.Add( "StartCommand", "Disable Jumping", function( ply, cmd )
    if not cmd:KeyDown( IN_FORWARD ) and cmd:KeyDown( IN_SPEED ) then
        cmd:RemoveKey( IN_SPEED )
    end

    --print(cmd:GetMouseWheel())
    if SERVER and cmd:GetMouseWheel() != 0 then
        local activeWep = ply:GetActiveWeapon()
        local activeSlot = activeWep:GetSlot()

        if cmd:GetMouseWheel() == 1 then
            ply:SelectWeapon( 'weapon_empty_hands' )
            return
        end

        local newSlot = activeSlot + 1

        if newSlot < 1 then newSlot = 2 end
        if newSlot > 2 then newSlot = 1 end

        local weapons = ply:GetWeapons()
        for _, wep in pairs( weapons ) do
            if wep:GetSlot() == newSlot and ply:GetActiveWeapon() != wep then
                ply:SelectWeapon( wep:GetClass() )
                return
            end
        end
    end
end )

local function MyFunc(pl, event, data)
    if event == PLAYERANIMEVENT_RELOAD then
        pl.isReloading = true
        timer.Simple(2, function()
            pl.isReloading = false
        end)
    end
end
hook.Add("DoAnimationEvent", "CheckPlayerReload", MyFunc)

function GM:PlayerButtonDown( ply, button )
    if button == KEY_Q then
        if SERVER and ply.LastHi + 2 <= CurTime() then

            local trace = util.QuickTrace( ply:GetShootPos(), ply:GetAimVector() * 8192, ply )

            if ply.isReloading then
                ply:EmitSound( table.Random( { "vo/npc/male01/coverwhilereload01.wav", "vo/npc/male01/coverwhilereload02.wav" } ), 75, 100, 1, CHAN_AUTO ) -- Same as below
            elseif ( trace.Entity && trace.Entity:IsNPC() && GMT:NPCGetFaction( trace.Entity ) != "" && ply.Factions[GMT:NPCGetFaction( trace.Entity )] > 0 ) then
                ply:EmitSound( "vo/npc/male01/squad_away03.wav", 75, 100, 1, CHAN_AUTO ) -- Same as below
            elseif ply:KeyDown( IN_SPEED ) then
                ply:EmitSound( table.Random( { "vo/npc/male01/runforyourlife01.wav", "vo/npc/male01/runforyourlife02.wav", "vo/npc/male01/runforyourlife02.wav" } ), 75, 100, 1, CHAN_AUTO ) -- Same as below
            elseif ply:GetActiveWeapon().dt.State == CW_AIMING then
                ply:EmitSound( "vo/npc/male01/getdown02.wav", 75, 100, 1, CHAN_AUTO ) -- Same as below
            else
                ply:EmitSound( table.Random( { "vo/npc/male01/hi01.wav", "vo/npc/male01/hi02.wav" } ), 75, 100, 1, CHAN_AUTO ) -- Same as below
            end

            ply.LastHi = CurTime()
        end
    end

    -- DROP WEAPON
    if button == KEY_X then
        if SERVER then
            local activeWeapon = ply:GetActiveWeapon()
            print(activeWeapon:GetSlot() )
            if activeWeapon:GetSlot() == 0 then return end
            print( "DROP WEP" )
            ply:DropWeapon( ply:GetActiveWeapon() )
        end
    end

    -- SWITCH WEAPON 0
    if button == KEY_1 and SERVER then
        local weapons = ply:GetWeapons()
        for _, wep in pairs( weapons ) do
            if wep:GetSlot() == 0 and ply:GetActiveWeapon() != wep  and wep:GetSlotPos() == 0 then
                ply:SelectWeapon( wep:GetClass() )
                return
            end
        end
    end

    -- SWITCH WEAPON 1
    if button == KEY_2 and SERVER then
        local weapons = ply:GetWeapons()
        for _, wep in pairs( weapons ) do
            if wep:GetSlot() == 1 and ply:GetActiveWeapon() != wep then
                ply:SelectWeapon( wep:GetClass() )
                return
            end
        end
    end

    -- SWITCH WEAPON 2
    if button == KEY_3 and SERVER then
        local weapons = ply:GetWeapons()
        for _, wep in pairs( weapons ) do
            if wep:GetSlot() == 2 and ply:GetActiveWeapon() != wep then
                ply:SelectWeapon( wep:GetClass() )
                return
            end
        end
    end

    if button == MOUSE_WHEEL_UP and SERVER then
        local activeWep = ply:GetActiveWeapon()
        local activeSlot = activeWep:GetSlot()
        print("up")
    end
end

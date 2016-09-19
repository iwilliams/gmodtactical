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
end )

function GM:PlayerButtonDown( ply, button )
    if button == KEY_Q then
        if SERVER and ply.LastHi + 2 <= CurTime() then

            --local trace = util.QuickTrace( ply:GetShootPos(), ply:GetAimVector() * 8192, ply )

            --if ( trace.Entity && trace.Entity:IsNPC() && GMT:NPCGetFaction( trace.Entity ) != "" && ply.Factions[GMT:NPCGetFaction( trace.Entity )] > 0 ) then
                --ply:EmitSound( "vo/npc/male01/squad_away03.wav", 75, 100, 1, CHAN_AUTO ) -- Same as below
            --else

            if ply:KeyDown( IN_SPEED ) then
                ply:EmitSound( table.Random( { "vo/npc/male01/runforyourlife01.wav", "vo/npc/male01/runforyourlife02.wav", "vo/npc/male01/runforyourlife02.wav" } ), 75, 100, 1, CHAN_AUTO ) -- Same as below
            elseif ply:GetActiveWeapon().dt.State == CW_AIMING then
                ply:EmitSound( "vo/npc/male01/getdown02.wav", 75, 100, 1, CHAN_AUTO ) -- Same as below
            else
                ply:EmitSound( table.Random( { "vo/npc/male01/hi01.wav", "vo/npc/male01/hi02.wav" } ), 75, 100, 1, CHAN_AUTO ) -- Same as below
            end

            ply.LastHi = CurTime()
        end
    end

    if button == KEY_X then
        if SERVER then
            local activeWeapon = ply:GetActiveWeapon()
            print(activeWeapon:GetSlot() )
            if activeWeapon:GetSlot() == 0 then return end
            print( "DROP WEP" )
            ply:DropWeapon( ply:GetActiveWeapon() )
        end
    end

    if button == KEY_1 and SERVER then
        local weapons = ply:GetWeapons()
        for _, wep in pairs( weapons ) do
            if wep:GetSlot() == 0 and ply:GetActiveWeapon() != wep then
                ply:SelectWeapon( wep:GetClass() )
                return
            end
        end
    end

    if button == KEY_2 and SERVER then
        local weapons = ply:GetWeapons()
        for _, wep in pairs( weapons ) do
            if wep:GetSlot() == 1 and ply:GetActiveWeapon() != wep then
                ply:SelectWeapon( wep:GetClass() )
                return
            end
        end
    end

    if button == KEY_3 and SERVER then
        local weapons = ply:GetWeapons()
        for _, wep in pairs( weapons ) do
            if wep:GetSlot() == 2 and ply:GetActiveWeapon() != wep then
                ply:SelectWeapon( wep:GetClass() )
                return
            end
        end
    end
end

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

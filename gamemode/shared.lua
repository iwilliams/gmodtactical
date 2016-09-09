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

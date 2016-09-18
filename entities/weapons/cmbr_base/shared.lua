if (SERVER) then

AddCSLuaFile( "shared.lua" )
SWEP.AutoSwitchTo       = false
SWEP.AutoSwitchFrom     = false

end

SWEP.PrintName          = "Unarmed" -- This will be shown in the spawn menu, and in the weapon selection menu
SWEP.Author         = "( your name )" -- These two options will be shown when you have the weapon highlighted in the weapon selection menu
SWEP.Instructions       = "Left mouse to fire a chair!"

SWEP.Primary.ClipSize       = -1
SWEP.Primary.DefaultClip    = -1
SWEP.Primary.Automatic      = true
SWEP.Primary.Ammo       = "none"

SWEP.Secondary.ClipSize     = -1
SWEP.Secondary.DefaultClip  = -1
SWEP.Secondary.Automatic    = false
SWEP.Secondary.Ammo     = "none"

SWEP.Weight         = 5
SWEP.AutoSwitchTo       = false
SWEP.AutoSwitchFrom     = false

SWEP.Slot               = 0
SWEP.SlotPos            = 2
SWEP.DrawAmmo           = false
SWEP.DrawCrosshair      = true

SWEP.UseHands = true

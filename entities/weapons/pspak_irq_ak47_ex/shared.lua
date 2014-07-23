SWEP.Base = "weapon_cc_base_ex"

if SERVER then
	AddCSLuaFile ("shared.lua")
end

SWEP.Spawnable				= true
SWEP.AdminSpawnable			= true

SWEP.PrintName				= "AK47"

SWEP.Slot					= 2
SWEP.IconLetter				= "b"

SWEP.ViewModel				= "models/weapons/v_irq_ak47.mdl"	-- Weapon view model
SWEP.WorldModel				= "models/weapons/w_irq_ak47.mdl"	-- Weapon world model
SWEP.ViewModelAimPos		= Vector (4.1774, -2.0709, 2.355) -- ORIGINAL
SWEP.ViewModelAimPos		= Vector (40.1774, -2.0709, 2.355)
--SWEP.ViewModelAimPos		= Vector (6.0774, 0, 1.9644) -- real ironsights; totally does not work
--SWEP.ViewModelAimAng		= Vector (2.8406, -0.0088, -0.4718)
SWEP.ViewModelFlip			= false

SWEP.DrawAmmo				= false
SWEP.DrawCrosshair			= false

 SWEP.Primary.Sound			= Sound("gunshot_irq_ak47")
-- SWEP.Primary.BullettimeSound		= Sound ("weapons/ak47/ak47-1.wav")
SWEP.Primary.BullettimeSoundPitch	= 70
SWEP.Primary.Damage			= 75
SWEP.Primary.NumShots		= 1
SWEP.Primary.Cone			= 0.03
SWEP.Primary.ConeZoomed		= 0.004
SWEP.Primary.Delay			= 0.1

SWEP.Primary.ClipSize		= 31
SWEP.Primary.DefaultClip	= 270
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "smg1"

SWEP.Recoil					= 1.3

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "none"

						-- (x, z (-towards +away), y)
SWEP.IronSightsPos = Vector (-2.9, -1, .5)
						-- (?, ? (twist +left +right))
SWEP.IronSightsAng = Vector (0, 0, 0)

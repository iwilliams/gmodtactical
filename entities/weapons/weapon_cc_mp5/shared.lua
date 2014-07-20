SWEP.Base = "weapon_cc_base"

SWEP.ViewModel				= "models/weapons/v_navymp5.mdl"	-- Weapon view model
SWEP.WorldModel				= "models/weapons/w_hk_mp5.mdl"	-- Weapon world model
SWEP.ViewModelFlip		= false
SWEP.HoldType				= "ar2"
SWEP.Spawnable			= true
SWEP.AdminSpawnable		= false

SWEP.m_WeaponDeploySpeed = 1

SWEP.Primary.Recoil		= 0.6
SWEP.Primary.Damage		= 20
SWEP.Primary.NumShots		= 1
SWEP.Primary.Cone			= .01
SWEP.Primary.Delay 		= 0.08

SWEP.Primary.ClipSize		= 30					// Size of a clip
SWEP.Primary.DefaultClip	= 60					// Default number of bullets in a clip
SWEP.Primary.Automatic		= true				// Automatic/Semi Auto
SWEP.Primary.Ammo			= "AirboatGun"

SWEP.Secondary.ClipSize		= -1					// Size of a clip
SWEP.Secondary.DefaultClip	= -1					// Default number of bullets in a clip
SWEP.Secondary.Automatic	= false				// Automatic/Semi Auto
SWEP.Secondary.Ammo		= "none"

SWEP.Pistol				= false
SWEP.Rifle				= true
SWEP.Shotgun			= false
SWEP.Sniper				= false

						-- (x, z (-towards +away), y)
SWEP.IronSightsPos = Vector (-2.9, -1, .5)
						-- (?, ? (twist +left +right))
SWEP.IronSightsAng = Vector (0, 0, 0)
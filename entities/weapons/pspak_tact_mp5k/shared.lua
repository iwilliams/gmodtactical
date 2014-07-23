-- Variables that are used on both client and server
SWEP.Gun = ("pspak_tact_mp5k") -- must be the name of your swep but NO CAPITALS!
SWEP.Category				= "Mr. Pyrous' SWEP Pack" --Category where you will find your weapons
SWEP.Author				= "Mr. Pyrous"
SWEP.Contact				= ""
SWEP.Purpose				= "Isn't it obvious?"
SWEP.Instructions				= "You know what to do, don't you? :3"
SWEP.PrintName				= "HK MP5K"		-- Weapon name (Shown on HUD)	
SWEP.Slot				= 2				-- Slot in the weapon selection menu
SWEP.SlotPos				= 4			-- Position in the slot
SWEP.DrawAmmo				= true		-- Should draw the default HL2 ammo counter
SWEP.DrawWeaponInfoBox		= false		-- Should draw the weapon info box
SWEP.BounceWeaponIcon   	= false		-- Should the weapon icon bounce?
SWEP.DrawCrosshair			= true		-- set false if you want no crosshair
SWEP.Weight					= 28		-- rank relative ot other weapons. bigger is better
SWEP.AutoSwitchTo			= true		-- Auto switch to if we pick it up
SWEP.AutoSwitchFrom			= true		-- Auto switch from if you pick up a better weapon
SWEP.HoldType 				= "smg"		-- how others view you carrying the weapon
-- normal melee melee2 fist knife smg ar2 pistol rpg physgun grenade shotgun crossbow slam passive 
-- you're mostly going to use ar2, smg, shotgun or pistol. rpg makes for good sniper rifles

SWEP.ViewModelFOV			= 70
SWEP.ViewModelFlip			= true
SWEP.ViewModel				= "models/weapons/v_tak_mp5.mdl"	-- Weapon view model
SWEP.WorldModel				= "models/weapons/w_tak_mp5.mdl"	-- Weapon world model
SWEP.ShowWorldModel			= false
SWEP.Base				= "pyrous_gun_base" --the Base this weapon will work on. PLEASE RENAME THE BASE! 
SWEP.Spawnable				= true
SWEP.AdminSpawnable			= true

SWEP.Primary.Sound			= Sound("gunshot_tact_mp5k")		-- Script that calls the primary fire sound
SWEP.Primary.SilencedSound 	= Sound("")		-- Sound if the weapon is silenced
SWEP.Primary.RPM			= 900			-- This is in Rounds Per Minute
SWEP.Primary.ClipSize			= 30		-- Size of a clip
SWEP.Primary.DefaultClip		= 90		-- Bullets you start with
SWEP.Primary.KickUp				= 0.1		-- Maximum up recoil (rise)
SWEP.Primary.KickDown			= 0.1		-- Maximum down recoil (skeet)
SWEP.Primary.KickHorizontal		= 0.2		-- Maximum up recoil (stock)
SWEP.Primary.Automatic			= true		-- Automatic = true; Semi Auto = false
SWEP.Primary.Ammo			= "smg1"			-- pistol, 357, smg1, ar2, buckshot, slam, SniperPenetratedRound, AirboatGun
-- Pistol, buckshot, and slam always ricochet. 
--Use AirboatGun for a light metal peircing shotgun pellets
SWEP.SelectiveFire		= true
SWEP.CanBeSilenced		= false

SWEP.Secondary.IronFOV			= 38		-- How much you 'zoom' in. Less is more! 	

SWEP.data 				= {}				--The starting firemode
SWEP.data.ironsights			= 1

SWEP.Primary.Damage		= 11	-- Base damage per bullet
SWEP.Primary.Spread		= .025	-- Define from-the-hip accuracy 1 is terrible, .0001 is exact)
SWEP.Primary.IronAccuracy = .015 -- Ironsight accuracy, should be the same for shotguns

-- Enter iron sight info and bone mod info below
SWEP.IronSightsPos = Vector(3.716,0,0.644)	--Iron Sight positions and angles. Use the Iron sights utility in 
SWEP.IronSightsAng = Vector(0,0,0)	            --Clavus's Swep Construction Kit to get these vectors
SWEP.SightsPos = Vector (3.716,0,0.644)
SWEP.SightsAng = Vector (0,0,0)
SWEP.RunSightsPos = Vector(-3.343,-6.707,0.882)	--These are for the angles your viewmodel will be when running
SWEP.RunSightsAng = Vector(-9.615,-62.199,4.236)	--Again, use the Swep Construction Kit

SWEP.WElements = {
	["mp5k"] = { type = "Model", model = "models/weapons/w_tak_mp5.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(-3.296, 0.308, 0.174), angle = Angle(-1.39, -3.467, -180), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}
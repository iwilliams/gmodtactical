-- Variables that are used on both client and server
SWEP.Gun = ("pspak_hk_416") -- must be the name of your swep but NO CAPITALS!
SWEP.Category				= "Mr. Pyrous' SWEP Pack" --Category where you will find your weapons
SWEP.Author				= "Mr. Pyrous"
SWEP.Contact				= ""
SWEP.Purpose				= "Isn't it obvious?"
SWEP.Instructions				= "You know what to do, don't you? :3"
SWEP.PrintName				= "HK 416"		-- Weapon name (Shown on HUD)	
SWEP.Slot				= 2				-- Slot in the weapon selection menu
SWEP.SlotPos				= 4			-- Position in the slot
SWEP.DrawAmmo				= true		-- Should draw the default HL2 ammo counter
SWEP.DrawWeaponInfoBox			= false		-- Should draw the weapon info box
SWEP.BounceWeaponIcon   		= 	false	-- Should the weapon icon bounce?
SWEP.DrawCrosshair			= true		-- Set false if you want no crosshair from hip
SWEP.Weight				= 30			-- Rank relative ot other weapons. bigger is better
SWEP.AutoSwitchTo			= true		-- Auto switch to if we pick it up
SWEP.AutoSwitchFrom			= true		-- Auto switch from if you pick up a better weapon
SWEP.XHair					= true		-- Used for returning crosshair after scope. Must be the same as DrawCrosshair
SWEP.BoltAction				= false		-- Is this a bolt action rifle?
SWEP.HoldType 				= "smg"		-- how others view you carrying the weapon
-- normal melee melee2 fist knife smg ar2 pistol rpg physgun grenade shotgun crossbow slam passive 
-- you're mostly going to use ar2, smg, shotgun or pistol. rpg and crossbow make for good sniper rifles

SWEP.ViewModelFOV			= 70
SWEP.ViewModelFlip			= false
SWEP.ViewModel				= "models/weapons/v_hnk_416.mdl"	-- Weapon view model
SWEP.WorldModel				= "models/weapons/w_hnk_416.mdl"	-- Weapon world model
SWEP.ShowWorldModel			= false
SWEP.Base 				= "pyrous_gun_base" --the Base this weapon will work on. PLEASE RENAME THE BASE!
SWEP.Spawnable				= true
SWEP.AdminSpawnable			= true

SWEP.Primary.Sound			= Sound("gunshot_hk_416")		-- Script that calls the primary fire sound
SWEP.Primary.SilencedSound 	= Sound("")		-- Sound if the weapon is silenced
SWEP.Primary.RPM			= 800			-- This is in Rounds Per Minute
SWEP.Primary.ClipSize			= 30		-- Size of a clip
SWEP.Primary.DefaultClip		= 90		-- Bullets you start with
SWEP.Primary.KickUp				= 0.2		-- Maximum up recoil (rise)
SWEP.Primary.KickDown			= 0.2		-- Maximum down recoil (skeet)
SWEP.Primary.KickHorizontal		= 0.2		-- Maximum up recoil (stock)
SWEP.Primary.Automatic			= true		-- Automatic = true; Semi Auto = false
SWEP.Primary.Ammo			= "ar2"			-- pistol, 357, smg1, ar2, buckshot, slam, SniperPenetratedRound, AirboatGun
-- Pistol, buckshot, and slam always ricochet. 
--Use AirboatGun for a light metal peircing shotgun pellets
SWEP.SelectiveFire		= true
SWEP.CanBeSilenced		= false

SWEP.Secondary.IronFOV			= 38		-- How much you 'zoom' in. Less is more! 	

SWEP.data 				= {}				--The starting firemode
SWEP.data.ironsights			= 1

SWEP.Primary.Damage		= 14	--base damage per bullet
SWEP.Primary.Spread		= .02	--define from-the-hip accuracy 1 is terrible, .0001 is exact)
SWEP.Primary.IronAccuracy = .01 -- ironsight accuracy, should be the same for shotguns

-- enter iron sight info and bone mod info below
SWEP.IronSightsPos = Vector(-2.881,0,0.259)	--Iron Sight positions and angles. Use the Iron sights utility in 
SWEP.IronSightsAng = Vector(0,0,0)	            --Clavus's Swep Construction Kit to get these vectors
SWEP.SightsPos = Vector (-2.881,0,0.259)
SWEP.SightsAng = Vector (0,0,0)
SWEP.RunSightsPos = Vector(3.539,-5.836,0.409)	--These are for the angles your viewmodel will be when running
SWEP.RunSightsAng = Vector(-20.209,64.088,-14.219)

SWEP.WElements = {
	["hk_416"] = { type = "Model", model = "models/weapons/w_hnk_416.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(-1.058, 0.583, 0.736), angle = Angle(-10.631, -4.217, -180), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}
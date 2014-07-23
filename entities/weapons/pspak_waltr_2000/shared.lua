-- Variables that are used on both client and server
SWEP.Gun = ("pspak_waltr_2000") -- must be the name of your swep but NO CAPITALS!
SWEP.Category				= "Mr. Pyrous' SWEP Pack" --Category where you will find your weapons
SWEP.Author				= "Mr. Pyrous"
SWEP.Contact				= ""
SWEP.Purpose				= "Isn't it obvious?"
SWEP.Instructions				= "You know what to do, don't you? :3"
SWEP.PrintName				= "Walther 2000"		-- Weapon name (Shown on HUD)	
SWEP.Slot				= 3				-- Slot in the weapon selection menu
SWEP.SlotPos				= 5			-- Position in the slot
SWEP.DrawAmmo				= true		-- Should draw the default HL2 ammo counter
SWEP.DrawWeaponInfoBox			= false		-- Should draw the weapon info box
SWEP.BounceWeaponIcon   		= 	false	-- Should the weapon icon bounce?
SWEP.DrawCrosshair			= true		-- Set false if you want no crosshair from hip
SWEP.Weight				= 30			-- Rank relative ot other weapons. bigger is better
SWEP.AutoSwitchTo			= true		-- Auto switch to if we pick it up
SWEP.AutoSwitchFrom			= true		-- Auto switch from if you pick up a better weapon
SWEP.XHair					= true		-- Used for returning crosshair after scope. Must be the same as DrawCrosshair
SWEP.BoltAction				= false		-- Is this a bolt action rifle?
SWEP.HoldType 				= "ar2"		-- how others view you carrying the weapon
-- normal melee melee2 fist knife smg ar2 pistol rpg physgun grenade shotgun crossbow slam passive 
-- you're mostly going to use ar2, smg, shotgun or pistol. rpg and crossbow make for good sniper rifles

SWEP.ViewModelFOV			= 70
SWEP.ViewModelFlip			= true
SWEP.ViewModel				= "models/weapons/v_waltr_2000.mdl"	-- Weapon view model
SWEP.WorldModel				= "models/weapons/w_waltr_2000.mdl"	-- Weapon world model
SWEP.ShowWorldModel			= false
SWEP.Base 				= "pyrous_scoped_base" --the Base this weapon will work on. PLEASE RENAME THE BASE!
SWEP.Spawnable				= true
SWEP.AdminSpawnable			= true

SWEP.Primary.Sound			= Sound("gunshot_waltr_2000")		-- script that calls the primary fire sound
SWEP.Primary.RPM			= 632		-- This is in Rounds Per Minute
SWEP.Primary.ClipSize		    = 6		-- Size of a clip
SWEP.Primary.DefaultClip		= 18	-- Bullets you start with
SWEP.Primary.KickUp			    = 1				-- Maximum up recoil (rise)
SWEP.Primary.KickDown			= 1			-- Maximum down recoil (skeet)
SWEP.Primary.KickHorizontal		= 1		-- Maximum up recoil (stock)
SWEP.Primary.Automatic			= false	-- Automatic/Semi Auto
SWEP.Primary.Ammo			= "ar2"	-- pistol, 357, smg1, ar2, buckshot, slam, SniperPenetratedRound, AirboatGun
-- Pistol, buckshot, and slam always ricochet. Use AirboatGun for a light metal peircing shotgun pellets
SWEP.SelectiveFire		= false

SWEP.Secondary.ScopeZoom			= 10
SWEP.Secondary.UseACOG			= false  -- Choose one scope type
SWEP.Secondary.UseMilDot		= true	-- I mean it, only one	
SWEP.Secondary.UseSVD			= false	-- If you choose more than one, your scope will not show up at all
SWEP.Secondary.UseParabolic		= false	
SWEP.Secondary.UseElcan			= false
SWEP.Secondary.UseGreenDuplex	= false
SWEP.Secondary.UseAimpoint		= false	

SWEP.data 				= {}
SWEP.data.ironsights			= 1
SWEP.ScopeScale 			= 0.5
SWEP.ReticleScale 				= 0.6

SWEP.Primary.Damage		= 85	--base damage per bullet
SWEP.Primary.Spread		= .01	--define from-the-hip accuracy 1 is terrible, .0001 is exact)
SWEP.Primary.IronAccuracy = .0003 -- ironsight accuracy, should be the same for shotguns

-- enter iron sight info and bone mod info below

SWEP.IronSightsPos = Vector(3.141,0.001,0.819)	--Iron Sight positions and angles. Use the Iron sights utility in 
SWEP.IronSightsAng = Vector(0,0,0)	            --Clavus's Swep Construction Kit to get these vectors
SWEP.SightsPos = Vector(3.141,0.001,0.819)
SWEP.SightsAng = Vector (0,0,0)
SWEP.RunSightsPos = Vector(-5.296,-4.862,0.418)	--These are for the angles your viewmodel will be when running
SWEP.RunSightsAng = Vector(-7.769,-58.5,5.405)

SWEP.WElements = {
	["waltr_2000"] = { type = "Model", model = "models/weapons/w_waltr_2000.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(-0.055, 0.223, 0.174), angle = Angle(-4.161, -2.553, -180), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}
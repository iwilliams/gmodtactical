-- Variables that are used on both client and server
SWEP.Gun = ("pspak_benli_m3")					-- must be the name of your swep
SWEP.Category				= "Mr. Pyrous' SWEP Pack"
SWEP.Author				= "Mr. Pyrous"
SWEP.Contact				= ""
SWEP.Purpose				= "Isn't it obvious?"
SWEP.Instructions				= "You know what to do, don't you? :3"
SWEP.PrintName				= "Benelli M3"		-- Weapon name (Shown on HUD)	
SWEP.Slot				= 3				-- Slot in the weapon selection menu
SWEP.SlotPos				= 143		-- Position in the slot
SWEP.DrawAmmo				= true		-- Should draw the default HL2 ammo counter
SWEP.DrawWeaponInfoBox			= false		-- Should draw the weapon info box
SWEP.BounceWeaponIcon   		= 	false	-- Should the weapon icon bounce?
SWEP.DrawCrosshair			= true		-- set false if you want no crosshair
SWEP.Weight				= 30			-- rank relative to other weapons. bigger is better
SWEP.AutoSwitchTo			= true		-- Auto switch to if we pick it up
SWEP.AutoSwitchFrom			= true		-- Auto switch from if you pick up a better weapon
SWEP.HoldType 				= "shotgun"

SWEP.ViewModelFOV			= 70
SWEP.ViewModelFlip			= true
SWEP.ViewModel				= "models/weapons/v_hnk1_m3super90.mdl"	-- Weapon view model
SWEP.WorldModel				= "models/weapons/w_hnk1_m3super90.mdl"	-- Weapon world model
SWEP.Base 				= "pyrous_shotty_base"
SWEP.ShowWorldModel			= false
SWEP.Spawnable				= true
SWEP.AdminSpawnable			= true

SWEP.Primary.Sound			= Sound("gunshot_benli_m3")		-- script that calls the primary fire sound
SWEP.Primary.RPM				= 70		-- This is in Rounds Per Minute
SWEP.Primary.ClipSize			= 8			-- Size of a clip
SWEP.Primary.DefaultClip		= 24	-- Default number of bullets in a clip
SWEP.Primary.KickUp				= 0.8			-- Maximum up recoil (rise)
SWEP.Primary.KickDown			= 0.5		-- Maximum down recoil (skeet)
SWEP.Primary.KickHorizontal		= 0.3	-- Maximum up recoil (stock)
SWEP.Primary.Automatic			= false		-- Automatic/Semi Auto
SWEP.Primary.Ammo			= "buckshot"	-- pistol, 357, smg1, ar2, buckshot, slam, SniperPenetratedRound, AirboatGun
-- Pistol, buckshot, and slam always ricochet. Use AirboatGun for a light metal peircing shotgun pellets

SWEP.Secondary.IronFOV			= 38		-- How much you 'zoom' in. Less is more! 

SWEP.data 				= {}				--The starting firemode
SWEP.data.ironsights			= 1

SWEP.ShellTime			= .45

SWEP.Primary.NumShots	= 9		-- How many bullets to shoot per trigger pull, AKA pellets
SWEP.Primary.Damage		= 10	-- Base damage per bullet
SWEP.Primary.Spread		= .0326	-- Define from-the-hip accuracy 1 is terrible, .0001 is exact)
SWEP.Primary.IronAccuracy = .0326	-- Ironsight accuracy, should be the same for shotguns
-- Because irons don't magically give you less pellet spread!

-- Enter iron sight info and bone mod info below
SWEP.IronSightsPos = Vector(2.279,0,1.279)
SWEP.IronSightsAng = Vector(0.349,-0.004,0)
SWEP.SightsPos = Vector(2.279,0,1.279)
SWEP.SightsAng = Vector(0.349,-0.004,0)
SWEP.RunSightsPos = Vector(-6.544,-6.228,1.233)	--These are for the angles your viewmodel will be when running
SWEP.RunSightsAng = Vector(-17.58,-59.69,6.748)

SWEP.WElements = {
	["benli_m3"] = { type = "Model", model = "models/weapons/w_hnk1_m3super90.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(3.134, 0.996, 1.115), angle = Angle(-12.266, -2.52, -167.842), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}
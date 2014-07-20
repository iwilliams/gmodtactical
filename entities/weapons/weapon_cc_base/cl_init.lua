include('shared.lua')

SWEP.PrintName			= "CC Weapon Base"			// 'Nice' Weapon name (Shown on HUD)	
SWEP.Slot				= 0							// Slot in the weapon selection menu
SWEP.SlotPos			= 1							// Position in the slot
SWEP.DrawAmmo			= true						// Should draw the default HL2 ammo counter?
SWEP.DrawCrosshair		= false 						// Should draw the default crosshair?
SWEP.DrawWeaponInfoBox		= false						// Should draw the weapon info box?
SWEP.BounceWeaponIcon   	= false						// Should the weapon icon bounce?
SWEP.SwayScale			= 1.0							// The scale of the viewmodel sway
SWEP.BobScale			= 1.0							// The scale of the viewmodel bob

local IRONSIGHT_TIME = 0.2
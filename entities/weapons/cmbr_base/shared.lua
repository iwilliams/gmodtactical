--//SWEP BASE CREATED BY BLOODRAYNE\\
--\\Version: 1.4.9                 //
if (SERVER) then

AddCSLuaFile( "shared.lua" )
SWEP.Weight         = 5
SWEP.AutoSwitchTo       = false
SWEP.AutoSwitchFrom     = false

end

if ( CLIENT ) then

SWEP.WeaponSelectIconLetter = "B"
SWEP.DrawAmmo           = true
--SWEP.DrawCrosshair        = false
SWEP.DrawWeaponInfoBox      = true                  // Should draw the weapon info box
SWEP.BounceWeaponIcon       = false                 // Should the weapon icon bounce?
SWEP.SwayScale          = 1.0                   // The scale of the viewmodel sway
SWEP.BobScale           = 1.0                   // The scale of the viewmodel bob
SWEP.WepSelectIcon      = surface.GetTextureID( "weapons/swep" )
SWEP.ViewModelFOV       = 75
SWEP.ViewModelFlip      = false
SWEP.CSMuzzleFlashes        = false

-- This is the font that's used to draw the death icons
--surface.CreateFont( "csd", ScreenScale( 30 ), 500, true, true, "CSKillIcons" )
--surface.CreateFont( "csd", ScreenScale( 60 ), 500, true, true, "CSSelectIcons" )
--surface.CreateFont( "Counter-Strike", ScreenScale( 60 ), 500, true, true, "CSSIcons" )

end

SWEP.Category           = "Your category here"

SWEP.Author             = "Your name here"
SWEP.Contact                = "Your email here"
SWEP.Purpose                = ""
SWEP.Instructions           = "Point. Aim. Shoot."

SWEP.Spawnable              = false
SWEP.AdminSpawnable         = false

SWEP.UseCustomMuzzleFlash       = true
SWEP.MuzzleEffect           = "CSSMuzzleFlashX"
SWEP.MuzzleAttachment           = "1"

SWEP.ShakeWeaponSelectIcon      = false

--SWEP.TracerFreq           = 0
SWEP.TracerType                     = "Tracer"

--Some Possible Tracer Values:
-- Tracer
-- AR2Tracer
-- HelicopterTracer
-- AirboatGunTracer
-- AirboatGunHeavyTracer

SWEP.InfiniteAmmo                       = false
SWEP.UseScope                           = false
SWEP.WeaponDeploySpeed                  = 1

--SWEP.ZoomedPrimaryAutomatic       = false
--SWEP.ZoomedPrimaryDelay       = 10
--SWEP.ZoomedPrimaryCone        = 10
--SWEP.ZoomedPrimaryDamage      = 10
--SWEP.ZoomedPrimaryRecoil      = 0.2
--SWEP.ZoomedTracerFreq         = 1
--SWEP.ZoomedDrawCrosshair      = false

--SWEP.UnzoomedPrimaryAutomatic     = false
--SWEP.UnzoomedPrimaryDelay     = 0.15
--SWEP.UnzoomedPrimaryCone      = 0.02
--SWEP.UnzoomedPrimaryDamage        = 40
--SWEP.UnzoomedPrimaryRecoil        = 0.2
--SWEP.UnzoomedTracerFreq       = 0
--SWEP.UnzoomedDrawCrosshair        = false

SWEP.Primary.BulletForce                = "5"
SWEP.Primary.WeaponDrawSound            = ""
SWEP.Primary.CustomReloadSound          = ""
SWEP.Primary.Sound          = "Weapon_AK47.Single"
--SWEP.Primary.Recoil           = 0.2
--SWEP.Primary.Damage           = 40
SWEP.Primary.NumShots           = 1
--SWEP.Primary.Cone         = 0.02
--SWEP.Primary.Delay            = 0.15

SWEP.Primary.ClipSize           = -1
SWEP.Primary.DefaultClip        = -1
--SWEP.Primary.Automatic        = false
SWEP.Primary.Ammo           = "smg1"

SWEP.Secondary.ClipSize         = -1
SWEP.Secondary.DefaultClip      = -1
SWEP.Secondary.Automatic        = false
SWEP.Secondary.Ammo         = "none"

local IronSightSound1 = Sound( "weapons/generic/ironsight_on.wav" );
local IronSightSound2 = Sound( "weapons/generic/ironsight_off.wav" );
local ShootThingSound = Sound ("player/pistolhit/PistolHit" .. math.random(1,3) .. ".wav");

--[[-----------------------------------------------------------
Name: SWEP:Deploy( )
Desc: Whip it out
---------------------------------------------------------]]--
function SWEP:Deploy()
self.Primary.Automatic = self.UnzoomedPrimaryAutomatic
self.Primary.Delay = self.UnzoomedPrimaryDelay
self.Primary.Cone = self.UnzoomedPrimaryCone
self.Primary.Damage = self.UnzoomedPrimaryDamage
self.Primary.Recoil = self.UnzoomedPrimaryRecoil
self.TracerFreq = self.UnzoomedTracerFreq
self.DrawCrosshair = self.UnzoomedDrawCrosshair
self.Weapon:EmitSound( Sound( self.Primary.WeaponDrawSound ) )
self:SetIronsights(false, self.Owner)
return true
end


--[[---------------------------------------------------------
---------------------------------------------------------]]--
function SWEP:Initialize()

if ( SERVER ) then
self:SetWeaponHoldType( self.HoldType )
self:SetNPCMinBurst( 30 )
self:SetNPCMaxBurst( 30 )
self:SetNPCFireRate( 0.01 )
end

self.Primary.Automatic = self.UnzoomedPrimaryAutomatic
self.Primary.Delay = self.UnzoomedPrimaryDelay
self.Primary.Cone = self.UnzoomedPrimaryCone
self.Primary.Damage = self.UnzoomedPrimaryDamage
self.Primary.Recoil = self.UnzoomedPrimaryRecoil
self.TracerFreq = self.UnzoomedTracerFreq
self.DrawCrosshair = self.UnzoomedDrawCrosshair
self.ScopeLevel = 0

self.Weapon:SetDeploySpeed( self.WeaponDeploySpeed )

self.Weapon:SetNetworkedBool( "Zoomed", false )

self.Weapon:SetNetworkedBool( "Ironsights", false )

end


--[[---------------------------------------------------------
Reload is being pressed
---------------------------------------------------------]]--
function SWEP:Reload()
self:SetIronsights(false)
self.Weapon:DefaultReload( ACT_VM_RELOAD )
if (self.UseScope == true) then
if ( (self.ScopeLevel == 1) or (self.ScopeLevel == 2) ) then
if self.Weapon:DefaultReload() then
self.Primary.Automatic = self.UnzoomedPrimaryAutomatic
self.Primary.Delay = self.UnzoomedPrimaryDelay
self.Primary.Cone = self.UnzoomedPrimaryCone
self.Primary.Damage = self.UnzoomedPrimaryDamage
self.Primary.Recoil = self.UnzoomedPrimaryRecoil
self.TracerFreq = self.UnzoomedTracerFreq
self.DrawCrosshair = self.UnzoomedDrawCrosshair
if (SERVER) then
self.Owner:SetFOV( self.OriginalFOV, 0.3 )
end
self:SetZoomed(false)
self.ScopeLevel = 0
end
end
end
if self.Weapon:DefaultReload() then
self.Weapon:EmitSound( Sound( self.Primary.CustomReloadSound ) )
end
end

--[[---------------------------------------------------------
GetViewModelPosition
---------------------------------------------------------]]--
local IRONSIGHT_TIME = 0.15
-- Time to enter in the ironsight mod

function SWEP:GetViewModelPosition(pos, ang)

if (not self.IronSightsPos) then return pos, ang end

local bIron = self.Weapon:GetNWBool("Ironsights")

if (bIron != self.bLastIron) then
self.bLastIron = bIron
self.fIronTime = CurTime()

if (bIron) then
self.SwayScale  = 0.3
self.BobScale   = 0.1
else
self.SwayScale  = 1.0
self.BobScale   = 1.0
end
end

local fIronTime = self.fIronTime or 0

if (not bIron and fIronTime < CurTime() - IRONSIGHT_TIME) then
return pos, ang
end

local Mul = 1.0

if (fIronTime > CurTime() - IRONSIGHT_TIME) then
Mul = math.Clamp((CurTime() - fIronTime) / IRONSIGHT_TIME, 0, 1)

if not bIron then Mul = 1 - Mul end
end

local Offset    = self.IronSightsPos

if (self.IronSightsAng) then
ang = ang * 1
ang:RotateAroundAxis(ang:Right(),       self.IronSightsAng.x * Mul)
ang:RotateAroundAxis(ang:Up(),      self.IronSightsAng.y * Mul)
ang:RotateAroundAxis(ang:Forward(),     self.IronSightsAng.z * Mul)
end

local Right     = ang:Right()
local Up        = ang:Up()
local Forward   = ang:Forward()

pos = pos + Offset.x * Right * Mul
pos = pos + Offset.y * Forward * Mul
pos = pos + Offset.z * Up * Mul

return pos, ang
end

--[[---------------------------------------------------------
Runs every tick
---------------------------------------------------------]]--
function SWEP:Think()

self:IronSight()
end


--[[---------------------------------------------------------
PrimaryAttack
---------------------------------------------------------]]--
function SWEP:PrimaryAttack()

self.Weapon:SetNextSecondaryFire( CurTime() + self.Primary.Delay )
self.Weapon:SetNextPrimaryFire( CurTime() + self.Primary.Delay )

if ( !self:CanPrimaryAttack() ) then return end

self.Weapon:EmitSound( Sound( self.Primary.Sound ) )

self:CSShootBullet( self.Primary.Damage, self.Primary.Recoil, self.Primary.NumShots, self.Primary.Cone )

if ( self.InfiniteAmmo == false ) then
self:TakePrimaryAmmo( 1 )
end

if ( self.Owner:IsNPC() ) then return end

self.Owner:ViewPunch( Angle( math.Rand(-0.2,-0.1) * self.Primary.Recoil, math.Rand(-0.1,0.1) *self.Primary.Recoil, 0 ) )

if ( (SinglePlayer() && SERVER) || CLIENT ) then
self.Weapon:SetNetworkedFloat( "LastShootTime", CurTime() )
end

local tr = self.Owner:GetEyeTrace();
if tr.Entity:IsNPC() or tr.Entity:IsPlayer() then
tr.Entity:EmitSound (ShootThingSound)
end
end

--[[---------------------------------------------------------
Name: SWEP:PrimaryAttack( )
Desc: +attack1 has been pressed
---------------------------------------------------------]]--
function SWEP:CSShootBullet( dmg, recoil, numbul, cone )

numbul  = numbul    or 1
cone    = cone      or 0.01

local bullet = {}
bullet.Num      = numbul
bullet.Src      = self.Owner:GetShootPos()  // Source
bullet.Dir      = self.Owner:GetAimVector() // Dir of bullet
bullet.Spread   = Vector( cone, cone, 0 )       // Aim Cone
bullet.Tracer   = self.TracerFreq
bullet.TracerName   = self.TracerType
bullet.Force    = self.Primary.BulletForce      // Amount of force to give to phys objects
bullet.Damage   = dmg


-- Muzzle Flash from Teta_Bonita's 'Realistic' SWEP Base :/

local PlayerPos = self.Owner:GetShootPos()
local PlayerAim = self.Owner:GetAimVector()

local fx = EffectData()
fx:SetEntity(self.Weapon)
fx:SetOrigin(PlayerPos)
fx:SetNormal(PlayerAim)
fx:SetAttachment(self.MuzzleAttachment)
if (self.UseCustomMuzzleFlash == true) then
util.Effect(self.MuzzleEffect,fx)
else
self.Owner:MuzzleFlash()
end

self.Owner:FireBullets( bullet )
self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK )  // View model animation
self.Owner:SetAnimation( PLAYER_ATTACK1 )       // 3rd Person Animation

if ( self.Owner:IsNPC() ) then return end

-- CUSTOM RECOIL !
if ( (SinglePlayer() && SERVER) || ( !SinglePlayer() && CLIENT && IsFirstTimePredicted() ) ) then

local eyeang = self.Owner:EyeAngles()
eyeang.pitch = eyeang.pitch - recoil
self.Owner:SetEyeAngles( eyeang )

end

end


--[[---------------------------------------------------------
Checks the objects before any action is taken
This is to make sure that the entities haven't been removed
---------------------------------------------------------]]--
function SWEP:DrawWeaponSelection( x, y, wide, tall, alpha )

    --draw.SimpleText( self.WeaponSelectIconLetter, "CSSIcons", x + wide/2, y + tall*0.2, Color( 255, 189, 6, 255 ), TEXT_ALIGN_CENTER )

    -- try to fool them into thinking theyre playing a Tony Hawks game
    if (self.ShakeWeaponSelectIcon == true) then
        --draw.SimpleText( self.WeaponSelectIconLetter, "CSSIcons", x + wide/2 + math.Rand(-4, 4), y + tall*0.2+ math.Rand(-14, 14), Color( 255, 210, 0, math.Rand(10, 120) ), TEXT_ALIGN_CENTER )
        --draw.SimpleText( self.WeaponSelectIconLetter, "CSSIcons", x + wide/2 + math.Rand(-4, 4), y + tall*0.2+ math.Rand(-9, 9), Color( 255, 210, 0, math.Rand(10, 120) ), TEXT_ALIGN_CENTER )
    end

end

local IRONSIGHT_TIME = 0.25

--[[---------------------------------------------------------
Name: GetViewModelPosition
Desc: Allows you to re-position the view model
---------------------------------------------------------]]--
function SWEP:GetViewModelPosition( pos, ang )

if ( !self.IronSightsPos ) then return pos, ang end

local bIron = self.Weapon:GetNetworkedBool( "Ironsights" )

if ( bIron != self.bLastIron ) then

self.bLastIron = bIron
self.fIronTime = CurTime()

if ( bIron ) then
self.SwayScale  = 0.3
self.BobScale   = 0.1
else
self.SwayScale  = 1.0
self.BobScale   = 1.0
end

end

local fIronTime = self.fIronTime or 0

if ( !bIron && fIronTime < CurTime() - IRONSIGHT_TIME ) then
return pos, ang
end

local Mul = 1.0

if ( fIronTime > CurTime() - IRONSIGHT_TIME ) then

Mul = math.Clamp( (CurTime() - fIronTime) / IRONSIGHT_TIME, 0, 1 )

if (!bIron) then Mul = 1 - Mul end

end

local Offset    = self.IronSightsPos

if ( self.IronSightsAng ) then

ang = ang * 1
ang:RotateAroundAxis( ang:Right(),      self.IronSightsAng.x * Mul )
ang:RotateAroundAxis( ang:Up(),         self.IronSightsAng.y * Mul )
ang:RotateAroundAxis( ang:Forward(),    self.IronSightsAng.z * Mul )


end

local Right     = ang:Right()
local Up        = ang:Up()
local Forward   = ang:Forward()



pos = pos + Offset.x * Right * Mul
pos = pos + Offset.y * Forward * Mul
pos = pos + Offset.z * Up * Mul

return pos, ang

end


--[[---------------------------------------------------------
SetIronsights
---------------------------------------------------------]]--
function SWEP:SetIronsights(b)

self.Weapon:SetNetworkedBool("Ironsights", b)
end

function SWEP:GetIronsights()

return self.Weapon:GetNWBool("Ironsights")
end

--[[---------------------------------------------------------
SecondaryAttack
---------------------------------------------------------]]--
function SWEP:SecondaryAttack()

end

--[[---------------------------------------------------------
DrawHUD
---------------------------------------------------------]]--
function SWEP:DrawHUD()

local trace = {}
trace.start = spos
trace.endpos = self.Owner:GetEyeTrace().HitPos
trace.filter = self.Owner

local tr = util.TraceLine(trace)

if tr.HitNonWorld then
if tr.Entity:IsPlayer() then
if tr.Entity:Team() != self.Owner:Team() then
surface.SetTexture(surface.GetTextureID("VGUI/crosshair/combine_crosshair"))
surface.SetDrawColor( 255, 0, 0, 255 )
surface.DrawTexturedRect( ScrW()/2 - 24, ScrH()/2 - 24, 48, 48 )
return
end
end
if tr.Entity:IsNPC() then
surface.SetTexture(surface.GetTextureID("VGUI/crosshair/combine_crosshair"))
surface.SetDrawColor( 255, 0, 0, 255 )
surface.DrawTexturedRect( ScrW()/2 - 24, ScrH()/2 - 24, 48, 48 )
return
end
else
surface.SetTexture(surface.GetTextureID("VGUI/crosshair/combine_crosshair"))
surface.SetDrawColor( 255, 255, 255, 255 )
surface.DrawTexturedRect( ScrW()/2 - 24, ScrH()/2 - 24, 48, 48 )
return
end

surface.SetTexture(surface.GetTextureID("VGUI/crosshair/combine_crosshair"))
surface.SetDrawColor( 255, 255, 255, 255 )
surface.DrawTexturedRect( ScrW()/2 - 24, ScrH()/2 - 24, 48, 48 )
end

--[[---------------------------------------------------------
IronSight
---------------------------------------------------------]]--
function SWEP:IronSight()

if !self.Owner:KeyDown(IN_USE) then

if self.Owner:KeyPressed(IN_ATTACK2) then

self.Owner:SetFOV( 0, 0.15 )
self.Owner:ViewPunch( Angle( -1, -1, 0 ) )

self:SetIronsights(true, self.Owner)
self.Weapon:EmitSound( IronSightSound1 )

if CLIENT then return end
end
end

if self.Owner:KeyReleased(IN_ATTACK2) then

self.Owner:SetFOV( 0, 0.15 )
self.Owner:ViewPunch( Angle( 1, 1, 0 ) )

self:SetIronsights(false, self.Owner)
self.Weapon:EmitSound( IronSightSound2 )

if CLIENT then return end
end
end

--[[---------------------------------------------------------
onRestore
Loaded a saved game (or changelevel)
---------------------------------------------------------]]--
function SWEP:OnRestore()

self.NextSecondaryAttack = 0.5
self:SetIronsights( false )
self:SetZoomed(false)

end
--function GM:PlayerInitialSpawn( ply )
--ply:PrintMessage( HUD_PRINTTALK, "Bloodrayne's Weapon Base Loaded-Coded Manifold Base Replacement-" )
--end

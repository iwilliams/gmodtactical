if SERVER then
	AddCSLuaFile ("shared.lua")
end

local tracerFreq = CreateClientConVar ("twitch_tracerfreq", "0", true)
local aimSensitivity = CreateClientConVar ("twitch_aim_sensitivity", "1", true)
local recoilMul = CreateConVar ("twitch_recoilmul", "1", {FCVAR_REPLICATED, FCVAR_ARCHIVE})
local damageMul = CreateConVar ("twitch_damagemul", "1", {FCVAR_REPLICATED, FCVAR_ARCHIVE})
local quickDraw = CreateConVar ("twitch_quickdraw", "0", {FCVAR_REPLICATED, FCVAR_ARCHIVE})
local bulletTime = CreateConVar ("twitch_aim_bullettime", "0", {FCVAR_REPLICATED, FCVAR_ARCHIVE})
local bulletTimeOnJump = CreateConVar ("twitch_aim_bullettime_onjump", "0", {FCVAR_REPLICATED, FCVAR_ARCHIVE})
local bulletTimeTimeScale = CreateConVar ("twitch_aim_bullettime_timescale", "0.2", {FCVAR_REPLICATED, FCVAR_ARCHIVE})
local bulletTimeTracers = CreateConVar ("twitch_aim_bullettime_tracers", "1", {FCVAR_REPLICATED, FCVAR_ARCHIVE})
local bulletTimeColourDrain = CreateClientConVar ("twitch_aim_bullettime_colourdrain", "1", true)
local aimInfiniteAmmo = CreateConVar ("twitch_aim_infiniteammo", "0", {FCVAR_REPLICATED, FCVAR_ARCHIVE})
local hideHUD = CreateClientConVar ("twitch_hidehud", "0", true)
local aimHideHUD = CreateClientConVar ("twitch_aim_hidehud", "1", true)
local aimHideCrosshair = CreateClientConVar ("twitch_aim_hidecrosshair", "0", true)

local ply = FindMetaTable ("Player")
if not ply then return end

function ply:TWRecoil (pitch, yaw)
	-- SCRIPT ERRORS
	-- if SERVER and SinglePlayer() then 
	-- 	self:SendLua("LocalPlayer():TWRecoil("..pitch..","..yaw..")")
	-- 	return
	-- end
	
	self:GetTable().TWRecoilYaw = self:GetTable().TWRecoilYaw or 0
	self:GetTable().TWRecoilPitch = self:GetTable().TWRecoilPitch or 0
	
	self:GetTable().TWRecoilYaw = self:GetTable().TWRecoilYaw 		+ yaw
	self:GetTable().TWRecoilPitch = self:GetTable().TWRecoilPitch 	+ pitch
end

function ply:AddTWRecoil (cmd)
	local pitch 	= self:GetTable().TWRecoilPitch or 0
	local yaw 		= self:GetTable().TWRecoilYaw or 0
	
	local pitch_d	= math.Approach (pitch, 0.0, 32.0 * FrameTime() * math.abs(pitch))
	local yaw_d		= math.Approach (yaw, 0.0, 32.0 * FrameTime() * math.abs(yaw))
	
	self:GetTable().TWRecoilPitch = pitch_d
	self:GetTable().TWRecoilYaw = yaw_d
		
	// Update eye angles
	local eyes = cmd:GetViewAngles()
		eyes.pitch = eyes.pitch + (pitch - pitch_d)
		eyes.yaw = eyes.yaw + (yaw - yaw_d)
		eyes.roll = 0
	cmd:SetViewAngles (eyes)
end

SWEP.Spawnable				= false
SWEP.AdminSpawnable			= false

SWEP.PrintName				= "Twitch Base"
SWEP.Category				= "Twitch Weaponry (Devenger)"
SWEP.Author					= "Devenger"

SWEP.HoldType			= "ar2"

SWEP.Slot					= 2

SWEP.ViewModel				= "models/weapons/v_smg_mp5.mdl"
SWEP.WorldModel				= "models/weapons/w_smg_mp5.mdl"
-- SWEP.ViewModelAimPos		= Vector (2.5364, -1.8409, 1.745) --Original
SWEP.ViewModelAimPos		= Vector (200.5364, -1.8409, 1.745)
SWEP.ZoomTime				= 0.2

SWEP.ViewModelFlip			= true
SWEP.ViewModelFOV			= 65
SWEP.CSMuzzleFlashes		= true

SWEP.DrawAmmo				= false
SWEP.DrawCrosshair			= false

SWEP.Primary.Sound			= Sound ("Weapon_MP5Navy.Single")
SWEP.Primary.Damage			= 20
SWEP.Primary.NumShots		= 1
SWEP.Primary.Cone			= 0.005
SWEP.Primary.Delay			= 0.075

SWEP.Primary.ClipSize		= 30
SWEP.Primary.DefaultClip	= 270
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "smg1"

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "none"

SWEP.UseStationaryAiming	= true
SWEP.StationaryAimingOn		= false

function SWEP:Initialize()
	self:SetHoldType( self.HoldType )
end

function SWEP:PrimaryAttack()
	self.Reloading = false
	
	self.Weapon:SetNextPrimaryFire (CurTime() + self.Primary.Delay)
	
	if !self:CanPrimaryAttack() then
		return
	end
	
	if bulletTime:GetBool() and (self.DegreeOfZoom or 0) > 0 then
		local pitch = 100 - self.DegreeOfZoom * (100 - (40 or self.Primary.BullettimeSoundPitch) / (1 - bulletTimeTimeScale:GetFloat()))
		self.Weapon:EmitSound (self.Primary.BullettimeSound or self.Primary.Sound or "", 100, pitch)
	else
		self.Weapon:EmitSound (self.Primary.Sound or "")
	end
	
	local cone = self.Primary.Cone
	if self.StationaryAimingOn and self.Primary.ConeZoomed then cone = self.Primary.ConeZoomed end
	
	self:DoShootBullet (self.Primary.Damage, self.Primary.NumShots, cone)
	local rec = recoilMul:GetFloat()
	if self.Owner:Crouching() then rec = rec * 0.5 end
	self.Owner:TWRecoil (math.Rand(-1, -0.5) * (self.Recoil or 1) * rec, math.Rand(-0.5, 0.5) * (self.Recoil or 1) * rec)
	
	if not (aimInfiniteAmmo:GetBool() and self.Owner:KeyDown(IN_ATTACK2) and self.Weapon:Clip1() == 1) then
		self:TakePrimaryAmmo (1)
	end
	
	if self.CustomPrimaryAttack then self:CustomPrimaryAttack() end
end

function SWEP:SecondaryAttack()
	
end

function SWEP:SetAiming (bool)
	self.StationaryAimingOn = bool
end

function SWEP:Thinkie()
	if --[[CLIENT and ]]self.Reloading then
		self:SetAiming (false)
		if not self.CustomReload and (self.LastClip or 0) < self.Weapon:Clip1() then
			self.Reloading = false
			if self.LastClip == 0 and self.Weapon:Clip1() == self.Primary.ClipSize and (not self.NoChamberingRounds) then
				self:TakePrimaryAmmo (1)
				if SERVER then self.Owner:GiveAmmo (1, self.Weapon:GetPrimaryAmmoType(), true) end
			end
		end
	else
		self:SetAiming ((self.Owner:KeyDown(IN_ATTACK2)
			or (bulletTime:GetBool() and bulletTimeOnJump:GetBool() and not util.QuickTrace (self.Owner:GetPos(), Vector (0,0,-16), self.Owner).Hit))
		and ((self.DrawTime or 0) + 0.8 < CurTime()))
	end
	
	if self.StationaryAimingOn then
		self.DegreeOfZoom = math.min((self.DegreeOfZoom or 0) + FrameTime() / self.ZoomTime, 1)
	else
		self.DegreeOfZoom = math.max((self.DegreeOfZoom or 0) - FrameTime() / self.ZoomTime, 0)
	end
	
	if SERVER then
		if bulletTime:GetBool() then
			game.ConsoleCommand ("host_timescale "..(1 - (1-bulletTimeTimeScale:GetFloat()) * self.DegreeOfZoom).."\n")
		end
	else
		self.FOVToSet = ((52 or self.FOVTargetOverride) * self.DegreeOfZoom) + (GetConVarNumber("fov_desired") or 75) * (1-self.DegreeOfZoom)
		self.ViewModelFOV = 65 * ((GetConVarNumber("fov_desired") or 75) / 75) ^ 0.8 --<-- if I knew why this worked, I'd be a much smarter person. Or the other way round....
		--print (self.FOVToSet, self.ViewModelFOV)
		self.MouseSensitivity = 1 - self.DegreeOfZoom * 0.5
		self.BobScale = 1 - self.DegreeOfZoom * 0.7
		self.SwayScale = 1 - self.DegreeOfZoom * 0.8
	end
end

function SWEP:Think()
	if self.CustomThink then
		self:CustomThink()
	end
end

-- THIS SHIT HAD TO GO ERRORS OUT DA ASS
-- function SWEP:Reload()
-- 	if SERVER and SinglePlayer() then
-- 		self.Owner:SendLua ("LocalPlayer():GetActiveWeapon():Reload()")
-- 	end
-- 	local reloadStarted = self.Weapon:DefaultReload (ACT_VM_RELOAD)
-- 	if reloadStarted then
-- 		self.Reloading = true
-- 		self.LastClip = self.Weapon:Clip1()
-- 	end
-- end

function SWEP:Deploy()
	-- DON'T know what this was but it was casing script errors
	-- if SERVER and SinglePlayer() then
	-- 	timer.Simple (0.05, self.Owner.SendLua, self.Owner, "if ValidEntity(LocalPlayer():GetActiveWeapon()) then LocalPlayer():GetActiveWeapon():Deploy() end")
	-- end 
	if not quickDraw:GetBool() then
		self.Weapon:SendWeaponAnim (ACT_VM_DRAW)
		local duration = self.Weapon:SequenceDuration()
		self.Weapon:SetNextPrimaryFire (CurTime() + duration)
	end
	self.DrawTime = CurTime()
	if self.CustomDeploy then self:CustomDeploy() end
end

function SWEP:Holster()
	self:SetAiming (false)
	self.Reloading = false
	if SERVER and bulletTime:GetBool() then
		game.ConsoleCommand ("host_timescale 1\n")
	end
	if self.CustomHolster then self:CustomHolster() end
	return true
end

function SWEP:DoShootBullet (dmg, numbul, cone)
	numbul 	= numbul 	or 1
	cone 	= cone 		or 0.02

	local bullet = {}
	bullet.Num 		= numbul
	bullet.Src 		= self.Owner:GetShootPos()
	bullet.Dir 		= self.Owner:GetAimVector()
	bullet.Spread 	= Vector (cone, cone, 0)
	tracers = self.CustomTracerFreq or tracerFreq:GetInt()
	if bulletTime:GetBool() and bulletTimeTracers:GetBool() and ((self.DegreeOfZoom or 0) > 0) then tracers = 1 end
	bullet.Tracer	= tracers
	bullet.TracerName	= self.CustomTracerName
	bullet.Force	= 10
	bullet.Damage	= dmg * damageMul:GetFloat()
	bullet.Callback	= self.CustomBulletCallback
	
	self.Owner:FireBullets (bullet)
	self.Weapon:SendWeaponAnim (ACT_VM_PRIMARYATTACK)
	self.Owner:MuzzleFlash()
	self.Owner:SetAnimation (PLAYER_ATTACK1)
end

function SWEP:DrawHUD()
	if aimHideCrosshair:GetBool() and ((self.DegreeOfZoom or 0) > 0.5) then return end
	local hitpos = util.TraceLine ({
		start = LocalPlayer():GetShootPos(),
		endpos = LocalPlayer():GetShootPos() + LocalPlayer():GetAimVector() * 4096,
		filter = LocalPlayer(),
		mask = MASK_SHOT
	}).HitPos
	local scrpos = hitpos:ToScreen()
	local size = 0.01 - math.max(0.008 * ((self.DegreeOfZoom or 0) - 0.5), 0)
	surface.SetDrawColor (202, 225, 255, 150)
	surface.DrawLine (scrpos.x - ScrW() * size, scrpos.y, scrpos.x + ScrW() * size, scrpos.y)
	surface.DrawLine (scrpos.x, scrpos.y + ScrW() * size, scrpos.x, scrpos.y - ScrW() * size)
	surface.SetDrawColor (72, 118, 255, 200)
	surface.DrawLine (scrpos.x - ScrW() * size + 1, scrpos.y + 1, scrpos.x + ScrW() * size + 1, scrpos.y + 1)
	surface.DrawLine (scrpos.x + 1, scrpos.y + ScrW() * size + 1, scrpos.x + 1, scrpos.y - ScrW() * size + 1)
end

local lockedViewAng = false
local lockedViewAngOffset = false

local function WeaponUsesStationaryAiming ()
	return LocalPlayer() and true and LocalPlayer():GetActiveWeapon().UseStationaryAiming
end

local function WeaponStationaryAimingOn ()
	return LocalPlayer():GetActiveWeapon().StationaryAimingOn
end

if SERVER then
	function StationaryAimingThink()
		for _,pl in pairs (player.GetAll()) do
			if pl:GetActiveWeapon().UseStationaryAiming then
				pl:GetActiveWeapon():Thinkie()
			end
		end
	end

	hook.Add ("Think", "SATHINK", StationaryAimingThink)
end

local function DrawTWEffects()
	prog = LocalPlayer():GetActiveWeapon().DegreeOfZoom
	if (not prog) or prog <= 0 then return end
	
	if aimHideHUD:GetBool() and WeaponUsesStationaryAiming then			
		LocalPlayer():GetActiveWeapon():DrawHUD()
	end
		
	if bulletTime:GetBool() and bulletTimeColourDrain:GetBool() then
		local tab = {}
 	 
		tab[ "$pp_colour_addr" ] 		= 0
		tab[ "$pp_colour_addg" ] 		= 0
		tab[ "$pp_colour_addb" ] 		= 0
		tab[ "$pp_colour_brightness" ] 	= 0 - prog * 0.1
		tab[ "$pp_colour_contrast" ] 	= 1 + prog * 0.5
		tab[ "$pp_colour_colour" ] 		= 1 - prog
		tab[ "$pp_colour_mulr" ] 		= 0
		tab[ "$pp_colour_mulg" ] 		= 0
		tab[ "$pp_colour_mulb" ] 		= 0
		 
		DrawColorModify (tab)
		
		DrawSharpen (0.5 * prog,0.5 * prog)
	end
end

hook.Add ("RenderScreenspaceEffects", "DrawTWEffects", DrawTWEffects)

-- local function HUDShouldDraw (name)
-- 	if not LocalPlayer():IsValid() then return end
-- 	if (hideHUD:GetBool()) and (WeaponUsesStationaryAiming) and (name != "CHudWeaponSelection") then return false end
-- 	if aimHideHUD:GetBool() and WeaponUsesStationaryAiming then	
-- 		prog = LocalPlayer():GetActiveWeapon().DegreeOfZoom
-- 		if (prog and prog > 0.5) then
-- 			return false
-- 		end
-- 	end
-- end

-- hook.Add ("HUDShouldDraw", "TWHUDDisabler", HUDShouldDraw)

--Need this too
local function SimilarizeAngles (ang1, ang2)
	if math.abs (ang1.y - ang2.y) > 180 then
		if ang1.y - ang2.y < 0 then
			ang1.y = ang1.y + 360
		else
			ang1.y = ang1.y - 360
		end
	end
end

--This is what i need?
local function StationaryAimingCalcView (pl, origin, angles, view)
	if WeaponUsesStationaryAiming() --[[and lockedViewAng ]]then
		usefulViewAng = lockedViewAng or angles
		local view = {}
		view.origin = origin
		view.angles = usefulViewAng
		local DefPos = (pl:GetActiveWeapon().ViewModelAimPos or Vector (0,0,0)) * pl:GetActiveWeapon().DegreeOfZoom
		
		SimilarizeAngles (angles, usefulViewAng)
		
		--print (GetConVarNumber("fov_desired"))
		fovratio = (LocalPlayer():GetActiveWeapon().FOVToSet or GetConVarNumber("fov_desired") or 75) / LocalPlayer():GetActiveWeapon().ViewModelFOV

		angles = (angles * fovratio) + (usefulViewAng * (1 - fovratio))


		
		local pos = origin
		local Right 	= angles:Right()
		local Up 		= angles:Up()
		local Forward 	= angles:Forward()
		pos = pos + DefPos.x * Right
		pos = pos + DefPos.y * Forward
		pos = pos + DefPos.z * Up
		view.vm_origin = pos
		if pl:GetActiveWeapon().ViewModelFlip then angles.y = usefulViewAng.y + (usefulViewAng.y - angles.y) end
		if pl:GetActiveWeapon().ViewModelAimAng then
			angles:RotateAroundAxis( angles:Right(), 	pl:GetActiveWeapon().ViewModelAimAng.x * pl:GetActiveWeapon().DegreeOfZoom ) 
			angles:RotateAroundAxis( angles:Up(), 		pl:GetActiveWeapon().ViewModelAimAng.y * pl:GetActiveWeapon().DegreeOfZoom ) 
			angles:RotateAroundAxis( angles:Forward(), 	pl:GetActiveWeapon().ViewModelAimAng.z * pl:GetActiveWeapon().DegreeOfZoom ) 
		end
		view.vm_angles = angles
		return view
	end
end

hook.Add ("CalcView", "SACV", StationaryAimingCalcView)

local lastRealViewAng = false
local allowedFromCentreX = 12 -- ORIGINAL
local allowedFromCentreY = 8.5 -- ORIGINAL

local function StationaryAimingCreateMove (cmd)

	if not lockedViewAng then
		lockedViewAng = cmd:GetViewAngles()
		lockedViewAngOffset = Angle (0,0,0)
	end
	
	--sensitivity
	local angles = cmd:GetViewAngles()
	if lastRealViewAng then
		SimilarizeAngles (lastRealViewAng, angles)
		local diff = angles - lastRealViewAng
		diff = diff * (LocalPlayer():GetActiveWeapon().MouseSensitivity or 1) * aimSensitivity:GetFloat()
		angles = lastRealViewAng + diff
	end
	
	lastRealViewAng = angles
	
	--
	SimilarizeAngles (lockedViewAng, angles)
	local ydiff = (angles.y - lockedViewAng.y)
	if ydiff > allowedFromCentreX then
		lockedViewAng.y = angles.y - allowedFromCentreX
	elseif ydiff < -allowedFromCentreX then
		lockedViewAng.y = angles.y + allowedFromCentreX
	end
	local pdiff = (angles.p - lockedViewAng.p)
	if pdiff > allowedFromCentreY then
		lockedViewAng.p = angles.p - allowedFromCentreY
	elseif pdiff < -allowedFromCentreY then
		lockedViewAng.p = angles.p + allowedFromCentreY
	end
	cmd:SetViewAngles (angles)
		
end

hook.Add ("CreateMove", "SACM", StationaryAimingCreateMove)


------------------------


local IRONSIGHT_TIME = 0.25
/*---------------------------------------------------------
   Name: GetViewModelPosition
   Desc: Allows you to re-position the view model
---------------------------------------------------------*/
SWEP.lastXAng = 0
function SWEP:GetViewModelPosition( pos, ang )

	if ( !self.IronSightsPos ) then 
		return pos, ang 
	end

	-- Iron Sights Code
	local bIron = self.Weapon:GetNetworkedBool( "Ironsights" )
	
	if ( bIron != self.bLastIron ) then
		self.bLastIron = bIron 
		self.fIronTime = CurTime()
		
		if ( bIron ) then 
			self.SwayScale 	= 0.3
			self.BobScale 	= 0.1
		else 
			self.SwayScale 	= 1.0
			self.BobScale 	= 1.0
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

	local Offset = self.IronSightsPos
	
	if ( self.IronSightsAng ) then
		ang = ang * 1
		ang:RotateAroundAxis( ang:Right(), 		self.IronSightsAng.x * Mul )
		ang:RotateAroundAxis( ang:Up(), 		self.IronSightsAng.y * Mul )
		ang:RotateAroundAxis( ang:Forward(), 	self.IronSightsAng.z * Mul )
	end
	
	local Right 	= ang:Right()
	local Up 		= ang:Up()
	local Forward 	= ang:Forward()
	
	pos = pos + Offset.x * Right * Mul
	pos = pos + Offset.y * Forward * Mul
	pos = pos + Offset.z * Up * Mul

	return pos, ang
	
end

/*---------------------------------------------------------
	SetIronsights
---------------------------------------------------------*/
function SWEP:SetIronsights( b )

	self.Weapon:SetNetworkedBool( "Ironsights", b )

end

SWEP.NextSecondaryAttack = 0
/*---------------------------------------------------------
	SecondaryAttack
---------------------------------------------------------*/
function SWEP:SecondaryAttack()

	if ( !self.IronSightsPos ) then return end
	if ( self.NextSecondaryAttack > CurTime() ) then return end
	
	bIronsights = !self.Weapon:GetNetworkedBool( "Ironsights", false )
	
	self:SetIronsights( bIronsights )
	
	self.NextSecondaryAttack = CurTime() + 0.3
	
end



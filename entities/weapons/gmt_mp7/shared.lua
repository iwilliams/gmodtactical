if CustomizableWeaponry then

AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

SWEP.magType = "smgMag"

    game.AddParticles("particles/contempt/ber_muzzle.pcf")
    
    PrecacheParticleSystem("ber_pistol_large")
    PrecacheParticleSystem("ber_pistol_med")
    PrecacheParticleSystem("ber_pistol_small")
    PrecacheParticleSystem("ber_rifle_large")
    PrecacheParticleSystem("ber_rifle_med")
    PrecacheParticleSystem("ber_rifle_small")
    PrecacheParticleSystem("ber_shotgun")
    PrecacheParticleSystem("ber_silenced")
    PrecacheParticleSystem("ber_silenced_small")
    PrecacheParticleSystem("ber_sniper")

if CLIENT then
    SWEP.DrawCrosshair = false
    SWEP.PrintName = "HK MP7"
    SWEP.CSMuzzleFlashes = true
    
    SWEP.IconLetter = "w"
    killicon.Add("cw_ber_hkmp7", "weaponicons/hkmp7-k", Color(255, 80, 0, 150))
    SWEP.SelectIcon = surface.GetTextureID("weaponicons/select/hk")
    
    SWEP.MuzzleEffect = "ber_pistol_med"
    SWEP.PosBasedMuz = true
    SWEP.SnapToGrip = true
    SWEP.Shell = "smallshell"
    SWEP.ShellScale = 0.4
    SWEP.ShellOffsetMul = 1
    SWEP.ShellPosOffset = {x = 0, y = 1, z = 0}
    
    SWEP.DrawTraditionalWorldModel = false
    SWEP.WM = "models/weapons/w_dber_p7.mdl"
    SWEP.WMPos = Vector(-1, 1, 1)
    SWEP.WMAng = Vector(0, 0, 180)

    SWEP.IronsightPos = Vector(-2.169, -1.364, 0.579)
    SWEP.IronsightAng = Vector(0.358, 0.012, 0)
    
    SWEP.MicroT1Pos = Vector(-2.155, -2.362, 0.179)
    SWEP.MicroT1Ang = Vector(0.003, 0.1, 0)
    
    SWEP.KobraPos = Vector(-2.174, -3.024, 0.05)
    SWEP.KobraAng = Vector(0, 0, 0)
    
    SWEP.EoTechPos = Vector(-2.158, -3.205, -0.168)
    SWEP.EoTechAng = Vector(0, 0.089, 0)
    
    SWEP.ELCANBERPos = Vector(-2.166, -1.95, -0.32)
    SWEP.ELCANBERAng = Vector(0, 0, 0)
    
    SWEP.ACOGV5Pos = Vector(-2.165, -3.261, -0.16)
    SWEP.ACOGV5Ang = Vector(0, 0, 0)

    SWEP.SprintPos = Vector(0.768, -0.24, -0.663)
    SWEP.SprintAng = Vector(-9.702, 17.201, -7.4)

    SWEP.CustomizePos = Vector(1.667, -1.303, -1.581)
    SWEP.CustomizeAng = Vector(10.039, 20.033, 0)
    
    SWEP.AimpointPos = Vector(-2.174, -2.431, 0.032)
    SWEP.AimpointAng = Vector(0, 0, 0)

    SWEP.AlternativePos = Vector(-0.361, 0, -0.021)
    SWEP.AlternativeAng = Vector(0, 0, 0)
    
    --[1] = {header = "Barrel", offset = {300, 0}, atts = {"md_tundra9mm"}},
    
    SWEP.MoveType = 1
    --SWEP.ViewModelMovementScale = 0.8
    --SWEP.FullAimViewmodelRecoil = false
    --SWEP.BoltBone = "charging_handle"
    --SWEP.BoltShootOffset = Vector(-1, 0, 0)
    --SWEP.HoldBoltWhileEmpty = false
    --SWEP.DontHoldWhenReloading = true
    --SWEP.DisableSprintViewSimulation = true
    
    SWEP.ELCANBERAxisAlign = {right = 0, up = 0, forward = 0}
    SWEP.ACOGV5AxisAlign = {right = 0, up = 0, forward = 0}
    
    SWEP.BackupSights = {["md_ber_elcanv2"] = {[1] = Vector(-2.162, -3.402, -1.306), [2] = Vector(0.289, 0, 0)}}
    
    SWEP.LaserPosAdjust = Vector( 0, 0, -0.5)
    SWEP.LaserAngAdjust = Angle(-0, 0, 0) 
    
    SWEP.CustomizationMenuScale = 0.014
    SWEP.BoltBonePositionRecoverySpeed = 40 -- how fast does the bolt bone move back into it's initial position after the weapon has fired
    
    SWEP.AttachmentModelsVM = {
    ["md_ber_surefire"] = {model = "models/weapons/upgrades/a_flashlight_m9.mdl", bone = "Frame", pos = Vector(-0.021, 5.11, -0.306), angle = Angle(0, -90, 0), size = Vector(0.791, 0.791, 0.791)},
    ["md_lightsup"] = {model = "models/weapons/upgrades/a_suppressor_ak.mdl", bone = "mp7_main",pos = Vector(7.881, -0.285, -0.002), angle = Angle(0, 0, 0), size = Vector(0.663, 0.663, 0.663)},
    ["md_ber_microt1"] = {model = "models/cw2/attachments/microt1.mdl", bone = "mp7_main", pos = Vector(-0.8, -2.132, -0.01), adjustment = {min =  -0.8, max = 2.8, axis = "x", inverseOffsetCalc = true}, angle = Angle(90, -90, 0), size = Vector(0.386, 0.386, 0.386)},
    ["md_eotech"] = {model = "models/wystan/attachments/2otech557sight.mdl", bone = "mp7_main", pos = Vector(-11, 9.215, -0.269), adjustment = {min =  -11, max = -9, axis = "x", inverseOffsetCalc = true}, angle = Angle(0, 3.006, -90), size = Vector(1, 1, 1)},
    ["md_kobra"] = {model = "models/weapons/upgrades/a_optic_kobra.mdl", bone = "mp7_main", pos = Vector(-0.2, -2.017, 0.001), adjustment = {min =  -0.2, max = 2.1, axis = "x", inverseOffsetCalc = true}, angle = Angle(0, 0, -90), size = Vector(1.003, 1.003, 1.003)},
    ["md_acogv5"] = {model = "models/weapons/v_dber_acoh.mdl", bone = "mp7_main", rel = "", pos = Vector(-0.4, -1.774, 0.01), adjustment = {min =  -0.4, max = 1.4, axis = "x", inverseOffsetCalc = true}, angle = Angle(90, 0, -90), size = Vector(1, 1, 1)},
    ["md_aimpoint"] = {model = "models/weapons/upgrades/barska/barska.mdl", bone = "mp7_main", pos = Vector(-0.237, -1.987, 0.219), adjustment = {min =  -0.237, max = 2.737, axis = "x", inverseOffsetCalc = true}, angle = Angle(0, 0, -90), size = Vector(0.85, 0.85, 0.85)},
    ["md_ber_elcanv2"] = {model = "models/weapons/upgrades/elcan.mdl", bone = "mp7_main", pos = Vector(0.037, -3.001, -0.005), adjustment = {min =  0.037, max = 1.639, axis = "x", inverseOffsetCalc = true}, angle = Angle(0, 0, -90), size = Vector(0.87, 0.87, 0.87)},
    --["md_ber_elcanv2"] = {model = "models/weapons/upgrades/elcan.mdl", bone = "mp7_main", pos = Vector(-0.1, -2.919, -0.009), adjustment = {min =  -0.1, max = 1.3, axis = "x", inverseOffsetCalc = true}, angle = Angle(0, 0, -90), size = Vector(0.787, 0.787, 0.787)},
    ["md_ber_surefire"] = {model = "models/weapons/upgraded/a_flashlight_rail.mdl", bone = "mp7_main", pos = Vector(5.3, -0.209, 0.561), angle = Angle(0, 0, 180), size = Vector(0.885, 0.885, 0.885)},
}

end

SWEP.LuaViewmodelRecoil = false
SWEP.CanRestOnObjects = true
SWEP.ADSFireAnim = false

SWEP.StockBGs = {main = 3, folded = 1, unfolded = 0}

SWEP.Attachments = {[1] = {header = "Sight", offset = {300, -300},  atts = {"md_ber_microt1", "md_aimpoint", "md_kobra", "md_eotech", "md_ber_elcanv2", "md_acogv5"}},
[2] = {header = "Muzzle", offset = {-300, -200}, atts = {"md_lightsup"}},
[3] = {header = "Rail", offset = {700, 100},  atts = {"md_ber_surefire"}},
[4] = {header = "Stock", offset = {200, 100}, atts = {"bg_mp7stock"}},
["+reload"] = {header = "Ammo", offset = {-400, 300}, atts = {"am_magnum", "am_matchgrade"}}}

SWEP.Animations = {fire = {"shoot1", "shoot2", "shoot3"},
    reload = "reload",
    reload_empty = "reload_empty",
    idle = "idle",
    draw = "ready",
    drew = "draw"
    }
    
function SWEP:drawAnimFunc()
self:sendWeaponAnim("drew",self.ReloadSpeed,0)
end 

    SWEP.Sounds = {ready = {{time = 0, sound = "CW_FOLEY_LIGHT"},
    {time = 0.3, sound = "CW_BER_MP7_STOCK"}},
    
    draw = {{time = 0, sound = "CW_BER_MP7_DRAW"}},
    
    reload = {{time = 0.3, sound = "CW_BER_MP7_MAGOUT"},
    {time = 0.85, sound = "CW_BER_MP7_MAGIN"}},

    reload_empty = {{time = 0.2, sound = "CW_BER_MP7_MAGOUT"},
    {time = 1, sound = "CW_BER_MP7_MAGIN"},
    {time = 2.39, sound = "CW_BER_MP7_BOLTBACK"},
    {time = 2.8, sound = "CW_BER_MP7_BOLTFORWARD"}}}


SWEP.SpeedDec = 10

SWEP.Slot = 3
SWEP.SlotPos = 0
SWEP.NormalHoldType = "smg"
SWEP.RunHoldType = "normal"
SWEP.FireModes = {"auto", "3burst", "semi"}
SWEP.Base = "gmt_base"
SWEP.Category = "BER_CW 2.0"

SWEP.Author         = "BER_"
SWEP.Contact        = ""
SWEP.Purpose        = ""
SWEP.Instructions   = ""

SWEP.ViewModelFOV   = 70
SWEP.ViewModelFlip  = false
SWEP.ViewModel      = "models/weapons/v_dber_mp7.mdl"
SWEP.WorldModel     = "models/weapons/w_dber_p7.mdl"

SWEP.Spawnable          = true
SWEP.AdminSpawnable     = true

SWEP.Primary.ClipSize       = 40
SWEP.Primary.DefaultClip    = 40
SWEP.Primary.Automatic      = true
SWEP.Primary.Ammo           = "5.7x28MM"

SWEP.FireDelay = 0.064
SWEP.FireSound = "CW_BER_MP7_FIRE"
SWEP.FireSoundSuppressed = "CW_BER_MP7_FIRE_SUPPRESSED"
SWEP.Recoil = 0.6

SWEP.HipSpread = 0.06
SWEP.AimSpread = 0.0007
SWEP.VelocitySensitivity = 1.2
SWEP.MaxSpreadInc = 0.07
SWEP.SpreadPerShot = 0.004
SWEP.SpreadCooldown = 0.20
SWEP.Shots = 1
SWEP.Damage = 50 
SWEP.DeployTime = 0.5
--SWEP.Chamberable = false

SWEP.ReloadSpeed = 1.1
SWEP.ReloadTime = 2.4
SWEP.ReloadTime_Empty = 3.6
SWEP.ReloadHalt = 2.4
SWEP.ReloadHalt_Empty = 3.5

end

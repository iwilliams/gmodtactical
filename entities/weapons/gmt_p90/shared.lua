AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

if CLIENT then
    SWEP.DrawCrosshair = false
    SWEP.PrintName = "FN P90"
    SWEP.CSMuzzleFlashes = true
    SWEP.ViewModelMovementScale = 1.15
    
    SWEP.IconLetter = "w"
    killicon.AddFont("cw_ar15", "CW_KillIcons", SWEP.IconLetter, Color(255, 80, 0, 150))
    
    SWEP.MuzzleEffect = "muzzleflash_pistol"
    SWEP.PosBasedMuz = true
    SWEP.SnapToGrip = true
    SWEP.ShellScale = 0.3
    SWEP.ShellOffsetMul = 1
    SWEP.ShellPosOffset = {x = -2, y = 0, z = -3}
    SWEP.ForeGripOffsetCycle_Draw = 0
    SWEP.ForeGripOffsetCycle_Reload = 0.65
    SWEP.ForeGripOffsetCycle_Reload_Empty = 0.9
    
    SWEP.M203OffsetCycle_Reload = 0.65
    SWEP.M203OffsetCycle_Reload_Empty = 0.73
    SWEP.M203OffsetCycle_Draw = 0
    
    SWEP.IronsightPos = Vector(3.407, 0.05, 1.24)
    SWEP.IronsightAng = Vector(0, 1.463, 0)
    
    SWEP.EoTechPos = Vector(3.2, 0, -0.02)
    SWEP.EoTechAng = Vector(0, 0.611, 0)
    
    SWEP.AimpointPos = Vector(3.315, 0, -0.004)
    SWEP.AimpointAng = Vector(0.49, 1.008, 0)
    
    SWEP.MicroT1Pos = Vector(3.305, -2.957, 0.181)
    SWEP.MicroT1Ang = Vector(0.55, 1.421, 0)
    
    SWEP.SprintPos = Vector(-3.1, 0, 0.519)
    SWEP.SprintAng = Vector(-8.829, -31.659, 0)
    
    SWEP.CustomizePos = Vector(-4.981, -3.217, 0.56)
    SWEP.CustomizeAng = Vector(9.145, -48.543, 0)
    
    SWEP.CustomizationMenuScale = 0.01
    
    SWEP.M203Pos = Vector(-0.562, -2.481, 0.24)
    SWEP.M203Ang = Vector(0, 0, 0)
    
    SWEP.AlternativePos = Vector(-0.32, 0, -0.64)
    SWEP.AlternativeAng = Vector(0, 0, 0)
    
    SWEP.BackupSights = {["md_acog"] = {[1] = Vector(-2.211, -4, -0.95), [2] = Vector(-2, 0, 0)}}

    SWEP.ACOGAxisAlign = {right = -0.5, up = 0, forward = 0}
    SWEP.SchmidtShortDotAxisAlign = {right = -2, up = 0, forward = 0}
    SWEP.M203CameraRotation = {p = -90, y = 0, r = -90}
    
    SWEP.BaseArm = "Bip01 L Clavicle"
    SWEP.BaseArmBoneOffset = Vector(-50, 0, 0)
    
    SWEP.AttachmentModelsVM = {
        ["md_aimpoint"] = {model = "models/wystan/attachments/aimpoint.mdl", bone = "frame gun", rel = "", pos = Vector(-0.2, 3.825, 0.967), angle = Angle(180, -180, 0), size = Vector(1, 1, 1)},
        ["md_eotech"] = {model = "models/wystan/attachments/2otech557sight.mdl", bone = "frame gun", rel = "", pos = Vector(0.352, 8.734, 6.609), angle = Angle(-3.382, 90, 180), size = Vector(1, 1, 1)},
        ["md_saker"] = {model = "models/cw2/attachments/556suppressor.mdl", bone = "frame gun", pos = Vector(0.136, 2.377, -0.373), angle = Angle(-180, -180, -1.556), size = Vector(0.5, 0.5, 0.5)},
        ["md_microt1"] = {model = "models/cw2/attachments/microt1.mdl", bone = "frame gun", pos = Vector(0.082, -1.357, -4.836), angle = Angle(-180, -0.224, 0), size = Vector(0.4, 0.4, 0.4)},
        ["md_anpeq15"] = {model = "models/cw2/attachments/anpeq15.mdl", bone = "frame gun", pos = Vector(-0.588, -5.065, -4.044), angle = Angle(177.063, 90, -90), size = Vector(0.5, 0.5, 0.5)},
    }
    
    SWEP.M203HoldPos = {
        ["Bip01 L Clavicle"] = { scale = Vector(1, 1, 1), pos = Vector(-2.76, 2.651, 1.386), angle = Angle(0, 0, 0) }
    }

    SWEP.ForeGripHoldPos = {
        ["Bip01 L Finger3"] = {pos = Vector(0, 0, 0), angle = Angle(0, 42.713, 0) },
        ["Bip01 L Clavicle"] = {pos = Vector(-3.299, 1.235, -1.79), angle = Angle(-55.446, 11.843, 0) },
        ["Bip01 L Forearm"] = {pos = Vector(0, 0, 0), angle = Angle(0, 0, 42.41) },
        ["Bip01 L Finger02"] = {pos = Vector(0, 0, 0), angle = Angle(0, 71.308, 0) },
        ["Bip01 L Finger11"] = {pos = Vector(0, 0, 0), angle = Angle(0, 25.795, 0) },
        ["Bip01 L Finger4"] = {pos = Vector(0, 0, 0), angle = Angle(0, 26.148, 0) },
        ["Bip01 L Finger1"] = {pos = Vector(0, 0, 0), angle = Angle(6.522, 83.597, 0) },
        ["Bip01 L Finger0"] = {pos = Vector(0, 0, 0), angle = Angle(23.2, 16.545, 0) },
        ["Bip01 L Finger42"] = {pos = Vector(0, 0, 0), angle = Angle(0, 31.427, 0) },
        ["Bip01 L Finger32"] = {pos = Vector(0, 0, 0), angle = Angle(0, 29.565, 0) },
        ["Bip01 L Hand"] = {pos = Vector(0, 0, 0), angle = Angle(9.491, 14.793, -15.926) },
        ["Bip01 L Finger12"] = {pos = Vector(0, 0, 0), angle = Angle(0, -9.195, 0) },
        ["Bip01 L Finger21"] = {pos = Vector(0, 0, 0), angle = Angle(0, 10.164, 0) },
        ["Bip01 L Finger01"] = {pos = Vector(0, 0, 0), angle = Angle(0, 18.395, 0) },
        ["Bip01 L Finger2"] = {pos = Vector(0, 0, 0), angle = Angle(2.411, 57.007, 0) }
    }
    
    SWEP.LaserPosAdjust = Vector(-.5, 0, 0)
    SWEP.LaserAngAdjust = Angle(-1, 179, 0) 
end

SWEP.MuzzleVelocity = 715 -- in meter/s

SWEP.SightBGs = {main = 4, carryhandle = 0, foldsight = 1, none = 2}
SWEP.BarrelBGs = {main = 3, longris = 4, long = 3, magpul = 2, ris = 1, regular = 0}
SWEP.StockBGs = {main = 2, regular = 0, heavy = 1, sturdy = 2}
SWEP.MagBGs = {main = 5, regular = 0, round60 = 1}
SWEP.LuaViewmodelRecoil = true

SWEP.Attachments = {[1] = {header = "Sight", offset = {800, -500}, atts = {"md_microt1", "md_eotech", "md_aimpoint"}},
    [2] = {header = "Barrel", offset = {450, -500}, atts = {"md_saker"}},
    [3] = {header = "Rail", offset = {100, -350}, atts = {"md_anpeq15"}},
    ["+reload"] = {header = "Ammo", offset = {800, 0}, atts = {"am_magnum", "am_matchgrade"}}}
    
SWEP.AttachmentDependencies = {["md_m203"] = {"bg_longris"}} -- this is on a PER ATTACHMENT basis, NOTE: the exclusions and dependencies in the Attachments table is PER CATEGORY

SWEP.Animations = {fire = {"shoot1", "shoot2", "shoot3"},
    reload = "reload",
    idle = "idle",
    draw = "draw"}
    
SWEP.Sounds = {draw = {{time = 0, sound = "CW_FOLEY_MEDIUM"}},

    reload = {[1] = {time = 0.25, sound = "CW_P90_RELEASE"},
    [2] = {time = 0.3, sound = "CW_P90_CLIPOUT"},
    [3] = {time = 1.7, sound = "CW_P90_CLIPIN"},
    [4] = {time = 2.55, sound = "CW_P90_BOLT"}}}

SWEP.SpeedDec = 30

SWEP.Slot = 2
SWEP.SlotPos = 0
SWEP.NormalHoldType = "smg"
SWEP.RunHoldType = "passive"
SWEP.FireModes = {"auto", "semi"}
SWEP.Base = "gmt_base"
SWEP.Category = "CW 2.0"

SWEP.Author         = "Samsung Galaxy S7"
SWEP.Contact        = ""
SWEP.Purpose        = ""
SWEP.Instructions   = ""

SWEP.ViewModelFOV   = 70
SWEP.ViewModelFlip  = true
SWEP.ViewModel      = "models/cw2/weapons/v_p90_cw2.mdl"
SWEP.WorldModel     = "models/cw2/weapons/w_p90_cw2.mdl"

SWEP.DrawTraditionalWorldModel = false
SWEP.WM = "models/cw2/weapons/w_p90_cw2.mdl"
SWEP.WMPos = Vector(0, 0, 0)
SWEP.WMAng = Vector (0, 0, 180)

SWEP.Spawnable          = true
SWEP.AdminSpawnable     = true

SWEP.Primary.ClipSize       = 50
SWEP.Primary.DefaultClip    = 50
SWEP.Primary.Automatic      = true
SWEP.Primary.Ammo           = "5.7x28MM"

SWEP.FireDelay = 0.066666666666667
SWEP.FireSound = "CW_P90_FIRE"
SWEP.FireSoundSuppressed = "CW_AR15_FIRE_SUPPRESSED"
SWEP.Recoil = 0.4

SWEP.HipSpread = 0.045
SWEP.AimSpread = 0.018
SWEP.VelocitySensitivity = 1.8
SWEP.MaxSpreadInc = 0.04
SWEP.SpreadPerShot = 0.007
SWEP.SpreadCooldown = 0.13
SWEP.Shots = 1
SWEP.Damage = 50
SWEP.DeployTime = 0.6

SWEP.ReloadSpeed = 1
SWEP.ReloadTime = 2.54
SWEP.ReloadTime_Empty = 3.4
SWEP.ReloadHalt = 2.54
SWEP.ReloadHalt_Empty = 3.1
SWEP.SnapToIdlePostReload = true

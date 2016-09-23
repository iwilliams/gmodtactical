AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")
// SCK Name: hk45
if SERVER then

        SWEP.AcceptInput = function(inputName, activator, called, data )
            if true then
                print("-----------")
                print("AcceptInput")
                print("inputName: ",    inputName)
                print("activator: ",    activator)
                print("called: ",       called)
                print("data: ",         data)
                print("-----------")
            end
        end

end


if CLIENT then
    SWEP.DrawCrosshair = false
    SWEP.PrintName = "HK45C"
    SWEP.CSMuzzleFlashes = true

    SWEP.IconLetter = "i"
    killicon.Add("cw_ws_hk45", "vgui/kills/cw_ws_hk45", Color(255, 255, 255, 255))
    SWEP.SelectIcon = surface.GetTextureID("vgui/kills/cw_ws_hk45")

    SWEP.MuzzleEffect = "muzzleflash_6"
    SWEP.PosBasedMuz = false
    SWEP.MuzzlePosMod = {x = 0, y = 0, z = 0}
    SWEP.Shell = "smallshell"
    SWEP.ShellScale = 0.5
    SWEP.ShellOffsetMul = 1
    SWEP.ShellPosOffset = {x = 0, y = 0, z = 0}

    //Hk pack attachments
    SWEP.CoD4ReflexPos = Vector(-2.3, 0, -0.32)
    SWEP.CoD4ReflexAng = Vector(0, 0, 0)

    SWEP.CoD4TascoPos = Vector(-2.31, 0, 0.01)
    SWEP.CoD4TascoAng = Vector(0, 0, 0)

    SWEP.FAS2AimpointPos = Vector(-2.26, 0, -0.26)
    SWEP.FAS2AimpointAng = Vector(0, 0, 0)

    if CustomizableWeaponry_KK_HK416 then
        SWEP.HoloPos = Vector(-2.32, 0, -0.461)
    else
        SWEP.HoloPos = Vector(-2.3, 0, -0.39)
    end

    SWEP.HoloAng = Vector(0, 0, 0)

    SWEP.CoD4ACOGPos = Vector(-2.31, 0, -0.341)
    SWEP.CoD4ACOGAng = Vector(0, 0, 0)

    SWEP.EoTech552Pos = Vector(-2.25, 0, -0.75)
    SWEP.EoTech552Ang = Vector(0, 0, 0)

    SWEP.EoTech553Pos = Vector(-2.3, 0, -0.7)
    SWEP.EoTech553Ang = Vector(0, 0, 0)

    SWEP.ACOGPos = Vector(-2.32, 0, -0.661)
    SWEP.ACOGAng = Vector(0, 0, 0)
    SWEP.ACOGAxisAlign = {right = 0, up = 0, forward = 0}
    SWEP.BackupSights = {["md_acog"] = {[1] = Vector(-2.306, 0, -1.66), [2] = Vector(0, 0, 0)}}
    SWEP.CoD4ACOGAxisAlign = {right = -0, up = 180, forward = 0}

    //aTTACHMENTS THAT COME WITH THE PACK
    SWEP.AimpointPos = Vector(-2.31, 0, -0.341)
    SWEP.AimpointAng = Vector(0, 0, 0)

    SWEP.EoTechPos = Vector(-2.3, 0, -0.601)
    SWEP.EoTechAng = Vector(0, 0, 0)

    SWEP.MicroT1Pos = Vector(-2.345, 0, -0.361)
    SWEP.MicroT1Ang = Vector(0, 0, 0)

    SWEP.SprintPos = Vector(1.159, 0, 0)
    SWEP.SprintAng = Vector(-14.775, 15.477, -11.256)

    SWEP.CustomizePos = Vector(2.92, -2.814, -0.44)
    SWEP.CustomizeAng = Vector(11.255, 23.92, 5.627)

    SWEP.IronsightPos = Vector(-2.352, 0, 0.87)
    SWEP.IronsightAng = Vector(0, -0.136, 0)

    SWEP.SprintPos = Vector(0.256, 0.01, 1.2)
    SWEP.SprintAng = Vector(-17.778, 0, 0)

    SWEP.AlternativePos = Vector(-0.281, 1.325, -0.52)
    SWEP.AlternativeAng = Vector(0, 0, 0)

    SWEP.DeltaPos = Vector(-2.33, 0, -0.051)
    SWEP.DeltaAng = Vector(0, 0, 0)

    SWEP.CoyotePos = Vector(-2.33, 0, -0.371)
    SWEP.CoyoteAng = Vector(0, 0, 0)

    SWEP.BFReflexPos  = Vector(-2.268, 0, -0.29)
    SWEP.BFReflexAng  = Vector(0, 0, 0)

    SWEP.SightWithRail = true

    SWEP.ViewModelMovementScale = 0.5
    SWEP.FullAimViewmodelRecoil = true

    SWEP.BoltBone = "slide"
    SWEP.BoltShootOffset = Vector(-2, 0, 0)
    SWEP.HoldBoltWhileEmpty = false
    SWEP.DontHoldWhenReloading = true

    SWEP.LuaVMRecoilAxisMod = {vert = 0, hor = 5, roll = 2.5, forward = 2, pitch = 3}
    SWEP.DisableSprintViewSimulation = true

    SWEP.AttachmentModelsVM = {
        ["md_fas2_eotech"] = { type = "Model", model = "models/c_fas2_eotech.mdl", bone = "frame", rel = "", pos = Vector(-2.597, -0.65, 0.05), angle = Angle(0, -180, 90), size = Vector(1.149, 1.149, 1.149)},
        ["md_fas2_eotech_stencil"] = { type = "Model", model = "models/c_fas2_eotech_stencil.mdl", bone = "frame", rel = "", pos = Vector(-2.597, -0.65, 0.05), angle = Angle(0, -180, 90), size = Vector(1.149, 1.149, 1.149)},
        ["md_cod4_eotech_v2"] = { type = "Model", model = "models/v_cod4_eotech.mdl", bone = "frame", rel = "", pos = Vector(4.675, 1.7, 0.029), angle = Angle(0, 0, -90), size = Vector(0.898, 0.898, 0.898)},
        ["md_acog"] = { type = "Model", model = "models/wystan/attachments/2cog.mdl", bone = "frame", rel = "", pos = Vector(6.199, 4, -0.311), angle = Angle(90, 0, -90), size = Vector(0.898, 0.898, 0.898)},
        ["md_tundra9mm"] = { type = "Model", model = "models/cw2/attachments/9mmsuppressor.mdl", bone = "frame", rel = "", pos = Vector(-5.1, -0.5, -0.681), angle = Angle(0, 90, 0), size = Vector(0.55, 0.55, 0.55)},
        ["md_bfeotech"] = { type = "Model", model = "models/rageattachments/bfeotech.mdl", bone = "frame", rel = "", pos = Vector(0.5, -0.65, 0.05), angle = Angle(0, -180, 90), size = Vector(1, 1, 1)},
        ["md_muzzlebrake"] = { type = "Model", model = "models/rageattachments/pistolmuzzlebreak.mdl", bone = "frame", rel = "", pos = Vector(-4, -0.431, -0.45), angle = Angle(0, -180, 0), size = Vector(1, 1, 1)},
        ["md_fas2_holo"] = { type = "Model", model = "models/v_holo_sight_kkrc.mdl", bone = "frame", rel = "", pos = Vector(3, 2.44, 0), angle = Angle(0, -180, 90), size = Vector(0.648, 0.648, 0.648)},
        ["md_fas2_holo_aim"] = { type = "Model", model = "models/v_holo_sight_orig_hx.mdl", bone = "frame", rel = "", pos = Vector(3, 2.44, 0), angle = Angle(0, -180, 90), size = Vector(0.648, 0.648, 0.648)},
        ["md_cod4_acog_v2"] = { type = "Model", model = "models/v_cod4_acog.mdl", bone = "frame", rel = "", pos = Vector(3.75, 1.1, 0.025), angle = Angle(0, 0, -90), size = Vector(0.75, 0.75, 0.75)},
        ["md_fas2_aimpoint"] = { type = "Model", model = "models/c_fas2_aimpoint_rigged.mdl", bone = "frame", rel = "", pos = Vector(-2, -0.5, 0.05), angle = Angle(0, -180, 90), size = Vector(1, 1, 1)},
        ["md_cod4_aimpoint_v2"] = { type = "Model", model = "models/v_cod4_aimpoint.mdl", bone = "frame", rel = "", pos = Vector(4.4, 1.5, 0), angle = Angle(0, 0, -90), size = Vector(0.8, 0.8, 0.8)},
        ["md_cod4_reflex"] = { type = "Model", model = "models/v_cod4_reflex.mdl", bone = "frame", rel = "", pos = Vector(4.3, 1.5, 0.009), angle = Angle(0, 0, -90), size = Vector(0.8, 0.8, 0.8)},
        ["md_bfreflex"] = { type = "Model", model = "models/rageattachments/usareddot.mdl", bone = "frame", rel = "", pos = Vector(0, -0.65, -0.01), angle = Angle(0, -180, 90), size = Vector(0.8, 0.8, 0.8)},
        ["md_cyotesight"] = { type = "Model", model = "models/rageattachments/cyotesight.mdl", bone = "frame", rel = "", pos = Vector(0.5, -0.871, 0.029), angle = Angle(0, -180, 90), size = Vector(0.75, 0.75, 0.75)},
        ["md_deltasight"] = { type = "Model", model = "models/rageattachments/deltasight.mdl", bone = "frame", rel = "", pos = Vector(0.5, -0.75, 0.019), angle = Angle(0, 180, 90), size = Vector(1.1, 1.1, 1.1)},
        ["md_aimpoint"] = { type = "Model", model = "models/wystan/attachments/aimpoint.mdl", bone = "frame", rel = "", pos = Vector(5.714, 3.349, -0.201), angle = Angle(90, -90, 0), size = Vector(0.8, 0.8, 0.8)},
        ["md_eotech"] = { type = "Model", model = "models/wystan/attachments/2otech557sight.mdl", bone = "frame", rel = "", pos = Vector(11.699, 9.55, 0.3), angle = Angle(0, -180, 90), size = Vector(1, 1, 1)},
        ["md_microt1"] = { type = "Model", model = "models/cw2/attachments/microt1.mdl", bone = "frame", rel = "", pos = Vector(0.8, -1.3, 0.009), angle = Angle(-90, 90, 0), size = Vector(0.4, 0.4, 0.4)},
        ["md_rail"] = { type = "Model", model = "models/weapons/CW2 Rails/v_railwspistol.mdl", bone = "frame", rel = "", pos = Vector(10.5, -2.1, -1.711), angle = Angle(180, 0, -90), size = Vector(0.899, 0.85, 0.85)},
        ["md_lasersight"] = { type = "Model", model = "models/rageattachments/pistoltribeam.mdl", bone = "frame", rel = "", pos = Vector(-2.201, 1.6, 0), angle = Angle(0, -180, 90), size = Vector(0.8, 0.8, 0.8)},
    }

    SWEP.CompM4SBoneMod = {}

    SWEP.LaserPosAdjust = Vector(0, 0, 0)
    SWEP.LaserAngAdjust = Angle(0, 0, 0)
end

SWEP.BarrelBGs = {main = 1, regular = 1, long = 2, short = 0}
SWEP.LuaViewmodelRecoil = false
SWEP.CanRestOnObjects = false

if CustomizableWeaponry_KK_HK416 and CustomizableWeaponry_Fluffy_Zorua then
    SWEP.Attachments = {
        [1] = {header = "Sight", offset = {-450, -400},  atts = {"md_microt1", "md_cod4_reflex", "md_deltasight", "md_bfreflex", "md_cyotesight", "md_eotech", "md_cod4_eotech_v2", "md_fas2_eotech", "md_aimpoint", "md_cod4_aimpoint_v2", "md_fas2_aimpoint", "md_acog", "md_cod4_acog_v2", "md_fas2_holo"}},
        [3] = {header = "Barrel", offset = {-450, 600}, atts = {"md_lasersight"}},
        [2] = {header = "Muzzle", offset = {-450, 150}, atts = {"md_tundra9mm", "md_muzzlebrake"}},
        ["+reload"] = {header = "Ammo", offset = {800, 600}, atts = {"am_matchgrade"}},
        ["impulse 100"] = {header = "Skins", offset = {200, 400}, atts = {"bg_wshk45_paint1", "bg_wshk45_paint2", "bg_wshk45_paint3"}},
        ["+attack2"] = {header = "Perks", offset = {800, 100}, atts = {"pk_sleightofhand", "pk_light"}}
    }
elseif CustomizableWeaponry_KK_HK416 then
    SWEP.Attachments = {
        [1] = {header = "Sight", offset = {-450, -400},  atts = {"md_microt1", "md_cod4_reflex", "md_eotech", "md_cod4_eotech_v2", "md_fas2_eotech", "md_aimpoint", "md_cod4_aimpoint_v2", "md_fas2_aimpoint", "md_acog", "md_cod4_acog_v2", "md_fas2_holo"}},
        [2] = {header = "Muzzle", offset = {-450, 600}, atts = {"md_tundra9mm"}},
        ["+reload"] = {header = "Ammo", offset = {-450, 150}, atts = {"am_matchgrade"}},
        ["impulse 100"] = {header = "Skins", offset = {800, 100}, atts = {"bg_wshk45_paint1", "bg_wshk45_paint2", "bg_wshk45_paint3"}}
    }
elseif CustomizableWeaponry_Fluffy_Zorua then
    SWEP.Attachments = {
        [1] = {header = "Sight", offset = {-450, -400},  atts = {"md_microt1", "md_deltasight", "md_bfreflex", "md_cyotesight", "md_eotech", "md_bfeotech", "md_aimpoint", "md_acog"}},
        [3] = {header = "Barrel", offset = {-450, 600}, atts = {"md_lasersight"}},
        [2] = {header = "Muzzle", offset = {-450, 150}, atts = {"md_tundra9mm", "md_muzzlebrake"}},
        ["+reload"] = {header = "Ammo", offset = {800, 600}, atts = {"am_matchgrade"}},
        ["impulse 100"] = {header = "Skins", offset = {200, 400}, atts = {"bg_wshk45_paint1", "bg_wshk45_paint2", "bg_wshk45_paint3"}},
        ["+attack2"] = {header = "Perks", offset = {800, 100}, atts = {"pk_sleightofhand", "pk_light"}}
    }
else
    SWEP.Attachments = {
        [1] = {header = "Sight", offset = {-450, -400},  atts = {"md_microt1", "md_eotech", "md_aimpoint", "md_acog"}},
        [2] = {header = "Muzzle", offset = {-450, 150}, atts = {"md_tundra9mm"}},
        ["+reload"] = {header = "Ammo", offset = {-450, 150}, atts = {"am_matchgrade"}},
        ["impulse 100"] = {header = "Skins", offset = {800, 100}, atts = {"bg_wshk45_paint1", "bg_wshk45_paint2", "bg_wshk45_paint3"}}
    }
end

SWEP.Animations = {fire = {"shoot1", "shoot2"},
    reload = "reload",
    //idle = "idle",
    draw = "draw"}

SWEP.Sounds = {
    draw = {
    [1] = {time = 0, sound = "CW_WS_HK45_SLIDPULL"},
    [2] = {time = 0.35, sound = "CW_WS_HK45_SLIDRELEASE"}},

    reload = {
    [1] = {time = 0.2, sound = "CW_WS_HK45_CLIPOUT"},
    [2] = {time = 1.3, sound = "CW_WS_HK45_CLIPIN"},
    [3] = {time = 2.28, sound = "CW_WS_HK45_SLIDRELEASE"}}
    }

SWEP.SpeedDec = 8

SWEP.Slot = 1
SWEP.SlotPos = 0
SWEP.NormalHoldType = "revolver"
SWEP.RunHoldType = "normal"
SWEP.FireModes = {"semi"}
SWEP.Base = "gmt_base"
SWEP.Category = "CW 2.0 White Snow"

SWEP.Author         = "White Snow"
SWEP.Contact        = ""
SWEP.Purpose        = ""
SWEP.Instructions   = ""

SWEP.ViewModelFOV   = 60
SWEP.AimViewModelFOV = 50
SWEP.ViewModelFlip  = false
SWEP.ViewModel      = "models/weapons/v_piws_hk45.mdl"
SWEP.WorldModel     = "models/weapons/w_piws_hk45.mdl"
SWEP.ADSFireAnim = false
SWEP.DrawTraditionalWorldModel = false
SWEP.WM = "models/weapons/w_piws_hk45.mdl"
SWEP.WMPos = Vector(-0.5, -1, -1.5) //SWEP.WMPos = Vector(-0.5, 0, -1)
SWEP.WMAng = Vector(-3,1,180)
SWEP.CustomizationMenuScale = 0.007

SWEP.Spawnable          = true
SWEP.AdminSpawnable     = true

SWEP.Primary.ClipSize       = 8
SWEP.Primary.DefaultClip    = 8
SWEP.Primary.Automatic      = false
SWEP.Primary.Ammo           = ".45 ACP"

SWEP.FireDelay = 0.12
SWEP.FireSound = "CW_WS_HK45_FIRE"
SWEP.FireSoundSuppressed = "CW_WS_HK45_FIRE_SUPPRESSED"
SWEP.Recoil = 1

SWEP.HipSpread = 0.039
SWEP.AimSpread = 0.01
SWEP.VelocitySensitivity = 1.2
SWEP.MaxSpreadInc = 0.06
SWEP.SpreadPerShot = 0.02
SWEP.SpreadCooldown = 0.25
SWEP.Shots = 1
SWEP.Damage = 50
SWEP.DeployTime = 1

SWEP.ReloadSpeed = 1.3
SWEP.ReloadTime = 3
SWEP.ReloadHalt = 3.5
SWEP.ReloadTime_Empty = 3
SWEP.ReloadHalt_Empty = 3.5
SWEP.SnapToIdlePostReload = true



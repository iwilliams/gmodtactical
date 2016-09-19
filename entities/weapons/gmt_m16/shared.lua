AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

SWEP.magType = "arMag"

if CLIENT then
    SWEP.DrawCrosshair = false
    SWEP.PrintName = "M16A1"
    SWEP.CSMuzzleFlashes = true
    SWEP.ViewModelMovementScale = 1.15
    
    SWEP.IconLetter = "w"
    killicon.AddFont("cw_ar15", "CW_KillIcons", SWEP.IconLetter, Color(255, 80, 0, 150))
    
    SWEP.MuzzleEffect = "muzzleflash_6"
    SWEP.PosBasedMuz = false
    SWEP.SnapToGrip = true
    SWEP.ShellScale = 0.315
    SWEP.ShellOffsetMul = 1
    SWEP.ShellPosOffset = {x = 0, y = 0, z = 0}
    SWEP.ForeGripOffsetCycle_Draw = 0
    SWEP.ForeGripOffsetCycle_Reload = 0.65
    SWEP.ForeGripOffsetCycle_Reload_Empty = 0.7
    
    SWEP.M203OffsetCycle_Reload = 0.65
    SWEP.M203OffsetCycle_Reload_Empty = 0.7
    SWEP.M203OffsetCycle_Draw = 0
    
    SWEP.IronsightPos = Vector(-1.8899, -1, 0.06)
    SWEP.IronsightAng = Vector(-0.04, 0.02, 0)
    
    SWEP.M633Pos = Vector(-1.881, -1, 0.06)
    SWEP.M633Ang = Vector(0.05, 0.12, 0)
        
    SWEP.ColtPos = Vector(-1.884, -2.5, -0.5767)
    SWEP.ColtAng = Vector(-0.04, 0.02, 0)

    SWEP.CustomizePos = Vector(4.28, -1, -2.161)
    SWEP.CustomizeAng = Vector(15.477, 31.809, 5.477)
    
    SWEP.M203Pos = Vector(-1, -1, -0.5)
    SWEP.M203Ang = Vector(1, 0, 0)
    
    SWEP.AlternativePos = Vector(0, 0, -.35)
    SWEP.AlternativeAng = Vector(0, 0, 0)

    SWEP.ACOGAxisAlign = {right = .05, up = 0, forward = 0}
    SWEP.SchmidtShortDotAxisAlign = {right = .05, up = 0, forward = 0}
    SWEP.M203CameraRotation = {p = -90, y = 0, r = -90}
    
    SWEP.BaseArm = "Bip01 L Clavicle"
    SWEP.BaseArmBoneOffset = Vector(-50, 0, 0)
    
            SWEP.AttachmentPosDependency = {
        ["md_3prongflash"] = {
            ["bg_m16longshort"] = Vector(2, -11.8, -0.327),
            ["bg_m16shortlong"] = Vector(2, -12.8, -0.327),
            ["bg_m16shortlong2"] = Vector(2, -12.8, -0.327),
            ["bg_m16shortmedium"] = Vector(2, -15, -0.327),
            ["bg_m16short"] = Vector(2, -16, -0.327),
        },
        ["md_a1flash"] = {
            ["bg_m16longshort"] = Vector(2, -11.8, -0.327),
            ["bg_m16shortlong"] = Vector(2, -12.8, -0.327),
            ["bg_m16shortlong2"] = Vector(2, -12.8, -0.327),
            ["bg_m16shortmedium"] = Vector(2, -15, -0.327),
            ["bg_m16short"] = Vector(2, -16, -0.327),
        },
        ["md_a2flash"] = {
            ["bg_m16longshort"] = Vector(2, -11.8, -0.327),
            ["bg_m16shortlong"] = Vector(2, -12.8, -0.327),
            ["bg_m16shortlong2"] = Vector(2, -12.8, -0.327),
            ["bg_m16shortmedium"] = Vector(2, -15, -0.327),
            ["bg_m16short"] = Vector(2, -16, -0.327),
        },
        ["md_45flash"] = {
            ["bg_m16longshort"] = Vector(2, -11.8, -0.327),
            ["bg_m16shortlong"] = Vector(2, -12.8, -0.327),
            ["bg_m16shortlong2"] = Vector(2, -12.8, -0.327),
            ["bg_m16shortmedium"] = Vector(2, -15, -0.327),
            ["bg_m16short"] = Vector(2, -16, -0.327),
        },
        ["md_35flash"] = {
            ["bg_m16longshort"] = Vector(2, -11.8, -0.327),
            ["bg_m16shortlong"] = Vector(2, -12.8, -0.327),
            ["bg_m16shortlong2"] = Vector(2, -12.8, -0.327),
            ["bg_m16shortmedium"] = Vector(2, -15, -0.327),
            ["bg_m16short"] = Vector(2, -16, -0.327),
        },
        ["md_conicalflash"] = {
            ["bg_m16longshort"] = Vector(2, -11.8, -0.327),
            ["bg_m16shortlong"] = Vector(2, -12.8, -0.327),
            ["bg_m16shortlong2"] = Vector(2, -12.8, -0.327),
            ["bg_m16shortmedium"] = Vector(2, -15, -0.327),
            ["bg_m16short"] = Vector(2, -16, -0.327),
        },
    }
    
     SWEP.AttachmentModelsVM = {
        ["md_m203"] = {model = "models/khrcw2/m16m203.mdl", bone = "M16_Body", pos = Vector(1.899, -9, 3.48), angle = Angle(0, -90, 0), size = Vector(.8, .8, .8), animated = true},
        ["md_3prongflash"] = { type = "Model", model = "models/khrcw2/attachments/3prongflash.mdl", bone = "M16_Body", rel = "", pos = Vector(2, -8.301, -0.327), angle = Angle(0, -90, -90), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
        ["md_a1flash"] = { type = "Model", model = "models/khrcw2/attachments/a1flash.mdl", bone = "M16_Body", rel = "", pos = Vector(2, -8.301, -0.327), angle = Angle(0, -90, -90), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
        ["md_a2flash"] = { type = "Model", model = "models/khrcw2/attachments/a2flash.mdl", bone = "M16_Body", rel = "", pos = Vector(2, -8.301, -0.327), angle = Angle(0, -90, -90), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
        ["md_45flash"] = { type = "Model", model = "models/khrcw2/attachments/45flash.mdl", bone = "M16_Body", rel = "", pos = Vector(2, -8.301, -0.327), angle = Angle(0, -90, -90), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
        ["md_35flash"] = { type = "Model", model = "models/khrcw2/attachments/35flash.mdl", bone = "M16_Body", rel = "", pos = Vector(2, -8.301, -0.327), angle = Angle(0, -90, -90), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
        ["md_conicalflash"] = { type = "Model", model = "models/khrcw2/attachments/conicalflash.mdl", bone = "M16_Body", rel = "", pos = Vector(2, -8.301, -0.327), angle = Angle(0, -90, -90), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
    }
    
    SWEP.M203HoldPos = {
        ["Bip01 L Clavicle"] = { scale = Vector(1, 1, 1), pos = Vector(0.449, 0, -1.601), angle = Angle(0, 0, 0) }
    }
    
    SWEP.LaserPosAdjust = Vector(1, 0, 0)
    SWEP.LaserAngAdjust = Angle(2, 180, 0) 
end

SWEP.MuzzleVelocity = 940 -- in meter/s
SWEP.CustomizationMenuScale = 0.018

SWEP.SightBGs =      {main = 6, normal = 0, flip = 1}
SWEP.ScopeBGs =      {main = 7, none = 0, scope = 1}
SWEP.StockBGs =      {main = 5, a1 = 0, xm177 = 1, m607 = 2, m608 = 3}
SWEP.BarrelBGs =     {main = 4, long = 0, longshort = 1, shortlong = 2, shortlong2 = 3, shortmedium = 4, short = 5, m633 = 6}
SWEP.HandguardBGs =  {main = 3, a1 = 0, a2 = 1, gldown = 2, glup = 3, m607 = 4, m608 = 5, xm177 = 6, m633 = 7}
SWEP.MagBGs =        {main = 2, rnd20 = 0, rnd30 = 1, rnd100 = 2, rnd25 = 3, rnd32 = 4}

SWEP.LuaViewmodelRecoil = true
SWEP.LuaVMRecoilAxisMod = {vert = 1, hor = .25, roll = .35, forward = .45, pitch = 1.5}

SWEP.AttachmentDependencies = { 
    ["bg_m16shortlong"] = {"bg_m607hg", "bg_m608hg", "bg_xm177hg"},
    ["bg_m16shortlong2"] = {"bg_m607hg", "bg_m608hg", "bg_xm177hg"},
    ["bg_m16shortmedium"] = {"bg_m607hg", "bg_m608hg", "bg_xm177hg"},
    ["bg_m16short"] = {"bg_m607hg", "bg_m608hg", "bg_xm177hg"},
    ["bg_m16short633"] = {"bg_m633hg"}
}
SWEP.AttachmentExclusions = {
    ["bg_m16longshort"] = {"bg_m607hg", "bg_m608hg", "bg_xm177hg", "bg_m633hg"},
}

    SWEP.ForegripOverridePos = {
    
    ["bg_m607hg"] = {
    ["Bip01 L Clavicle"] = { scale = Vector(1, 1, 1), pos = Vector(-0.186, -1.5, -2.408), angle = Angle(12.222, 0, -5.557) },
    ["Bip01 L Finger0"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(1.11, 1.11, 0) },
    ["Bip01 L Finger11"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(-3.333, 43.333, 0) },
    ["Bip01 L Finger31"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 18.888, 0) },
    ["Bip01 L Finger21"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 25.555, 0) },
    ["Bip01 L Finger02"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 1.11, 0) },
    ["Bip01 L Finger01"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, -7.778, 0) },
    ["Bip01 L Finger41"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 23.333, 0) }},
    
    ["bg_m608hg"] = {
    ["Bip01 L Finger41"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 30, 0) },
    ["Bip01 L Clavicle"] = { scale = Vector(1, 1, 1), pos = Vector(-0, -2.037, -3.241), angle = Angle(14.444, 0, -10) },
    ["Bip01 L Finger0"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(-5.557, 5.556, 0) },
    ["Bip01 L Finger11"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(-3.333, 43.333, 0) },
    ["Bip01 L Finger31"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 21.111, 0) },
    ["Bip01 L Finger22"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 56.666, 0) },
    ["Bip01 L Finger01"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, -10, 0) }},
    
    ["bg_xm177hg"] = {
    ["Bip01 L Clavicle"] = { scale = Vector(1, 1, 1), pos = Vector(-0.556, -1.5, -2.1), angle = Angle(12.222, 0, -5.557) },
    ["Bip01 L Finger0"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(-3.333, 1.11, 0) },
    ["Bip01 L Finger11"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(-3.333, 43.333, 0) },
    ["Bip01 L Finger31"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 18.888, 0) },
    ["Bip01 L Finger21"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 25.555, 0) },
    ["Bip01 L Finger01"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, -7.778, 0) },
    ["Bip01 L Finger41"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 23.333, 0) }},
    
    ["bg_m633hg"] = {
    ["Bip01 L Finger41"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 30, 0) },
    ["Bip01 L Clavicle"] = { scale = Vector(1, 1, 1), pos = Vector(-0, -2.037, -3.241), angle = Angle(14.444, 0, -10) },
    ["Bip01 L Finger0"] = { scale = Vector(1, 1, 1), pos = Vector(-.2, 0, 0), angle = Angle(5.557, -2.556, 0) },
    ["Bip01 L Finger11"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(-3.333, 43.333, 0) },
    ["Bip01 L Finger31"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 21.111, 0) },
    ["Bip01 L Finger22"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 56.666, 0) },
    ["Bip01 L Finger01"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(5, 10, 0) },
    ["Bip01 L Finger02"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 5, 0) }},
    }

SWEP.Attachments = {[7] = {header = "Rear Sight", offset = {1300, 200}, atts = {"bg_altaperturea1"}},
    [8] = {header = "Scope", offset = {1200, -500}, atts = {"bg_m16scope"}},
    [3] = {header = "Barrel", offset = {350, -650}, atts = {"bg_m16longshort", "bg_m16shortlong", "bg_m16shortlong2", "bg_m16shortmedium", "bg_m16short", "bg_m16short633"}},
    [1] = {header = "Flash Hider", offset = {-600, -575}, atts = {"md_3prongflash", "md_a1flash", "md_a2flash", "md_35flash", "md_45flash", "md_conicalflash"}, exclusions = {bg_m16short633 = true}},
    [5] = {header = "Underbarrel", offset = {-710, 215}, atts = {"md_m203"}, dependencies = {bg_m16a2hg = true}},
    [2] = {header = "Handguard", offset = {-650, -150}, atts = {"bg_m16a2hg", "bg_m607hg", "bg_m608hg", "bg_xm177hg", "bg_m633hg"}},
    [4] = {header = "Magazine", offset = {-100, 400}, atts = {"bg_30rnda1", "bg_100rnda1"}},
    --[8] = {header = "Stock", offset = {1000, 600}, atts = {"bg_ar15sturdystock", "bg_ar15heavystock"}},
    ["+reload"] = {header = "Ammo", offset = {500, 400}, atts = {"am_magnum", "am_matchgrade"}}}
    

SWEP.Animations = {fire = {"shoot1", "shoot2", "shoot3"},
    reload_empty = "reloadempty",
    reload = "reloadnonempty",
    idle = "idle",
    draw = "draw_second"}
    
SWEP.Sounds = {draw_first = {[1] = {time = 0, sound = "CW_M16A1_DEPLOY"},
    [2] = {time = .7, sound = "CW_M16A1_BOLTRELEASE"}},

    reloadnonempty = {[1] = {time = 0.35, sound = "CW_M16A1_MAGOUT"},
    [2] = {time = 1.2, sound = "CW_M16A1_MAGIN"},
    [3] = {time = 1.75, sound = "CW_M16A1_SHOULDER"}},
    
    reloadempty = {[1] = {time = 0.35, sound = "CW_M16A1_MAGOUT"},
    [2] = {time = 1.2, sound = "CW_M16A1_MAGIN"},
    [3] = {time = 1.8, sound = "CW_M16A1_BOLTPULL"},
    [4] = {time = 2.6, sound = "CW_M16A1_SHOULDER"}}}

SWEP.SpeedDec = 30

SWEP.Slot = 3
SWEP.SlotPos = 0
SWEP.NormalHoldType = "ar2"
SWEP.RunHoldType = "passive"
SWEP.FireModes = {"auto", "semi"}
SWEP.Base = "gmt_base"
SWEP.Category = "CW 2.0 - Khris"

SWEP.Author         = "Spy"
SWEP.Contact        = ""
SWEP.Purpose        = ""
SWEP.Instructions   = ""

SWEP.ViewModelFOV   = 75
SWEP.ViewModelFlip  = false
SWEP.ViewModel      = "models/khrcw2/v_khr_m16.mdl"
SWEP.WorldModel     = "models/weapons/w_rif_m4a1.mdl"

SWEP.Spawnable          = true
SWEP.AdminSpawnable     = true

SWEP.Primary.ClipSize       = 20
SWEP.Primary.DefaultClip    = 20
SWEP.Primary.Automatic      = true
SWEP.Primary.Ammo           = "5.56x45MM"

SWEP.FireDelay = 60/850
SWEP.FireSound = "CW_M16A1_FIRE"
SWEP.FireSoundSuppressed = "CW_AR15_FIRE_SUPPRESSED"
SWEP.Recoil = .9

SWEP.HipSpread = 0.045
SWEP.AimSpread = 0.003
SWEP.VelocitySensitivity = 1.5
SWEP.MaxSpreadInc = 0.04
SWEP.SpreadPerShot = 0.007
SWEP.SpreadCooldown = 0.13
SWEP.Shots = 1
SWEP.Damage = 39
SWEP.DeployTime = .65

SWEP.ReloadSpeed = 1
SWEP.ReloadTime = 2.4
SWEP.ReloadTime_Empty = 3.2
SWEP.ReloadHalt = 2.4
SWEP.ReloadHalt_Empty = 3.2

function SWEP:buildBoneTable()
local vm = self.CW_VM

for i = 0, vm:GetBoneCount() - 1 do
local boneName = vm:GetBoneName(i)
local bone

if boneName then
bone = vm:LookupBone(boneName)
end

-- some ins models have [__INVALIDBONE__]s so to prevent nilpointerexceptions bone = 1
self.vmBones[i + 1] = {boneName = boneName, bone = i, curPos = Vector(0, 0, 0), curAng = Angle(0, 0, 0), targetPos = Vector(0, 0, 0), targetAng = Angle(0, 0, 0)}
end
end


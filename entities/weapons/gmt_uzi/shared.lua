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
    SWEP.PrintName = "UZI"
    SWEP.CSMuzzleFlashes = true
    SWEP.ViewModelMovementScale = 1

    SWEP.IconLetter = "w"
    killicon.Add("cw_ber_uzi", "weaponicons/uzi-k", Color(255, 80, 0, 150))
    SWEP.SelectIcon = surface.GetTextureID("weaponicons/select/imi2")

    SWEP.MuzzleEffect = "ber_rifle_small"
    SWEP.PosBasedMuz = true
    SWEP.SnapToGrip = true
    SWEP.ShellScale = 0.4
    SWEP.ShellOffsetMul = 1
    SWEP.Shell = "smallshell"
    SWEP.ShellPosOffset = {x = 2, y = 0, z = 0}
    SWEP.FireMoveMod = 1

    SWEP.DrawTraditionalWorldModel = false
    SWEP.WM = "models/weapons/w_dber_uzir.mdl"
    SWEP.WMPos = Vector(-1.5, 0, 0)
    SWEP.WMAng = Vector(0, 0, 180)

    SWEP.IronsightPos = Vector(-2.164, -0.033, 0.777)
    SWEP.IronsightAng = Vector(0.05, 0.02, 0)

    SWEP.SprintPos = Vector(0.119, 1.138, -0.419)
    SWEP.SprintAng = Vector(-6.315, 4.916, -6.693)

    SWEP.CustomizePos = Vector(3.375, -0.115, -0.412)
    SWEP.CustomizeAng = Vector(6.322, 23.833, 8.472)

    SWEP.BackupSights = {["md_acogv2"] = {[1] = Vector(-1.739, -1.078, -1.03), [2] = Vector(0.372, 0.071, 0)}}

    SWEP.SightWithRail = false

    SWEP.ACOGV4AxisAlign = {right = 0, up = 0, forward = 0}

    SWEP.AlternativePos = Vector(0.239, 1.157, 0.039)
    SWEP.AlternativeAng = Vector(0, 0, 0)

    SWEP.CustomizationMenuScale = 0.015

    SWEP.AttachmentModelsVM = {
    ["md_lightsup"] = {model = "models/weapons/upgrades/a_suppressor_ak.mdl", bone = "UZI", pos = Vector(0.002, 6.131, 1.192), angle = Angle(0, -90, 0), size = Vector(0.768, 0.768, 0.768)},
    }

    SWEP.LuaVMRecoilAxisMod = {vert = 1.5, hor = 2, roll = 1, forward = 1, pitch = 1}

    SWEP.LaserPosAdjust = Vector(0.2, -2, -0.8)
    SWEP.LaserAngAdjust = Angle(0, 0, 0)
end


SWEP.BoltBone = "UZI_Bolt"
SWEP.BoltShootOffset = Vector(0, 1.6, 0)
SWEP.HoldBoltWhileEmpty = true
SWEP.DontHoldWhenReloading = true

SWEP.LuaViewmodelRecoil = false

function SWEP:drawAnimFunc()
self:sendWeaponAnim("drew",self.ReloadSpeed,0)
end

SWEP.StockBGs = {main = 3, folded = 1, unfolded = 0}

--[1] = {header = "Sight", offset = {600, -100},  atts = {"md_microt1", "md_eotech", "md_aimpoint", "md_acogv2"}}, --"md_acog"
--[2] = {header = "Barrel", offset = {-300, -200},  atts = {"md_saker"}},
--[3] = {header = "UnderBarrel", offset = {-100, 300},  atts = {"md_foregrip"}},

SWEP.Attachments = {[1] = {header = "Barrel", offset = {-300, -400},  atts = {"md_lightsup"}},
[2] = {header = "Change of Pace", offset = {400, 0},  atts = {"bg_ber_uzi_lil_bit", "bg_ber_uzi_vury_worn"}},
[3] = {header = "Stock", offset = {100, 100},  atts = {"bg_uzistock"}},
["+reload"] = {header = "Ammo", offset = {-400, 200}, atts = {"am_magnum", "am_matchgrade"}}}

SWEP.Animations = {fire = {"mac10_fire", "mac10_fire2", "mac10_fire3"},
    reload = "mac10_reload",
    reload_empty = "mac10_reload_empty",
    idle = "mac10_idle",
    draw = "mac10_draw",
    drew = "mac10_drew"}

    SWEP.Sounds = {mac10_draw = {{time = 0.2, sound = "CW_FOLEY_LIGHT"},
    {time = 0.4, sound = "CW_BER_UZI_HIT"},
    {time = 0.89, sound = "CW_BER_UZI_STOCK"},
    {time = 1, sound = "CW_FOLEY_LIGHT"}},

    mac10_drew = {{time = 0, sound = "CW_BER_UZI_DRAW"}},

    mac10_reload = {{time = 0.2, sound = "CW_FOLEY_LIGHT"},
    {time = 0.4, sound = "CW_BER_UZI_MAGOUT"},
    {time = 1.7, sound = "CW_BER_UZI_MAGIN"},
    {time = 2.2, sound = "CW_FOLEY_LIGHT"}},

    mac10_reload_empty = {{time = 0.4, sound = "CW_FOLEY_LIGHT"},
    {time = 0.6, sound = "CW_BER_UZI_BOLTBACK"},
    {time = 0.7, sound = "CW_BER_UZI_BOLTFORWARD"},
    {time = 1.5, sound = "CW_BER_UZI_MAGOUT"},
    {time = 1.5, sound = "CW_FOLEY_LIGHT"},
    {time = 2.9, sound = "CW_BER_UZI_MAGIN"},
    {time = 2.2, sound = "CW_FOLEY_LIGHT"}}}


SWEP.SpeedDec = 10

SWEP.Slot = 3
SWEP.SlotPos = 0
SWEP.NormalHoldType = "smg"
SWEP.RunHoldType = "normal"
SWEP.FireModes = {"auto", "semi"}
SWEP.Base = "gmt_base"
SWEP.Category = "BER_CW 2.0"

SWEP.Author         = "BER_"
SWEP.Contact        = ""
SWEP.Purpose        = ""
SWEP.Instructions   = ""

SWEP.ViewModelFOV   = 70
SWEP.ViewModelFlip  = false
SWEP.ViewModel      = "models/weapons/v_dber_uzir.mdl"
SWEP.WorldModel     = "models/weapons/w_dber_uzir.mdl"

SWEP.Spawnable          = true
SWEP.AdminSpawnable     = true

SWEP.Primary.ClipSize       = 32
SWEP.Primary.DefaultClip    = 32
SWEP.Primary.Automatic      = true
SWEP.Primary.Ammo           = "9x19MM"

SWEP.FireDelay = 0.071
SWEP.FireSound = "CW_BER_UZI_FIRE"
SWEP.FireSoundSuppressed = "CW_BER_UZI_FIRE_SUPPRESSED"
SWEP.Recoil = 0.45

SWEP.HipSpread = 0.05
SWEP.AimSpread = 0.00008
SWEP.VelocitySensitivity = 1.8
SWEP.MaxSpreadInc = 0.08
SWEP.SpreadPerShot = 0.04
SWEP.SpreadCooldown = 0.1
SWEP.Shots = 1
SWEP.Damage = 40
SWEP.DeployTime = 0.5

SWEP.ReloadSpeed = 1
SWEP.ReloadTime = 2.7
SWEP.ReloadTime_Empty = 4
SWEP.ReloadHalt = 2.8
SWEP.ReloadHalt_Empty = 4
SWEP.Chamberable = false

SWEP.SnapToIdlePostReload = false

end

include("shared.lua");

GMT = {}

-- Taken straight from dat OG DarkRP bb
-- I guess you have to include CS files here because I can't seem to do it in the modules themselves
local function LoadModules()
    local root = GM.FolderName .. "/gamemode/modules/"
    local _, folders = file.Find(root .. "*", "LUA")

    for _, folder in SortedPairs(folders, true) do
        for _, File in SortedPairs(file.Find(root .. folder .. "/sh_*.lua", "LUA"), true) do
            include(root .. folder .. "/" .. File)
        end

        for _, File in SortedPairs(file.Find(root .. folder .. "/cl_*.lua", "LUA"), true) do
            include(root .. folder .. "/" .. File)
        end
    end
end
LoadModules()


--sound.PlayURL ( "http://warez.iwillia.ms/garrysmod/output.wav", "", function( station )
    --if ( IsValid( station ) ) then

        ----station:SetPos( LocalPlayer():GetPos() )
        --station:SetVolume(1)
        --station:Play()

    --else

        --LocalPlayer():ChatPrint( "Invalid URL!" )

    --end
--end )

local hide = {
    CHudHealth      = true,
    CHudCrosshair   = true,
    CHudAmmo        = true,
    CHudVoiceStatus = true,
    CHudWeaponSelection = true
    --CHudBattery     = true,
    --CHudSecondaryAmmo = true
}

-- sets voice hud off
--function GM:Initialize()
    --g_VoicePanelList:SetVisible(false)
--end

hook.Add( "HUDShouldDraw", "gmt_hide_HUD", function( name )
    if ( hide[ name ] ) then return false end

    // allow weapon hiding
    local ply = LocalPlayer()
    if IsValid(ply) then
        local wep = ply:GetActiveWeapon()
        if IsValid(wep) && wep.HUDShouldDraw then
            return wep.HUDShouldDraw(wep, name)
        end
    end

    return true
end)

function GM:DrawDeathNotice( x, y )
end

function GM:HUDDrawTargetID()
end

-- Remove NPC rag dolls on death after 10s
function RemoveDeadRag( ent )
    if (ent == NULL) or (ent == nil) then return end
    if (ent:GetClass() == "class C_ClientRagdoll") then
        if ent:IsValid() and !(ent == NULL) then
            SafeRemoveEntityDelayed(ent, 10)
        end
    end
end
hook.Add("OnEntityCreated", "RemoveDeadRag", RemoveDeadRag)

function GM:RenderScreenspaceEffects()
    local ply     = LocalPlayer()
    local maxHealth  = ply:GetMaxHealth()
    local health     = ply:Health()

    --if health > 85 then return end

    local percentage = (health/maxHealth)

    local maxBlur = 0.005
    local blur = maxBlur - (maxBlur * percentage)

    local maxRed = 0.1
    local maxColour = .2

    local contrast = 1
    if not ply:Alive() then contrast = 0 end

    local tab = {
        [ "$pp_colour_addr" ] = math.max(maxRed - (maxRed * percentage), 0) * 1.2,
        [ "$pp_colour_addg" ] = 0,
        [ "$pp_colour_addb" ] = 0,
        [ "$pp_colour_brightness" ] = 0,
        [ "$pp_colour_contrast" ] = contrast,
        [ "$pp_colour_colour" ] = math.max(1 * percentage, 0),
        [ "$pp_colour_mulr" ] = 0,
        [ "$pp_colour_mulg" ] = 0,
        [ "$pp_colour_mulb" ] = 0
    }

    DrawColorModify( tab )
    --DrawMotionBlur( 0.4, 0.8, math.max(blur, 0) )

    --DrawBloom( 0.75, 1.5, 9, 9, 1, 1, 1, 1, 1 )
end

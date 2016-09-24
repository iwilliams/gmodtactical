AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")
include("player.lua")

GMT = {}
include("config.lua")
include("sv_inventory.lua")

concommand.Add("cleanup", function( ply, cmd, args )
    if ply:IsSuperAdmin() then
        game.CleanUpMap()
        GMT:SpawnCrates()
    end
end)


hook.Add( "PlayerFootstep", "PlayerModelFootstep", function( ply, pos, foot, sound, volume, filter )
    if ply:KeyDown(IN_SPEED) then
        ply:EmitSound( "npc/combine_soldier/gear" .. math.random( 1, 6 ) .. ".wav", 75, 100, volume )
        return true
    end
end )



-- table.filter({"a", "b", "c", "d"}, function(o, k, i) return o >= "c" end)  --> {"c","d"}
-- --
-- -- @FGRibreau - Francois-Guillaume Ribreau
-- -- @Redsmin - A full-feature client for Redis http://redsmin.com
table.filter = function(t, filterIter)
    local out = {}

    for k, v in pairs(t) do
        if filterIter(v, k, t) then out[k] = v end
    end

    return out
end

function has_value (tab, val)
    for index, value in pairs (tab) do
        if value == val then
            return true
        end
    end

    return false
end

function GM:PlayerSwitchFlashlight( ply, enabled)
    return true
end

-- DELET THIS
hook.Add( "PlayerNoClip", "NoClipCheck", function(ply, noclip)
    --if ply:IsSuperAdmin() then
        ply:SetNoTarget(noclip)
    --end
    return true
    --return ply:IsSuperAdmin()
end)

function GM:OnNPCKilled( victim, killer, weapon )
    -- Drop Weapon
    local wep = victim:GetActiveWeapon()

    if IsValid( wep ) then
        local wepName = string.sub(wep:GetClass(), 5)

        if wepName == "m9k_usp"     then wepName = "gmt_hk45"   end
        if wepName == "m9k_mp5"     then wepName = "gmt_mp5"    end
        if wepName == "m9k_m416"    then wepName = "gmt_hk416"  end
        if wepName == "m9k_m249lmg" then wepName = "gmt_pkm"    end
        if wepName == "m9k_m4a1"    then wepName = "gmt_ar15"   end
        if wepName == "m9k_auga3"   then wepName = "gmt_aug"    end
        if wepName == "m9k_ak74"    then wepName = "gmt_ak74"   end
        if wepName == "m9k_mp7"     then wepName = "gmt_mp7"    end

        local newWep = ents.Create( wepName )
        if IsValid(newWep) then
            newWep:SetPos(victim:GetPos() + Vector(0,0,64))
            newWep:Spawn()
            GMT:ScheduleDespawn(newWep)
        end
    end
end

function GM:GetFallDamage( ply, speed )
    return ( speed / 9 )
end

hook.Add( "PlayerCanPickupWeapon", "checkWeaponPickup", function( ply, wep )
    local activeWep = ply:GetActiveWeapon()

    -- walk over wepon to get ammo
    if IsValid(activeWep) and IsValid(wep) and activeWep:GetPrimaryAmmoType() == wep:GetPrimaryAmmoType() then
        local ammoCount1 = wep:Clip1()
        --local ammoCount2 = wep:Clip2()

        wep:SetClip1(0)
        --wep:SetClip2(0)

        ply:GiveAmmo(ammoCount1, wep:GetPrimaryAmmoType())
        --ply:GiveAmmo(ammoCount2, wep:GetPrimaryAmmoType())
    end

    -- Check E button LOS
    if ( CurTime() <= ( ply.UseWeaponSpawn or 0 ) ) then return end
    if ( !ply:KeyDown( IN_USE ) && !ply.serverGivingWep ) then return false end

    if(!ply.serverGivingWep) then
        local trace = util.QuickTrace( ply:GetShootPos(), ply:GetAimVector() * 8192, ply )
        if ( !trace.Entity || !trace.Entity:IsValid() || trace.Entity != wep ) then
            return false
        end
    end

    ply.serverGivingWep = false

    -- Figure out which weapons to drop
    local newWep        = wep:GetClass()
    local newWepType    = nil

    if has_value(GMT.PrimaryWeapons, newWep) then
        newWepType = "PrimaryWeapons"
    elseif has_value(GMT.SecondaryWeapons, newWep) then
        newWepType = "SecondaryWeapons"
    else
        newWepType = "OtherWeapons"
    end

    local playerWeapons = ply:GetWeapons()

    for k, v in pairs( playerWeapons ) do
        if has_value(GMT[newWepType], v:GetClass()) then
            ply:DropWeapon( v )
            GMT:ScheduleDespawn(v)
        end
    end

    timer.Simple(0, function() ply:SelectWeapon(newWep) end)
end )

local function PlayerSpawn( ply )
    ply.UseWeaponSpawn = CurTime()


    ply.Factions = {
        combine = -5,
        rebel   = 2
    }

    ply.LastHi = CurTime()

    for _, npc in pairs( ents.FindByClass( "npc_*" ) ) do
        if IsValid(npc) and npc:IsNPC() then
            npc:AddEntityRelationship( ply, GMT:PlayerNPCRelationship( ply, npc ), 99 )
        end
    end
end
hook.Add( "PlayerSpawn", "UseWeapon", PlayerSpawn )

function GM:PlayerHurt( victim, attacker, healthRemaining )
    if ( victim:IsPlayer() ) then
        victim:EmitSound("vo/npc/male01/pain02.wav")
    end
end

hook.Add( "PlayerCanHearPlayersVoice", "Maximum Range", function( listener, talker )
    if listener:GetPos():Distance( talker:GetPos() ) > 500 then return false end
end )


function GM:ScalePlayerDamage( ply, hitgroup, dmginfo )

    -- More damage when we're shot in the head
    if ( hitgroup == HITGROUP_HEAD ) then
        dmginfo:ScaleDamage( 100 )
    end

    local attacker = dmginfo:GetAttacker()
    if attacker:IsNPC() then
        dmginfo:ScaleDamage( 1.75 )
    end

end


function GMT:ScheduleDespawn(ent)
    --timer.Simple(2, function()
    timer.Simple(GMT.WeaponDespawn, function()
        if not ent:IsValid() then return end
        local owner = ent:GetOwner()
        if ent:IsValid() and not owner:IsValid() then
            ent:Remove()
        end
    end)
end

function GMT:NPCGetFaction ( npc )
    local faction = ""
    if     npc:GetClass()       == "npc_combine_s" or npc:GetClass() == "npc_metropolice" then faction = "combine"
    elseif npc:GetClass()   == "npc_citizen" then faction = "rebel" end

    return faction
end

function GMT:PlayerNPCRelationship( player, npc )
    local faction = GMT:NPCGetFaction ( npc )

    if faction == "" then return D_NU end

    if player.Factions[faction] < 0 then
        return D_HT
    end

    if player.Factions[faction] > 0 then
        return D_LI
    end

    return D_NU
end

function GMT:PlayerKillNPC( ply, npc )
    local faction = GMT:NPCGetFaction( npc )

    if faction == "combine" then
        ply.Factions.combine = ply.Factions.combine - 5
    end

    if faction == "rebel" then
        ply.Factions.rebel   = ply.Factions.rebel - 2
        ply.Factions.combine = ply.Factions.combine + 2
    end

    for _, npc in pairs( ents.FindByClass( "npc_*" ) ) do
        if IsValid(npc) and npc:IsNPC() then
            npc:AddEntityRelationship( ply, GMT:PlayerNPCRelationship( ply, npc ), 99 )
        end
    end

    print( "Player allignment: ", ply )
    PrintTable( ply.Factions )
end


function GMT:SpawnCrate(entsIn)
    local spawnEnts  = entsIn or ents.FindByClass( "info_crate_spawn" )
    --local randomPoit = math.random( #spawnEnts )

    local spawnPoint = table.Random(spawnEnts)
    local maxTries = #spawnEnts
    local try = 1
    while spawnPoint.hasCrate == true and try != maxTries do
        spawnPoint = table.Random(spawnEnts)
        try = try + 1
        if try == maxTries then return end
    end

    if spawnPoint != nil then
        print("Crate spawning")
        local crate = ents.Create("weapon_crate")
        crate:SetPos(spawnPoint:GetPos())
        crate:Spawn()
        crate.spawnPoint = spawnPoint
        spawnPoint.hasCrate = true
    end
end

function GMT:SpawnCrates()
    local spawnEnts  = ents.FindByClass( "info_crate_spawn" )
    local maxCrates = (#spawnEnts * .10)

    for i=1, maxCrates do
        GMT:SpawnCrate(spawnEnts)
    end
end


hook.Add( "InitPostEntity", "spawnCrates", function()
    timer.Simple(1, function()
        GMT:SpawnCrates()

        GMT.squads = {}
        for _, squad in pairs( ents.FindByClass('logic_npc_squad') ) do
            GMT.squads[squad:GetName()] = squad
        end
        print( "INITIALIZED SQUADS: ")
        PrintTable(GMT.squads)
    end)

end )

-- Setup player inventory
hook.Add("PlayerLoadout", "gmt_player_spawn_inventory", function ( ply )
    -- Make sure player has nothing
    ply:StripWeapons()
    ply:StripAmmo()

    -- Default inventory
    if not inventory then
        inventory = {
            {
                weapon = 'gmt_hk45'
            },
            {
                weapon = 'weapon_empty_hands'
            },
            {
                weapon = 'weapon_crowbar'
            },
            --{
                --weapon = 'gmt_m16'
            --},
            --{
                --weapon = 'gmt_ak74'
            --},
            --{
                --weapon = 'gmt_ar15'
            --},
            --{
                --weapon = 'gmt_aug'
            --},
            --{
                --weapon = 'gmt_hk416'
            --},
            --{
                --weapon = 'gmt_mosin'
            --},
            --{
                --weapon = 'gmt_mp5'
            --},
            --{
                --weapon = 'gmt_mp7'
            --},
            --{
                --weapon = 'gmt_p90'
            --},
            --{
                --weapon = 'gmt_pkm'
            --},
            --{
                --weapon = 'gmt_scout'
            --},
            --{
                --weapon = 'gmt_uzi'
            --}
        }
    end

    ply.forceGive = true
    for _, weapon in pairs(inventory) do
        ply:Give( weapon.weapon )
    end
    ply.forceGive = false


    local playerAmmo = {
        {
            amount = 16,
            ammo_type = ".45 ACP"
        },
        --{
            --amount = 100,
            --ammo_type = "7.62x51MM"
        --},
        --{
            --amount = 100,
            --ammo_type = "5.7x28MM"
        --}
    }

    if playerAmmo then
        for _, ammo in pairs(playerAmmo) do
            ply:SetAmmo(ammo['amount'], ammo['ammo_type'])
        end
    end

    return true
end)

hook.Add("OnNPCKilled", "gmt_npc_killed", function( npc, attacker, inflictor )
    if IsValid( attacker ) and attacker:IsPlayer() then
        GMT:PlayerKillNPC( attacker, npc )
    end
end)

hook.Add("PlayerDeath", "gmt_player_death_inventory", function ( victim, inflictor, attacker )
    victim:StopSound("player_breathe")
    victim:StopSound("player_heart")
    victim.isBreathing = false

    local testItem = ents.Create( "inventory_item" )
    testItem:SetItem( "health_spray" )
    testItem:SetPos( victim:GetPos() )
    testItem:Spawn()

    for k, v in pairs( victim:GetWeapons() ) do
        victim:DropWeapon( v )
    end

    local ragDoll = victim:GetRagdollEntity()
    if IsValid(ragDoll) then ragDoll:Remove() end

    if( attacker:IsNPC() ) then
        local kv = attacker:GetKeyValues()

        local squad = GMT.squads[kv["squadname"]]
        if IsValid(squad) then
            squad:PlayerDeath( victim, attacker )
        end
    end
end)


function GM:PlayerDeath( Victim, Inflictor, Attacker ) -- We are copying this function from Base to make it not print into players consoles that a player died.

    -- Don't spawn for at least 2 seconds
    Victim.NextSpawnTime = CurTime() + 5
    Victim.DeathTime = CurTime()

    if ( !IsValid( Inflictor ) && IsValid( Attacker ) ) then
        Inflictor = Attacker
    end

    -- Convert the inflictor to the weapon that they're holding if we can.
    -- This can be right or wrong with NPCs since combine can be holding a
    -- pistol but kill you by hitting you with their arm.
    if ( Inflictor && Inflictor == Attacker && (Inflictor:IsPlayer() || Inflictor:IsNPC()) ) then

        Inflictor = Inflictor:GetActiveWeapon()
        if ( !IsValid( Inflictor ) ) then Inflictor = Attacker end

    end

    if (Attacker == Victim) then

        --umsg.Start( "PlayerKilledSelf" )
            --umsg.Entity( Victim )
        --umsg.End()

        print( Attacker:Nick() .. " suicided!" )

    return end

    if ( Attacker:IsPlayer() ) then

        --umsg.Start( "PlayerKilledByPlayer" )

            --umsg.Entity( Victim )
            --umsg.String( Inflictor:GetClass() )
            --umsg.Entity( Attacker )

        --umsg.End()

        print( Attacker:Nick() .. " killed " .. Victim:Nick() .. " using " .. Inflictor:GetClass() )

    return end

    --umsg.Start( "PlayerKilled" )

        --umsg.Entity( Victim )
        --umsg.String( Inflictor:GetClass() )
        --umsg.String( Attacker:GetClass() )

    --umsg.End()

    print( Victim:Nick() .. " was killed by " .. Attacker:GetClass() )

end

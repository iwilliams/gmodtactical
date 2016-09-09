AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")
include("player.lua")

GMT = {}
include("config.lua")

function has_value (tab, val)
    for index, value in pairs (tab) do
        if value == val then
            return true
        end
    end

    return false
end

-- DELET THIS
hook.Add( "PlayerNoClip", "NoClipCheck", function(ply)
    return ply:IsSuperAdmin()
end)

function GM:OnNPCKilled( victim, killer, weapon )
    -- Drop Weapon
    local wep = victim:GetActiveWeapon()
    local wepName = string.sub(wep:GetClass(), 5)
    local newWep = ents.Create( wepName )
    if IsValid(newWep) then
        newWep:SetPos(victim:GetPos() + Vector(0,0,64))
        newWep:Spawn()
        GMT:ScheduleDespawn(newWep)
    end
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
    if ( !ply:KeyDown( IN_USE ) ) then return false end
    local trace = util.QuickTrace( ply:GetShootPos(), ply:GetAimVector() * 8192, ply )
    if ( !trace.Entity || !trace.Entity:IsValid() || trace.Entity != wep ) then
        return false
    end

    -- If its the same weapon you have then only pickup ammo
    --if ( ply:HasWeapon( wep:GetClass() ) ) then
        --local ammoCount1 = wep:Clip1()
        --local ammoCount2 = wep:Clip2()

        --wep:SetClip1(0)
        --wep:SetClip2(0)

        --ply:GiveAmmo(ammoCount1, wep:GetPrimaryAmmoType())
        --ply:GiveAmmo(ammoCount2, wep:GetPrimaryAmmoType())
        --return false
    --end

    -- Figure out which weapons to drop
    local newWep        = wep:GetClass()
    local newWepType    = nil
    if has_value(GMT.PrimaryWeapons, newWep) then
        newWepType = "PrimaryWeapons"
    else
        newWepType = "SecondaryWeapons"
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
end
hook.Add( "PlayerSpawn", "UseWeapon", PlayerSpawn )

function GM:PlayerHurt( victim, attacker, healthRemaining )
    if ( victim:IsPlayer() ) then
        victim:EmitSound("vo/npc/male01/pain02.wav")

        if healthRemaining < 20 and not victim.isBreathing then
            --victim:EmitSound("player_heart")
            --victim:EmitSound("player_breathe")
            --
            --local testSound = CreateSound(victim, Sound("player_breathe"))
            --testSound:Play()
            --victim.isBreathing = true
        end
    end
end

hook.Add( "PlayerCanHearPlayersVoice", "Maximum Range", function( listener, talker )
    if listener:GetPos():Distance( talker:GetPos() ) > 500 then return false end
end )



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
    local maxCrates = (#spawnEnts * .4)

    for i=1, maxCrates do
        GMT:SpawnCrate(spawnEnts)
    end
end


hook.Add( "InitPostEntity", "spawnCrates", function()
    timer.Simple(1, function()
        GMT:SpawnCrates()
    end)
end )


function GMT:ClearPlayerInventory( ply )
    local steamid = ply:SteamID()

    local result = sql.Query([[
        DELETE FROM gmt_player_inventory WHERE steamID = "]] .. steamid .. [[";
    ]])

    if result == false then
        print(sql.LastError())
    end
end

function GMT:SavePlayerInventory( ply )
    local weapons = ply:GetWeapons()
    local steamid = ply:SteamID()

    for key, weapon in pairs(weapons) do
        result = sql.Query([[
            INSERT INTO gmt_player_inventory VALUES (
                "]] .. steamid .. [[",
                "]] .. weapon:GetClass() .. [[",
                ]] .. weapon:Clip1() .. [[,
                ]] .. weapon:Clip2() .. [[
            );
        ]])

        if result == false then
            print(sql.LastError())
        end
    end
end

function GMT:PlayerAmmoClear( ply )
    local steamid = ply:SteamID()

    local result = sql.Query([[
        DELETE FROM gmt_player_ammo WHERE steamID = "]] .. steamid .. [[";
    ]])

    if result == false then
        print(sql.LastError())
    end
end

function GMT:PlayerAmmoSave( ply )
    local steamid = ply:SteamID()

    for i=1,27 do
        local ammoName  = game.GetAmmoName(i)
        local ammoCount = ply:GetAmmoCount(ammoName)

        if ammoCount > 0 then
            local result = sql.Query([[
                INSERT INTO gmt_player_ammo VALUES (
                    "]] .. steamid .. [[",
                    "]] .. ammoName .. [[",
                    ]] .. ammoCount .. [[
                );
            ]])

            if result == false then
                print(sql.LastError())
            end
        end
    end

    return
end

function GMT:PlayerAmmoGet( ply )
    local steamid = ply:SteamID()

    local ammoTable = sql.Query([[
        SELECT ammo_type, amount FROM gmt_player_ammo
    ]])

    return ammoTable
end

function GMT:SetupDB()
    if not sql.TableExists('gmt_player') then
        sql.Begin()
            sql.Query([[
                CREATE TABLE IF NOT EXISTS gmt_player(
                    steamID     VARCHAR(25) NOT NULL PRIMARY KEY,
                    money       INTEGER DEFAULT 200
                )
            ]])
        sql.Commit()
    end

    if not sql.TableExists('gmt_player_inventory') then
        sql.Begin()
            sql.Query([[
                CREATE TABLE IF NOT EXISTS gmt_player_inventory(
                    steamID  VARCHAR(25) NOT NULL,
                    weapon   VARCHAR(100) NOT NULL,
                    clip1    INTEGER,
                    clip2    INTEGER
                )
            ]])
            sql.Query([[
                CREATE INDEX gmt_player_inventory_steamIDIdx ON gmt_player_inventory(steamID);
            ]])
        sql.Commit()
    end

    if not sql.TableExists('gmt_player_ammo') then
        sql.Begin()
            sql.Query([[
                CREATE TABLE IF NOT EXISTS gmt_player_ammo(
                    steamID   VARCHAR(25) NOT NULL,
                    ammo_type VARCHAR(50) NOT NULL,
                    amount    INTEGER NOT NULL
                )
            ]])
            sql.Query([[
                CREATE INDEX gmt_player_ammo_steamIDIdx ON gmt_player_ammo(steamID);
            ]])
        sql.Commit()
    end
end

local function init()
    GMT:SetupDB()
end
hook.Add( "Initialize", "some_unique_name", init )

hook.Add("PlayerAuthed", "gmt_db_store_player", function( ply, steamid )
    -- Create a db entry fot his player
    sql.Begin()
    result = sql.Query("INSERT OR IGNORE INTO gmt_player (steamID) VALUES (" .. sql.SQLStr(steamid) .. ")")
    if not result then
        print(sql.LastError())
    end
    sql.Commit()

    -- Player hasn't spawned yet
    ply.hasSpawned = false

    PrintTable(sql.Query("SELECT * FROM gmt_player"))
end)

-- Setup player inventory
hook.Add("PlayerLoadout", "gmt_player_spawn_inventory", function ( ply )
    -- Make sure player has nothing
    ply:StripWeapons()
    ply:StripAmmo()

    -- Make sure when player dies they will drop their wep
    ply:ShouldDropWeapon(true)

    local inventory = false

    -- Try to load inventory form db
    if not ply.hasSpawned then
        local steamid = ply:SteamID()

        inventory = sql.Query([[
            SELECT * FROM gmt_player_inventory WHERE steamID = "]] .. steamid .. [[";
        ]])
    end

    -- Default inventory
    if not inventory then
        inventory = {
            {
                weapon = 'm9k_hk45',
            },
            --{
                --weapon = 'weapon_cc_hk416_ex',
            --},
            {
                weapon = 'm9k_knife',
            }
        }
    end

    --PrintTable(inventory)

    for key, weapon in pairs(inventory) do
        local wepEnt = ply:Give(weapon['weapon'])
        if weapon['clip1'] != nil then wepEnt:SetClip1(weapon['clip1']) end
        if weapon['clip2'] != nil then wepEnt:SetClip2(weapon['clip2']) end
    end

    -- If this is the first spawn then try to load ammo
    local playerAmmo = false

    if not ply.hasSpawned then
        playerAmmo = GMT:PlayerAmmoGet(ply)
    end

    if not playerAmmo then
        playerAmmo = {
            {
                amount = 32,
                ammo_type = "Pistol"
            }
        }
    else
        GMT:PlayerAmmoClear(ply)
    end

    if playerAmmo then
        for _, ammo in pairs(playerAmmo) do
            ply:SetAmmo(ammo['amount'], ammo['ammo_type'])
        end
    end

    -- This doesn't seem to really work here but do it anyway
    ply.hasSpawned = true

    return true
end)

hook.Add("PlayerDeath", "gmt_player_death_inventory", function ( victim )
    if victim.hasSpawned == false then
        GMT:ClearPlayerInventory(victim)
        GMT:PlayerAmmoClear(victim)
    end

    victim:StopSound("player_breathe")
    victim:StopSound("player_heart")
    victim.isBreathing = false


    print(victim:GetModel())

    -- first person death
    --victim:Spectate(OBS_MODE_IN_EYE)
    --victim:SpectateEntity( victim:GetRagdollEntity() )

    local ragDoll = victim:GetRagdollEntity()
    if IsValid(ragDoll) then ragDoll:Remove() end
    --victim:ScreenFade( SCREENFADE.OUT, color_black, 5, 60 * 60 * 60)

    victim.hasSpawned = true
end)

hook.Add("PlayerDisconnected", "gmt_db_player_disconnect", function( ply )
    sql.Begin()
    -- Clear Player info
    GMT:ClearPlayerInventory(ply)
    GMT:PlayerAmmoClear(ply)
    -- Save player info
    GMT:SavePlayerInventory(ply)
    GMT:PlayerAmmoSave(ply)
    sql.Commit()
end)

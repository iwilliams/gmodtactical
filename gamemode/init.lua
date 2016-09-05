AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")
include("player.lua")

GMT = {}

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
GMT:SetupDB()

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

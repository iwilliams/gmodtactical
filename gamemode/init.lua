AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")
include("player.lua")

function has_value (tab, val)
    for index, value in pairs (tab) do
        if value == val then
            return true
        end
    end

    return false
end

-- DELET THIS
--hook.Add( "PlayerNoClip", "EnableNoclip", function()
   --return true
--end)

GMT = {
    PrimaryWeapons = {
        'm9k_pkm',
        'm9k_m3',
        'm9k_sl8',
        'm9k_fal',
        'm9k_ithacam37',
        'm9k_m14sp',
        'm9k_m61_frag',
        'm9k_mp5',
        'm9k_ak74',
        'm9k_psg1',
        'm9k_tar21',
        'm9k_dragunov',
        'm9k_m60',
        'm9k_orbital_strike',
        'm9k_m79gl',
        'm9k_m1918bar',
        'm9k_fg42',
        'm9k_jackhammer',
        'm9k_vector',
        'm9k_browningauto5',
        'm9k_ied_detonator',
        'm9k_famas',
        'm9k_minigun',
        'm9k_1897winchester',
        'm9k_val',
        'm9k_kac_pdw',
        'm9k_spas12',
        'm9k_uzi',
        'm9k_bizonp19',
        'm9k_striker12',
        'm9k_fists',
        'm9k_mp9',
        'm9k_g36',
        'm9k_milkormgl',
        'm9k_ex41',
        'm9k_damascus',
        'm9k_vikhr',
        'm9k_smgp90',
        'm9k_m202',
        'm9k_m4a1',
        'm9k_auga3',
        'm9k_nitro',
        'm9k_honeybadger',
        'm9k_rpg7',
        'm9k_mp40',
        'm9k_suicide_bomb',
        'm9k_tec9',
        'm9k_m98b',
        'm9k_usas',
        'm9k_an94',
        'm9k_l85',
        'm9k_m249lmg',
        'm9k_acr',
        'm9k_davy_crockett',
        'm9k_scar',
        'm9k_amd65',
        'm9k_thompson',
        'm9k_dbarrel',
        'm9k_sten',
        'm9k_harpoon',
        'm9k_svt40',
        'm9k_ak47',
        'm9k_m416',
        'm9k_winchester73',
        'm9k_m16a4_acog',
        'm9k_contender',
        'm9k_usc',
        'm9k_intervention',
        'm9k_svu',
        'm9k_ares_shrike',
        'm9k_magpulpdr',
        'm9k_1887winchester',
        'm9k_aw50',
        'm9k_m24',
        'm9k_barret_m82',
        'm9k_proxy_mine',
        'm9k_mossberg590',
        'm9k_g3a3',
        'm9k_nerve_gas',
        'm9k_mp5sd',
        'm9k_mp7',
        'm9k_f2000',
        'm9k_remington870',
        'm9k_ump45',
        'm9k_machete',
        'm9k_matador',
        'm9k_sticky_grenade',
        'm9k_remington7615p'
    },
    SecondaryWeapons = {
        'm9k_hk45',
        'm9k_colt1911',
        'm9k_coltpython',
        'm9k_deagle',
        'm9k_glock',
        'm9k_usp',
        'm9k_m29satan',
        'm9k_m92beretta',
        'm9k_luger',
        'm9k_ragingbull',
        'm9k_scoped_taurus',
        'm9k_remington1858',
        'm9k_model3russian',
        'm9k_model500',
        'm9k_model627',
        'm9k_sig_p229r'
    },
    OtherWeapons = {
        'm9k_knife'
    },
    Items = {
        'item_healthvial',
        'item_healthkit',
        'item_battery',
        'm9k_ammo_ar2',
        'm9k_ammo_pistol',
        'm9k_ammo_buckshot',
        'm9k_ammo_frags',
        'm9k_ammo_357',
        'm9k_ammo_proxmines',
        'm9k_ammo_smg',
        'm9k_ammo_sniper_rounds',
        --'m9k_ammo_c4',
        'sent_ball'
    }
}

hook.Add( "PlayerCanPickupWeapon", "checkWeaponPickup", function( ply, wep )

    -- Check E button LOS
    if ( CurTime() <= ( ply.UseWeaponSpawn or 0 ) ) then return end
    if ( !ply:KeyDown( IN_USE ) ) then return false end
    local trace = util.QuickTrace( ply:GetShootPos(), ply:GetAimVector() * 8192, ply )
    if ( !trace.Entity || !trace.Entity:IsValid() || trace.Entity != wep ) then
        return false
    end

    -- If its the same weapon you have then only pickup ammo
    if ( ply:HasWeapon( wep:GetClass() ) ) then
        local ammoCount1 = wep:Clip1()
        local ammoCount2 = wep:Clip2()

        wep:SetClip1(0)
        wep:SetClip2(0)

        ply:GiveAmmo(ammoCount1, wep:GetPrimaryAmmoType())
        ply:GiveAmmo(ammoCount2, wep:GetPrimaryAmmoType())
        return false
    end

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
        end
    end

    timer.Simple(0, function() ply:SelectWeapon(newWep) end)
end )

local function PlayerSpawn( ply )
    ply.UseWeaponSpawn = CurTime()
end
hook.Add( "PlayerSpawn", "UseWeapon", PlayerSpawn )



hook.Add( "PlayerCanHearPlayersVoice", "Maximum Range", function( listener, talker )
    if listener:GetPos():Distance( talker:GetPos() ) > 500 then return false end
end )



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
    local maxCrates = (#spawnEnts * .75)

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

    -- first person death
    victim:Spectate(OBS_MODE_IN_EYE)
    victim:SpectateEntity( victim:GetRagdollEntity() )

    victim:ScreenFade( SCREENFADE.OUT, color_black, 5, 60 * 60 )

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

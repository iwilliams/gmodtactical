require( "mysqloo" )
local db = mysqloo.connect( "127.0.0.1", "root", "", "gmodtactical", 3306 )

local function migrate()
    print('MIGRATE')

    -- Create gmt_player
    local gmtPlayerQuery = db:query([[
        CREATE TABLE IF NOT EXISTS gmt_player (
            steamID     VARCHAR(25) NOT NULL PRIMARY KEY,
            money       INTEGER DEFAULT 200
        )
    ]])
    gmtPlayerQuery:start()


    -- Create gmt_player_inventory
    local gmtPlayerInventoryQuery = db:query([[
        CREATE TABLE IF NOT EXISTS gmt_player_inventory(
            player_inventory_id INTEGER PRIMARY KEY AUTO_INCREMENT,
            steamID  VARCHAR(25) NOT NULL,
            weapon   VARCHAR(100) NOT NULL,
            clip1    INTEGER,
            clip2    INTEGER
        )
    ]])
    --function gmtPlayerInventoryQuery:onSuccess( data )
        --PrintTable(data)
        --local idxQuery = db:query([[
            --CREATE INDEX gmt_player_inventory_steamIDIdx ON gmt_player_inventory(steamID);
        --]])
        --idxQuery:start()
    --end
    gmtPlayerInventoryQuery:start()


    -- Create gmt_player_ammo
    local gmtPlayerAmmoQuery = db:query([[
        CREATE TABLE IF NOT EXISTS gmt_player_ammo(
            player_ammo_id INTEGER PRIMARY KEY AUTO_INCREMENT,
            steamID   VARCHAR(25) NOT NULL,
            ammo_type VARCHAR(50) NOT NULL,
            amount    INTEGER NOT NULL
        )
    ]])
    --function gmtPlayerAmmoQuery:onSuccess( data )
        --local idxQuery = db:query([[
            --CREATE INDEX gmt_player_ammo_steamIDIdx ON gmt_player_ammo(steamID);
        --]])
        --idxQuery:start()
    --end
    gmtPlayerAmmoQuery:start()


    -- Create gmt_player_map_pos
    local gmtPlayerMapPosQuery = db:query([[
        CREATE TABLE IF NOT EXISTS gmt_player_map_pos(
            player_map_pos_id INTEGER PRIMARY KEY AUTO_INCREMENT,
            steamID   VARCHAR(25) NOT NULL,
            map       VARCHAR(50) NOT NULL,
            pos       VARCHAR(50) NOT NULL,
            angle     VARCHAR(50) NOT NULL
        )
    ]])
    --function gmtPlayerMapPosQuery:onSuccess( data )
        --local idxQuery = db:query([[
            --CREATE INDEX gmt_player_map_pos_steamIDIdx ON gmt_map_pos(steamID);
        --]])
        --idxQuery:start()
    --end
    gmtPlayerMapPosQuery:start()
end

function db:onConnected()
    print( "Database has connected!" )
    migrate()
end

function db:onConnectionFailed( err )
    print( "Connection to database failed!" )
    print( "Error:", err )
end

db:connect()

--function GMT.DB:


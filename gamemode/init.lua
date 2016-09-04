AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")
include("player.lua")

include("config.lua")
include("libraries/mysqlite/mysqlite.lua")
MySQLite.initialize(GMT_DBConfig)

--local tableExists = sql.TableExists('gmt_player')

--if not tableExists then
    --sql.begin()
        --sql.query([[
            --CREATE TABLE IF NOT EXISTS gmt_player(
                --teamID VARCHAR(25) NOT NULL PRIMARY KEY
        --]])
    --sql.commit()
--end

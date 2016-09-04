AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")
include("player.lua")

include("config.lua")

local tableExists = sql.TableExists('gmt_player')

if not tableExists then
    sql.Begin()
        sql.query([[
            CREATE TABLE IF NOT EXISTS gmt_player(
                steamID VARCHAR(25) NOT NULL PRIMARY KEY
            )
        ]])
    sql.Commit()
end

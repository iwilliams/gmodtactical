AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")
include("player.lua")

include("config.lua")
include("libraries/mysqlite/mysqlite.lua")

MySQLite.initialize(GMT_DBConfig)

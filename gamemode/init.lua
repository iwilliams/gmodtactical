AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")
include("player.lua")

include("libraries/mysqlite/mysqlite.lua")

MySQLite.initialize({ EnableMySQL         = true --      :: Bool   - set to true to use MySQL, false for SQLite
                    , Host                = "localhost" --             :: String - database hostname
                    , Username            = "root"   --      :: String - database usernam"
                    , Password            = "" --       :: String - database password (keep away from clients!)
                    , Database_name       = "gmodtactical" }) --:: String - name of the database

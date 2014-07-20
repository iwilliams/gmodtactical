AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")
include("player.lua")

-- Assault weapons
-- resource.AddWorkshop( "285820424" )



function AddDir(dir)
 
	local files, dirs = file.Find(dir.."/*", "GAME")
 
	for _, fdir in pairs(dirs) do
	    if fdir != ".svn" then
	    AddDir(dir.."/"..fdir)
	    end
	end
 
	for k,v in pairs(files) do
	    resource.AddFile(dir.."/"..v)
	end
 
end

-- Models

resource.AddFile( "models/weapons/v_hk416rif.mdl" )
resource.AddFile( "models/weapons/w_hk_416.mdl" )

resource.AddFile( "models/weapons/v_tct_ak47.mdl" )	
resource.AddFile( "models/weapons/w_tct_ak47.mdl" )

-- Model Skins
AddDir('materials/models/weapons/v_models/twinke_hk416')
AddDir('materials/models/weapons/w_models/twinke_hk416')

AddDir('materials/models/weapons/v_models/rif_ak74')
AddDir('materials/models/weapons/w_models/rif_ak74')

AddDir('materials/models/weapons/v_models/thanez_ak')
AddDir('materials/models/weapons/w_models/thanez_ak')

-- Sounds
AddDir('sound/weapons/twinkie_hk416')
AddDir('sound/weapons/fokku_tc_ak47')
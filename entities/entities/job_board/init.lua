AddCSLuaFile( "cl_init.lua" ) --Send cl_init.lua to the client
AddCSLuaFile( "shared.lua" ) --Send shared.lua to the client
include( 'shared.lua' ) --Include shared.lua

function ENT:Use( activator, caller, useType, value )
    --local spawns = ents.FindByName( "quest_item_spawn_*" )

    ----local questItem = ents.Create( "prop_physics" )
    --local questItem = ents.Create( "quest_item" )
    ----questItem:SetModel( "models/props_c17/BriefCase001a.mdl" )
    --questItem:SetPos( spawns[1]:GetPos() )
    --questItem:Spawn()

    --self.questItem = questItem
    --self:SpawnItem()
end

function ENT:AcceptInput(inputName, activator, called, data )
    if true then
        print("-----------")
        print("AcceptInput")
        print("inputName: ",    inputName)
        print("activator: ",    activator)
        print("called: ",       called)
        print("data: ",         data)
        print("-----------")
    end

    if inputName == "OnStartTouch" and !self.isRewarding and IsValid(self.questItem) and activator == self.questItem then
        self.isRewarding = true
        print( "Item dropped off" )
        timer.Simple(2, function()
            self.isRewarding = false
            self.questItem:Remove()
        end)

        local spawns = ents.FindByName( "job_board_1_booster_spawn" )
        local spawnPos = spawns[1]:GetPos()

        local crate = ents.Create("booster_pack")
        crate:SetPos(spawnPos)
        crate:Spawn()

        spawnPos:Add( Vector(0, 0, 40) )
        local crate1 = ents.Create("booster_pack")
        crate1:SetPos(spawnPos)
        crate1:Spawn()

        spawnPos:Add( Vector(0, 0, 80) )
        local crate2 = ents.Create("booster_pack")
        crate2:SetPos(spawnPos)
        crate2:Spawn()

        self:EmitSound( "buttons/button24.wav", 75, 100, 1, CHAN_AUTO )

        timer.Simple(2, function()
            self:SpawnItem()
        end)
    end
end

function ENT:SpawnItem()
    local spawns = ents.FindByName( "quest_item_spawn_*" )

    --local questItem = ents.Create( "prop_physics" )
    local questItem = ents.Create( "quest_item" )
    local spawn = table.Random(spawns)
    questItem:SetPos( spawn:GetPos() )
    questItem:Spawn()

    self.questItem = questItem

    self.Jobs = {
        {
            name = "Retrieve the case from the " .. string.Replace( spawn:GetName(), "quest_item_spawn_", "" )
        }
    }

    self:SyncJobs(player.GetHumans())
end

util.AddNetworkString( "job_board_update" )
function ENT:SyncJobs(clients)
    net.Start("job_board_update")
        net.WriteTable(self.Jobs)
        net.WriteEntity(self)
    net.Send(clients)
end

util.AddNetworkString( "job_board_request" )
net.Receive( "job_board_request", function(len, ply)
   local board = net.ReadEntity()
   board:SyncJobs(ply)
end)

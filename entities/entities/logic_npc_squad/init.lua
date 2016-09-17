AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

local SQUAD_UNSPAWNED = 0
local SQUAD_WAITING   = 1
local SQUAD_PATROLING   = 2
local SQUAD_SEARCHING   = 3

local function GetNPCSchedule( npc )
    if ( !IsValid( npc ) ) then return end
    for s = 0, LAST_SHARED_SCHEDULE-1 do
        if ( npc:IsCurrentSchedule( s ) ) then return s end
    end
    return 0
end
local pathTable1 = {}

local function GetNPCNumber( npc )
    return string.Explode("_", npc:GetName() )[4]
end

function ENT:SendNPCToPoint( npc, pointName )
    if not IsValid(npc) then return end

    -- Get the Brain
    local scriptOne = ents.FindByName(npc:GetName() .. "_brain")
    local script    = scriptOne[1]

    -- Get the next path
    local nextPath

    if pointName then
        nextPath = pointName
    elseif IsValid( npc:GetSaveTable().m_hGoalEnt ) then
        nextPath = npc:GetSaveTable().m_hGoalEnt:GetName()
    else
        nextPath = self:GetName() .. "_path_1"
    end

    if nextPath then
        script:SetKeyValue( "goalent", nextPath )
        script:Fire( "StartSchedule" )
    end

    npc.pathDone = false

    print( "Sending NPC " .. npc:GetName() .. " to next path " .. nextPath )
end

 -- Set custom key values in hammer and then assign them here
function ENT:KeyValue(key, value)
    if (key == "name") then
        self:SetName(value)
    end
end

function ENT:Initialize()
    self.LastThink = CurTime()

    print( "----- INITIALIZE " .. self:GetName() .. "------" )

    -- Store Spawners
    self.NPCMakers = {}

    for k, v in pairs( ents.FindByClass( "npc_template_maker" ) ) do
        if string.find( v:GetName(), self:GetName() ) then
            --table.insert( self.NPCMakers, v )
            self.NPCMakers[v:GetName()] = v
        end
    end

    print( "--- Makers: ---" )
    PrintTable( self.NPCMakers )

    self.SpawnPoints = ents.FindByName( self:GetName() .. "_spawn_*" )

    print ( "--- Spawn Points ---" )
    PrintTable( self.SpawnPoints )

    -- Max NPCs Allowed
    self.MaxNPCs = table.Count( self.SpawnPoints )

    -- Set Squad state
    self.State = SQUAD_UNSPAWNED

    -- Table for alive NPCs
    self.AliveNPCs = {}

    -- Set respawn number
    self.Respawns = 0

    -- Set level
    self.Level = 1
end

function ENT:SpawnSquad()
    print("----- Spawn " .. self:GetName() .. " NPCs -----")

    local level

    if not self.Respawns      then level = 1
    elseif self.Respawns < 5  then level = 1
    elseif self.Respawns < 10 then level = 2
    elseif self.Respawns < 15 then level = 3
    else level = 4 end

    for k, v in pairs( self.SpawnPoints ) do
        print( v, v.IsAlive )
        if not v.IsAlive then
            -- Set destination to spawn point
            self.NPCMakers[self:GetName() .. "_maker_level_"  .. level]:Fire("ChangeDestinationGroup", self:GetName() .. "_spawn_" .. k)
            -- Spawn
            self.NPCMakers[self:GetName() .. "_maker_level_"  .. level]:Fire( "Enable"  )
            self.NPCMakers[self:GetName() .. "_maker_level_"  .. level]:Fire( "Spawn"   )
            self.NPCMakers[self:GetName() .. "_maker_level_"  .. level]:Fire( "Disable" )
        end
    end

    self.Spawned = true
end

function ENT:ChangeState( state )
    self.State = state
    self.LastThink = CurTime()
end

-- Think Logic
function ENT:Think()
    -- If the squad is unspawned then wait 5 seconds and spawn them
    if self.State == SQUAD_UNSPAWNED then
        if CurTime() - self.LastThink > 5 then
            self:SpawnSquad()

            timer.Simple(1, function()
                for k, npc in pairs(self.AliveNPCs) do
                    self:SendNPCToPoint( npc, self:GetName() .. "_path_" .. GetNPCNumber(npc) .. "_1" )
                end
            end)

            return self:ChangeState( SQUAD_PATROLING )
        end
    elseif self.State == SQUAD_PATROLING then

        if (CurTime() - self.LastThink) > 15 then
            print("---- " .. self:GetName() .. " " .. "CHECK NPCS ----")
            self.LastThink = CurTime()

            if table.Count( self.AliveNPCs )  < 1 then
                print("---- " .. self:GetName() .. " " .. "RESPAWN NPCS ----")
                return self:ChangeState( SQUAD_UNSPAWNED )
            else
                for k, v in pairs(self.AliveNPCs) do
                    if v:IsNPC() then

                        local npcSchedule = GetNPCSchedule( v )

                        if npcSchedule == SCHED_IDLE_STAND then
                            print( v:GetName() .. " status: SCHED_IDLE_STAND" )
                            self:SendNPCToPoint( v )
                        elseif npcSchedule == SCHED_NONE then
                            print( v:GetName() .. " status: SCHED_NONE" )
                            if v.noneTimes then
                                v.noneTimes = v.noneTimes + 1
                            else
                                v.noneTimes = 1
                            end

                            if v.noneTimes == 3 then
                                v.noneTimes = 0
                                self:SendNPCToPoint( v )
                            end
                        else
                            print( v:GetName() .. " status: " .. npcSchedule )
                            v.noneTimes = 0
                        end

                    end
                end
            end

        end

    end

end

function ENT:AcceptInput(inputName, actevator, called, data )
    if true then
        print("-----------")
        print("AcceptInput")
        print("inputName: ",    inputName)
        print("activator: ",    activator)
        print("called: ",       called)
        print("data: ",         data)
        print("-----------")
    end

    -- NPC lost player
    if inputName == "OnLostPlayer" then
    end

    if inputName == "OnLostEnemy" then
        print( "---- " .. called:GetName() .. " OnLostEnemy ----" )
    end

    -- NPC Spawner Spawned NPC
    if inputName == "OnSpawnNPC" then
        local kv = called:GetKeyValues()

        if kv["classname"] == "info_npc_spawn_destination" then
            local npc = ents.FindByName( kv["RenameNPC"] )[1]
            npc.Name = kv["RenameNPC"]

            print( "Renaming npc " .. kv["RenameNPC"] )

            npc:SetCurrentWeaponProficiency( WEAPON_PROFICIENCY_PERFECT )

            called.IsAlive = true

            table.insert( self.AliveNPCs, npc )
        end
    end

    if inputName == "OnDeath" then
        table.RemoveByValue( self.AliveNPCs, called )
        self.Respawns = self.Respawns + 1

        if self.Respawns % 5 == 0 then
            local siren = ents.FindByName("squad_siren")[1]
            siren:Fire('PlaySound')
            timer.Simple(15, function()
                siren:Fire('FadeOut', 5)
                timer.Simple(5, function()
                    siren:Fire('StopSound')
                end)
            end)
        end

        if self.Respawns >= 2 then
            self.NPCMakers[self:GetName() .. "_maker_helicopter"]:Fire( "Enable"  )
            self.NPCMakers[self:GetName() .. "_maker_helicopter"]:Fire( "Spawn"   )
            self.NPCMakers[self:GetName() .. "_maker_helicopter"]:Fire( "Disable" )
        end

        -- Find the spawn point that spawned this NPC
        for k, point in pairs( self.SpawnPoints ) do
            local pointKeyValues = point:GetKeyValues()

            if called.Name == pointKeyValues["RenameNPC"] then
                point.IsAlive = false
                return
            end
        end

    end

    if inputName == "OnPathEnd" then
        local npcName   = data
        local npc       = ents.FindByName( npcName )[1]

        npc.pathDone = true

        local allDone = true
        for k, v in pairs(self.AliveNPCs) do
            allDone = allDone && v.pathDone
        end

        if allDone then
            return self:ChangeState( SQUAD_UNSPAWNED )
        end
    end
end


AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

local function GetNPCSchedule( npc )
    if ( !IsValid( npc ) ) then return end
    for s = 0, LAST_SHARED_SCHEDULE-1 do
        if ( npc:IsCurrentSchedule( s ) ) then return s end
    end
    return 0
end
local pathTable1 = {}

local function SendNPCToPoint( npc, pointName )
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
        nextPath = npc:GetName() .. "_path_1"
    end

    if nextPath then
        script:SetKeyValue( "goalent", nextPath )
        script:Fire( "StartSchedule" )
    end

    print( "Sending NPC " .. npc:GetName() .. " to next path " .. nextPath )
end

function ENT:KeyValue(key, value)
    if (key == "name") then
        self:SetName(value)
    end
end

function ENT:Initialize()
    --self:SetName("npc_controller_1")
    self.LastNPCCheck = CurTime()

    -- Store Spawners
    self.NPCMakers = ents.FindByClass( "npc_template_maker" )

    -- Store Squads
    self.Squads = ents.FindByClass( "logic_npc_squad" )

    timer.Simple(10, function()
        self:SpawnNPCs()
    end)
end

function ENT:SpawnNPCs()
    print("----- Spawn NPCs -----")
    for k, maker in pairs(self.NPCMakers) do
        maker:Fire( "Enable"  )
        maker:Fire( "Spawn"   )
        maker:Fire( "Disable" )
    end
end

function ENT:GetNPCs()
    return table.filter(ents.FindByName("npc_*"), function(v, k, allEnts)
        return v:IsNPC()
    end)
end

function ENT:Think()
    if (CurTime() - self.LastNPCCheck) > 15 then
        print("---- CHECK NPCS ----")
        self.LastNPCCheck = CurTime()

        local npcs = self:GetNPCs()

        print("Num NPCs: ", table.Count(npcs) )
        if table.Count( npcs ) == 0 then
            self:SpawnNPCs()
        -- If all NPCs are waiting for orders
        elseif table.Count( npcs ) == table.Count( table.filter( npcs, function(v) return v.pathDone end ) ) then
            for k, v in pairs(npcs) do
                if v:IsNPC() then
                    SendNPCToPoint( v , v:GetName() .. "_path_1" )
                    v.pathDone = false
                end
            end
        else
            for k, v in pairs(npcs) do
                if v:IsNPC() then
                    local npcSchedule = GetNPCSchedule( v )
                    print( v:GetName() .. " status:", npcSchedule )

                    if npcSchedule == SCHED_IDLE_STAND and not v.pathDone then
                        SendNPCToPoint( v )
                    elseif npcSchedule == SCHED_NONE then
                        if v.noneTimes then
                            v.noneTimes = v.noneTimes + 1
                        else
                            v.noneTimes = 1
                        end

                        if v.noneTimes == 3 then
                            v.noneTimes = 0
                            SendNPCToPoint( v )
                        end
                    else
                        v.noneTimes = 0
                    end
                end
            end
        end
    end
end

function ENT:AcceptInput(inputName, actevator, called, data )
    print("-----------")
    print("AcceptInput")
    print("inputName: ",    inputName)
    print("activator: ",    activator)
    print("called: ",       called)
    print("data: ",         data)
    print("-----------")

    -- NPC lost player
    if inputName == "OnLostPlayer" then
        timer.Simple(5, function()
            SendNPCToPoint( called )
        end)
    end

    -- NPC Spawner Spawned NPC
    if inputName == "OnSpawnNpc" then
        local npcName = data
        local npc = ents.FindByName( npcName )[1]

        npc.pathDone = true
        --timer.Simple(2, function()
            --SendNPCToPoint( npc[1], npcName .. "_path_1" )
        --end)
        --PrintTable( npc )
        -- Find the closest path
        --local paths     = ents.FindByName("path_1_*")
        --local npcPos    = called:GetPos()
        --table.sort(paths, function(a, b)
            --local aPos = a:GetPos()
            --local bPos = b:GetPos()

            --return aPos:Distance(npcPos) < bPos:Distance(npcPos)
        --end)
        --local closestPath = paths[1]

        --local nextPathNum    = string.sub(nextPath:GetName(), 8)
        --local closestPathNum = string.sub(closestPath:GetName(), 8)

        --print(nextPathNum, closestPathNum)le
    end

    if inputName == "OnPathEnd" then
        local npcName = data
        local npc = ents.FindByName( npcName )[1]
        npc.pathDone = true

        local npcs = self:GetNPCs()
        -- If there are fewer npcs then spawners refil squad
        if table.Count( npcs ) < table.Count( self.NPCMakers ) then
            self:SpawnNPCs()
        end
    end
end


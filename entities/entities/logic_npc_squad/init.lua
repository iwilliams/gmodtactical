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
        nextPath = self:GetName() .. "_path_1"
    end

    if nextPath then
        script:SetKeyValue( "goalent", nextPath )
        script:Fire( "StartSchedule" )
    end

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

    -- Store Spawners
    self.NPCMakers = table.filter(ents.FindByClass( "npc_template_maker" ), function(maker)
        return string.find( maker:GetName(), self:GetName() )
    end)

    -- Max NPCs Allowed
    self.MaxNPCs = table.Count( self.NPCMakers )

    -- Set Squad state
    self.State = SQUAD_UNSPAWNED

    -- Table for alive NPCs
    self.AliveNPCs = {}
end

function ENT:SpawnSquad()
    print("----- Spawn NPCs -----")
    for k, maker in pairs(self.NPCMakers) do
        print(maker)
        maker:Fire( "Enable"  )
        maker:Fire( "Spawn"   )
        maker:Fire( "Disable" )
    end
end

--function ENT:GetNPCs()
    --return table.filter(ents.FindByName("npc_*"), function(v, k, allEnts)
        --return v:IsNPC()
    --end)
--end

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
            return self:ChangeState( SQUAD_WAITING )
        end
    elseif self.State == SQUAD_WAITING then
        print( "waiting" )
        for k, npc in pairs(self.AliveNPCs) do
            SendNPCToPoint( npc, self:GetName() .. "_path_" .. GetNPCNumber(npc) .. "_1" )
            npc.isPatroling = true
        end
        return self:ChangeState( SQUAD_PATROLING )
    elseif self.State == SQUAD_SEARCHING then
        --if CurTime - self.LastThink
    end

    --[[
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
    --]]
end
--]]

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
        --timer.Simple(5, function()
            --SendNPCToPoint( called )
        --end)
    end

    if inputName == "OnLostEnemy" then
        timer.Simple(5, function()
            SendNPCToPoint( called )
        end)
    end

    -- NPC Spawner Spawned NPC
    if inputName == "OnSpawnNPC" then
        local npcName = data
        local npc = ents.FindByName( npcName )[1]

        table.insert( self.AliveNPCs, npc )

        npc.isPatroling = false
        --timer.Simple(2, function()
            --SendNPCToPoint( npc[1], npcName .. "_path_1" )
    end

    if inputName == "OnDeath" then
        table.RemoveByValue( self.AliveNPCs, called )
    end

    if inputName == "OnPathEnd" then
        local npcName = data
        local npc = ents.FindByName( npcName )[1]
        npc.isPatroling = false

        local allDone = true
        for k,v in pairs( self.AliveNPCs ) do
           allDone = allDone && !v.isPatroling
        end

        if allDone then
            return self:ChangeState( SQUAD_WAITING )
        end

        --local npcs = self:GetNPCs()
        ---- If there are fewer npcs then spawners refil squad
        --if table.Count( npcs ) < table.Count( self.NPCMakers ) then
            --self:SpawnNPCs()
        --end
    end
end


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

function ENT:Initialize()
    self:SetName("npc_controller_1")

    --timer.Simple(20, function()
        --local npcs  = entsIn or ents.FindByClass( "npc_combine_s" )

        --for key, npc in pairs(npcs) do
            --print(GetNPCSchedule(npc))
            --npc:SetKeyValue("target", "path_1_1")

            --local corners = ents.FindByName( "path_1_1" )

            --npc:SetSaveValue( "m_hGoalEnt", corners[1] )
            --npc:SetSaveValue( "m_bIsMoving", true )
            --npc:SetSchedule(SCHED_IDLE_WALK)
        --end
    --end)

    print("HELLO")
end

function ENT:AcceptInput(inputName, actevator, called, data )
    print("AcceptInput")
    print(inputName)
    print(activator)
    print(called)
    print(data)

    if data == "lost_player" then
        -- Get the Brain
        local scriptOne = ents.FindByName(called:GetName() .. "_brain")
        local script =   scriptOne[1]

        -- Get the next path
        local nextPath = called:GetSaveTable().m_hGoalEnt


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

        --print(nextPathNum, closestPathNum)


        script:SetKeyValue("goalent", nextPath:GetName())
        script:Fire("StartSchedule")
    end
end

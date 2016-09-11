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

function ENT:KeyValue(key, value)
    if (key == "name") then
        self:SetName(value)
    end
end

function ENT:Initialize()
end

function ENT:Think()
end

function ENT:AcceptInput(inputName, actevator, called, data )
end


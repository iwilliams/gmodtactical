AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

 -- Set custom key values in hammer and then assign them here
function ENT:KeyValue(key, value)
    if (key == "name") then
        self:SetName(value)
    end
end

function ENT:Initialize()
end

-- Think Logic
function ENT:Think()
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

    local kv = called:GetKeyValues()
    if kv.cycle >= 1 then
        print( "SET TIMER FOR HEALTH REFIL" )
        timer.Simple(5, function()
            called:SetKeyValue('cycle', 0)
        end)
    end
end


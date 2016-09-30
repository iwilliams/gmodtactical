include("shared.lua")

if ( CLIENT ) then
    ENT.Mat = nil
    ENT.Panel = nil
end

net.Receive( "job_board_update", function()
    local jobs = net.ReadTable()
    local chest = net.ReadEntity()

    print( jobs, chest, self )

    chest.Panel:Call( [[ updateJobs(']] .. util.TableToJSON( jobs ) .. [[') ]] )
end)

include("shared.lua")

if ( CLIENT ) then
    ENT.Mat = nil
    ENT.Panel = nil
end

net.Receive( "job_board_open", function()

end)

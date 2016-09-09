include("shared.lua")

function ENT:Initialize()
    self.rotate = 0
    self.lasttime = SysTime()
end

function ENT:Draw()
    self.Entity:DrawModel()

    local dlight = DynamicLight( self:EntIndex() )
    if ( dlight ) then
        local pos = self:GetPos()
        pos:Add(Vector(0, 0, 25))
        dlight.pos = pos
        dlight.r = 0
        dlight.g = 255
        dlight.b = 0
        dlight.brightness = 2
        dlight.Decay = 1000
        dlight.Size = 256
        dlight.style = 6
        dlight.DieTime = CurTime() + 1
    end
end


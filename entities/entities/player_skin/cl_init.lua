include("shared.lua")

function ENT:Initialize()
    self.rotate = 0
    self.lasttime = SysTime()
end

function ENT:Draw()
    self.Entity:DrawModel()
    --local realPos =self.Entity:GetPos()
    ----self.Spin = self.Spin+.1 % 360
    --self.Entity:SetAngles(Angle(0, self.rotate, 0))
    --self.Entity:DrawModel()

    --if ( self.rotate > 359 ) then self.rotate = 0 end

    --self.rotate = self.rotate - ( 100*( self.lasttime-SysTime() ) )
    --self.lasttime = SysTime()
end


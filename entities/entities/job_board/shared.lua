ENT.Type = "anim"
ENT.Base = "base_entity"

ENT.PrintName = "Web Screen"
ENT.Author = "iwiliams"

function ENT:Initialize()


    self.Jobs = {
        {
            name = "Retrieve the case from the warehouse"
        }
    }

    if ( SERVER ) then
        self:SetModel( "models/props_phx/rt_screen.mdl" )
        self:SetMoveType( MOVETYPE_VPHYSICS )
        self:SetSolid( SOLID_VPHYSICS )

        self:SetUseType(SIMPLE_USE)

        self:PhysicsInit( SOLID_VPHYSICS )

        self:Freeze()

        self.isRewarding = false

        self:SpawnItem()
    else

        -- Reset material and panel and load DHTML panel
        self.Mat = nil
        self.Panel = nil
        self:OpenPage()

        self:RequestSync()
    end
end

function ENT:Freeze()
    local phys = self:GetPhysicsObject()
    if ( IsValid( phys ) ) then phys:EnableMotion( false ) end
end

function ENT:RequestSync()
    net.Start("job_board_request")
        net.WriteEntity(self)
    net.SendToServer()
end

-- Load the DHTML reference panel
function ENT:OpenPage()

    -- Iff for some reason a panel is already loaded, delete it
    if ( self.Panel ) then

        self.Panel:Remove()
        self.Panel = nil

    end

    -- Create a web page panel and fill the entire screen
    self.Panel = vgui.Create( "DHTML" )
    self.Panel:SetSize( 2048, 1024 )
    --self.Panel:Dock( FILL )

    print( self.Panel:GetName() )

    -- Wiki page URL
    --local url = "http://wiki.garrysmod.com/page/Category:Material"
    local url = "http://warez.iwillia.ms/jobboard.html"

    -- Load the wiki page
    self.Panel:OpenURL( url )
    print(util.TableToJSON( self.Jobs ))
    --self.Panel:Call( [[ updateJobs(']] .. util.TableToJSON( self.Jobs ) .. [[') ]] )
    --self.Panel:Call( [[ window.updateJobs('[{"name": "test"}]') ]] )

    -- Hide the panel
    self.Panel:SetAlpha( 0 )
    --self.Panel:SetMouseInputEnabled( false )
    self.Panel:SetMouseInputEnabled( true )

    -- Disable HTML messages
    --function self.Panel:ConsoleMessage( msg ) end

end

function ENT:Draw()

    -- Iff the material has already been grabbed from the panel
    if ( self.Mat ) then


        -- Apply it to the screen/model
        if ( render.MaterialOverrideByIndex ) then
            render.MaterialOverrideByIndex( 1, self.Mat )
        else
            render.ModelMaterialOverride( self.Mat )
        end

    -- Otherwise, check that the panel is valid and the HTML material is finished loading
    elseif ( self.Panel != nil && self.Panel && self.Panel:IsLoading() == false && self.Panel:GetHTMLMaterial() ) then

        -- Get the html material
        print( self.Panel )
        local html_mat = self.Panel:GetHTMLMaterial()

        -- Used to make the material fit the model screen
        -- May need to be changed iff using a different model
        --local scale_x, scale_y = ScrW()/2048, ScrH()/1024
        local scale_x, scale_y = 1, 1

        -- Create a new material with the proper scaling and shader
        local matdata =
        {
            ["$basetexture"]=html_mat:GetName(),
            ["$basetexturetransform"]="center 0 0 scale "..scale_x.." "..scale_y.." rotate 0 translate 0 0",
            ["$model"]=1
        }

        -- Unique ID used for material name
        local uid = string.Replace( html_mat:GetName(), "__vgui_texture_", "" )

        -- Create the model material
        self.Mat = CreateMaterial( "WebMaterial_"..uid, "VertexLitGeneric", matdata )

    end

    -- Render the model
    self:DrawModel()

    -- Reset the material override or else everything will have a HTML material!
    render.ModelMaterialOverride( nil )

end

function ENT:OnRemove()
    -- Make sure the panel is removed too
    if ( self.Panel ) then self.Panel:Remove() end
end

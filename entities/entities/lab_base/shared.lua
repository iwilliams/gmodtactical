ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Lab"
ENT.Author = "DarkRP Developers"
ENT.Spawnable = false
ENT.CanSetPrice = true

-- These are variables that should be set in entities that base from this
-- models/props_junk/wood_crate001a.mdl
ENT.model = "models/props_junk/wood_crate001a.mdl"

--function ENT:initVars()
    ---- Implement this to set the above variables
--end

--function ENT:SetupDataTables()
    --self:NetworkVar("Int", 0, "price")
    --self:NetworkVar("Entity", 1, "owning_ent")
--end

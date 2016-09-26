ENT.Type        = "anim" --The entity source base, most entity's use anim
ENT.Base        = "base_entity" --The entity's garrys mod base, most entity's use base_gmodentity
ENT.Category        = "" --The entites catagory in the spawn menu
ENT.Instructions = ""

ENT.PrintName   = "Loot Crate" --The name
ENT.Author      = "iwilliams" --Author
ENT.Contact     = "" --Contact email

ENT.Spawnable       = true --Spawnable?
ENT.AdminSpawnable  = true --If spawnable, is it admin only?

ENT.AutomaticFrameAdvance = true

function ENT:SetAutomaticFrameAdvance( bUsingAnim ) -- This is called by the game to tell the entity if it should animate itself.
    self.AutomaticFrameAdvance = bUsingAnim
end

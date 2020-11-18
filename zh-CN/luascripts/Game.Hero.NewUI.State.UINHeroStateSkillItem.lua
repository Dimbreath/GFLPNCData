-- params : ...
-- function num : 0 , upvalues : _ENV
local UINHeroStateSkillItem = class("UINHeroStateSkillItem", UIBaseNode)
local base = UIBaseNode
local UINBaseSkillItem = require("Game.CommonUI.Item.UINBaseSkillItem")
UINHeroStateSkillItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINBaseSkillItem
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  self.skillItem = (UINBaseSkillItem.New)()
  ;
  (self.skillItem):Init((self.ui).obj_skillItem)
end

UINHeroStateSkillItem.InitSkillItem = function(self, skillData, resloader)
  -- function num : 0_1 , upvalues : _ENV
  (self.skillItem):InitBaseSkillItem(skillData, resloader)
  if skillData:GetIsUnlock() then
    ((self.ui).tex_SkillName):SetIndex(1, skillData:GetName())
    if skillData:IsFullLevel() then
      ((self.ui).tex_SkillLevel):SetIndex(1)
    else
      ;
      ((self.ui).tex_SkillLevel):SetIndex(0, tostring(skillData.level))
    end
  else
    ;
    ((self.ui).tex_SkillName):SetIndex(0)
    ;
    ((self.ui).tex_SkillLevel):SetIndex(0, "0")
  end
end

UINHeroStateSkillItem.OnDelete = function(self)
  -- function num : 0_2 , upvalues : base
  (base.OnDelete)(self)
end

return UINHeroStateSkillItem


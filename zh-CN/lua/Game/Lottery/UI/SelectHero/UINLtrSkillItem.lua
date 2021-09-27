local UINLtrSkillItem = class("UINLtrSkillItem", UIBaseNode)
local base = UIBaseNode
UINLtrSkillItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
end

UINLtrSkillItem.InitLtrSkillItem = function(self, skillData)
  -- function num : 0_1 , upvalues : _ENV
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R2 in 'UnsetPending'

  ((self.ui).img_icon).sprite = CRH:GetSprite(skillData:GetIcon(), CommonAtlasType.SkillIcon)
  local skillTag = skillData:GetSkillTag()
  ;
  ((self.ui).img_type):SetIndex(skillTag)
  ;
  ((self.ui).img_typeLine):SetIndex(skillTag)
  -- DECOMPILER ERROR at PC29: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (((self.ui).img_type).image).color = eBattleSkillTypeColor[skillData:GetBattleSkillTypeColor()]
end

UINLtrSkillItem.OnDelete = function(self)
  -- function num : 0_2 , upvalues : base
  (base.OnDelete)(self)
end

return UINLtrSkillItem


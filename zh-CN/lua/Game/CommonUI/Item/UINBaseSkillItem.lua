local UINBaseSkillItem = class("UINBaseSkillItem", UIBaseNode)
local base = UIBaseNode
UINBaseSkillItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
end

UINBaseSkillItem.InitBaseSkillItem = function(self, skillData, resloader)
  -- function num : 0_1
  self.resloader = resloader
  self:RefreshBaseSkillItem(skillData)
end

UINBaseSkillItem.RefreshBaseSkillItem = function(self, skillData)
  -- function num : 0_2
  self.skillData = skillData
  self:__RefreshIsUnlock()
end

UINBaseSkillItem.GetSkillData = function(self)
  -- function num : 0_3
  return self.skillData
end

UINBaseSkillItem.GetSkillUnlockState = function(self)
  -- function num : 0_4
  return self.unlock
end

UINBaseSkillItem.__RefreshIsUnlock = function(self)
  -- function num : 0_5
  if self.skillData == nil then
    return 
  end
  self.unlock = (self.skillData):GetIsUnlock()
  self:__SetUnlockUI(self.unlock)
end

UINBaseSkillItem.__SetUnlockUI = function(self, active)
  -- function num : 0_6 , upvalues : _ENV
  ((self.ui).lock):SetActive(not active)
  ;
  ((self.ui).unlock):SetActive(active)
  -- DECOMPILER ERROR at PC20: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.ui).img_icon).sprite = CRH:GetSprite((self.skillData):GetIcon(), CommonAtlasType.SkillIcon)
  local skillTag = (self.skillData):GetSkillTag()
  ;
  ((self.ui).img_type):SetIndex(skillTag)
  ;
  ((self.ui).img_typeLine):SetIndex(skillTag)
  -- DECOMPILER ERROR at PC42: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (((self.ui).img_type).image).color = eBattleSkillTypeColor[(self.skillData):GetBattleSkillTypeColor()]
end

UINBaseSkillItem.OnDelete = function(self)
  -- function num : 0_7 , upvalues : base
  (base.OnDelete)(self)
end

return UINBaseSkillItem


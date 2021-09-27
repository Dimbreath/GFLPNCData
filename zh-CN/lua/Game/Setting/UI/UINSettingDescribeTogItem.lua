local UINSettingDescribeTogItem = class("UINSettingDescribeTogItem", UIBaseNode)
local HeroSkillData = require("Game.PlayerData.Skill.HeroSkillData")
UINSettingDescribeTogItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddValueChangedListener)((self.ui).togItem, self, self.OnSwitchTogChanged)
end

UINSettingDescribeTogItem.InitSettingDescribeItem = function(self, idx, skillID, showDetailDesc, onValueChangeCallback)
  -- function num : 0_1
  self.idx = idx
  self.onValueChangeCallback = onValueChangeCallback
  self:UpdateSkillInfo(skillID, showDetailDesc)
end

UINSettingDescribeTogItem.UpdateSkillInfo = function(self, skillID, showDetailDesc)
  -- function num : 0_2 , upvalues : HeroSkillData, _ENV
  local skillData = (HeroSkillData.New)(skillID)
  local maxLevel = skillData:GetMaxLevel()
  -- DECOMPILER ERROR at PC12: Confused about usage of register: R5 in 'UnsetPending'

  ;
  ((self.ui).tex_SkillDesc).text = skillData:GetLevelDescribe(maxLevel, false, showDetailDesc)
  -- DECOMPILER ERROR at PC17: Confused about usage of register: R5 in 'UnsetPending'

  ;
  ((self.ui).tex_SkillName).text = skillData:GetName()
  ;
  ((self.ui).isUSKill):SetActive(skillData:IsUniqueSkill())
  -- DECOMPILER ERROR at PC33: Confused about usage of register: R5 in 'UnsetPending'

  ;
  ((self.ui).img_SkillIcon).sprite = CRH:GetSprite(skillData:GetIcon(), CommonAtlasType.SkillIcon)
  local skillTag = skillData:GetSkillTag()
  ;
  ((self.ui).img_SkillType):SetIndex(skillTag)
  ;
  ((self.ui).img_SkillTypeLine):SetIndex(skillTag)
  -- DECOMPILER ERROR at PC53: Confused about usage of register: R6 in 'UnsetPending'

  ;
  (((self.ui).img_SkillType).image).color = eBattleSkillTypeColor[skillData:GetBattleSkillTypeColor()]
end

UINSettingDescribeTogItem.SetIsON = function(self)
  -- function num : 0_3
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R1 in 'UnsetPending'

  ((self.ui).togItem).isOn = true
end

UINSettingDescribeTogItem.OnSwitchTogChanged = function(self, value)
  -- function num : 0_4
  if self.onValueChangeCallback ~= nil then
    (self.onValueChangeCallback)(self.idx, value)
  end
end

return UINSettingDescribeTogItem


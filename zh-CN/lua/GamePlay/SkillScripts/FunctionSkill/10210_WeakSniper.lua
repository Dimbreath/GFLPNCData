local bs_10210 = class("bs_10210", LuaSkillBase)
local base = LuaSkillBase
bs_10210.config = {checkBuffId = 1059, buffId = 1060, buffStartId = 1173}
bs_10210.ctor = function(self)
  -- function num : 0_0
end

bs_10210.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddAfterAddBuffTrigger("bs_10210_7", 1, self.OnAfterAddBuff, nil, nil, nil, nil, (self.config).checkBuffId)
  self:AddTrigger(eSkillTriggerType.BuffDie, "bs_10210_9", 1, self.OnBuffDie)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_10210_1", 1, self.OnAfterBattleStart)
end

bs_10210.OnAfterBattleStart = function(self)
  -- function num : 0_2 , upvalues : _ENV
  LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffStartId, 1, nil, true)
end

bs_10210.OnAfterAddBuff = function(self, buff, target)
  -- function num : 0_3 , upvalues : _ENV
  if buff.dataId == (self.config).checkBuffId then
    LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId, buff.tier, nil, true)
    self:PlayChipEffect()
  end
end

bs_10210.OnBuffDie = function(self, buff, target, removeType)
  -- function num : 0_4 , upvalues : _ENV
  if buff.dataId == (self.config).checkBuffId then
    LuaSkillCtrl:DispelBuff(self.caster, (self.config).buffId, buff.tier, true)
  end
end

bs_10210.OnCasterDie = function(self)
  -- function num : 0_5 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10210


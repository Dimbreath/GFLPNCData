local bs_10249 = class("bs_10249", LuaSkillBase)
local base = LuaSkillBase
bs_10249.config = {buffId1 = 1135, buffId2 = 1136, buffTier = 1, checkBuffId = 1088}
bs_10249.ctor = function(self)
  -- function num : 0_0
end

bs_10249.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddSelfTrigger(eSkillTriggerType.AfterBattleStart, "bs_10249_1", 1, self.OnAfterBattleStart)
  self:AddAfterAddBuffTrigger("bs_10249_7", 2, self.OnAfterAddBuff, nil, nil, nil, nil, (self.config).checkBuffId)
  self:AddTrigger(eSkillTriggerType.BuffDie, "bs_10249_11", 3, self.OnBuffDie)
  self.buffNum = 0
end

bs_10249.OnAfterAddBuff = function(self, buff, target)
  -- function num : 0_2 , upvalues : _ENV
  if buff.dataId == (self.config).checkBuffId then
    self.buffNum = self.buffNum + buff.tier
    local buff_limit = (self.arglist)[3]
    if self.buffNum <= buff_limit then
      LuaSkillCtrl:DispelBuff(self.caster, (self.config).buffId2, 0)
      LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId2, self.buffNum, nil, true)
    else
      LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId2, buff_limit, nil, true)
    end
  end
end

bs_10249.OnBuffDie = function(self, buff, target, removeType)
  -- function num : 0_3 , upvalues : _ENV
  if buff.dataId == (self.config).checkBuffId then
    self.buffNum = (math.max)(0, self.buffNum - buff.tier)
    local buff_limit = (self.arglist)[3]
    if self.buffNum <= buff_limit then
      LuaSkillCtrl:DispelBuff(self.caster, (self.config).buffId2, 0)
      LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId2, self.buffNum, nil, true)
    else
      LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId2, buff_limit, nil, true)
    end
  end
end

bs_10249.OnAfterBattleStart = function(self)
  -- function num : 0_4 , upvalues : _ENV
  LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId1, (self.config).buffTier, nil, true)
  self:PlayChipEffect()
end

bs_10249.OnCasterDie = function(self)
  -- function num : 0_5 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10249


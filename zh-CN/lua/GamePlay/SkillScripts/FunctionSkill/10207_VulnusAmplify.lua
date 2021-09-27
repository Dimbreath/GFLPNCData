local bs_10207 = class("bs_10207", LuaSkillBase)
local base = LuaSkillBase
bs_10207.config = {
damageConfig1 = {basehurt_formula = 10034}
, 
damageConfig2 = {basehurt_formula = 10073}
, buffId = 195, effectId = 1049, effectId1 = 10753, buffId2 = 1124, buffId3 = 1183, buffTier = 1}
bs_10207.ctor = function(self)
  -- function num : 0_0
end

bs_10207.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_10207_1", 2, self.OnAfterBattleStart)
  self:AddAfterAddBuffTrigger("bs_10207_2", 1, self.OnAfterAddBuff, self.caster, nil, nil, nil, (self.config).buffId)
end

bs_10207.OnAfterBattleStart = function(self)
  -- function num : 0_2 , upvalues : _ENV
  LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId2, 1, nil, true)
end

bs_10207.OnAfterAddBuff = function(self, buff, target)
  -- function num : 0_3 , upvalues : _ENV
  if buff.dataId == (self.config).buffId then
    LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId3, (self.config).buffTier, nil, true)
  end
end

bs_10207.OnCasterDie = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10207


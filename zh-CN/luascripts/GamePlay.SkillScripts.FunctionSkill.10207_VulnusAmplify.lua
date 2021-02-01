-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_10207 = class("bs_10207", LuaSkillBase)
local base = LuaSkillBase
bs_10207.config = {
damageConfig1 = {basehurt_formula = 10034}
, 
damageConfig2 = {basehurt_formula = 10073}
, buffId = 195, effectId = 1049, effectId1 = 10753, buffId2 = 1124}
bs_10207.ctor = function(self)
  -- function num : 0_0
end

bs_10207.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddSelfTrigger(eSkillTriggerType.SetHurt, "bs_10207_2", 1, self.OnSetHurt)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_10207_1", 2, self.OnAfterBattleStart)
end

bs_10207.OnAfterBattleStart = function(self)
  -- function num : 0_2 , upvalues : _ENV
  LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId2, 1, nil, true)
end

bs_10207.OnSetHurt = function(self, context)
  -- function num : 0_3 , upvalues : _ENV
  if context.sender == self.caster and not (context.skill).isCommonAttack and not context.isTriggerSet then
    local buffTier = (context.target):GetBuffTier((self.config).buffId)
    if buffTier <= 0 then
      return 
    end
    context.hurt = context.hurt + context.hurt * (self.arglist)[1] * buffTier // 1000
    LuaSkillCtrl:CallEffect(context.target, (self.config).effectId1, self)
  end
end

bs_10207.OnCasterDie = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10207


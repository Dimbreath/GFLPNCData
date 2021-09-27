local bs_10124 = class("bs_10124", LuaSkillBase)
local base = LuaSkillBase
bs_10124.config = {
hurt_config = {hit_formula = 0, def_formula = 9996, basehurt_formula = 10076, minhurt_formula = 9994, crit_formula = 0, crithur_ratio = 9995, correct_formula = 9989}
, effectId = 1002}
bs_10124.ctor = function(self)
  -- function num : 0_0
end

bs_10124.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddAfterAddBuffTrigger("bs_10124_1", 1, self.OnAfterAddBuff, self.caster, nil, nil, nil, nil, eBuffType.Debeneficial)
end

bs_10124.OnAfterAddBuff = function(self, buff, target, isOverlay)
  -- function num : 0_2 , upvalues : _ENV
  if buff.buffType == 2 and buff.maker == self.caster then
    LuaSkillCtrl:CallEffect(target, (self.config).effectId, self, self.SkillEventFunc)
    self:PlayChipEffect()
  end
end

bs_10124.SkillEventFunc = function(self, effect, eventId, target)
  -- function num : 0_3 , upvalues : _ENV
  if eventId == eBattleEffectEvent.Trigger then
    local skillResult = LuaSkillCtrl:CallSkillResult(effect, target)
    LuaSkillCtrl:HurtResult(self, skillResult, (self.config).hurt_config)
    skillResult:EndResult()
  end
end

bs_10124.OnCasterDie = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10124


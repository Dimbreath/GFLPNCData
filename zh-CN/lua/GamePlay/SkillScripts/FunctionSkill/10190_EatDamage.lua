local bs_10190 = class("bs_10190", LuaSkillBase)
local base = LuaSkillBase
bs_10190.config = {
hurt_config = {basehurt_formula = 10076}
, effectId = 10254}
bs_10190.ctor = function(self)
  -- function num : 0_0
end

bs_10190.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddLuaTrigger(eSkillLuaTrigger.OnDoodad, self.OnDoodad)
end

bs_10190.OnDoodad = function(self, sender, targetRole)
  -- function num : 0_2 , upvalues : _ENV
  if targetRole == self.caster then
    local targetList = LuaSkillCtrl:CallTargetSelect(self, 1, 20)
    if targetList ~= nil and targetList.Count > 0 then
      local hurtTarget = (targetList[0]).targetRole
      if hurtTarget ~= nil then
        LuaSkillCtrl:CallEffect(hurtTarget, (self.config).effectId, self, self.SkillEventFunc)
        self:PlayChipEffect()
      end
    end
  end
end

bs_10190.SkillEventFunc = function(self, effect, eventId, target)
  -- function num : 0_3 , upvalues : _ENV
  if eventId == eBattleEffectEvent.Trigger then
    local skillResult = LuaSkillCtrl:CallSkillResult(effect, target)
    LuaSkillCtrl:HurtResult(self, skillResult, (self.config).hurt_config, nil, true)
    skillResult:EndResult()
  end
end

bs_10190.OnCasterDie = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10190


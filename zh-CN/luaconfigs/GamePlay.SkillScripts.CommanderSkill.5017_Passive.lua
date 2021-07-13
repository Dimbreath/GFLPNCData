-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_5017 = class("bs_5017", LuaSkillBase)
local base = LuaSkillBase
bs_5017.config = {effectIdAttack = 10127, 
HurtConfig = {basehurt_formula = 10127}
}
bs_5017.ctor = function(self)
  -- function num : 0_0
end

bs_5017.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_5017_1", 10, self.OnAfterHurt, nil, nil, (self.caster).belongNum)
end

bs_5017.OnAfterHurt = function(self, sender, target, skill, hurt, isMiss, isCrit, isRealDmg)
  -- function num : 0_2 , upvalues : _ENV
  if sender.belongNum == (self.caster).belongNum and skill.isCommonAttack and LuaSkillCtrl:CallRange(1, 1000) <= (self.arglist)[2] then
    LuaSkillCtrl:StartTimer(self, 6, function()
    -- function num : 0_2_0 , upvalues : _ENV, target, self
    LuaSkillCtrl:CallEffect(target, (self.config).effectIdAttack, self, self.SkillEventFunc)
  end
)
  end
end

bs_5017.SkillEventFunc = function(self, effect, eventId, target)
  -- function num : 0_3 , upvalues : _ENV
  if eventId == eBattleEffectEvent.Trigger then
    local highAttRole = LuaSkillCtrl:CallTargetSelect(self, 46, 20)
    if highAttRole ~= nil and highAttRole.Count > 0 and highAttRole[0] ~= nil then
      local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
      LuaSkillCtrl:HurtResult(self, skillResult, (self.config).HurtConfig, {((highAttRole[0]).targetRole).skill_intensity}, true)
      skillResult:EndResult()
    end
  end
end

bs_5017.OnCasterDie = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_5017


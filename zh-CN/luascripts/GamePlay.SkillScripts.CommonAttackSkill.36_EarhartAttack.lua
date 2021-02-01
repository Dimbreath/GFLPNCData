-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_36 = class("bs_36", bs_1)
local base = bs_1
bs_36.config = {effectId = 10736, effectstartId4 = 10738, effectstartId5 = 10738, effect_JQ = 10740, effect_JQL = 10742, effect_JQR = 10743, effect_JQhit = 10741, buffId = 236, 
HurtConfig = {basehurt_formula = 10110}
}
bs_36.config = setmetatable(bs_36.config, {__index = base.config})
bs_36.ctor = function(self)
  -- function num : 0_0
end

bs_36.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
end

bs_36.RealPlaySkill = function(self, target, data)
  -- function num : 0_2 , upvalues : _ENV, base
  if (self.caster):GetBuffTier((self.config).buffId) > 0 then
    local attackTrigger2 = BindCallback(self, self.OnAttackTrigger2, target)
    self:CallCasterWait(18)
    LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, 1008, 1, 8, attackTrigger2)
  else
    do
      ;
      (base.RealPlaySkill)(self, target, data)
    end
  end
end

bs_36.OnAttackTrigger2 = function(self, target)
  -- function num : 0_3 , upvalues : _ENV
  LuaSkillCtrl:CallEffect(target, (self.config).effect_JQ, self, self.SkillEventFunc2)
  LuaSkillCtrl:CallEffect(target, (self.config).effect_JQL, self)
  LuaSkillCtrl:CallEffect(target, (self.config).effect_JQR, self)
end

bs_36.SkillEventFunc2 = function(self, effect, eventId, target)
  -- function num : 0_4 , upvalues : _ENV
  if eventId == eBattleEffectEvent.Create then
    local arg1 = ((self.caster).recordTable).skill_arg1
    LuaSkillCtrl:CallEffect(target.targetRole, (self.config).effect_JQhit, self)
    local skillResult = LuaSkillCtrl:CallSkillResult(effect, target)
    LuaSkillCtrl:HurtResult(skillResult, (self.config).HurtConfig, {arg1})
    skillResult:EndResult()
  end
end

bs_36.OnCasterDie = function(self)
  -- function num : 0_5 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_36


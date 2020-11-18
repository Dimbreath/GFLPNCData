-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_1026 = class("bs_1026", LuaSkillBase)
local base = LuaSkillBase
bs_1026.config = {
aoe_config = {effect_shape = 2, aoe_select_code = 4, aoe_range = 1}
, 
hurt_config1 = {basehurt_formula = 10007}
, 
hurt_config2 = {basehurt_formula = 9993}
}
bs_1026.ctor = function(self)
  -- function num : 0_0
end

bs_1026.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : _ENV
  self:AddTrigger(eSkillTriggerType.AfterHurt, "bs_1026_3", 1, self.OnAfterHurt)
end

bs_1026.OnAfterHurt = function(self, sender, target, skill, hurt, isMiss, isCrit, isRealDmg)
  -- function num : 0_2 , upvalues : _ENV
  if sender == self.caster and skill.isCommonAttack then
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target, (self.config).aoe_config)
    if (skillResult.roleList).Count ~= 0 then
      local prob = LuaSkillCtrl:CallRange(0, (skillResult.roleList).Count - 1)
      for i = 0, (skillResult.roleList).Count - 1 do
        local role = (skillResult.roleList)[i]
        if i == prob then
          if (self.arglist)[2] == 1 then
            LuaSkillCtrl:CallEffectWithArgOverride(role, 10009, self, target, true, self.SkillEventFunc, (self.config).hurt_config2)
          else
            LuaSkillCtrl:CallEffectWithArgOverride(role, 10009, self, target, true, self.SkillEventFunc, (self.config).hurt_config1)
          end
        else
          LuaSkillCtrl:CallEffectWithArgOverride(role, 10009, self, target, true, self.SkillEventFunc, (self.config).hurt_config1)
        end
      end
    end
    do
      skillResult:EndResult()
    end
  end
end

bs_1026.SkillEventFunc = function(self, hurt_config, effect, eventId, target)
  -- function num : 0_3 , upvalues : _ENV
  if eventId == eBattleEffectEvent.Trigger then
    local skillResult = LuaSkillCtrl:CallSkillResult(effect, target)
    LuaSkillCtrl:HurtResult(skillResult, hurt_config)
    skillResult:EndResult()
  end
end

bs_1026.OnCasterDie = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_1026


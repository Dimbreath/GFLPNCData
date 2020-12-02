-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_103802 = class("bs_103802", LuaSkillBase)
local base = LuaSkillBase
bs_103802.config = {
aoe_config = {effect_shape = 2, aoe_select_code = 4, aoe_range = 1}
, 
hurt_config = {basehurt_formula = 10076}
, effectId = 10389, speed = 1.5, buffId = 195}
bs_103802.ctor = function(self)
  -- function num : 0_0
end

bs_103802.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
end

bs_103802.PlaySkill = function(self, data)
  -- function num : 0_2 , upvalues : _ENV
  local preList = LuaSkillCtrl:CallTargetSelect(self, 9, 0)
  if preList.Count == 0 then
    return 
  end
  LuaSkillCtrl:CallBreakAllSkill(self.caster)
  self:CallCasterWait(15)
  LuaSkillCtrl:CallRoleAction(self.caster, 1002, (self.config).speed)
  LuaSkillCtrl:StartTimer(self, 0, function()
    -- function num : 0_2_0 , upvalues : _ENV, self
    LuaSkillCtrl:CallEffectWithArgAndSpeed(self.caster, (self.config).effectId, self, (self.config).speed, true, self.SkillEventFunc)
  end
)
end

bs_103802.SkillEventFunc = function(self, effect, eventId, target)
  -- function num : 0_3 , upvalues : _ENV
  if eventId == eBattleEffectEvent.Trigger then
    LuaSkillCtrl:StartTimer(self, 8, function()
    -- function num : 0_3_0 , upvalues : _ENV, self, target
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target, (self.config).aoe_config)
    LuaSkillCtrl:HurtResult(skillResult, (self.config).hurt_config)
    if (self.arglist)[2] == 1 then
      skillResult:BuffResult((self.config).buffId, 1, 45)
    end
    skillResult:EndResult()
  end
)
  end
end

bs_103802.OnCasterDie = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_103802


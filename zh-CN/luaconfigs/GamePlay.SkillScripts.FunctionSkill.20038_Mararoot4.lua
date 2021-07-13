-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_20038 = class("bs_20038", LuaSkillBase)
local base = LuaSkillBase
bs_20038.config = {effectId = 10795, buffId = 66, buffTier = 1, 
hurt_config = {basehurt_formula = 10076}
, skillDelay = 30}
bs_20038.ctor = function(self)
  -- function num : 0_0
end

bs_20038.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  if (self.caster).roleDataId ~= 30001 and (self.caster).roleDataId ~= 30002 then
    return 
  end
  self:AddTrigger(eSkillTriggerType.AfterPlaySkill, "bs_20038_3", 3, self.OnAfterPlaySkill)
end

bs_20038.OnAfterPlaySkill = function(self, skill, role)
  -- function num : 0_2 , upvalues : _ENV
  if (skill.maker).belongNum ~= (self.caster).belongNum and (skill.maker).roleType == 1 and not skill.isCommonAttack then
    local arriveCallBack = BindCallback(self, self.OnArriveAction, skill.maker)
    LuaSkillCtrl:StartTimer(nil, (self.config).skillDelay, arriveCallBack)
  end
end

bs_20038.OnArriveAction = function(self, role)
  -- function num : 0_3 , upvalues : _ENV
  LuaSkillCtrl:CallEffect(role, (self.config).effectId, self, self.SkillEventFunc)
end

bs_20038.SkillEventFunc = function(self, effect, eventId, target)
  -- function num : 0_4 , upvalues : _ENV
  if eventId == eBattleEffectEvent.Trigger then
    local skillResult = LuaSkillCtrl:CallSkillResult(effect, target, (self.config).aoe_config)
    skillResult:BuffResult((self.config).buffId, (self.config).buffTier, (self.arglist)[2])
    LuaSkillCtrl:HurtResult(self, skillResult, (self.config).hurt_config)
    skillResult:EndResult()
  end
end

bs_20038.OnCasterDie = function(self)
  -- function num : 0_5 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_20038


-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_1003 = class("bs_1003", LuaSkillBase)
local base = LuaSkillBase
bs_1003.config = {
hurt_config = {hit_formula = 0, basehurt_formula = 1049, crit_formula = 0, crithur_ratio = 0}
, 
aoe_config = {effect_shape = 3, aoe_select_code = 4, aoe_range = 2}
, effectId = 101, effectId2 = 1044, buffId = 49, buffTier = 1, buffId2 = 102}
bs_1003.ctor = function(self)
  -- function num : 0_0
end

bs_1003.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1
end

bs_1003.PlaySkill = function(self, data)
  -- function num : 0_2 , upvalues : _ENV
  self:CallCasterWait(10)
  local targetList = LuaSkillCtrl:CallTargetSelect(self, 8, 0)
  LuaSkillCtrl:CallEffect(targetList, (self.config).effectId, self, self.SkillEventFunc, nil, nil, true)
end

bs_1003.SkillEventFunc = function(self, effect, eventId, target)
  -- function num : 0_3 , upvalues : _ENV
  if eventId == eBattleEffectEvent.Trigger then
    local skillResult = LuaSkillCtrl:CallSkillResult(effect, target, (self.config).aoe_config)
    LuaSkillCtrl:HurtResult(skillResult, (self.config).hurt_config)
    skillResult:BuffResult((self.config).buffId, (self.config).buffTier, (self.arglist)[3])
    if (self.arglist)[4] == 1 then
      if (skillResult.roleList).Count == 0 then
        return 
      else
        for i = 0, (skillResult.roleList).Count - 1 do
          LuaSkillCtrl:CallEffect((skillResult.roleList)[i], (self.config).effectId2, self, self.SkillEventFunc1)
        end
      end
    end
    do
      skillResult:EndResult()
    end
  end
end

bs_1003.SkillEventFunc1 = function(self, effect, eventId, target)
  -- function num : 0_4 , upvalues : _ENV
  if eventId == eBattleEffectEvent.Trigger then
    LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId2, 1, (self.arglist)[3])
  end
end

bs_1003.OnCasterDie = function(self)
  -- function num : 0_5 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_1003

-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_1003 = class("bs_1003", LuaSkillBase)
local base = LuaSkillBase
bs_1003.config = {
    hurt_config = {
        hit_formula = 0,
        basehurt_formula = 1049,
        crit_formula = 0,
        crithur_ratio = 0
    },
    aoe_config = {effect_shape = 3, aoe_select_code = 4, aoe_range = 2},
    effectId = 101,
    effectId2 = 1044,
    buffId = 49,
    buffTier = 1,
    buffId2 = 102
}
bs_1003.ctor = function(self)
    -- function num : 0_0
end

bs_1003.InitSkill = function(self, isMidwaySkill)
    -- function num : 0_1
end

bs_1003.PlaySkill = function(self, data)
    -- function num : 0_2 , upvalues : _ENV
    self:CallCasterWait(10)
    local targetList = LuaSkillCtrl:CallTargetSelect(self, 8, 0)
    LuaSkillCtrl:CallEffect(targetList, (self.config).effectId, self,
                            self.SkillEventFunc, nil, nil, true)
end

bs_1003.SkillEventFunc = function(self, effect, eventId, target)
    -- function num : 0_3 , upvalues : _ENV
    if eventId == eBattleEffectEvent.Trigger then
        local skillResult = LuaSkillCtrl:CallSkillResult(effect, target,
                                                         (self.config).aoe_config)
        LuaSkillCtrl:HurtResult(skillResult, (self.config).hurt_config)
        skillResult:BuffResult((self.config).buffId, (self.config).buffTier,
                               (self.arglist)[3])
        if (self.arglist)[4] == 1 then
            if (skillResult.roleList).Count == 0 then
                return
            else
                for i = 0, (skillResult.roleList).Count - 1 do
                    LuaSkillCtrl:CallEffect((skillResult.roleList)[i],
                                            (self.config).effectId2, self,
                                            self.SkillEventFunc1)
                end
            end
        end
        do skillResult:EndResult() end
    end
end

bs_1003.SkillEventFunc1 = function(self, effect, eventId, target)
    -- function num : 0_4 , upvalues : _ENV
    if eventId == eBattleEffectEvent.Trigger then
        LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId2, 1,
                              (self.arglist)[3])
    end
end

bs_1003.OnCasterDie = function(self)
    -- function num : 0_5 , upvalues : base
    (base.OnCasterDie)(self)
end

return bs_1003


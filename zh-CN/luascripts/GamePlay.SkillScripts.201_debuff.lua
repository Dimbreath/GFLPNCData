-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_201 = class("bs_201", LuaSkillBase)
local base = LuaSkillBase
bs_201.config = {effectIdAttack = 1027, buffId = 90, buffTier = 1, buffDuration = 45, 
hurt_config = {basehurt_formula = 2013}
}
bs_201.ctor = function(self)
  -- function num : 0_0
end

bs_201.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1
end

bs_201.PlaySkill = function(self, data)
  -- function num : 0_2 , upvalues : _ENV
  local targetList = LuaSkillCtrl:CallTargetSelect(self, 21, 20)
  self:CallCasterLookAt(targetList)
  LuaSkillCtrl:CallEffect(targetList, (self.config).effectIdAttack, self, self.SkillEventFunc)
  LuaSkillCtrl:CallBuff(self, target, (self.config).buffId, (self.config).buffTier, (self.config).buffDuration)
  print("1")
end

bs_201.SkillEventFunc = function(self, effect, eventId, target)
  -- function num : 0_3 , upvalues : _ENV
  if eventId == eBattleEffectEvent.Trigger then
    local skillResult = LuaSkillCtrl:CallSkillResult(effect, target)
    LuaSkillCtrl:HurtResult(skillResult, (self.config).hurt_config)
    skillResult:EndResult()
  end
end

bs_201.OnCasterDie = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_201

-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_201 = class("bs_201", LuaSkillBase)
local base = LuaSkillBase
bs_201.config = {
    effectIdAttack = 1027,
    buffId = 90,
    buffTier = 1,
    buffDuration = 45,
    hurt_config = {basehurt_formula = 2013}
}
bs_201.ctor = function(self)
    -- function num : 0_0
end

bs_201.InitSkill = function(self, isMidwaySkill)
    -- function num : 0_1
end

bs_201.PlaySkill = function(self, data)
    -- function num : 0_2 , upvalues : _ENV
    local targetList = LuaSkillCtrl:CallTargetSelect(self, 21, 20)
    self:CallCasterLookAt(targetList)
    LuaSkillCtrl:CallEffect(targetList, (self.config).effectIdAttack, self,
                            self.SkillEventFunc)
    LuaSkillCtrl:CallBuff(self, target, (self.config).buffId,
                          (self.config).buffTier, (self.config).buffDuration)
    print("1")
end

bs_201.SkillEventFunc = function(self, effect, eventId, target)
    -- function num : 0_3 , upvalues : _ENV
    if eventId == eBattleEffectEvent.Trigger then
        local skillResult = LuaSkillCtrl:CallSkillResult(effect, target)
        LuaSkillCtrl:HurtResult(skillResult, (self.config).hurt_config)
        skillResult:EndResult()
    end
end

bs_201.OnCasterDie = function(self)
    -- function num : 0_4 , upvalues : base
    (base.OnCasterDie)(self)
end

return bs_201


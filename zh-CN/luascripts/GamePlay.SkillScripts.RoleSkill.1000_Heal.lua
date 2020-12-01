-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_1000 = class("bs_1000", LuaSkillBase)
local base = LuaSkillBase
bs_1000.config = {
heal_config1 = {baseheal_formula = 10030, heal_number = 0, correct_formula = 9990}
, 
heal_config2 = {baseheal_formula = 1064, heal_number = 0, correct_formula = 9990}
, 
heal_config3 = {baseheal_formula = 1065, heal_number = 0, correct_formula = 9990}
, creationId = 1042, selectId = 25}
bs_1000.ctor = function(self)
  -- function num : 0_0
end

bs_1000.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1
end

bs_1000.PlaySkill = function(self, data)
  -- function num : 0_2 , upvalues : _ENV
  self:CallCasterWait(20)
  local targetList = LuaSkillCtrl:CallTargetSelect(self, (self.config).selectId, (self.cskill).rangeOffset)
  local num = (self.arglist)[2]
  if targetList.Count <= (self.arglist)[2] then
    num = targetList.Count
  end
  if num ~= 0 then
    for i = 0, num - 1 do
      if i == 0 then
        self:RealPlaySkill(targetList[i], nil, i + 1)
      else
        self:RealPlaySkill(targetList[i], (targetList[i - 1]).targetRole, i + 1)
      end
    end
  end
end

bs_1000.RealPlaySkill = function(self, target, caster, healId)
  -- function num : 0_3 , upvalues : _ENV
  local healConfig = (self.config)["heal_config" .. tostring(healId)]
  LuaSkillCtrl:StartTimer(self, healId * 5, function()
    -- function num : 0_3_0 , upvalues : _ENV, target, self, caster, healConfig
    LuaSkillCtrl:CallEffectWithArgOverride(target, (self.config).creationId, self, caster, true, self.SkillEventFunc, healConfig)
  end
, nil)
end

bs_1000.SkillEventFunc = function(self, healConfig, effect, eventId, target)
  -- function num : 0_4 , upvalues : _ENV
  if eventId == eBattleEffectEvent.Trigger then
    local skillResult = LuaSkillCtrl:CallSkillResult(effect, target)
    LuaSkillCtrl:HealResult(skillResult, healConfig)
    skillResult:EndResult()
  end
end

bs_1000.OnCasterDie = function(self)
  -- function num : 0_5 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_1000

-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_1000 = class("bs_1000", LuaSkillBase)
local base = LuaSkillBase
bs_1000.config = {
    heal_config1 = {
        baseheal_formula = 10030,
        heal_number = 0,
        correct_formula = 9990
    },
    heal_config2 = {
        baseheal_formula = 1064,
        heal_number = 0,
        correct_formula = 9990
    },
    heal_config3 = {
        baseheal_formula = 1065,
        heal_number = 0,
        correct_formula = 9990
    },
    creationId = 1042,
    selectId = 25
}
bs_1000.ctor = function(self)
    -- function num : 0_0
end

bs_1000.InitSkill = function(self, isMidwaySkill)
    -- function num : 0_1
end

bs_1000.PlaySkill = function(self, data)
    -- function num : 0_2 , upvalues : _ENV
    self:CallCasterWait(20)
    local targetList = LuaSkillCtrl:CallTargetSelect(self,
                                                     (self.config).selectId,
                                                     (self.cskill).rangeOffset)
    local num = (self.arglist)[2]
    if targetList.Count <= (self.arglist)[2] then num = targetList.Count end
    if num ~= 0 then
        for i = 0, num - 1 do
            if i == 0 then
                self:RealPlaySkill(targetList[i], nil, i + 1)
            else
                self:RealPlaySkill(targetList[i],
                                   (targetList[i - 1]).targetRole, i + 1)
            end
        end
    end
end

bs_1000.RealPlaySkill = function(self, target, caster, healId)
    -- function num : 0_3 , upvalues : _ENV
    local healConfig = (self.config)["heal_config" .. tostring(healId)]
    LuaSkillCtrl:StartTimer(self, healId * 5, function()
        -- function num : 0_3_0 , upvalues : _ENV, target, self, caster, healConfig
        LuaSkillCtrl:CallEffectWithArgOverride(target, (self.config).creationId,
                                               self, caster, true,
                                               self.SkillEventFunc, healConfig)
    end, nil)
end

bs_1000.SkillEventFunc = function(self, healConfig, effect, eventId, target)
    -- function num : 0_4 , upvalues : _ENV
    if eventId == eBattleEffectEvent.Trigger then
        local skillResult = LuaSkillCtrl:CallSkillResult(effect, target)
        LuaSkillCtrl:HealResult(skillResult, healConfig)
        skillResult:EndResult()
    end
end

bs_1000.OnCasterDie = function(self)
    -- function num : 0_5 , upvalues : base
    (base.OnCasterDie)(self)
end

return bs_1000


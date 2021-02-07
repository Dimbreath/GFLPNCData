-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_50013 = class("bs_50013", LuaSkillBase)
local base = LuaSkillBase
bs_50013.config = {buffId1 = 1127, buffId2 = 1128, buffTier = 1, buffDuration = 45, 
heal_config = {baseheal_formula = 1047, heal_number = 0, correct_formula = 9990}
}
bs_50013.ctor = function(self)
  -- function num : 0_0
end

bs_50013.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  if isMidwaySkill then
    local arriveCallBack = BindCallback(self, self.OnArriveAction)
    if self.timer == nil then
      self.timer = LuaSkillCtrl:StartTimer(nil, (self.config).buffDuration - 1, arriveCallBack, nil, -1, (self.config).buffDuration - 3)
    end
  end
end

bs_50013.OnArriveAction = function(self)
  -- function num : 0_2 , upvalues : _ENV
  if (self.caster).camp == 2 and (self.caster).belongNum == 2 then
    LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId1, (self.config).buffTier, (self.config).buffDuration, true)
    local damageNum = (self.caster).maxHp * 5 // 100
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, self.caster)
    LuaSkillCtrl:HealResult(skillResult, (self.config).heal_config, nil, true)
  else
    do
      LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId2, (self.config).buffTier, (self.config).buffDuration, true)
      local damageNum = (self.caster).maxHp * 5 // 100
      LuaSkillCtrl:RemoveLife(damageNum, self, self.caster, true, true)
    end
  end
end

bs_50013.OnSkillRemove = function(self)
  -- function num : 0_3 , upvalues : base, _ENV
  (base.OnSkillRemove)(self)
  if self.timer ~= nil then
    (self.timer):Stop()
    self.timer = nil
  end
  LuaSkillCtrl:DispelBuff(self.caster, (self.config).buffId1, 0)
  LuaSkillCtrl:DispelBuff(self.caster, (self.config).buffId2, 0)
end

bs_50013.OnCasterDie = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_50013


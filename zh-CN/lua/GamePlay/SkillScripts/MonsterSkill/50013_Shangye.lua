local bs_50013 = class("bs_50013", LuaSkillBase)
local base = LuaSkillBase
bs_50013.config = {buffId = 1126, buffId1 = 1127, buffId2 = 1128, buffTier = 1, buffDuration = 45, 
heal_config = {baseheal_formula = 1047, heal_number = 0, correct_formula = 9990}
, 
hurt_config = {hit_formula = 0, basehurt_formula = 1047, crit_formula = 0}
}
bs_50013.ctor = function(self)
  -- function num : 0_0
end

bs_50013.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.OnSelfAfterMove, "bs_50013_1", 1, self.OnAfterMove)
  if isMidwaySkill then
    local arriveCallBack = BindCallback(self, self.OnArriveAction)
    if self.timer == nil then
      self.timer = LuaSkillCtrl:StartTimer(nil, (self.config).buffDuration - 1, arriveCallBack, nil, -1, (self.config).buffDuration - 15)
    end
  end
end

bs_50013.OnArriveAction = function(self)
  -- function num : 0_2 , upvalues : _ENV
  if self.timer ~= nil and (self.timer):IsOver() then
    self.timer = nil
  end
  if self.caster == nil or (self.caster).hp <= 0 then
    return 
  end
  if (self.caster).roleDataId == 25006 or (self.caster).roleDataId == 25007 or (self.caster).roleDataId == 25008 then
    return 
  end
  if (self.caster).camp == 2 and (self.caster).belongNum == 2 then
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, self.caster)
    LuaSkillCtrl:HealResult(skillResult, (self.config).heal_config, nil, true)
    skillResult:EndResult()
  else
    do
      local damage = (self.caster).maxHp * 75 // 1000
      LuaSkillCtrl:RemoveLife(damage, self, self.caster, true, nil, true, true)
    end
  end
end

bs_50013.OnSkillRemove = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnSkillRemove)(self)
  if self.timer ~= nil then
    (self.timer):Stop()
    self.timer = nil
  end
end

bs_50013.OnAfterMove = function(self)
  -- function num : 0_4 , upvalues : _ENV
  local GridId = LuaSkillCtrl:GetRoleEfcGrid(self.caster)
  if GridId ~= 15 then
    LuaSkillCtrl:DispelBuff(self.caster, (self.config).buffId, 0)
  end
end

bs_50013.OnCasterDie = function(self)
  -- function num : 0_5 , upvalues : base
  (base.OnCasterDie)(self)
  if self.timer ~= nil then
    (self.timer):Stop()
    self.timer = nil
  end
end

return bs_50013


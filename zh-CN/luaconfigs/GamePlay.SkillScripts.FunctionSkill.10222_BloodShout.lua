-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_10222 = class("bs_10222", LuaSkillBase)
local base = LuaSkillBase
bs_10222.config = {buffId = 195, buffTier = 1, effectId = 10644, 
hurtConfig = {basehurt_formula = 10078}
}
bs_10222.ctor = function(self)
  -- function num : 0_0
end

bs_10222.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_10222_1", 80, self.OnAfterBattleStart)
  self:AddSelfTrigger(eSkillTriggerType.BeforePlaySkill, "bs_10222_11", 2, self.OnBeforePlaySkill)
end

bs_10222.OnAfterBattleStart = function(self)
  -- function num : 0_2 , upvalues : _ENV
  self:PlayChipEffect()
  local targetList = LuaSkillCtrl:CallTargetSelect(self, 9, 10)
  if targetList.Count < 1 then
    return 
  end
  LuaSkillCtrl:CallEffect(self.caster, (self.config).effectId, self)
  for i = 0, targetList.Count - 1 do
    local targetRole = (targetList[i]).targetRole
    if targetRole.belongNum ~= 0 then
      local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, targetRole)
      LuaSkillCtrl:HurtResult(self, skillResult, (self.config).hurtConfig, nil, true)
      LuaSkillCtrl:CallBuff(self, targetRole, (self.config).buffId, (self.arglist)[2], (self.arglist)[1])
    end
  end
end

bs_10222.OnBeforePlaySkill = function(self, role, context)
  -- function num : 0_3 , upvalues : _ENV
  if role == self.caster and not (context.skill).isCommonAttack then
    self:PlayChipEffect()
    local targetList = LuaSkillCtrl:CallTargetSelect(self, 9, 10)
    if targetList.Count < 1 then
      return 
    end
    LuaSkillCtrl:CallEffect(self.caster, (self.config).effectId, self)
    for i = 0, targetList.Count - 1 do
      local targetRole = (targetList[i]).targetRole
      if targetRole.belongNum ~= 0 then
        local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, targetRole)
        LuaSkillCtrl:HurtResult(self, skillResult, (self.config).hurtConfig, nil, true)
        LuaSkillCtrl:CallBuff(self, targetRole, (self.config).buffId, (self.arglist)[2], (self.arglist)[1])
      end
    end
  end
end

bs_10222.OnCasterDie = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10222


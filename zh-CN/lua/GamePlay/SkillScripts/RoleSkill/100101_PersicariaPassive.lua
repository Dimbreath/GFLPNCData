local bs_100101 = class("bs_100101", LuaSkillBase)
local base = LuaSkillBase
bs_100101.config = {effectId_line = 100103, effectId_PassHit = 100104, buffId_live = 3009, 
heal_config = {baseheal_formula = 3021}
, selectId = 20, selectRange = 10}
bs_100101.ctor = function(self)
  -- function num : 0_0
end

bs_100101.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1
  self:AddSetDeadHurtTrigger("bs_100101_1", 99, self.OnSetDeadHurt, nil, nil, nil, (self.caster).belongNum, nil, 1)
end

bs_100101.OnSetDeadHurt = function(self, context)
  -- function num : 0_2 , upvalues : _ENV
  if self:IsReadyToTake() and (context.target).belongNum == (self.caster).belongNum and (context.target).roleType == 1 and context.target ~= context.sender then
    LuaSkillCtrl:CallBuff(self, context.target, (self.config).buffId_live, 1, 15, true)
    LuaSkillCtrl:CallEffect(context.target, (self.config).effectId_line, self)
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, context.target)
    LuaSkillCtrl:HealResult(skillResult, (self.config).heal_config, {(self.arglist)[1]}, false, false)
    skillResult:EndResult()
    LuaSkillCtrl:CallEffect(context.target, (self.config).effectId_PassHit, self)
    LuaSkillCtrl:DispelBuff(context.target, (self.config).buffId_live, 0, true)
    self:OnSkillTake()
  end
end

bs_100101.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_100101


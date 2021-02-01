-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_10235 = class("bs_10235", LuaSkillBase)
local base = LuaSkillBase
bs_10235.config = {buffId = 1088, 
heal_config = {baseheal_formula = 10006, heal_number = 0, correct_formula = 9990}
, effectId = 10635, debuffId = 1119}
bs_10235.ctor = function(self)
  -- function num : 0_0
end

bs_10235.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self.time = (self.arglist)[2]
  self:AddSelfTrigger(eSkillTriggerType.SetHeal, "bs_10235_1", 1000, self.OnSetHeal)
end

bs_10235.OnSetHeal = function(self, context)
  -- function num : 0_2 , upvalues : _ENV
  if (context.target).belongNum == 1 and context.sender == self.caster and self:IsReadyToTake() and self.time > 0 and not context.isTriggerSet then
    self:OnSkillTake()
    local buffTier = (context.target):GetBuffTier((self.config).buffId)
    if buffTier > 0 then
      LuaSkillCtrl:CallBuff(self, context.target, (self.config).debuffId, 1, 3)
      LuaSkillCtrl:DispelBuff(context.target, (self.config).buffId, 0)
      LuaSkillCtrl:CallEffect(context.target, (self.config).effectId, self)
      local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, context.target)
      -- DECOMPILER ERROR at PC57: Confused about usage of register: R4 in 'UnsetPending'

      ;
      ((self.config).heal_config).isTriggerSet = true
      LuaSkillCtrl:HealResult(skillResult, (self.config).heal_config, nil, true)
      skillResult:EndResult()
      self:PlayChipEffect()
      self.time = self.time - 1
    end
  end
end

bs_10235.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10235


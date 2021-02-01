-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_10129 = class("bs_10129", LuaSkillBase)
local base = LuaSkillBase
bs_10129.config = {effectId = 10172}
bs_10129.ctor = function(self)
  -- function num : 0_0
end

bs_10129.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddSelfTrigger(eSkillTriggerType.SetHurt, "bs_10129_2", 1, self.OnSetHurt)
  -- DECOMPILER ERROR at PC13: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.caster).recordTable)["10129_lastRole"] = nil
end

bs_10129.OnSetHurt = function(self, context)
  -- function num : 0_2
  -- DECOMPILER ERROR at PC19: Confused about usage of register: R2 in 'UnsetPending'

  if context.sender == self.caster and not context.isMiss and self:IsReadyToTake() then
    if ((self.caster).recordTable)["10129_lastRole"] == nil then
      ((self.caster).recordTable)["10129_lastRole"] = context.target
    end
    if ((self.caster).recordTable)["10129_lastRole"] ~= nil and ((self.caster).recordTable)["10129_lastRole"] ~= context.target then
      self:PlayChipEffect()
      if context.isCrit then
        context.hurt = (1000 + (self.caster).critDamage - (self.arglist)[1]) * context.hurt // (1000 + (self.caster).critDamage)
      else
        context.isCrit = true
        context.hurt = (1000 + (self.caster).critDamage - (self.arglist)[1]) * context.hurt // 1000
      end
      -- DECOMPILER ERROR at PC64: Confused about usage of register: R2 in 'UnsetPending'

      ;
      ((self.caster).recordTable)["10129_lastRole"] = context.target
      self:OnSkillTake()
    end
  end
end

bs_10129.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10129


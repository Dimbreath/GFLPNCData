local bs_103701 = class("bs_103701", LuaSkillBase)
local base = LuaSkillBase
bs_103701.config = {effectId_num1 = 10320, effectId_num2 = 10321, effectId_num3 = 10322, effectId_num4 = 10323, effectId_num5 = 10324, buffId1 = 103701, audioId1 = 286}
bs_103701.ctor = function(self)
  -- function num : 0_0
end

bs_103701.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddSelfTrigger(eSkillTriggerType.AfterPlaySkill, "bs_103701_12", 1, self.OnAfterPlaySkill)
  -- DECOMPILER ERROR at PC13: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.caster).recordTable).Passive = 0
  -- DECOMPILER ERROR at PC16: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.caster).recordTable).X_num = 0
end

bs_103701.OnAfterPlaySkill = function(self, skill, role)
  -- function num : 0_2 , upvalues : _ENV
  -- DECOMPILER ERROR at PC12: Confused about usage of register: R3 in 'UnsetPending'

  if role == self.caster and skill.isCommonAttack then
    ((self.caster).recordTable).Passive = ((self.caster).recordTable).Passive + 1
    if (self.arglist)[1] <= ((self.caster).recordTable).Passive and ((self.caster).recordTable).X_num < 5 then
      local X_number = ((self.caster).recordTable).X_num + 1
      local X_effect = (self.config)["effectId_num" .. tostring(X_number)]
      -- DECOMPILER ERROR at PC38: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self.caster).recordTable).Passive = 0
      LuaSkillCtrl:PlayAuSource(self.caster, (self.config).audioId1)
      LuaSkillCtrl:CallEffect(self.caster, X_effect, self, nil, nil, nil, false)
      LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId1, 1, nil, true)
      -- DECOMPILER ERROR at PC69: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self.caster).recordTable).X_num = ((self.caster).recordTable).X_num + 1
    end
  end
end

bs_103701.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_103701


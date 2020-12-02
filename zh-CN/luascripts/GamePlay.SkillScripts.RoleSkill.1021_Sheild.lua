-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_1021 = class("bs_1021", LuaSkillBase)
local base = LuaSkillBase
bs_1021.config = {buffId = 103, buffTier = 1, effectId = 1045}
bs_1021.ctor = function(self)
  -- function num : 0_0
end

bs_1021.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : _ENV
  self:AddTrigger(eSkillTriggerType.SetHurt, "bs_1021_2", 2, self.OnSetHurt)
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.caster).recordTable).sheildValue_1021 = 0
end

bs_1021.PlaySkill = function(self, data)
  -- function num : 0_2 , upvalues : _ENV
  self:CallCasterWait(2)
  if ((self.caster).recordTable).sheildValue_1021 == 0 then
    LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId, 1)
  end
  -- DECOMPILER ERROR at PC24: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.caster).recordTable).sheildValue_1021 = (self.caster).maxHp * (self.arglist)[1] // 1000
end

bs_1021.OnSetHurt = function(self, context)
  -- function num : 0_3 , upvalues : _ENV
  if context.target == self.caster and ((self.caster).recordTable).sheildValue_1021 ~= 0 then
    local realHurt = context.hurt - ((self.caster).recordTable).sheildValue_1021
    if realHurt >= 0 then
      context.hurt = realHurt
      -- DECOMPILER ERROR at PC19: Confused about usage of register: R3 in 'UnsetPending'

      ;
      ((self.caster).recordTable).sheildValue_1021 = 0
    else
      context.hurt = 0
      -- DECOMPILER ERROR at PC25: Confused about usage of register: R3 in 'UnsetPending'

      ;
      ((self.caster).recordTable).sheildValue_1021 = 0 - realHurt
    end
    if ((self.caster).recordTable).sheildValue_1021 == 0 and (self.caster):GetBuffTier((self.config).buffId) > 0 then
      LuaSkillCtrl:DispelBuff(self.caster, (self.config).buffId)
    end
  end
end

bs_1021.OnCasterDie = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_1021


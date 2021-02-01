-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_10301 = class("bs_10301", LuaSkillBase)
local base = LuaSkillBase
bs_10301.config = {effectId = 10070}
bs_10301.ctor = function(self)
  -- function num : 0_0
end

bs_10301.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : _ENV
  self:AddSelfTrigger(eSkillTriggerType.SetHurt, "bs_1029_2", 1, self.OnSetHurt)
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.caster).recordTable)["1029_hudun"] = 2
end

bs_10301.OnSetHurt = function(self, context)
  -- function num : 0_2 , upvalues : _ENV
  if context.target == self.caster and (context.skill).isCommonAttack and ((self.caster).recordTable)["1029_hudun"] > 0 then
    context.hurt = 0
    -- DECOMPILER ERROR at PC20: Confused about usage of register: R2 in 'UnsetPending'

    ;
    ((self.caster).recordTable)["1029_hudun"] = ((self.caster).recordTable)["1029_hudun"] - 1
  end
  if ((self.caster).recordTable)["1029_hudun"] == 0 then
    LuaSkillCtrl:DispelBuff(self.caster, 109, 1, true)
    self:BreakSkill()
  end
end

bs_10301.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10301


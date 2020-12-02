-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_10187 = class("bs_10187", LuaSkillBase)
local base = LuaSkillBase
bs_10187.config = {beatBackBuff = 151}
bs_10187.ctor = function(self)
  -- function num : 0_0
end

bs_10187.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterHurt, "bs_10187_3", 1, self.OnAfterHurt)
  -- DECOMPILER ERROR at PC13: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.caster).recordTable)["10187_time"] = 1
end

bs_10187.OnAfterHurt = function(self, sender, target, skill, hurt, isMiss, isCrit, isRealDmg)
  -- function num : 0_2 , upvalues : _ENV
  if sender == self.caster and skill.isCommonAttack and LuaSkillCtrl:CallRange(1, 1000) <= (self.arglist)[1] and ((self.caster).recordTable)["10187_time"] > 0 then
    self:PlayChipEffect()
    LuaSkillCtrl:CallBuff(self, target, (self.config).beatBackBuff, 1, 3)
    -- DECOMPILER ERROR at PC33: Confused about usage of register: R8 in 'UnsetPending'

    ;
    ((self.caster).recordTable)["10187_time"] = 0
  end
end

bs_10187.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10187


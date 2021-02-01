-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_10145 = class("bs_10145", LuaSkillBase)
local base = LuaSkillBase
bs_10145.config = {buffId = 1027, buffTier = 1, effectId = 10251}
bs_10145.ctor = function(self)
  -- function num : 0_0
end

bs_10145.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddSelfTrigger(eSkillTriggerType.AfterHurt, "bs_10144_3", 1, self.OnAfterHurt)
  -- DECOMPILER ERROR at PC13: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.caster).recordTable)["10145_AttackTime"] = 0
end

bs_10145.OnAfterHurt = function(self, sender, target, skill, hurt, isMiss, isCrit, isRealDmg, isTriggerSet)
  -- function num : 0_2 , upvalues : _ENV
  -- DECOMPILER ERROR at PC16: Confused about usage of register: R9 in 'UnsetPending'

  if sender == self.caster and skill.isCommonAttack and not isMiss and not isTriggerSet then
    ((self.caster).recordTable)["10145_AttackTime"] = ((self.caster).recordTable)["10145_AttackTime"] + 1
    if (self.arglist)[1] <= ((self.caster).recordTable)["10145_AttackTime"] then
      local targetlist = LuaSkillCtrl:CallTargetSelect(self, 30, 10)
      if targetlist.Count <= 0 then
        return 
      end
      self:PlayChipEffect()
      LuaSkillCtrl:CallBuff(self, (targetlist[0]).targetRole, (self.config).buffId, (self.config).buffTier, (self.arglist)[3])
      -- DECOMPILER ERROR at PC50: Confused about usage of register: R10 in 'UnsetPending'

      ;
      ((self.caster).recordTable)["10145_AttackTime"] = 0
    end
  end
end

bs_10145.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
  if self.damTimer then
    (self.damTimer):Stop()
    self.damTimer = nil
  end
end

return bs_10145


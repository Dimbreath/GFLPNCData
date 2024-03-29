local bs_10131 = class("bs_10131", LuaSkillBase)
local base = LuaSkillBase
bs_10131.config = {buffId = 1009}
bs_10131.ctor = function(self)
  -- function num : 0_0
end

bs_10131.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_10131_1", 1, self.OnAfterHurt, self.caster)
end

bs_10131.OnAfterHurt = function(self, sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  -- function num : 0_2 , upvalues : _ENV
  if sender == self.caster and not isMiss and not isTriggerSet then
    local debuffNum = 0
    local buffs = LuaSkillCtrl:GetRoleBuffs(target)
    if buffs.Count > 0 then
      for i = 0, buffs.Count - 1 do
        if (buffs[i]).buffType == 2 then
          debuffNum = debuffNum + 1
        end
      end
      if debuffNum > 30 then
        debuffNum = 30
      end
      self:PlayChipEffect()
      LuaSkillCtrl:DispelBuff(self.caster, (self.config).buffId, 0, true)
      LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId, (self.arglist)[1] * debuffNum, nil, true)
    else
      LuaSkillCtrl:DispelBuff(self.caster, (self.config).buffId, 0, true)
    end
  end
end

bs_10131.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10131


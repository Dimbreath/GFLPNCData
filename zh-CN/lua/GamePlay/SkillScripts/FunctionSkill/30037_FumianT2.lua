local bs_30037 = class("bs_30037", LuaSkillBase)
local base = LuaSkillBase
bs_30037.config = {buffId = 1200}
bs_30037.ctor = function(self)
  -- function num : 0_0
end

bs_30037.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_30037_1", 1, self.OnAfterHurt, self.caster)
end

bs_30037.OnAfterHurt = function(self, sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
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
      LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId, debuffNum, nil, true)
    else
      LuaSkillCtrl:DispelBuff(self.caster, (self.config).buffId, 0, true)
    end
  end
end

bs_30037.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_30037


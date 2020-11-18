-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_10131 = class("bs_10131", LuaSkillBase)
local base = LuaSkillBase
bs_10131.config = {buffId = 1009}
bs_10131.ctor = function(self)
  -- function num : 0_0
end

bs_10131.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterHurt, "bs_10131_1", 1, self.OnAfterHurt)
end

bs_10131.OnAfterHurt = function(self, sender, target, skill, hurt, isMiss, isCrit, isRealDmg)
  -- function num : 0_2 , upvalues : _ENV
  if sender == self.caster and not isMiss then
    local debuffNum = 0
    local buffs = LuaSkillCtrl:GetRoleBuffs(target)
    if buffs.Count > 0 then
      for i = 0, buffs.Count - 1 do
        if (buffs[i]).buffType == 2 then
          debuffNum = debuffNum + (buffs[i]).tier
        end
      end
      self:PlayChipEffect()
      LuaSkillCtrl:DispelBuff(self.caster, (self.config).buffId, 0)
      LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId, (self.arglist)[1] * (debuffNum))
    else
      LuaSkillCtrl:DispelBuff(self.caster, (self.config).buffId, 0)
    end
  end
end

bs_10131.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10131


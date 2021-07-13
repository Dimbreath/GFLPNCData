-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_103101 = class("bs_103101", LuaSkillBase)
local base = LuaSkillBase
bs_103101.config = {buffId_172 = 172, buffId_173 = 173, selectId = 34}
bs_103101.ctor = function(self)
  -- function num : 0_0
end

bs_103101.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_103101_3", 1, self.OnAfterHurt, self.caster)
end

bs_103101.OnAfterHurt = function(self, sender, target, skill, hurt, isMiss, isCrit, isRealDmg, isTriggerSet)
  -- function num : 0_2 , upvalues : _ENV
  if sender == self.caster and skill.isCommonAttack and not isMiss then
    LuaSkillCtrl:CallBuff(self, target, (self.config).buffId_172, 1, (self.arglist)[3])
    if (self.arglist)[2] > 0 then
      LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId_173, 1, (self.arglist)[3])
      local num = 1 - (self.caster).attackRange
      local target_buff = LuaSkillCtrl:CallTargetSelect(self, (self.config).selectId, num)
      if target_buff.Count > 0 then
        for i = 0, target_buff.Count - 1 do
          LuaSkillCtrl:CallBuff(self, (target_buff[i]).targetRole, (self.config).buffId_173, 1, (self.arglist)[3])
        end
      end
    end
  end
end

bs_103101.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_103101


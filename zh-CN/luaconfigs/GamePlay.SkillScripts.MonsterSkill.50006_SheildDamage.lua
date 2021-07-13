-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_50006 = class("bs_50006", LuaSkillBase)
local base = LuaSkillBase
bs_50006.config = {sheildBuffId = 174, shieldKeyYuan = "50002_HuDun", shieldKeyJin = "50003_HuDun", buffIdYuan = 1047, effectIdYuan = 10371, buffIdJin = 1048, effectIdJin = 10373, fakeYuanId = 1055, fakeJinId = 1056}
bs_50006.ctor = function(self)
  -- function num : 0_0
end

bs_50006.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
  self:AddSetHurtTrigger("bs_50006_1", 1000, self.OnSetHurt, self.caster)
end

bs_50006.OnSetHurt = function(self, context)
  -- function num : 0_2 , upvalues : _ENV
  if (context.skill).SkillRange > 10 then
    return 
  end
  if context.sender == self.caster and (self.caster).attackRange > 1 and (context.target):GetShield(eShieldType.LongRange) > 0 then
    context.hurt = context.hurt * 1500 // 1000
  end
  if context.sender == self.caster and (self.caster).attackRange == 1 and (context.target):GetShield(eShieldType.NoRange) > 0 then
    context.hurt = context.hurt * 1500 // 1000
  end
end

bs_50006.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_50006


-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_202501 = class("bs_202501", LuaSkillBase)
local base = LuaSkillBase
bs_202501.config = {buffId_193 = 193, effectId = 1}
bs_202501.ctor = function(self)
  -- function num : 0_0
end

bs_202501.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_202501_3", 1, self.OnAfterHurt, self.caster)
end

bs_202501.OnAfterHurt = function(self, sender, target, skill, hurt, isMiss, isCrit, isRealDmg, isTriggerSet)
  -- function num : 0_2 , upvalues : _ENV
  if sender == self.caster and isCrit then
    LuaSkillCtrl:CallBuff(self, target, (self.config).buffId_193, 1, (self.arglist)[1], true)
  end
end

bs_202501.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_202501


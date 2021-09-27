local bs_100301 = class("bs_100301", LuaSkillBase)
local base = LuaSkillBase
bs_100301.config = {effectId_pass = 100306, audioId_pass = 100308}
bs_100301.ctor = function(self)
  -- function num : 0_0
end

bs_100301.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1
  self:AddSetHurtTrigger("bs_100301_2", 1, self.OnSetHurt, nil, self.caster)
end

bs_100301.OnSetHurt = function(self, context)
  -- function num : 0_2 , upvalues : _ENV
  if context.target == self.caster and LuaSkillCtrl:CallRange(1, 1000) <= (self.arglist)[2] and (context.skill).dataId ~= 202003 and context.isTriggerSet ~= true and (LuaSkillCtrl:GetGridsDistance((context.sender).x, (context.sender).y, (self.caster).x, (self.caster).y) > 1 or (context.sender).attackRange > 1 or (context.skill).dataId == 201903) then
    LuaSkillCtrl:CallEffect(self.caster, (self.config).effectId_pass, self)
    context.hurt = context.hurt * (1000 - (self.arglist)[1]) // 1000
  end
end

bs_100301.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_100301


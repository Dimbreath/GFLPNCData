local bs_15047 = class("bs_15047", LuaSkillBase)
local base = LuaSkillBase
bs_15047.config = {buffId = 26}
bs_15047.ctor = function(self)
  -- function num : 0_0
end

bs_15047.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterHurt, "bs_15047_4", 1, self.OnAfterHurt)
end

bs_15047.OnAfterHurt = function(self, sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  -- function num : 0_2 , upvalues : _ENV
  LuaSkillCtrl:CallBuff(self, target, (self.config).buffId, 1, 15, true)
end

bs_15047.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_15047


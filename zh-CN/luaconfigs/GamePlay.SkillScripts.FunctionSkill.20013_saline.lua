-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_20013 = class("bs_20013", LuaSkillBase)
local base = LuaSkillBase
bs_20013.config = {buffId = 1111}
bs_20013.ctor = function(self)
  -- function num : 0_0
end

bs_20013.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddSelfTrigger(eSkillTriggerType.HurtResultStart, "bs_20013_14", 1, self.OnHurtResultStart)
  self:AddSelfTrigger(eSkillTriggerType.HurtResultEnd, "bs_20013_15", 1, self.OnHurtResultEnd)
end

bs_20013.OnHurtResultStart = function(self, skill, context)
  -- function num : 0_2 , upvalues : _ENV
  if (context.target).hp * 1000 // (context.target).maxHp < (self.arglist)[1] and (context.target).intensity > 0 then
    LuaSkillCtrl:CallBuff(self, context.target, (self.config).buffId, 1, nil, true)
  end
end

bs_20013.OnHurtResultEnd = function(self, skill, targetRole, hurtValue)
  -- function num : 0_3 , upvalues : _ENV
  LuaSkillCtrl:DispelBuff(targetRole, (self.config).buffId, 0, true)
end

bs_20013.OnCast4rDie = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_20013


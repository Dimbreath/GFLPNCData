-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_6002 = class("bs_6002", LuaSkillBase)
local base = LuaSkillBase
bs_6002.config = {}
bs_6002.ctor = function(self)
  -- function num : 0_0
end

bs_6002.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddSelfTrigger(eSkillTriggerType.HealResultStart, "bs_6002_15", 1, self.OnHealResultStart)
end

bs_6002.OnHealResultStart = function(self, skill, context)
  -- function num : 0_2
  if context.sender == self.caster then
    local offset = (self.arglist)[1]
    local precent = (self.arglist)[2]
    if (context.target).hp * 100 // (context.target).maxHp <= precent then
      offset = (self.arglist)[3]
    end
    context.correct_offset = context.correct_offset + offset * 10
  end
end

bs_6002.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_6002


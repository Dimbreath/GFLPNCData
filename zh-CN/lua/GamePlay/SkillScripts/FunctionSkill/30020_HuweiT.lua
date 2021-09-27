local bs_30020 = class("bs_30020", LuaSkillBase)
local base = LuaSkillBase
bs_30020.config = {}
bs_30020.ctor = function(self)
  -- function num : 0_0
end

bs_30020.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
  self:AddSetHealTrigger("bs_30020_4", 1, self.OnSetHeal, nil, nil, nil, (self.caster).belongNum)
end

bs_30020.OnSetHeal = function(self, context)
  -- function num : 0_2 , upvalues : _ENV
  if context.target ~= self.caster and not context.isTriggerSet then
    local healNum = context.heal * (self.arglist)[1] // 1000
    LuaSkillCtrl:CallHeal(healNum, self, self.caster, true)
  end
end

bs_30020.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_30020


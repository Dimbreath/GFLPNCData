-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_10217 = class("bs_10217", LuaSkillBase)
local base = LuaSkillBase
bs_10217.config = {}
bs_10217.ctor = function(self)
  -- function num : 0_0
end

bs_10217.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.SetHeal, "bs_10217_4", 1, self.OnSetHeal)
end

bs_10217.OnSetHeal = function(self, context)
  -- function num : 0_2 , upvalues : _ENV
  if (context.target).belongNum == 2 then
    context.heal = (math.max)(1, context.heal * (1000 - (self.arglist)[1]) // 1000)
  end
end

bs_10217.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10217


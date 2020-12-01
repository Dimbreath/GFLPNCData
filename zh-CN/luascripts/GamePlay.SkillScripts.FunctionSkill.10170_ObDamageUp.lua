-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_10170 = class("bs_10170", LuaSkillBase)
local base = LuaSkillBase
bs_10170.config = {}
bs_10170.ctor = function(self)
  -- function num : 0_0
end

bs_10170.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.SetHurt, "bs_10170_2", 1, self.OnSetHurt)
end

bs_10170.OnSetHurt = function(self, context)
  -- function num : 0_2
  if context.sender == self.caster and (context.target).belongNum == 0 and (context.target).intensity == 0 then
    context.hurt = context.hurt + context.hurt * (self.arglist)[1] // 1000
  end
end

bs_10170.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10170

-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_10170 = class("bs_10170", LuaSkillBase)
local base = LuaSkillBase
bs_10170.config = {}
bs_10170.ctor = function(self)
    -- function num : 0_0
end

bs_10170.InitSkill = function(self, isMidwaySkill)
    -- function num : 0_1 , upvalues : base, _ENV
    (base.InitSkill)(self, isMidwaySkill)
    self:AddTrigger(eSkillTriggerType.SetHurt, "bs_10170_2", 1, self.OnSetHurt)
end

bs_10170.OnSetHurt = function(self, context)
    -- function num : 0_2
    if context.sender == self.caster and (context.target).belongNum == 0 and
        (context.target).intensity == 0 then
        context.hurt = context.hurt + context.hurt * (self.arglist)[1] // 1000
    end
end

bs_10170.OnCasterDie = function(self)
    -- function num : 0_3 , upvalues : base
    (base.OnCasterDie)(self)
end

return bs_10170


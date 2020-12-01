-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_50001 = class("bs_50001", LuaSkillBase)
local base = LuaSkillBase
bs_50001.config = {}
bs_50001.ctor = function(self)
  -- function num : 0_0
end

bs_50001.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.BeforePlaySkill, "bs_50001_1", 1, self.OnBeforePlaySkill)
end

bs_50001.OnBeforePlaySkill = function(self, role, context)
  -- function num : 0_2
  if role == self.caster and (context.skill).isCommonAttack then
    local passdata = {rangeOffset = 10, targetSelect = 21}
    context.passdata = passdata
  end
end

bs_50001.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_50001

-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_50001 = class("bs_50001", LuaSkillBase)
local base = LuaSkillBase
bs_50001.config = {}
bs_50001.ctor = function(self)
    -- function num : 0_0
end

bs_50001.InitSkill = function(self, isMidwaySkill)
    -- function num : 0_1 , upvalues : base, _ENV
    (base.InitSkill)(self, isMidwaySkill)
    self:AddTrigger(eSkillTriggerType.BeforePlaySkill, "bs_50001_1", 1,
                    self.OnBeforePlaySkill)
end

bs_50001.OnBeforePlaySkill = function(self, role, context)
    -- function num : 0_2
    if role == self.caster and (context.skill).isCommonAttack then
        local passdata = {rangeOffset = 10, targetSelect = 21}
        context.passdata = passdata
    end
end

bs_50001.OnCasterDie = function(self)
    -- function num : 0_3 , upvalues : base
    (base.OnCasterDie)(self)
end

return bs_50001


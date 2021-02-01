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
  self:AddSelfTrigger(eSkillTriggerType.BeforeTargetSelect, "bs_50001_13", 1, self.OnBeforeTargetSelect)
end

bs_50001.OnBeforeTargetSelect = function(self, skill, role, selectConfig)
  -- function num : 0_2
  if skill.maker == self.caster and skill.isCommonAttack then
    selectConfig.IsAscendOrder = false
  end
end

bs_50001.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_50001


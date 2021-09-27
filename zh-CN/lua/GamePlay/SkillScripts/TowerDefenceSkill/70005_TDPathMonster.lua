local bs_70005 = class("bs_70005", LuaSkillBase)
local base = LuaSkillBase
bs_70005.config = {}
bs_70005.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_0 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
end

bs_70005.PlaySkill = function(self, data)
  -- function num : 0_1 , upvalues : _ENV
  LuaSkillCtrl:RemoveLife((self.caster).hp + 1, self, self.caster, true, nil, false, true)
end

bs_70005.OnCasterDie = function(self)
  -- function num : 0_2 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_70005


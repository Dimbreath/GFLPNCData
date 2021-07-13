-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_40021 = class("bs_40021", LuaSkillBase)
local base = LuaSkillBase
bs_40021.config = {}
bs_40021.ctor = function(self)
  -- function num : 0_0
end

bs_40021.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1
  -- DECOMPILER ERROR at PC4: Confused about usage of register: R2 in 'UnsetPending'

  ((self.caster).recordTable).life_num = (self.arglist)[1]
end

bs_40021.OnCasterDie = function(self)
  -- function num : 0_2 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_40021


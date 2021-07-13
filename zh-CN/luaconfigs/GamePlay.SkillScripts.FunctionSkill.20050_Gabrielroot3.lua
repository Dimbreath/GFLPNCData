-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_20050 = class("bs_20050", LuaSkillBase)
local base = LuaSkillBase
bs_20050.config = {}
bs_20050.ctor = function(self)
  -- function num : 0_0
end

bs_20050.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
  if (self.caster).roleDataId ~= 30004 then
    return 
  end
  -- DECOMPILER ERROR at PC13: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.caster).recordTable)["20050_root3arg1"] = (self.arglist)[1]
end

bs_20050.OnCasterDie = function(self)
  -- function num : 0_2 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_20050


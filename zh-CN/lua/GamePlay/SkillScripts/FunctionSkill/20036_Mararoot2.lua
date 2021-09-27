local bs_20036 = class("bs_20036", LuaSkillBase)
local base = LuaSkillBase
bs_20036.config = {}
bs_20036.ctor = function(self)
  -- function num : 0_0
end

bs_20036.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
  if (self.caster).roleDataId ~= 30001 and (self.caster).roleDataId ~= 30002 then
    return 
  end
  self:AddSetHurtTrigger("bs_20036_2", 1, self.OnSetHurt, self.caster)
  -- DECOMPILER ERROR at PC21: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.caster).recordTable)["20036_root2arg"] = true
end

bs_20036.OnSetHurt = function(self, context)
  -- function num : 0_2
  if context.sender == self.caster and (context.skill).dataId == 200903 then
    context.hurt = context.hurt - context.hurt * (self.arglist)[1] // 1000
  end
end

bs_20036.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_20036


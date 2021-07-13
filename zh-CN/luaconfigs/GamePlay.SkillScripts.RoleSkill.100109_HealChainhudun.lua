-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_100109 = class("bs_100109", LuaSkillBase)
local base = LuaSkillBase
bs_100109.config = {}
bs_100109.ctor = function(self)
  -- function num : 0_0
end

bs_100109.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1
  self:AddSetHurtTrigger("bs_100109_2", 1, self.OnSetHurt, nil, self.caster)
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.caster).recordTable)["100109_hudun"] = 2
end

bs_100109.OnSetHurt = function(self, context)
  -- function num : 0_2 , upvalues : _ENV
  if context.target == self.caster and ((self.caster).recordTable)["100109_hudun"] > 0 then
    context.hurt = 0
    LuaSkillCtrl:CallFloatText(self.caster, 7)
    -- DECOMPILER ERROR at PC21: Confused about usage of register: R2 in 'UnsetPending'

    ;
    ((self.caster).recordTable)["100109_hudun"] = ((self.caster).recordTable)["100109_hudun"] - 1
  end
  if ((self.caster).recordTable)["100109_hudun"] == 0 then
    LuaSkillCtrl:DispelBuff(self.caster, 109, 1, true)
    self:BreakSkill()
  end
end

bs_100109.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_100109


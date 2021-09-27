local bs_50004 = class("bs_50004", LuaSkillBase)
local base = LuaSkillBase
bs_50004.config = {buffId = 1051, effectId = 10481}
bs_50004.ctor = function(self)
  -- function num : 0_0
end

bs_50004.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddBeforeAddBuffTrigger("bs_50004_2", 1, self.OnBeforeAddBuff, nil, self.caster, nil, nil, nil, eBuffType.Debeneficial)
end

bs_50004.OnBeforeAddBuff = function(self, target, context)
  -- function num : 0_2
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R3 in 'UnsetPending'

  if (context.buff).buffType == 2 and target == self.caster then
    (context.buff).tier = 0
  end
end

bs_50004.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_50004


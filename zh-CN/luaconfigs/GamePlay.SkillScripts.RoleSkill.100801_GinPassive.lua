-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_100801 = class("bs_100801", LuaSkillBase)
local base = LuaSkillBase
bs_100801.config = {buffId_159 = 159}
bs_100801.ctor = function(self)
  -- function num : 0_0
end

bs_100801.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.caster).recordTable).BJ = true
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.caster).recordTable)["arglist[1]"] = (self.arglist)[1]
  self:AddAfterHealTrigger("bs_100801_1", 1, self.OnAfterHeal, self.caster, nil, nil, nil, nil, nil, 14)
  self:AddAfterAddBuffTrigger("bs_100801_1", 1, self.OnAfterAddBuff, nil, self.caster)
  self:AddSelfTrigger(eSkillTriggerType.BuffDie, "bs_100801_1", 1, self.OnBuffDie)
end

bs_100801.OnAfterHeal = function(self, sender, target, skill, heal, isStealHeal)
  -- function num : 0_2 , upvalues : _ENV
  if skill.dataId == 14 and sender == self.caster and (self.arglist)[2] > 0 and not isStealHeal then
    LuaSkillCtrl:CallBuff(self, target, (self.config).buffId_159, 1, (self.arglist)[3])
  end
end

bs_100801.OnAfterAddBuff = function(self, buff, target)
  -- function num : 0_3 , upvalues : _ENV
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R3 in 'UnsetPending'

  if buff:ContainFeature(eBuffFeatureType.Taunt) and target == self.caster then
    ((self.caster).recordTable).BJ = false
  end
end

bs_100801.OnBuffDie = function(self, buff, target, removeType)
  -- function num : 0_4 , upvalues : _ENV
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R4 in 'UnsetPending'

  if buff:ContainFeature(eBuffFeatureType.Taunt) and target == self.caster then
    ((self.caster).recordTable).BJ = true
  end
end

bs_100801.OnCasterDie = function(self)
  -- function num : 0_5 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_100801


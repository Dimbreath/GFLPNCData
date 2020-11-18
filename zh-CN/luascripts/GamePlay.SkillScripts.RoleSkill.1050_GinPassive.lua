-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_1050 = class("bs_1050", LuaSkillBase)
local base = LuaSkillBase
bs_1050.config = {buffId = 159, buffIdBJ = 160, action1 = 1001, action2 = 1004, effectId = 10208}
bs_1050.ctor = function(self)
  -- function num : 0_0
end

bs_1050.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.caster).recordTable).BJ = true
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.caster).recordTable)["arglist[1]"] = (self.arglist)[1]
  self:AddTrigger(eSkillTriggerType.AfterHeal, "bs_1050_1", 1, self.OnAfterHeal)
  self:AddTrigger(eSkillTriggerType.AfterAddBuff, "bs_1050_1", 1, self.OnAfterAddBuff)
  self:AddTrigger(eSkillTriggerType.BuffDie, "bs_1050_1", 1, self.OnBuffDie)
end

bs_1050.OnAfterHeal = function(self, sender, target, skill, heal, isStealHeal)
  -- function num : 0_2 , upvalues : _ENV
  if skill.dataId == 14 and sender == self.caster and (self.arglist)[5] > 0 and not isStealHeal then
    LuaSkillCtrl:CallBuff(self, target, (self.config).buffId, 1, (self.arglist)[3])
  end
end

bs_1050.OnAfterAddBuff = function(self, buff, target)
  -- function num : 0_3 , upvalues : _ENV
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R3 in 'UnsetPending'

  if buff:ContainFeature(eBuffFeatureType.Taunt) and target == self.caster then
    ((self.caster).recordTable).BJ = false
  end
end

bs_1050.OnBuffDie = function(self, buff, target, removeType)
  -- function num : 0_4 , upvalues : _ENV
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R4 in 'UnsetPending'

  if buff:ContainFeature(eBuffFeatureType.Taunt) and target == self.caster then
    ((self.caster).recordTable).BJ = true
  end
end

bs_1050.OnCasterDie = function(self)
  -- function num : 0_5 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_1050


local bs_102101 = class("bs_102101", LuaSkillBase)
local base = LuaSkillBase
bs_102101.config = {buffId_171 = 171, 
AOE = {effect_shape = 3, aoe_select_code = 4, aoe_range = 10}
, 
HurtConfig = {basehurt_formula = 10058, minhurt_formula = 9994, correct_formula = 9989}
, audioId1 = 77, buffId_170 = 170, effectId_Grid = 10709}
bs_102101.ctor = function(self)
  -- function num : 0_0
end

bs_102101.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_102101_3", 1, self.OnAfterHurt, nil, nil, nil, nil, nil, eBattleRoleType.character)
end

bs_102101.OnAfterHurt = function(self, sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  -- function num : 0_2 , upvalues : _ENV
  if isMiss and target.roleType == 1 and (self.caster):GetBuffTier((self.config).buffId_170) == 0 then
    LuaSkillCtrl:CallResetCDNumForRole(self.caster, (self.arglist)[1])
  end
end

bs_102101.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base, _ENV
  (base.OnCasterDie)(self)
  if self.timerhurt ~= nil then
    (self.timerhurt):Stop()
    self.timerhurt = nil
  end
  if self.loop ~= nil then
    LuaSkillCtrl:StopAudioByBack(self.loop)
    self.loop = nil
  end
end

bs_102101.LuaDispose = function(self)
  -- function num : 0_4 , upvalues : base
  (base.LuaDispose)(self)
  self.loop = nil
  self.effectQ = nil
end

return bs_102101


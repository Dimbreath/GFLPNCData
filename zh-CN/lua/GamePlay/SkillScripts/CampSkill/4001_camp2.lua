local bs_4001 = class("bs_4001", LuaSkillBase)
local base = LuaSkillBase
bs_4001.config = {buffId = 66, buffTier = 1, buffDuration = 30, probMax = 3, probHit = 1}
bs_4001.ctor = function(self)
  -- function num : 0_0
end

bs_4001.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1
  self:AddAfterHurtTrigger("bs_4001_3", 1, self.OnAfterHurt, self.caster)
end

bs_4001.OnAfterHurt = function(self, sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  -- function num : 0_2 , upvalues : _ENV
  if sender == self.caster and skill.isCommonAttack and LuaSkillCtrl:CallRange(1, (self.config).probMax) == (self.config).probHit then
    local targetList = LuaSkillCtrl:CallTargetSelect(self, 1001, 0)
    self:CallCasterLookAt(targetList)
    LuaSkillCtrl:CallBuff(self, target, (self.config).buffId, (self.config).buffTier, (self.config).buffDuration, true)
  end
end

bs_4001.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_4001


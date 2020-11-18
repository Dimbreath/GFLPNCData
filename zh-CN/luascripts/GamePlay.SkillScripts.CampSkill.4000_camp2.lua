-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_4000 = class("bs_4000", LuaSkillBase)
local base = LuaSkillBase
bs_4000.config = {buffId = 66, buffTier = 1, buffDuration = 30, probMax = 5, probHit = 1}
bs_4000.ctor = function(self)
  -- function num : 0_0
end

bs_4000.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : _ENV
  self:AddTrigger(eSkillTriggerType.AfterHurt, "bs_4000_3", 1, self.OnAfterHurt)
end

bs_4000.OnAfterHurt = function(self, sender, target, skill, hurt, isMiss, isCrit, isRealDmg)
  -- function num : 0_2 , upvalues : _ENV
  if sender == self.caster and skill.isCommonAttack and LuaSkillCtrl:CallRange(1, (self.config).probMax) == (self.config).probHit then
    local targetList = LuaSkillCtrl:CallTargetSelect(self, 1001, 0)
    self:CallCasterLookAt(targetList)
    LuaSkillCtrl:CallBuff(self, target, (self.config).buffId, (self.config).buffTier, (self.config).buffDuration)
  end
end

bs_4000.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_4000


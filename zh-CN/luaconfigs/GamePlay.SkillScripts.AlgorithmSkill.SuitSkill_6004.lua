-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_6004 = class("bs_6004", LuaSkillBase)
local base = LuaSkillBase
bs_6004.config = {buffId_1152 = 1152}
bs_6004.ctor = function(self)
  -- function num : 0_0
end

bs_6004.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_6004_3", 1, self.OnAfterHurt, nil, self.caster)
end

bs_6004.OnAfterHurt = function(self, sender, target, skill, hurt, isMiss, isCrit, isRealDmg)
  -- function num : 0_2 , upvalues : _ENV
  if target == self.caster and self:IsReadyToTake() and (self.caster).hp <= (self.caster).maxHp * (self.arglist)[1] // 1000 then
    LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId_1152, 1, (self.arglist)[5], true)
    self:OnSkillTake()
  end
end

bs_6004.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_6004


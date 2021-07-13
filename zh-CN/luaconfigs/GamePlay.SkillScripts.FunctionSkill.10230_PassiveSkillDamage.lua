-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_10230 = class("bs_10230", LuaSkillBase)
local base = LuaSkillBase
bs_10230.config = {buffId = 1085, buffTier = 1}
bs_10230.ctor = function(self)
  -- function num : 0_0
end

bs_10230.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
  self:AddAfterAddBuffTrigger("bs_10230_2", 1, self.OnAfterAddBuff, self.caster)
end

bs_10230.OnAfterAddBuff = function(self, buff, target, isOverlay)
  -- function num : 0_2 , upvalues : _ENV
  if buff.buffType ~= 0 and buff.maker == self.caster and self:IsReadyToTake() then
    LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId, (self.config).buffTier, nil, true)
    self:PlayChipEffect()
  end
end

bs_10230.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10230


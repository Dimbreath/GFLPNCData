-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_10230 = class("bs_10230", LuaSkillBase)
local base = LuaSkillBase
bs_10230.config = {buffId = 1085, buffTier = 1}
bs_10230.ctor = function(self)
  -- function num : 0_0
end

bs_10230.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddSelfTrigger(eSkillTriggerType.AfterAddBuff, "bs_10230_2", 1, self.OnAfterAddBuff)
end

bs_10230.OnAfterAddBuff = function(self, buff, target, isOverlay)
  -- function num : 0_2 , upvalues : _ENV
  if buff.buffType == 1 and isOverlay and buff.maker == self.caster and self:IsReadyToTake() then
    self:OnSkillTake()
    local buffTier = target:GetBuffTier((self.config).buffId)
    if buffTier < (self.arglist)[2] then
      LuaSkillCtrl:CallBuff(self, target, (self.config).buffId, (self.config).buffTier, nil, true)
    else
      if (self.arglist)[2] < buffTier then
        LuaSkillCtrl:DispelBuff(target, (self.config).buffId, 0, true)
        LuaSkillCtrl:CallBuff(self, target, (self.config).buffId, (self.arglist)[1], nil, true)
      end
    end
  end
end

bs_10230.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10230


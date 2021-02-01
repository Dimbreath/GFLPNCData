-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_10238 = class("bs_10238", LuaSkillBase)
local base = LuaSkillBase
bs_10238.config = {buffId = 1091, buffTier = 1, buffId2 = 1125}
bs_10238.ctor = function(self)
  -- function num : 0_0
end

bs_10238.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddSelfTrigger(eSkillTriggerType.AfterHurt, "bs_10238_3", 1, self.OnAfterHurt)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_10238_1", 2, self.OnAfterBattleStart)
end

bs_10238.OnAfterBattleStart = function(self)
  -- function num : 0_2 , upvalues : _ENV
  LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId2, 1, nil, true)
end

bs_10238.OnAfterHurt = function(self, sender, target, skill, hurt, isMiss, isCrit, isRealDmg, isTriggerSet)
  -- function num : 0_3 , upvalues : _ENV
  if sender == self.caster and isCrit and self:IsReadyToTake() then
    self:OnSkillTake()
    local targetlist = LuaSkillCtrl:CallTargetSelect(self, 6, 10)
    if targetlist.Count < 1 then
      return 
    end
    for i = 0, targetlist.Count - 1 do
      local targetRole = (targetlist[i]).targetRole
      local buffTier = targetRole:GetBuffTier((self.config).buffId)
      if buffTier < (self.arglist)[2] then
        LuaSkillCtrl:CallBuff(self, targetRole, (self.config).buffId, (self.config).buffTier, nil, true)
      else
        if (self.arglist)[2] < buffTier then
          LuaSkillCtrl:DispelBuff(self.caster, (self.config).buffId, 0, true)
          LuaSkillCtrl:CallBuff(self, targetRole, (self.config).buffId, (self.arglist)[2], nil, true)
        end
      end
    end
  end
end

bs_10238.OnCasterDie = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10238


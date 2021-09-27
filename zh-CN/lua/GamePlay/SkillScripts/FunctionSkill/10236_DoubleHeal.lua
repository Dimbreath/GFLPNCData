local bs_10236 = class("bs_10236", LuaSkillBase)
local base = LuaSkillBase
bs_10236.config = {buffId = 1089, buffTier = 1}
bs_10236.ctor = function(self)
  -- function num : 0_0
end

bs_10236.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddSetHealTrigger("bs_10236_4", 1, self.OnSetHeal, self.caster)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_10236_1", 1, self.OnAfterBattleStart)
end

bs_10236.OnAfterBattleStart = function(self)
  -- function num : 0_2 , upvalues : _ENV
  LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId, (self.config).buffTier, nil, true)
end

bs_10236.OnSetHeal = function(self, context)
  -- function num : 0_3 , upvalues : _ENV
  if context.sender == self.caster and self:IsReadyToTake() and not context.isTriggerSet then
    self:OnSkillTake()
    local targetlist = LuaSkillCtrl:CallTargetSelect(self, 26, 10)
    if targetlist.Count < 1 then
      return 
    end
    LuaSkillCtrl:CallHeal(context.heal, self, (targetlist[0]).targetRole, true)
  end
end

bs_10236.OnCasterDie = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10236


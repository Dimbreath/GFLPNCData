local bs_10241 = class("bs_10241", LuaSkillBase)
local base = LuaSkillBase
bs_10241.config = {buffId = 1116}
bs_10241.ctor = function(self)
  -- function num : 0_0
end

bs_10241.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_10241_1", 1, self.OnAfterBattleStart)
  self:AddTrigger(eSkillTriggerType.OnGridCreatedInBattle, "bs_10241_2", 2, self.OnGridCreatedInBattle)
end

bs_10241.OnGridCreatedInBattle = function(self, gridId, totalGridCount)
  -- function num : 0_2 , upvalues : _ENV
  local tier = (math.min)(15, totalGridCount)
  local buffTier = (self.caster):GetBuffTier((self.config).buffId)
  if buffTier > 0 then
    LuaSkillCtrl:DispelBuff(self.caster, (self.config).buffId, 0)
    LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId, tier, nil, true)
  end
end

bs_10241.OnAfterBattleStart = function(self)
  -- function num : 0_3 , upvalues : _ENV
  local tier = LuaSkillCtrl:CallGetTotalEfcGridCount()
  tier = (math.min)(15, tier)
  LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId, tier, nil, true)
end

bs_10241.OnCasterDie = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10241


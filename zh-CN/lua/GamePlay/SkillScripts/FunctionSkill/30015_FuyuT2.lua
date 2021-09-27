local bs_30015 = class("bs_30015", LuaSkillBase)
local base = LuaSkillBase
bs_30015.config = {buffId2 = 1136, buffTier = 1, buffId_fuyu = 1088}
bs_30015.ctor = function(self)
  -- function num : 0_0
end

bs_30015.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
  self:AddAfterAddBuffTrigger("bs_30015_7", 1, self.OnAfterAddBuff, nil, nil, nil, nil, (self.config).buffId_fuyu)
  self:AddBeforeBuffDispelTrigger("bs_30015_1", 1, self.BeforeBuffDispel, nil, nil, (self.config).buffId_fuyu)
  self:AddBuffDieTrigger("bs_30015_2", 1, self.OnBuffDie, nil, nil, (self.config).buffId_fuyu)
end

bs_30015.OnAfterAddBuff = function(self, buff, target)
  -- function num : 0_2 , upvalues : _ENV
  LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId2, buff.tier, nil, true)
end

bs_30015.BeforeBuffDispel = function(self, targetRole, context)
  -- function num : 0_3 , upvalues : _ENV
  LuaSkillCtrl:DispelBuff(self.caster, (self.config).buffId2, context.tier)
end

bs_30015.OnBuffDie = function(self, buff, target, removeType)
  -- function num : 0_4 , upvalues : _ENV
  LuaSkillCtrl:DispelBuff(self.caster, (self.config).buffId2, buff.tier, true)
end

bs_30015.OnCasterDie = function(self)
  -- function num : 0_5 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_30015


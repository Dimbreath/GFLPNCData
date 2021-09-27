local bs_10292 = class("bs_10292", LuaSkillBase)
local base = LuaSkillBase
bs_10292.config = {buffId_fuyu = 1088, buff_jisu = 1202}
bs_10292.ctor = function(self)
  -- function num : 0_0
end

bs_10292.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
  self:AddAfterAddBuffTrigger("bs_10292_7", 1, self.OnAfterAddBuff, nil, nil, nil, nil, (self.config).buffId_fuyu)
  self:AddBeforeBuffDispelTrigger("bs_10292_1", 1, self.BeforeBuffDispel, nil, nil, (self.config).buffId_fuyu)
  self:AddBuffDieTrigger("bs_10292_2", 1, self.OnBuffDie, nil, nil, (self.config).buffId_fuyu)
end

bs_10292.OnAfterAddBuff = function(self, buff, target)
  -- function num : 0_2 , upvalues : _ENV
  LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buff_jisu, buff.tier, nil, true)
end

bs_10292.BeforeBuffDispel = function(self, targetRole, context)
  -- function num : 0_3 , upvalues : _ENV
  LuaSkillCtrl:DispelBuff(self.caster, (self.config).buff_jisu, context.tier)
end

bs_10292.OnBuffDie = function(self, buff, target, removeType)
  -- function num : 0_4 , upvalues : _ENV
  LuaSkillCtrl:DispelBuff(self.caster, (self.config).buff_jisu, buff.tier, true)
end

bs_10292.OnCasterDie = function(self)
  -- function num : 0_5 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10292


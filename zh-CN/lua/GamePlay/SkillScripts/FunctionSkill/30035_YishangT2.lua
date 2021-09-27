local bs_30035 = class("bs_30035", LuaSkillBase)
local base = LuaSkillBase
bs_30035.config = {checkBuffId = 1059, buffId = 1060}
bs_30035.ctor = function(self)
  -- function num : 0_0
end

bs_30035.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
  self:AddAfterAddBuffTrigger("bs_30035_7", 1, self.OnAfterAddBuff, nil, nil, nil, nil, (self.config).checkBuffId)
  self:AddBeforeBuffDispelTrigger("bs_30035_2", 2, self.BeforeBuffDispel, nil, nil, (self.config).checkBuffId)
  self:AddBuffDieTrigger("bs_30035_1", 1, self.OnBuffDie, nil, nil, (self.config).checkBuffId)
end

bs_30035.OnAfterAddBuff = function(self, buff, target)
  -- function num : 0_2 , upvalues : _ENV
  if buff.dataId == (self.config).checkBuffId then
    LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId, buff.tier, nil, true)
  end
end

bs_30035.BeforeBuffDispel = function(self, targetRole, context)
  -- function num : 0_3 , upvalues : _ENV
  LuaSkillCtrl:DispelBuff(self.caster, (self.config).buffId, context.tier)
end

bs_30035.OnBuffDie = function(self, buff, target, removeType)
  -- function num : 0_4 , upvalues : _ENV
  if buff.dataId == (self.config).checkBuffId then
    LuaSkillCtrl:DispelBuff(self.caster, (self.config).buffId, buff.tier)
  end
end

bs_30035.OnCasterDie = function(self)
  -- function num : 0_5 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_30035


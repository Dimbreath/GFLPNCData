local bs_101101 = class("bs_101101", LuaSkillBase)
local base = LuaSkillBase
bs_101101.config = {buffId = 101103}
bs_101101.ctor = function(self)
  -- function num : 0_0
end

bs_101101.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddSelfTrigger(eSkillTriggerType.AfterPlaySkill, "bs_101101_12", 1, self.OnAfterPlaySkill)
  self:OnCasterAttributeChange()
  self:AddTrigger(eSkillTriggerType.OnSelfAttrChanged, "bs_101101_attrObs", 1, self.OnCasterAttributeChange)
  self.timeattack = 0
  self.time = 0
end

bs_101101.OnAfterPlaySkill = function(self, skill, role)
  -- function num : 0_2 , upvalues : _ENV
  if role == self.caster and skill.isCommonAttack then
    self.timeattack = self.timeattack + 1
  end
  if role == self.caster and skill.isCommonAttack and self.timeattack == (self.arglist)[1] and self.time < (self.arglist)[3] then
    LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId, 1, nil, true)
    local heal = (self.caster).skill_intensity * (self.arglist)[2] // 1000
    LuaSkillCtrl:CallHeal(heal, self, self.caster, true)
    self.time = self.time + 1
    self.timeattack = 0
  end
end

bs_101101.OnCasterAttributeChange = function(self)
  -- function num : 0_3 , upvalues : _ENV
  if self.num == nil then
    self.num = 0
    self._change_def = 0
    self.maxHp = (self.caster).maxHp
  end
  local change_hp = (self.caster).maxHp - self.maxHp
  local change_def = change_hp * (self.arglist)[6] // (self.arglist)[5]
  if self._change_def ~= change_def then
    local num = change_def - self._change_def
    ;
    (self.caster):AddRoleProperty(eHeroAttr.magic_res, num, eHeroAttrType.Extra)
    self._change_def = change_def
  end
end

bs_101101.OnCasterDie = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_101101


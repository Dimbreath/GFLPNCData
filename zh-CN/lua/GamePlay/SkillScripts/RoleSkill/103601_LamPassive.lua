local bs_103601 = class("bs_103601", LuaSkillBase)
local base = LuaSkillBase
bs_103601.config = {}
bs_103601.ctor = function(self)
  -- function num : 0_0
end

bs_103601.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self.lastSpeedOfs = 0
  self:OnCasterAttributeChange()
  self:AddTrigger(eSkillTriggerType.OnSelfAttrChanged, "bs_103601_attrObs", 1, self.OnCasterAttributeChange)
end

bs_103601.OnCasterAttributeChange = function(self)
  -- function num : 0_2 , upvalues : _ENV
  if self.numtime == nil then
    self.numtime = 0
    self.speed_num = (self.caster).speed
    self.crit_num = (self.caster).crit
    self.critdamage_num = (self.caster).critDamage
  end
  local change_spd = (self.arglist)[1] - (self.caster).speed
  if self.numtime > 0 then
    self.speed_num = self.speed_num - change_spd
  end
  ;
  (self.caster):AddRoleProperty(eHeroAttr.speed, change_spd, eHeroAttrType.Extra)
  self.numtime = self.numtime + 1
  if (self.arglist)[1] < self.speed_num then
    local ret_old = self.crit_num - (self.caster).crit
    ;
    (self.caster):AddRoleProperty(eHeroAttr.crit, ret_old, eHeroAttrType.Extra)
    local ret = self.speed_num - (self.arglist)[1]
    local ret_crit = (Mathf.Min)(1000, ret * (self.arglist)[3] // (self.arglist)[2])
    ;
    (self.caster):AddRoleProperty(eHeroAttr.crit, ret_crit, eHeroAttrType.Extra)
  else
    do
      local ret_old = self.crit_num - (self.caster).crit
      ;
      (self.caster):AddRoleProperty(eHeroAttr.crit, ret_old, eHeroAttrType.Extra)
    end
  end
end

bs_103601.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_103601


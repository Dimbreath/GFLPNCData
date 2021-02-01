-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_101101 = class("bs_101101", LuaSkillBase)
local base = LuaSkillBase
bs_101101.config = {buffId = 210}
bs_101101.ctor = function(self)
  -- function num : 0_0
end

bs_101101.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_101101_1", 1, self.OnAfterBattleStart)
  self:OnCasterAttributeChange()
  self:AddTrigger(eSkillTriggerType.OnSelfAttrChanged, "bs_1042_attrObs", 1, self.OnCasterAttributeChange)
end

bs_101101.OnAfterBattleStart = function(self)
  -- function num : 0_2 , upvalues : _ENV
  LuaSkillCtrl:StartTimer(nil, (self.arglist)[1], function()
    -- function num : 0_2_0 , upvalues : self, _ENV
    if (self.caster).maxHp <= self.maxHp * (1000 + (self.arglist)[3]) // 1000 then
      LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId, 1, nil, true)
      local heal = (self.caster).skill_intensity * (self.arglist)[2] // 1000
      LuaSkillCtrl:CallHeal(heal, self, self.caster, true)
    end
  end
, self, -1)
end

bs_101101.OnCasterAttributeChange = function(self)
  -- function num : 0_3 , upvalues : _ENV
  if self.num == nil then
    self.num = 0
    self.maxHp = (self.caster).maxHp
    self.def = (self.caster).def
  end
  local change_hp = (self.caster).maxHp - self.maxHp
  if change_hp ~= 0 and (self.arglist)[4] > 0 then
    local hp = (self.caster).maxHp - self.maxHp
    if hp > 0 then
      local def_old = (self.caster).def - self.def
      ;
      (self.caster):AddRoleProperty(eHeroAttr.def, -def_old, eHeroAttrType.Extra)
      local change_def = (self.caster).maxHp * (self.arglist)[6] // (self.arglist)[5]
      ;
      (self.caster):AddRoleProperty(eHeroAttr.def, change_def, eHeroAttrType.Extra)
    else
      do
        local def_old = (self.caster).def - self.def
        ;
        (self.caster):AddRoleProperty(eHeroAttr.def, -def_old, eHeroAttrType.Extra)
      end
    end
  end
end

bs_101101.OnCasterDie = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_101101


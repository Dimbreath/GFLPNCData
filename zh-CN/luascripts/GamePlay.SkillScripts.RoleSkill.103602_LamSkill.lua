-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_1043 = class("bs_1043", LuaSkillBase)
local base = LuaSkillBase
bs_1043.config = {effectId1 = 10181, effectId2 = 10183, effectIdHit1 = 10182, effectIdHit2 = 10184, 
HurtConfig1 = {hit_formula = 0, def_formula = 9996, basehurt_formula = 10061, minhurt_formula = 9994, crit_formula = 0, crithur_ratio = 0, correct_formula = 9989, lifesteal_formula = 1001, spell_lifesteal_formula = 1002, returndamage_formula = 1000}
, 
HurtConfig2 = {hit_formula = 0, def_formula = 9996, basehurt_formula = 10061, minhurt_formula = 9994, crit_formula = 10003, crithur_ratio = 9995, correct_formula = 9989, lifesteal_formula = 1001, spell_lifesteal_formula = 1002, returndamage_formula = 1000}
, audioId1 = 113}
bs_1043.ctor = function(self)
  -- function num : 0_0
end

bs_1043.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
end

bs_1043.PlaySkill = function(self, data)
  -- function num : 0_2 , upvalues : _ENV
  LuaSkillCtrl:CallBreakAllSkill(self.caster)
  local targetList = LuaSkillCtrl:CallTargetSelect(self, 38, 10)
  if targetList ~= nil and targetList.Count > 0 and targetList[0] ~= nil then
    LuaSkillCtrl:PlayAuSource(self.caster, (self.config).audioId1)
    local attackTrigger = BindCallback(self, self.OnAttackTrigger, (targetList[0]).targetRole, data)
    ;
    (self.caster):LookAtTarget((targetList[0]).targetRole)
    self:CallCasterWait(30)
    LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, 1002, 1, 7, attackTrigger)
  end
end

bs_1043.OnAttackTrigger = function(self, target, data)
  -- function num : 0_3 , upvalues : _ENV
  self.roll = LuaSkillCtrl:CallRange(1, 1000)
  if (self.arglist)[4] > 0 then
    if self.roll <= (self.caster).crit then
      LuaSkillCtrl:CallEffect(target, (self.config).effectId2, self)
      local Callback = BindCallback(self, self.OnCallback, 1, target, data)
      LuaSkillCtrl:StartTimer(self, 5, Callback, self)
    else
      do
        LuaSkillCtrl:CallEffect(target, (self.config).effectId1, self)
        do
          local Callback = BindCallback(self, self.OnCallback, 2, target, data)
          LuaSkillCtrl:StartTimer(self, 5, Callback, self)
          LuaSkillCtrl:CallEffect(target, (self.config).effectId1, self)
          local Callback = BindCallback(self, self.OnCallback, 2, target, data)
          LuaSkillCtrl:StartTimer(self, 5, Callback, self)
        end
      end
    end
  end
end

bs_1043.OnCallback = function(self, num, target, data)
  -- function num : 0_4 , upvalues : _ENV
  local hurtpro = 1000 + target.hp * 1000 // target.maxHp * (self.arglist)[3] // (self.arglist)[2]
  if num == 1 then
    LuaSkillCtrl:CallEffect(target, (self.config).effectIdHit2, self)
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
    LuaSkillCtrl:HurtResult(skillResult, (self.config).HurtConfig2, {hurtpro})
    skillResult:EndResult()
  else
    do
      LuaSkillCtrl:CallEffect(target, (self.config).effectIdHit1, self)
      local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
      LuaSkillCtrl:HurtResult(skillResult, (self.config).HurtConfig1, {hurtpro})
      skillResult:EndResult()
    end
  end
end

bs_1043.OnCasterDie = function(self)
  -- function num : 0_5 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_1043


-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_512 = class("bs_512", bs_1)
local base = bs_1
bs_512.config = {effectId1 = 10225, effectId2 = 10226, effectId33 = 10227, effectId4 = 10228, action3 = 1021, buffId = 165, 
hurt_config = {hit_formula = 0, def_formula = 0, basehurt_formula = 10055, minhurt_formula = 9994, crit_formula = 0, crithur_ratio = 0, correct_formula = 9989, lifesteal_formula = 1001, spell_lifesteal_formula = 1002, returndamage_formula = 1000, isRealDmg = true}
, 
aoe_config = {effect_shape = 3, aoe_select_code = 5, aoe_range = 1}
}
bs_512.config = setmetatable(bs_512.config, {__index = base.config})
bs_512.ctor = function(self)
  -- function num : 0_0
end

bs_512.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
end

bs_512.RealPlaySkill = function(self, target, data)
  -- function num : 0_2 , upvalues : _ENV, base
  local Roll = ((self.caster).recordTable).Roll
  if Roll == nil then
    Roll = 0
  end
  if LuaSkillCtrl:CallRange(1, 1000) <= Roll then
    local atkSpeed = LuaSkillCtrl:CallFormulaNumber(9997, self.caster, self.caster)
    local atkSpeedRatio = 1
    local atkActionId = (self.config).action1
    local atkTriggerFrame = 0
    atkSpeedRatio = self:CalcAtkActionSpeed(atkSpeed, 1)
    atkTriggerFrame = 10
    atkActionId = (self.config).action3
    self.attackNum = self.attackNum + 1
    local attackTrigger2 = BindCallback(self, self.OnAttackTrigger2, target, data)
    local waitTime = atkSpeed - 1 - (self.rotateWaited and 3 or 0)
    if waitTime > 0 then
      self:CallCasterWait(waitTime)
    end
    LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, atkActionId, atkSpeedRatio, atkTriggerFrame, attackTrigger2)
    LuaSkillCtrl:CallEffect(target, (self.config).effectId33, self)
    LuaSkillCtrl:CallEffect(target, (self.config).effectId4, self)
  else
    do
      ;
      (base.RealPlaySkill)(self, target, data)
    end
  end
end

bs_512.OnAttackTrigger2 = function(self, target, data)
  -- function num : 0_3 , upvalues : _ENV
  LuaSkillCtrl:CallBuff(self, target, (self.config).buffId, 1, 13)
  local arg = ((self.caster).recordTable).arg
  local skillResult2 = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
  if (skillResult2.roleList).Count ~= 0 then
    LuaSkillCtrl:HurtResult(skillResult2, (self.config).hurt_config, {arg})
    skillResult2:EndResult()
  end
  local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target, (self.config).aoe_config)
  if (skillResult.roleList).Count ~= 0 then
    for i = 0, (skillResult.roleList).Count - 1 do
      local role = (skillResult.roleList)[i]
      if LuaSkillCtrl:IsRoleAdjacent(role, self.caster) then
        local attackTrigger3 = BindCallback(self, self.OnAttackTrigger3, role)
        LuaSkillCtrl:StartTimer(self, 10, attackTrigger3, nil, 0)
      end
    end
  end
  do
    skillResult:EndResult()
  end
end

bs_512.OnAttackTrigger3 = function(self, target)
  -- function num : 0_4 , upvalues : _ENV
  local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
  if (skillResult.roleList).Count ~= 0 and ((skillResult.roleList)[0]).hp > 0 then
    LuaSkillCtrl:HurtResult(skillResult)
    skillResult:EndResult()
  end
end

bs_512.OnCasterDie = function(self)
  -- function num : 0_5 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_512


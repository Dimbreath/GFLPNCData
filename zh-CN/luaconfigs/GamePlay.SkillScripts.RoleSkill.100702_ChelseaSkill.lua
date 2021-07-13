-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_100702 = class("bs_100702", LuaSkillBase)
local base = LuaSkillBase
bs_100702.config = {audioId = 42, skill_time = 31, start_time = 15, actionId = 1002, action_speed = 1, 
Aoe_base = {effect_shape = 3, aoe_select_code = 4, aoe_range = 1}
, 
Aoe_advance = {effect_shape = 3, aoe_select_code = 4, aoe_range = 2}
, 
HurtConfig = {hit_formula = 0, basehurt_formula = 10076, crit_formula = 0, crithur_ratio = 0}
, buffId_243 = 243, buffId_151 = 151, buffId_66 = 66, effectId_hit = 10017, effectId_base = 10016, effectId_advance = 10860}
bs_100702.ctor = function(self)
  -- function num : 0_0
end

bs_100702.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
end

bs_100702.PlaySkill = function(self, data)
  -- function num : 0_2 , upvalues : _ENV
  local range = nil
  if (self.arglist)[3] == 0 then
    range = (self.config).Aoe_base
    LuaSkillCtrl:CallEffect(self.caster, (self.config).effectId_base, self)
  else
    range = (self.config).Aoe_advance
    LuaSkillCtrl:CallEffect(self.caster, (self.config).effectId_advance, self)
  end
  local attackTrigger = BindCallback(self, self.OnAttackTrigger, range)
  self:CallCasterWait((self.config).skill_time)
  LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, (self.config).actionId, (self.config).action_speed, (self.config).start_time, attackTrigger)
  LuaSkillCtrl:PlayAuSource(self.caster, (self.config).audioId)
end

bs_100702.OnAttackTrigger = function(self, range)
  -- function num : 0_3 , upvalues : _ENV
  local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, self.caster, range)
  if (skillResult.roleList).Count > 0 then
    for i = 0, (skillResult.roleList).Count - 1 do
      LuaSkillCtrl:CallBuff(self, (skillResult.roleList)[i], (self.config).buffId_243, 1, (self.arglist)[2])
      LuaSkillCtrl:CallEffect((skillResult.roleList)[i], (self.config).effectId_hit, self)
      if (self.arglist)[3] > 0 and LuaSkillCtrl:IsAbleAttackTarget(self.caster, (skillResult.roleList)[i], 1) then
        local targetX = ((skillResult.roleList)[i]).x
        local targetY = ((skillResult.roleList)[i]).y
        local buffCheck = LuaSkillCtrl:CallBuff(self, (skillResult.roleList)[i], (self.config).buffId_151, 1, 3)
        if buffCheck ~= nil and ((skillResult.roleList)[i]).x == targetX and ((skillResult.roleList)[i]).y == targetY then
          LuaSkillCtrl:CallBuff(self, (skillResult.roleList)[i], (self.config).buffId_66, 1, (self.arglist)[4])
        end
      end
    end
  end
  do
    LuaSkillCtrl:HurtResult(self, skillResult, (self.config).HurtConfig)
    skillResult:EndResult()
    self:CancleCasterWait()
  end
end

bs_100702.OnCasterDie = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_100702


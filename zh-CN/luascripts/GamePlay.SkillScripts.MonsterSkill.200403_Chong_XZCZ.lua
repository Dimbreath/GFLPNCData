-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_40014 = class("bs_40014", LuaSkillBase)
local base = LuaSkillBase
bs_40014.config = {
hurt_config = {basehurt_formula = 10007}
, 
aoe_config = {effect_shape = 3, aoe_select_code = 4, aoe_range = 1}
, effectId = 10101, hitEffectId = 10100, buffId = 66, buffId2 = 151, buffTier = 1, startAnimID = 1002, audioId1 = 53}
bs_40014.ctor = function(self)
  -- function num : 0_0
end

bs_40014.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1
end

bs_40014.PlaySkill = function(self, data)
  -- function num : 0_2 , upvalues : _ENV
  LuaSkillCtrl:PlayAuSource(self.caster, (self.config).audioId1)
  local attackTrigger = BindCallback(self, self.OnAttackTrigger, self.caster, data)
  self:CallCasterWait(50)
  LuaSkillCtrl:CallEffect(self.caster, (self.config).effectId, self, nil, nil, nil, true)
  LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, (self.config).startAnimID, 1, 7, attackTrigger)
end

bs_40014.OnAttackTrigger = function(self, target, data)
  -- function num : 0_3 , upvalues : _ENV
  local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target, (self.config).aoe_config)
  LuaSkillCtrl:HurtResult(skillResult, (self.config).hurt_config)
  skillResult:BuffResult((self.config).buffId, (self.config).buffTier, (self.arglist)[2])
  skillResult:BuffResult((self.config).buffId2, (self.config).buffTier, 3)
  if (skillResult.roleList).Count > 0 then
    for i = 0, (skillResult.roleList).Count - 1 do
      local role = (skillResult.roleList)[i]
      LuaSkillCtrl:CallEffect(role, (self.config).hitEffectId, self)
    end
  end
  do
    skillResult:EndResult()
  end
end

bs_40014.OnCasterDie = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_40014


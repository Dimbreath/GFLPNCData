-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_1045 = class("bs_1045", LuaSkillBase)
local base = LuaSkillBase
bs_1045.config = {buffId1 = 145, buffId2 = 146, effectId = 10188, effecthitId = 10189, effectId2 = 10190, 
aoe_config = {effect_shape = 3, aoe_select_code = 5, aoe_range = 1}
, 
HurtConfig = {def_formula = 9996, basehurt_formula = 10031, minhurt_formula = 9994, correct_formula = 9989, spell_lifesteal_formula = 1002, returndamage_formula = 1000}
}
bs_1045.ctor = function(self)
  -- function num : 0_0
end

bs_1045.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
end

bs_1045.PlaySkill = function(self, data)
  -- function num : 0_2 , upvalues : _ENV
  local targetList = LuaSkillCtrl:CallTargetSelect(self, 1001, 10)
  if targetList ~= nil and targetList.Count > 0 and targetList[0] ~= nil then
    local attackTrigger = BindCallback(self, self.OnAttackTrigger, (targetList[0]).targetRole, data)
    ;
    (self.caster):LookAtTarget((targetList[0]).targetRole)
    self:CallCasterWait(30)
    LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, 1002, 1, 12, attackTrigger)
  end
end

bs_1045.OnAttackTrigger = function(self, target, data)
  -- function num : 0_3 , upvalues : _ENV
  LuaSkillCtrl:CallEffect(target, (self.config).effectId, self, self.SkillEventFunc)
  if (self.arglist)[2] > 0 then
    LuaSkillCtrl:StartTimer(self, 5, function()
    -- function num : 0_3_0 , upvalues : _ENV, self
    LuaSkillCtrl:CallRoleAction(self.caster, 1007)
    local grid = LuaSkillCtrl:FindEmptyGridWithinRange(self.caster, 2)
    if grid ~= nil then
      LuaSkillCtrl:CallPhaseMove(self, self.caster, grid.x, grid.y, 6, 69)
    end
  end
)
    LuaSkillCtrl:StartTimer(self, 6, function()
    -- function num : 0_3_1 , upvalues : _ENV, self
    LuaSkillCtrl:CallRoleAction(self.caster, 1009)
    local targetList = LuaSkillCtrl:CallTargetSelect(self, 1001, 10)
    ;
    (self.caster):LookAtTarget((targetList[0]).targetRole)
  end
)
  end
end

bs_1045.SkillEventFunc = function(self, effect, eventId, target)
  -- function num : 0_4 , upvalues : _ENV
  if eventId == eBattleEffectEvent.Trigger then
    LuaSkillCtrl:CallEffect(target, (self.config).effectId2, self)
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target, (self.config).aoe_config)
    LuaSkillCtrl:HurtResult(skillResult, (self.config).HurtConfig)
    skillResult:EndResult()
  end
end

bs_1045.OnCasterDie = function(self)
  -- function num : 0_5 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_1045


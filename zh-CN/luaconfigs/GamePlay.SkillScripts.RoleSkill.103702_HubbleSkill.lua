-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_103702 = class("bs_103702", LuaSkillBase)
local base = LuaSkillBase
bs_103702.config = {effectId_start = 10329, effectId_skill = 10330, effectId_ex_skill = 10801, selectId_1 = 15, selectRange_1 = 20, selectId_2 = 19, selectRange_2 = 20, 
HurtConfig1 = {hit_formula = 0, def_formula = 0, basehurt_formula = 10076, crit_formula = 0, crithur_ratio = 0}
, 
HurtConfig2 = {hit_formula = 0, def_formula = 0, basehurt_formula = 10078, crit_formula = 0, crithur_ratio = 0, lifesteal_formula = 0, spell_lifesteal_formula = 0, returndamage_formula = 0}
, 
HurtConfig_aoe = {hit_formula = 0, def_formula = 0, basehurt_formula = 502, crit_formula = 0, crithur_ratio = 0, lifesteal_formula = 0, spell_lifesteal_formula = 0, returndamage_formula = 0}
, 
Aoe = {effect_shape = 3, aoe_select_code = 4, aoe_range = 1}
, skill_ex_time = 10}
bs_103702.ctor = function(self)
  -- function num : 0_0
end

bs_103702.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_103702_3", 1, self.OnAfterHurt, self.caster, nil, nil, nil, nil, nil, 103702)
  self.mainTarget = nil
end

bs_103702.OnAfterHurt = function(self, sender, target, skill, hurt, isMiss, isCrit, isRealDmg, isTriggerSet)
  -- function num : 0_2 , upvalues : _ENV
  if sender == self.caster and target == self.mainTarget and not isMiss and skill.dataId == 103702 and not isRealDmg and target.belongNum ~= (self.caster).belongNum and hurt > 0 then
    local realHurt = hurt * (self.arglist)[2] // 1000
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target, (self.config).Aoe)
    for i = 0, (skillResult.roleList).Count - 1 do
      local role = (skillResult.roleList)[i]
      local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, role)
      LuaSkillCtrl:PlayAuHit(self, target)
      LuaSkillCtrl:HurtResult(self, skillResult, (self.config).HurtConfig_aoe, {realHurt}, true, true)
      skillResult:EndResult()
    end
    skillResult:EndResult()
    self.mainTarget = nil
  end
end

bs_103702.PlaySkill = function(self, data)
  -- function num : 0_3 , upvalues : _ENV
  local targetList = LuaSkillCtrl:CallTargetSelect(self, (self.config).selectId_1, (self.config).selectRange_1)
  if targetList.Count <= 0 then
    return 
  end
  self:CallCasterWait(15)
  local attackTrigger = BindCallback(self, self.OnAttackTrigger, (targetList[0]).targetRole)
  ;
  (self.caster):LookAtTarget((targetList[0]).targetRole)
  LuaSkillCtrl:CallEffect(self.caster, (self.config).effectId_start, self)
  LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, 1002, 2, 7, attackTrigger)
end

bs_103702.OnAttackTrigger = function(self, target)
  -- function num : 0_4 , upvalues : _ENV
  self.mainTarget = target
  LuaSkillCtrl:CallEffect(target, (self.config).effectId_skill, self, self.SkillEventFunc)
  if (self.arglist)[4] > 0 then
    for i = 1, ((self.caster).recordTable).X_num do
      LuaSkillCtrl:StartTimer(self, i * 3, function()
    -- function num : 0_4_0 , upvalues : _ENV, self
    local targetList = LuaSkillCtrl:CallTargetSelect(self, (self.config).selectId_2, (self.config).selectRange_2)
    if targetList.Count > 0 and (targetList[0]).targetRole ~= nil then
      LuaSkillCtrl:CallEffect((targetList[0]).targetRole, (self.config).effectId_ex_skill, self, self.SkillEventFunc1)
    end
  end
, nil)
    end
  end
end

bs_103702.SkillEventFunc = function(self, effect, eventId, target)
  -- function num : 0_5 , upvalues : _ENV
  if eventId == eBattleEffectEvent.Trigger then
    LuaSkillCtrl:StartTimer(self, 11, function()
    -- function num : 0_5_0 , upvalues : _ENV, self, target
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
    LuaSkillCtrl:PlayAuHit(self, target)
    LuaSkillCtrl:HurtResult(self, skillResult, (self.config).HurtConfig1)
    skillResult:EndResult()
  end
, nil)
  end
end

bs_103702.SkillEventFunc1 = function(self, effect, eventId, target)
  -- function num : 0_6 , upvalues : _ENV
  if eventId == eBattleEffectEvent.Trigger then
    LuaSkillCtrl:StartTimer(self, (self.config).skill_ex_time, function()
    -- function num : 0_6_0 , upvalues : _ENV, self, target
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
    LuaSkillCtrl:HurtResult(self, skillResult, (self.config).HurtConfig2, nil, true)
    skillResult:EndResult()
  end
, nil)
  end
end

bs_103702.LuaDispose = function(self)
  -- function num : 0_7 , upvalues : base
  (base.LuaDispose)(self)
  self.mainTarget = nil
end

bs_103702.OnCasterDie = function(self)
  -- function num : 0_8 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_103702


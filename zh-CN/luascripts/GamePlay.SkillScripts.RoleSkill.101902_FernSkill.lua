-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_201902 = class("bs_201902", LuaSkillBase)
local base = LuaSkillBase
bs_201902.config = {action = 1020, effectId = 10688, buffId = 223, buffId2 = 66, effectId_fly = 10690, 
HurtConfig = {hit_formula = 0, basehurt_formula = 10076, crit_formula = 0, crithur_ratio = 0}
, 
Aoe = {effect_shape = 3, aoe_select_code = 5, aoe_range = 1}
, buffId_fly = 237}
bs_201902.ctor = function(self)
  -- function num : 0_0
end

bs_201902.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
end

bs_201902.PlaySkill = function(self, data)
  -- function num : 0_2 , upvalues : _ENV
  local last_target = ((self.caster).recordTable).lastComAttackRole
  local target = nil
  if last_target ~= nil and last_target.hp > 0 and last_target.intensity ~= 0 then
    target = last_target
  else
    local targetList = LuaSkillCtrl:CallTargetSelect(self, 33, 10)
    if targetList.Count > 0 then
      target = (targetList[0]).targetRole
    end
  end
  do
    if target ~= nil then
      local attackTrigger = BindCallback(self, self.OnAttackTrigger, target)
      ;
      (self.caster):LookAtTarget(target)
      self:CallCasterWait(30)
      LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, 1020, 1, 13, attackTrigger)
    end
  end
end

bs_201902.OnAttackTrigger = function(self, target)
  -- function num : 0_3 , upvalues : _ENV
  if LuaSkillCtrl:RoleContainsBuffFeature(target, eBuffFeatureType.CtrlImmunity) == false then
    LuaSkillCtrl:CallEffect(target, (self.config).effectId_fly, self)
  end
  LuaSkillCtrl:StartTimer(nil, 16, function()
    -- function num : 0_3_0 , upvalues : _ENV, target, self
    if LuaSkillCtrl:RoleContainsBuffFeature(target, 15) == false then
      LuaSkillCtrl:CallBuff(self, target, (self.config).buffId, 1, 20, true)
      local target2 = (LuaSkillCtrl:CallTargetSelect(self, 21, 10))
      local grid = nil
      LuaSkillCtrl:StartTimer(nil, 20, function()
      -- function num : 0_3_0_0 , upvalues : _ENV, target, self
      LuaSkillCtrl:CallEffect(target, (self.config).effectId, self, self.SkillEventFunc)
    end
)
      if target2.Count > 0 and (target2[0]).targetRole == target then
        return 
      end
      if target2.Count > 0 and (target2[0]).targetRole ~= target then
        grid = LuaSkillCtrl:FindEmptyGridWithoutEfcGridAroundRole((target2[0]).targetRole)
      end
      if grid ~= nil and target.hp > 0 then
        LuaSkillCtrl:CallPhaseMove(self, target, grid.x, grid.y, 20, 69)
      end
    end
  end
)
end

bs_201902.SkillEventFunc = function(self, effect, eventId, target)
  -- function num : 0_4 , upvalues : _ENV
  if eventId == eBattleEffectEvent.Create then
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target, (self.config).Aoe)
    do
      if (self.arglist)[3] >= 0 then
        skillResult:BuffResult((self.config).buffId2, 1, (self.arglist)[2])
      else
        LuaSkillCtrl:CallBuff(self, target.targetRole, (self.config).buffId2, 1, (self.arglist)[2])
      end
      LuaSkillCtrl:StartTimer(nil, 3, function()
    -- function num : 0_4_0 , upvalues : _ENV, skillResult, self
    LuaSkillCtrl:HurtResult(skillResult, (self.config).HurtConfig)
    skillResult:EndResult()
  end
)
    end
  end
end

bs_201902.OnCasterDie = function(self)
  -- function num : 0_5 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_201902


-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_40012 = class("bs_40012", LuaSkillBase)
local base = LuaSkillBase
bs_40012.config = {
hurt_config = {basehurt_formula = 10007}
, 
aoe_config = {effect_shape = 3, aoe_select_code = 5, aoe_range = 1}
, effectId = 10117, effectId1 = 10118, audioId1 = 55}
bs_40012.ctor = function(self)
  -- function num : 0_0
end

bs_40012.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
end

bs_40012.PlaySkill = function(self, data)
  -- function num : 0_2 , upvalues : _ENV
  if (self.config).audioId1 ~= nil then
    ((self.caster).auSource):PlayAudioById((self.config).audioId1)
  end
  if ((self.caster).recordTable).lastAttackRole ~= nil then
    if LuaSkillCtrl:IsAbleAttackTarget(self.caster, ((self.caster).recordTable).lastAttackRole, 1) then
      self:CallCasterWait(23)
      ;
      (self.caster):LookAtTarget(((self.caster).recordTable).lastAttackRole)
      LuaSkillCtrl:CallRoleAction(self.caster, 1002, 1)
      LuaSkillCtrl:CallEffect(((self.caster).recordTable).lastAttackRole, (self.config).effectId, self, self.SkillEventFunc, nil, 1)
    else
      self:BreakSkill()
    end
  else
    local targetlist = LuaSkillCtrl:CallTargetSelect(self, 1001, 0)
    if targetlist.Count > 0 then
      if LuaSkillCtrl:IsAbleAttackTarget(self.caster, (targetlist[0]).targetRole, 1) then
        self:CallCasterWait(23)
        ;
        (self.caster):LookAtTarget(targetlist[0])
        LuaSkillCtrl:CallRoleAction(self.caster, 1002, 1)
        LuaSkillCtrl:CallEffect(targetlist[0], (self.config).effectId, self, self.SkillEventFunc, nil, 1)
      else
        self:BreakSkill()
      end
    end
  end
end

bs_40012.SkillEventFunc = function(self, effect, eventId, target)
  -- function num : 0_3 , upvalues : _ENV
  if eventId == eBattleEffectEvent.Trigger then
    local skillResult = LuaSkillCtrl:CallSkillResult(effect, target, (self.config).aoe_config)
    if (skillResult.roleList).Count ~= 0 then
      for i = 0, (skillResult.roleList).Count - 1 do
        local role = (skillResult.roleList)[i]
        do
          if LuaSkillCtrl:IsRoleAdjacent(role, self.caster) then
            LuaSkillCtrl:StartTimer(self, 11, function()
    -- function num : 0_3_0 , upvalues : _ENV, role, self
    LuaSkillCtrl:CallEffect(role, (self.config).effectId1, self, self.HurtFunc, nil, 1, true)
  end
, nil, 0)
          end
        end
      end
    end
    do
      skillResult:EndResult()
    end
  end
end

bs_40012.HurtFunc = function(self, effect, eventId, target)
  -- function num : 0_4 , upvalues : _ENV
  if eventId == eBattleEffectEvent.Trigger then
    local skillResult = LuaSkillCtrl:CallSkillResult(effect, target)
    LuaSkillCtrl:HurtResult(skillResult, (self.config).hurt_config)
    skillResult:EndResult()
  end
end

bs_40012.OnCasterDie = function(self)
  -- function num : 0_5 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_40012


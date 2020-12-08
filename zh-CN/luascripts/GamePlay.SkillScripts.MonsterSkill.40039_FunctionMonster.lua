-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_40039 = class("bs_40039", LuaSkillBase)
local base = LuaSkillBase
bs_40039.config = {
hurt_config = {basehurt_formula = 9988}
, hpBuffId = 1003, atkBuffId = 1030, fqBuffId = 1064, mAtkBuufId = 1038, mFQBuffId = 1073, effectId = 10170, startAnimID = 1020, audioId1 = 56}
bs_40039.ctor = function(self)
  -- function num : 0_0
end

bs_40039.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.SetHurt, "bs_40039_2", 1, self.OnSetHurt)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_40039_1", 1, self.OnAfterBattleStart)
end

bs_40039.OnAfterBattleStart = function(self)
  -- function num : 0_2 , upvalues : _ENV
  LuaSkillCtrl:CallBuff(self, self.caster, (self.config).atkBuffId, 0)
  LuaSkillCtrl:CallBuff(self, self.caster, (self.config).fqBuffId, 0)
  LuaSkillCtrl:CallBuff(self, self.caster, (self.config).mAtkBuufId, 0)
  LuaSkillCtrl:CallBuff(self, self.caster, (self.config).mFQBuffId, 0)
  LuaSkillCtrl:CallBuff(self, self.caster, (self.config).hpBuffId, 10000)
  LuaSkillCtrl:CallHeal((self.caster).maxHp, self, self.caster)
  local arriveCallBack = BindCallback(self, self.OnArriveAction)
  LuaSkillCtrl:StartTimer(nil, 600, arriveCallBack)
end

bs_40039.OnArriveAction = function(self)
  -- function num : 0_3 , upvalues : _ENV
  local targetList = LuaSkillCtrl:CallTargetSelect(self, 9, 10)
  if targetList.Count == 0 then
    return 
  end
  for i = 0, targetList.Count - 1 do
    LuaSkillCtrl:RemoveLife(99999, self, (targetList[i]).targetRole, true, true)
  end
end

bs_40039.PlaySkill = function(self, data)
  -- function num : 0_4 , upvalues : _ENV
  self.attackTime = 6
  LuaSkillCtrl:CallBreakAllSkill(self.caster)
  LuaSkillCtrl:CallRoleAction(self.caster, 1020)
  self:CallCasterWait(28)
  local moveAttackTrigger = BindCallback(self, self.OnMoveAttackTrigger, target, data)
  LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, (self.config).startAnimID, 1, 13, moveAttackTrigger)
end

bs_40039.OnMoveAttackTrigger = function(self, target, data)
  -- function num : 0_5 , upvalues : _ENV
  if (self.config).audioId1 ~= nil then
    ((self.caster).auSource):PlayAudioById((self.config).audioId1)
  end
  local targetList = LuaSkillCtrl:CallTargetSelect(self, 9, 10)
  if targetList.Count == 0 then
    return 
  end
  while self.attackTime ~= 0 do
    for i = 0, targetList.Count - 1 do
      if (targetList[i]).targetRole ~= nil then
        LuaSkillCtrl:CallEffect((targetList[i]).targetRole, (self.config).effectId, self, self.SkillEventFunc)
        self.attackTime = self.attackTime - 1
      end
    end
  end
  do
    if self.attackTime > 0 then
      LuaSkillCtrl:CallBuff(self, self.caster, (self.config).atkBuffId, 0)
      LuaSkillCtrl:CallBuff(self, self.caster, (self.config).fqBuffId, 0)
      LuaSkillCtrl:CallBuff(self, self.caster, (self.config).mAtkBuufId, 0)
      LuaSkillCtrl:CallBuff(self, self.caster, (self.config).mFQBuffId, 0)
    end
  end
end

bs_40039.SkillEventFunc = function(self, effect, eventId, target)
  -- function num : 0_6 , upvalues : _ENV
  if eventId == eBattleEffectEvent.Trigger then
    local skillResult = LuaSkillCtrl:CallSkillResult(effect, target)
    LuaSkillCtrl:HurtResult(skillResult, (self.config).hurt_config)
    skillResult:EndResult()
  end
end

bs_40039.OnSetHurt = function(self, context)
  -- function num : 0_7
  if context.sender == self.caster then
    if (context.target).attackRange > 1 then
      context.hurt = context.hurt * 800 // 1000
    else
      context.hurt = context.hurt * 1200 // 1000
    end
  end
end

bs_40039.OnCasterDie = function(self)
  -- function num : 0_8 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_40039


local bs_305 = class("bs_305", LuaSkillBase)
local base = LuaSkillBase
bs_305.config = {effectId = 10137, buffId = 66}
bs_305.ctor = function(self)
  -- function num : 0_0
end

bs_305.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
end

bs_305.PlaySkill = function(self, data)
  -- function num : 0_2 , upvalues : _ENV
  self.monsterRecord = {}
  local targetListall = LuaSkillCtrl:CallTargetSelect(self, 9, 10)
  if targetListall.Count == 0 then
    return 
  end
  for i = 0, targetListall.Count - 1 do
    -- DECOMPILER ERROR at PC20: Confused about usage of register: R7 in 'UnsetPending'

    (self.monsterRecord)[(targetListall[i]).targetRole] = 0
  end
  local targetList = LuaSkillCtrl:CallTargetSelect(self, 1001, 10)
  if targetList.Count == 0 then
    return 
  end
  ;
  (self.caster):LookAtTarget((targetList[0]).targetRole)
  self:CallCasterWait(30)
  local attackTrigger = BindCallback(self, self.OnAttackTrigger, (targetList[0]).targetRole, data)
  LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, 1002, 1, 20, attackTrigger)
end

bs_305.OnAttackTrigger = function(self, target, data)
  -- function num : 0_3 , upvalues : _ENV
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R3 in 'UnsetPending'

  ((self.caster).recordTable)["305_Time"] = 4
  LuaSkillCtrl:CallEffectWithArgOverride(target, (self.config).effectId, self, nil, true, false, self.SkillEventFunc)
end

bs_305.SkillEventFunc = function(self, effect, eventId, target)
  -- function num : 0_4 , upvalues : _ENV
  if effect.dataId == (self.config).effectId and eventId == eBattleEffectEvent.Trigger and ((self.caster).recordTable)["305_Time"] > 0 then
    local hurt = (self.caster).pow * ((self.arglist)[1] - (self.arglist)[2] * ((self.arglist)[4] - ((self.caster).recordTable)["305_Time"])) // 1000
    LuaSkillCtrl:RemoveLife(hurt, self, target)
    if ((self.caster).recordTable)["305_Time"] == (self.arglist)[4] and (self.arglist)[3] >= 0 then
      LuaSkillCtrl:CallBuff(self, target.targetRole, 66, 1, 15)
    end
    -- DECOMPILER ERROR at PC61: Confused about usage of register: R5 in 'UnsetPending'

    ;
    ((self.caster).recordTable)["305_Time"] = ((self.caster).recordTable)["305_Time"] - 1
    -- DECOMPILER ERROR at PC68: Confused about usage of register: R5 in 'UnsetPending'

    ;
    (self.monsterRecord)[target.targetRole] = (self.monsterRecord)[target.targetRole] + 1
    local targetList = LuaSkillCtrl:CallTargetSelect(self, 34, 2, target.targetRole)
    if targetList.Count == 0 then
      return 
    end
    local targetRole = nil
    for i = 0, targetList.Count - 1 do
      if (self.monsterRecord)[(targetList[i]).targetRole] < 2 then
        targetRole = (targetList[i]).targetRole
        break
      end
    end
    do
      if targetRole ~= nil then
        LuaSkillCtrl:CallEffectWithArgOverride(targetRole, (self.config).effectId, self, target.targetRole, true, false, self.SkillEventFunc)
      end
    end
  end
end

bs_305.OnCasterDie = function(self)
  -- function num : 0_5 , upvalues : base
  (base.OnCasterDie)(self)
end

bs_305.LuaDispose = function(self)
  -- function num : 0_6 , upvalues : base
  (base.LuaDispose)(self)
  self.monsterRecord = nil
end

return bs_305


-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_1035 = class("bs_1035", LuaSkillBase)
local base = LuaSkillBase
local ShieldSkillBase = require("GamePlay.SkillScripts.BaseSkill.ShieldSkillBase")
bs_1035.config = {buffId = 114, buffId2 = 67, effectCFId = 123, effectstartId = 10067, effectendId = 10068, effectHit1 = 10071, effectHit2 = 10072, effectHit3 = 10073, effectHit4 = 10074, effectHit5 = 10075, effectHit6 = 10076, effectHit7 = 10077, effectHit8 = 10078, effectHit9 = 10079, effectHit10 = 10080, audioId1 = 33, audioId2 = 34, audioId3 = 35, shieldKey = "1035_HuDun", shieldFormula = 10087, buffId196 = 196}
bs_1035.ctor = function(self)
  -- function num : 0_0
end

bs_1035.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddSelfTrigger(eSkillTriggerType.SetHurt, "bs_1035_2", 30, self.OnSetHurt)
  self:AddTrigger(eSkillTriggerType.BeforeBattleEnd, "bs_1035_3", 1, self.BeforeEndBattle)
  -- DECOMPILER ERROR at PC22: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.caster).recordTable)[(self.config).shieldKey] = 0
end

bs_1035.PlaySkill = function(self, data)
  -- function num : 0_2 , upvalues : _ENV
  local arg4 = (self.arglist)[4]
  local bufftime = 15 + arg4
  LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId196, 1, bufftime, true)
  self.loop = nil
  local skilltime = 15 + arg4 + 10
  self:CallCasterWait(skilltime)
  local attackTrigger = BindCallback(self, self.OnAttackTrigger, data)
  LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, 1002, 1, 9, attackTrigger)
end

bs_1035.OnAttackTrigger = function(self, data)
  -- function num : 0_3 , upvalues : _ENV, ShieldSkillBase
  self.OnaudioLoop = BindCallback(self, self.audioLoop)
  LuaSkillCtrl:PlayAuSource(self.caster, (self.config).audioId1)
  LuaSkillCtrl:StartTimer(self, 5, self.audioLoop, self)
  LuaSkillCtrl:CallEffect(self.caster, (self.config).effectCFId, self, nil, nil, nil, true)
  local bufftime = (self.arglist)[4]
  if (self.arglist)[5] > 0 then
    local targetList = LuaSkillCtrl:CallTargetSelect(self, 9, 10)
    if targetList.Count > 0 then
      for i = 0, targetList.Count - 1 do
        LuaSkillCtrl:CallBuff(self, (targetList[i]).targetRole, (self.config).buffId2, 1, bufftime)
      end
    end
  end
  do
    LuaSkillCtrl:CallBuff(self, self.caster, 114, 1, bufftime, true)
    LuaSkillCtrl:CallRoleAction(self.caster, 1007)
    local shieldValue = LuaSkillCtrl:CallFormulaNumberWithSkill((self.config).shieldFormula, self.caster, nil, self)
    if shieldValue > 0 then
      (ShieldSkillBase.UpdateShieldView)(self.caster, (self.config).shieldKey, shieldValue)
      self.hudunEffect = LuaSkillCtrl:CallEffect(self.caster, (self.config).effectstartId, self, nil, nil, nil, true)
    end
    LuaSkillCtrl:StartTimer(nil, bufftime, function()
    -- function num : 0_3_0 , upvalues : self, ShieldSkillBase, _ENV
    if ((self.caster).recordTable)[(self.config).shieldKey] > 0 then
      (ShieldSkillBase.ClearShieldType)(self.caster, (self.config).shieldKey)
      if self.loop ~= nil then
        AudioManager:StopAudioByBack(self.loop)
        self.loop = nil
      end
      LuaSkillCtrl:CallEffect(self.caster, 10068, self)
      if self.hudunEffect ~= nil then
        (self.hudunEffect):Die()
        self.hudunEffect = nil
      end
      LuaSkillCtrl:CallRoleAction(self.caster, 100)
      LuaSkillCtrl:DispelBuff(self.caster, 114, 0, true)
      LuaSkillCtrl:DispelBuff(self.caster, (self.config).buffId196, 0, true)
      local targetList = LuaSkillCtrl:CallTargetSelect(self, 9, 10)
      for i = 0, targetList.Count - 1 do
        LuaSkillCtrl:DispelBuff((targetList[i]).targetRole, (self.config).buffId2, 1)
      end
      self:CancleCasterWait()
    end
  end
, self)
  end
end

bs_1035.audioLoop = function(self)
  -- function num : 0_4 , upvalues : _ENV
  if ((self.caster).recordTable)[(self.config).shieldKey] > 0 then
    self.loop = LuaSkillCtrl:PlayAuSource(self.caster, (self.config).audioId2)
  end
end

bs_1035.OnSetHurt = function(self, context)
  -- function num : 0_5 , upvalues : _ENV, ShieldSkillBase
  if context.target == self.caster and ((self.caster).recordTable)[(self.config).shieldKey] > 0 then
    local roll = LuaSkillCtrl:CallRange(1, 10)
    local roleeffect = (self.config)["effectHit" .. tostring(roll)]
    LuaSkillCtrl:PlayAuSource(self.caster, (self.config).audioId3)
    LuaSkillCtrl:CallEffect(self.caster, roleeffect, self)
    local retHurt = (ShieldSkillBase.ShieldBaseFunc)(context.hurt, self.caster, (self.config).shieldKey)
    -- DECOMPILER ERROR at PC52: Confused about usage of register: R5 in 'UnsetPending'

    if (self.arglist)[3] > 0 then
      ((self.caster).recordTable)["1035_fanshang"] = context.hurt * (self.arglist)[2] // 1000
      -- DECOMPILER ERROR at PC60: Confused about usage of register: R5 in 'UnsetPending'

      if ((self.caster).recordTable)["1035_fanshang"] <= 0 then
        ((self.caster).recordTable)["1035_fanshang"] = 1
      end
      local hurt = ((self.caster).recordTable)["1035_fanshang"]
      LuaSkillCtrl:RemoveLife(hurt, self, context.sender, false, true)
    end
    do
      context.hurt = retHurt
      LuaSkillCtrl:CallFloatText(self.caster, 7)
      if ((self.caster).recordTable)[(self.config).shieldKey] <= 0 then
        if self.loop ~= nil then
          AudioManager:StopAudioByBack(self.loop)
        end
        LuaSkillCtrl:CallEffect(self.caster, 10068, self)
        if self.hudunEffect ~= nil then
          (self.hudunEffect):Die()
          self.hudunEffect = nil
        end
        LuaSkillCtrl:CallRoleAction(self.caster, 100)
        LuaSkillCtrl:DispelBuff(self.caster, 114, 1, true)
        LuaSkillCtrl:DispelBuff(self.caster, (self.config).buffId196, 0, true)
        local targetList = LuaSkillCtrl:CallTargetSelect(self, 9, 10)
        for i = 0, targetList.Count - 1 do
          LuaSkillCtrl:DispelBuff((targetList[i]).targetRole, (self.config).buffId2, 1, true)
        end
        self:CancleCasterWait()
      end
    end
  end
end

bs_1035.BeforeEndBattle = function(self)
  -- function num : 0_6 , upvalues : _ENV
  if self.loop ~= nil then
    AudioManager:StopAudioByBack(self.loop)
    self.loop = nil
  end
end

bs_1035.OnCasterDie = function(self)
  -- function num : 0_7 , upvalues : base, _ENV
  (base.OnCasterDie)(self)
  local targetList = LuaSkillCtrl:CallTargetSelect(self, 9, 10)
  for i = 0, targetList.Count - 1 do
    LuaSkillCtrl:DispelBuff((targetList[i]).targetRole, (self.config).buffId2, 1)
  end
end

return bs_1035


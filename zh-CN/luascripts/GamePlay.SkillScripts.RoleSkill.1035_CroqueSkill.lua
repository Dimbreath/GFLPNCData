-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_1035 = class("bs_1035", LuaSkillBase)
local base = LuaSkillBase
bs_1035.config = {buffId = 114, buffId2 = 67, effectCFId = 123, effectstartId = 10067, effectendId = 10068, effectHit1 = 10071, effectHit2 = 10072, effectHit3 = 10073, effectHit4 = 10074, effectHit5 = 10075, effectHit6 = 10076, effectHit7 = 10077, effectHit8 = 10078, effectHit9 = 10079, effectHit10 = 10080, audioId1 = 33, audioId2 = 34, audioId3 = 35}
bs_1035.ctor = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self.OnaudioLoop = BindCallback(self, self.audioLoop)
end

bs_1035.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
end

bs_1035.PlaySkill = function(self, data)
  -- function num : 0_2 , upvalues : _ENV
  self.loop = nil
  LuaSkillCtrl:CallBuff(self, self.caster, 114, 1)
  self:CallCasterWait(15)
  local attackTrigger = BindCallback(self, self.OnAttackTrigger, data)
  LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, 1002, 1, 11, attackTrigger)
end

bs_1035.OnAttackTrigger = function(self, data)
  -- function num : 0_3 , upvalues : _ENV
  ((self.caster).auSource):PlayAudioById((self.config).audioId1)
  LuaSkillCtrl:StartTimer(self, 5, self.audioLoop, self)
  LuaSkillCtrl:CallEffect(self.caster, (self.config).effectCFId, self)
  -- DECOMPILER ERROR at PC22: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.caster).recordTable)["1035_Realhurt"] = 0
  local targetList = LuaSkillCtrl:CallTargetSelect(self, 9, 10)
  for i = 0, targetList.Count - 1 do
    LuaSkillCtrl:CallBuff(self, (targetList[i]).targetRole, (self.config).buffId2, 1)
  end
  LuaSkillCtrl:CallRoleAction(self.caster, 1007)
  -- DECOMPILER ERROR at PC57: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.caster).recordTable)["1035_HuDun"] = (self.caster).maxHp * (self.arglist)[1] // 1000
  if ((self.caster).recordTable)["1035_HuDun"] > 0 then
    self.hudunEffect = LuaSkillCtrl:CallEffect(self.caster, (self.config).effectstartId, self, nil, nil, nil, nil)
    self:AddTrigger(eSkillTriggerType.SetHurt, "bs_1035_2", 1, self.OnSetHurt)
  end
  LuaSkillCtrl:StartTimer(self, (self.arglist)[4], function()
    -- function num : 0_3_0 , upvalues : self
    -- DECOMPILER ERROR at PC7: Confused about usage of register: R0 in 'UnsetPending'

    if ((self.caster).recordTable)["1035_HuDun"] > 0 then
      ((self.caster).recordTable)["1035_HuDun"] = 0
    end
  end
, self, 1)
end

bs_1035.audioLoop = function(self)
  -- function num : 0_4
  self.loop = ((self.caster).auSource):PlayAudioById((self.config).audioId2)
end

bs_1035.OnSetHurt = function(self, context)
  -- function num : 0_5 , upvalues : _ENV
  if context.target == self.caster and ((self.caster).recordTable)["1035_HuDun"] > 0 then
    local roll = LuaSkillCtrl:CallRange(1, 10)
    local roleeffect = (self.config)["effectHit" .. tostring(roll)]
    ;
    ((self.caster).auSource):PlayAudioById((self.config).audioId3)
    LuaSkillCtrl:CallEffect(self.caster, roleeffect, self, nil, nil, nil, nil)
    -- DECOMPILER ERROR at PC41: Confused about usage of register: R4 in 'UnsetPending'

    ;
    ((self.caster).recordTable)["1035_HuDun"] = ((self.caster).recordTable)["1035_HuDun"] - context.hurt
    -- DECOMPILER ERROR at PC49: Confused about usage of register: R4 in 'UnsetPending'

    ;
    ((self.caster).recordTable)["1035_fanshang"] = context.hurt * (self.arglist)[2] // 1000
    -- DECOMPILER ERROR at PC57: Confused about usage of register: R4 in 'UnsetPending'

    if ((self.caster).recordTable)["1035_fanshang"] <= 0 then
      ((self.caster).recordTable)["1035_fanshang"] = 1
    end
    do
      do
        if (self.arglist)[3] > 0 then
          local hurt = ((self.caster).recordTable)["1035_fanshang"]
          LuaSkillCtrl:RemoveLife(hurt, self, context.sender)
        end
        -- DECOMPILER ERROR at PC75: Confused about usage of register: R4 in 'UnsetPending'

        ;
        ((self.caster).recordTable)["1035_Realhurt"] = context.hurt * 1
        context.hurt = 0
        LuaSkillCtrl:CallFloatText(self.caster, 7)
        if ((self.caster).recordTable)["1035_HuDun"] <= ((self.caster).recordTable)["1035_Realhurt"] then
          if self.loop ~= nil then
            AudioManager:StopAudioByBack(self.loop)
          end
          LuaSkillCtrl:CallEffect(self.caster, 10068, self, nil, nil, nil, nil)
          if self.hudunEffect ~= nil then
            (self.hudunEffect):Die()
            self.hudunEffect = nil
            LuaSkillCtrl:CallRoleAction(self.caster, 100)
          end
          LuaSkillCtrl:RemoveTrigger(self, eSkillTriggerType.SetHurt)
          LuaSkillCtrl:DispelBuff(self.caster, 114, 0)
          local targetList = LuaSkillCtrl:CallTargetSelect(self, 9, 10)
          for i = 0, targetList.Count - 1 do
            LuaSkillCtrl:DispelBuff((targetList[i]).targetRole, (self.config).buffId2, 1)
          end
        end
      end
    end
  end
end

bs_1035.OnCasterDie = function(self)
  -- function num : 0_6 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_1035


-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_1047 = class("bs_1047", LuaSkillBase)
local base = LuaSkillBase
bs_1047.config = {selectId = 6, buffId = 148, effectId = 10198, actionId = 1002, audioId1 = 70}
bs_1047.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_0 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
  if (self.arglist)[4] > 0 then
    self.buffTier = 2
  else
    self.buffTier = 1
  end
end

bs_1047.PlaySkill = function(self, data)
  -- function num : 0_1 , upvalues : _ENV
  self:CallCasterWait(36)
  local targets = LuaSkillCtrl:CallTargetSelect(self, (self.config).selectId, 20)
  if targets.Count > 0 then
    local skillActionTrigger = BindCallback(self, self.ActionCallBack, targets)
    ;
    ((self.caster).auSource):PlayAudioById((self.config).audioId1)
    LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, (self.config).actionId, 2, 12, skillActionTrigger)
  end
end

bs_1047.ActionCallBack = function(self, targets)
  -- function num : 0_2 , upvalues : _ENV
  LuaSkillCtrl:CallEffect(self.caster, (self.config).effectId, self)
  for i = 0, targets.Count - 1 do
    -- DECOMPILER ERROR at PC17: Confused about usage of register: R6 in 'UnsetPending'

    (((targets[i]).targetRole).recordTable).CounterSpellBuffId = (self.config).buffId
    -- DECOMPILER ERROR at PC23: Confused about usage of register: R6 in 'UnsetPending'

    ;
    (((targets[i]).targetRole).recordTable).CounterSpellCount = (self.arglist)[2]
    -- DECOMPILER ERROR at PC29: Confused about usage of register: R6 in 'UnsetPending'

    ;
    (((targets[i]).targetRole).recordTable).buffDieHealRatio = (self.arglist)[3]
    LuaSkillCtrl:CallBuff(self, (targets[i]).targetRole, (self.config).buffId, self.buffTier, (self.arglist)[1])
  end
end

bs_1047.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_1047

-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_1047 = class("bs_1047", LuaSkillBase)
local base = LuaSkillBase
bs_1047.config = {
    selectId = 6,
    buffId = 148,
    effectId = 10198,
    actionId = 1002,
    audioId1 = 70
}
bs_1047.InitSkill = function(self, isMidwaySkill)
    -- function num : 0_0 , upvalues : base
    (base.InitSkill)(self, isMidwaySkill)
    if (self.arglist)[4] > 0 then
        self.buffTier = 2
    else
        self.buffTier = 1
    end
end

bs_1047.PlaySkill = function(self, data)
    -- function num : 0_1 , upvalues : _ENV
    self:CallCasterWait(36)
    local targets = LuaSkillCtrl:CallTargetSelect(self, (self.config).selectId,
                                                  20)
    if targets.Count > 0 then
        local skillActionTrigger = BindCallback(self, self.ActionCallBack,
                                                targets);
        ((self.caster).auSource):PlayAudioById((self.config).audioId1)
        LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster,
                                               (self.config).actionId, 2, 12,
                                               skillActionTrigger)
    end
end

bs_1047.ActionCallBack = function(self, targets)
    -- function num : 0_2 , upvalues : _ENV
    LuaSkillCtrl:CallEffect(self.caster, (self.config).effectId, self)
    for i = 0, targets.Count - 1 do
        -- DECOMPILER ERROR at PC17: Confused about usage of register: R6 in 'UnsetPending'

        (((targets[i]).targetRole).recordTable).CounterSpellBuffId =
            (self.config).buffId -- DECOMPILER ERROR at PC23: Confused about usage of register: R6 in 'UnsetPending'
        ;
        (((targets[i]).targetRole).recordTable).CounterSpellCount =
            (self.arglist)[2] -- DECOMPILER ERROR at PC29: Confused about usage of register: R6 in 'UnsetPending'
        ;
        (((targets[i]).targetRole).recordTable).buffDieHealRatio =
            (self.arglist)[3]
        LuaSkillCtrl:CallBuff(self, (targets[i]).targetRole,
                              (self.config).buffId, self.buffTier,
                              (self.arglist)[1])
    end
end

bs_1047.OnCasterDie = function(self)
    -- function num : 0_3 , upvalues : base
    (base.OnCasterDie)(self)
end

return bs_1047


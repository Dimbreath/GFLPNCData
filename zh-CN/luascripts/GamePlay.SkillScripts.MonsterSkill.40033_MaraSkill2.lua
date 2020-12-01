-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_40033 = class("bs_40033", LuaSkillBase)
local base = LuaSkillBase
bs_40033.config = {buffId = 164, antion1 = 1022, antion2 = 1023, antion3 = 1024, effectId = 10241, effectIdloop = 10242, buffId196 = 196, 
HurtConfig = {hit_formula = 9991, def_formula = 9996, basehurt_formula = 10056, minhurt_formula = 9994, crit_formula = 9992, crithur_ratio = 9995, correct_formula = 9989, lifesteal_formula = 1001, spell_lifesteal_formula = 1002, returndamage_formula = 1000}
, 
AOE = {effect_shape = 3, aoe_select_code = 5, aoe_range = 2}
, audioId1 = 87, audioId2 = 88}
bs_40033.ctor = function(self)
  -- function num : 0_0
end

bs_40033.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.SetHurt, "bs_40033_2", 5, self.OnSetHurt)
end

bs_40033.PlaySkill = function(self, data)
  -- function num : 0_2 , upvalues : _ENV
  self.gridteam = LuaSkillCtrl:FindAllGridsWithinRange(self.caster, 2, true)
  self.grid_effect = {}
  for i = 0, (self.gridteam).Count - 1 do
    local target = LuaSkillCtrl:GetTargetWithGrid(((self.gridteam)[i]).x, ((self.gridteam)[i]).y)
    -- DECOMPILER ERROR at PC32: Confused about usage of register: R7 in 'UnsetPending'

    ;
    (self.grid_effect)[i] = LuaSkillCtrl:CallEffect(target, (self.config).effectIdloop, self)
  end
  LuaSkillCtrl:CallEffect(self.caster, (self.config).effectId, self)
  self:CallCasterWait(15 + (self.arglist)[3])
  local attackTrigger = BindCallback(self, self.OnAttackTrigger)
  ;
  ((self.caster).auSource):PlayAudioById((self.config).audioId1)
  LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, (self.config).antion1, 1, 15, attackTrigger)
end

bs_40033.OnAttackTrigger = function(self)
  -- function num : 0_3 , upvalues : _ENV
  LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId196, 1, (self.arglist)[3])
  self.loopaudio = ((self.caster).auSource):PlayAudioById((self.config).audioId2)
  local grid = LuaSkillCtrl:FindEmptyGridWithinRange(self.caster, 2)
  local time = (self.arglist)[3] + 2
  local attackTrigger2 = BindCallback(self, self.OnAttackTrigger2)
  LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, (self.config).antion2, 1, time, attackTrigger2)
  local time_da = (self.arglist)[1]
  self.times = LuaSkillCtrl:StartTimer(self, 15, function()
    -- function num : 0_3_0 , upvalues : _ENV, self
    local targetList = LuaSkillCtrl:CallTargetSelect(self, 33, 1)
    if targetList.Count > 0 then
      for i = 0, targetList.Count - 1 do
        local tier = ((targetList[i]).targetRole):GetBuffTier((self.config).buffId)
        local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, (targetList[i]).targetRole)
        LuaSkillCtrl:HurtResult(skillResult, (self.config).HurtConfig, {tier})
        skillResult:EndResult()
      end
    end
    do
      local tier2 = (self.caster):GetBuffTier((self.config).buffId)
      local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, self.caster)
      LuaSkillCtrl:HurtResult(skillResult, (self.config).HurtConfig, {tier2})
      skillResult:EndResult()
    end
  end
, -1, 14)
end

bs_40033.OnAttackTrigger2 = function(self)
  -- function num : 0_4 , upvalues : _ENV
  for i = 0, (self.gridteam).Count - 1 do
    if (self.grid_effect)[i] ~= nil then
      ((self.grid_effect)[i]):Die()
      -- DECOMPILER ERROR at PC15: Confused about usage of register: R5 in 'UnsetPending'

      ;
      (self.grid_effect)[i] = nil
    end
  end
  AudioManager:StopAudioByBack(self.loopaudio)
  if self.times ~= nil then
    (self.times):Stop()
    self.times = nil
  end
end

bs_40033.OnSetHurt = function(self, context)
  -- function num : 0_5
end

bs_40033.OnCasterDie = function(self)
  -- function num : 0_6 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_40033

-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_40033 = class("bs_40033", LuaSkillBase)
local base = LuaSkillBase
bs_40033.config = {
    buffId = 164,
    antion1 = 1022,
    antion2 = 1023,
    antion3 = 1024,
    effectId = 10241,
    effectIdloop = 10242,
    buffId196 = 196,
    HurtConfig = {
        hit_formula = 9991,
        def_formula = 9996,
        basehurt_formula = 10056,
        minhurt_formula = 9994,
        crit_formula = 9992,
        crithur_ratio = 9995,
        correct_formula = 9989,
        lifesteal_formula = 1001,
        spell_lifesteal_formula = 1002,
        returndamage_formula = 1000
    },
    AOE = {effect_shape = 3, aoe_select_code = 5, aoe_range = 2},
    audioId1 = 87,
    audioId2 = 88
}
bs_40033.ctor = function(self)
    -- function num : 0_0
end

bs_40033.InitSkill = function(self, isMidwaySkill)
    -- function num : 0_1 , upvalues : base, _ENV
    (base.InitSkill)(self, isMidwaySkill)
    self:AddTrigger(eSkillTriggerType.SetHurt, "bs_40033_2", 5, self.OnSetHurt)
end

bs_40033.PlaySkill = function(self, data)
    -- function num : 0_2 , upvalues : _ENV
    self.gridteam = LuaSkillCtrl:FindAllGridsWithinRange(self.caster, 2, true)
    self.grid_effect = {}
    for i = 0, (self.gridteam).Count - 1 do
        local target = LuaSkillCtrl:GetTargetWithGrid(((self.gridteam)[i]).x,
                                                      ((self.gridteam)[i]).y) -- DECOMPILER ERROR at PC32: Confused about usage of register: R7 in 'UnsetPending'
        ;
        (self.grid_effect)[i] = LuaSkillCtrl:CallEffect(target,
                                                        (self.config).effectIdloop,
                                                        self)
    end
    LuaSkillCtrl:CallEffect(self.caster, (self.config).effectId, self)
    self:CallCasterWait(15 + (self.arglist)[3])
    local attackTrigger = BindCallback(self, self.OnAttackTrigger);
    ((self.caster).auSource):PlayAudioById((self.config).audioId1)
    LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster,
                                           (self.config).antion1, 1, 15,
                                           attackTrigger)
end

bs_40033.OnAttackTrigger = function(self)
    -- function num : 0_3 , upvalues : _ENV
    LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId196, 1,
                          (self.arglist)[3])
    self.loopaudio = ((self.caster).auSource):PlayAudioById(
                         (self.config).audioId2)
    local grid = LuaSkillCtrl:FindEmptyGridWithinRange(self.caster, 2)
    local time = (self.arglist)[3] + 2
    local attackTrigger2 = BindCallback(self, self.OnAttackTrigger2)
    LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster,
                                           (self.config).antion2, 1, time,
                                           attackTrigger2)
    local time_da = (self.arglist)[1]
    self.times = LuaSkillCtrl:StartTimer(self, 15, function()
        -- function num : 0_3_0 , upvalues : _ENV, self
        local targetList = LuaSkillCtrl:CallTargetSelect(self, 33, 1)
        if targetList.Count > 0 then
            for i = 0, targetList.Count - 1 do
                local tier = ((targetList[i]).targetRole):GetBuffTier(
                                 (self.config).buffId)
                local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self,
                                                                         (targetList[i]).targetRole)
                LuaSkillCtrl:HurtResult(skillResult, (self.config).HurtConfig,
                                        {tier})
                skillResult:EndResult()
            end
        end
        do
            local tier2 = (self.caster):GetBuffTier((self.config).buffId)
            local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self,
                                                                     self.caster)
            LuaSkillCtrl:HurtResult(skillResult, (self.config).HurtConfig,
                                    {tier2})
            skillResult:EndResult()
        end
    end, -1, 14)
end

bs_40033.OnAttackTrigger2 = function(self)
    -- function num : 0_4 , upvalues : _ENV
    for i = 0, (self.gridteam).Count - 1 do
        if (self.grid_effect)[i] ~= nil then
            ((self.grid_effect)[i]):Die() -- DECOMPILER ERROR at PC15: Confused about usage of register: R5 in 'UnsetPending'
            ;
            (self.grid_effect)[i] = nil
        end
    end
    AudioManager:StopAudioByBack(self.loopaudio)
    if self.times ~= nil then
        (self.times):Stop()
        self.times = nil
    end
end

bs_40033.OnSetHurt = function(self, context)
    -- function num : 0_5
end

bs_40033.OnCasterDie = function(self)
    -- function num : 0_6 , upvalues : base
    (base.OnCasterDie)(self)
end

return bs_40033


-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_40033 = class("bs_40033", LuaSkillBase)
local base = LuaSkillBase
bs_40033.config = {buffId_164 = 164, buffId_256 = 256, buffId_196 = 196, buffID_1158 = 1158, antion1 = 1022, antion2 = 1023, antion3 = 1024, effectId = 10241, effectIdloop = 10242, 
HurtConfig = {hit_formula = 0, def_formula = 9996, basehurt_formula = 10056, minhurt_formula = 9994, crit_formula = 0, crithur_ratio = 9995, correct_formula = 9989, lifesteal_formula = 1001, spell_lifesteal_formula = 1002, returndamage_formula = 1000}
, 
AOE = {effect_shape = 3, aoe_select_code = 5, aoe_range = 10}
, audioId1 = 87, audioId2 = 88, start_time = 45, end_time = 45, skill_range = 2, select_id = 33, select_range = 10}
bs_40033.ctor = function(self)
  -- function num : 0_0
end

bs_40033.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.BeforeBattleEnd, "bs_40033_3", 1, self.BeforeEndBattle)
end

bs_40033.PlaySkill = function(self, data)
  -- function num : 0_2 , upvalues : _ENV
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R2 in 'UnsetPending'

  ((self.caster).recordTable).NoBreak = true
  LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffID_1158, 1)
  self:CallCasterWait((self.config).start_time + (self.arglist)[3] + 999)
  self:AbandonSkillCdAutoReset(true)
  local attackTrigger = BindCallback(self, self.OnAttackTrigger)
  LuaSkillCtrl:PlayAuSource(self.caster, (self.config).audioId1)
  LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, (self.config).antion1, 1, (self.config).start_time, attackTrigger)
  LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId_196, 1, (self.arglist)[3] + (self.config).start_time)
end

bs_40033.OnAttackTrigger = function(self)
  -- function num : 0_3 , upvalues : _ENV
  LuaSkillCtrl:CallEffect(self.caster, (self.config).effectId, self, nil, nil, nil, true)
  local target = LuaSkillCtrl:GetTargetWithGrid(3, 2)
  self.grid_effect = LuaSkillCtrl:CallEffect(target, (self.config).effectIdloop, self, nil, nil, nil, true)
  self.loopaudio = LuaSkillCtrl:PlayAuSource(self.caster, (self.config).audioId2)
  local freq = (self.arglist)[1]
  local times = (self.arglist)[3] // freq
  LuaSkillCtrl:StartTimer(self, freq, function()
    -- function num : 0_3_0 , upvalues : _ENV, self
    local targetList = LuaSkillCtrl:CallTargetSelect(self, (self.config).select_id, (self.config).select_range)
    if targetList.Count > 0 then
      for i = 0, targetList.Count - 1 do
        local tier = ((targetList[i]).targetRole):GetBuffTier((self.config).buffId_164)
        local exTier = ((targetList[i]).targetRole):GetBuffTier((self.config).buffId_256)
        tier = tier + exTier
        local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, (targetList[i]).targetRole)
        LuaSkillCtrl:PlayAuHit(self, (targetList[i]).targetRole)
        LuaSkillCtrl:HurtResult(self, skillResult, (self.config).HurtConfig, {tier})
        skillResult:EndResult()
      end
    end
    do
      local tier2 = (self.caster):GetBuffTier((self.config).buffId_164)
      local exTier2 = (self.caster):GetBuffTier((self.config).buffId_256)
      tier2 = tier2 + exTier2
      local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, self.caster)
      LuaSkillCtrl:HurtResult(self, skillResult, (self.config).HurtConfig, {tier2})
      skillResult:EndResult()
    end
  end
, self, times, freq - 1)
  local arriveCallBack = BindCallback(self, self.OnSkill2End)
  self.endTimer = LuaSkillCtrl:StartTimer(nil, (self.arglist)[3], arriveCallBack)
end

bs_40033.OnSkill2End = function(self)
  -- function num : 0_4 , upvalues : _ENV
  if self.endTimer ~= nil and (self.endTimer):IsOver() then
    self.endTimer = nil
  end
  LuaSkillCtrl:StopAudioByBack(self.loopaudio)
  if self.grid_effect ~= nil then
    (self.grid_effect):Die()
    self.grid_effect = nil
  end
  local EndTrigger = BindCallback(self, self.OnEndTrigger)
  LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, (self.config).antion3, 1, 45, EndTrigger)
end

bs_40033.OnEndTrigger = function(self)
  -- function num : 0_5 , upvalues : _ENV
  self:CancleCasterWait()
  self:CallNextBossSkill()
  LuaSkillCtrl:DispelBuff(self.caster, (self.config).buffID_1158, 0)
  -- DECOMPILER ERROR at PC13: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.caster).recordTable).NoBreak = false
end

bs_40033.BeforeEndBattle = function(self)
  -- function num : 0_6 , upvalues : _ENV
  if self.loopaudio ~= nil then
    LuaSkillCtrl:StopAudioByBack(self.loopaudio)
    self.loopaudio = nil
  end
end

bs_40033.OnCasterDie = function(self)
  -- function num : 0_7 , upvalues : base
  (base.OnCasterDie)(self)
  if self.endTimer ~= nil then
    (self.endTimer):Stop()
    self.endTimer = nil
  end
end

bs_40033.LuaDispose = function(self)
  -- function num : 0_8 , upvalues : base
  (base.LuaDispose)(self)
  self.grid_effect = nil
  self.gridteam = nil
  self.loopaudio = nil
end

return bs_40033


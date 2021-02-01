-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_202901 = class("bs_202901", LuaSkillBase)
local base = LuaSkillBase
bs_202901.config = {buffId = 110, buffId2 = 66, effectId = 10570, effectHitId = 10571, 
HurtConfig = {hit_formula = 0, def_formula = 0, basehurt_formula = 10018, minhurt_formula = 9994, crit_formula = 0, crithur_ratio = 0}
}
bs_202901.ctor = function(self)
  -- function num : 0_0
end

bs_202901.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterAddBuff, "bs_202901_7", 1, self.OnAfterAddBuff)
end

bs_202901.PlaySkill = function(self, data)
  -- function num : 0_2 , upvalues : _ENV
  local targetList = LuaSkillCtrl:CallTargetSelect(self, 9, 0)
  if targetList ~= nil and targetList.Count > 0 and targetList[0] ~= nil then
    local attackTrigger = BindCallback(self, self.OnAttackTrigger, data)
    self:CallCasterWait(16 + (self.arglist)[6] + 5)
    LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, 1008, 1, 16, attackTrigger)
    self.loopeffect = LuaSkillCtrl:CallEffect(self.caster, (self.config).effectId, self, nil, nil, nil, true)
  end
end

bs_202901.OnAttackTrigger = function(self, data)
  -- function num : 0_3 , upvalues : _ENV
  LuaSkillCtrl:CallRoleAction(self.caster, 1007)
  self.time = LuaSkillCtrl:StartTimer(self, (self.arglist)[1], function()
    -- function num : 0_3_0 , upvalues : _ENV, self
    local targetList = LuaSkillCtrl:CallTargetSelect(self, 9, 0)
    if targetList.Count > 0 then
      for i = 0, targetList.Count - 1 do
        local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, (targetList[i]).targetRole)
        skillResult:BuffResult((self.config).buffId, 1)
        LuaSkillCtrl:HurtResult(skillResult, (self.config).HurtConfig)
        skillResult:EndResult()
        LuaSkillCtrl:CallEffect((targetList[i]).targetRole, (self.config).effectHitId, self, nil, nil, nil, true)
      end
    end
  end
, self, -1, (self.arglist)[1] - 5)
  LuaSkillCtrl:StartTimer(self, (self.arglist)[6], function()
    -- function num : 0_3_1 , upvalues : self, _ENV
    if self.loopeffect ~= nil then
      (self.loopeffect):Die()
      self.loopeffect = nil
    end
    if self.time ~= nil then
      (self.time):Stop()
      self.time = nil
    end
    LuaSkillCtrl:CallRoleAction(self.caster, 1009)
    LuaSkillCtrl:StartTimer(nil, 5, function()
      -- function num : 0_3_1_0 , upvalues : _ENV, self
      LuaSkillCtrl:CallRoleAction(self.caster, 100)
    end
)
  end
)
end

bs_202901.OnAfterAddBuff = function(self, buff, target)
  -- function num : 0_4 , upvalues : _ENV
  if buff.dataId == (self.config).buffId then
    local restTier = target:GetBuffTier((self.config).buffId)
    if (self.arglist)[4] <= restTier then
      LuaSkillCtrl:CallBuff(self, target, (self.config).buffId2, 1, (self.arglist)[5])
      LuaSkillCtrl:DispelBuff(target, (self.config).buffId, 0, true)
      restTier = 0
    end
  end
end

bs_202901.OnCasterDie = function(self)
  -- function num : 0_5 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_202901


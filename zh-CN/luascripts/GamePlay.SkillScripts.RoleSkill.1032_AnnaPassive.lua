-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_1032 = class("bs_1032", LuaSkillBase)
local base = LuaSkillBase
bs_1032.config = {buffId1 = 110, buffId2 = 66, buffId3 = 120, effectId = 10050, effectId1 = 10049}
bs_1032.ctor = function(self)
  -- function num : 0_0
end

bs_1032.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : _ENV
  self:AddTrigger(eSkillTriggerType.AfterAddBuff, "bs_1032_7", 1, self.OnAfterAddBuff)
  self:AddTrigger(eSkillTriggerType.AfterHurt, "bs_1032_1", 1, self.OnAfterHurt)
end

bs_1032.OnAfterHurt = function(self, sender, target, skill, hurt, isMiss, isCrit, isRealDmg)
  -- function num : 0_2 , upvalues : _ENV
  if sender == self.caster and skill.isCommonAttack and not isMiss then
    LuaSkillCtrl:CallBuff(self, target, (self.config).buffId1, 1)
  end
  if target.hp <= 0 and (self.caster).belongNum ~= target.belongNum and target:GetBuffTier((self.config).buffId1) > 0 then
    if (self.arglist)[4] > 0 then
      local targetList = LuaSkillCtrl:CallTargetSelect(self, 19, 10)
      if targetList ~= nil and targetList.Count > 0 and targetList[0] ~= nil then
        LuaSkillCtrl:CallEffect((targetList[0]).targetRole, (self.config).effectId1, self, nil, target)
        LuaSkillCtrl:CallEffectWithArgOverride((targetList[0]).targetRole, (self.config).effectId, self, target, true, self.SkillEventFunc, target:GetBuffTier((self.config).buffId1))
        LuaSkillCtrl:DispelBuff(target, (self.config).buffId1, 0)
      end
    else
      do
        LuaSkillCtrl:DispelBuff(target, (self.config).buffId1, 0)
      end
    end
  end
end

bs_1032.OnAfterAddBuff = function(self, buff, target)
  -- function num : 0_3 , upvalues : _ENV
  if buff.dataId == (self.config).buffId1 then
    local restTier = target:GetBuffTier((self.config).buffId1)
    if (self.arglist)[1] <= restTier then
      LuaSkillCtrl:CallBuff(self, target, (self.config).buffId2, 1, (self.arglist)[2])
      LuaSkillCtrl:DispelBuff(target, (self.config).buffId1, (self.arglist)[1])
      restTier = restTier - (self.arglist)[1]
    end
  end
end

bs_1032.SkillEventFunc = function(self, tier, effect, eventId, target)
  -- function num : 0_4 , upvalues : _ENV
  if eventId == eBattleEffectEvent.Trigger then
    local skillResult = LuaSkillCtrl:CallSkillResult(effect, target)
    skillResult:BuffResult((self.config).buffId1, tier)
    skillResult:EndResult()
  end
end

bs_1032.OnCasterDie = function(self)
  -- function num : 0_5
  self:RemoveAllTimers()
  self:RemoveAllBreakKillEffects()
end

return bs_1032

-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_1032 = class("bs_1032", LuaSkillBase)
local base = LuaSkillBase
bs_1032.config = {
    buffId1 = 110,
    buffId2 = 66,
    buffId3 = 120,
    effectId = 10050,
    effectId1 = 10049
}
bs_1032.ctor = function(self)
    -- function num : 0_0
end

bs_1032.InitSkill = function(self, isMidwaySkill)
    -- function num : 0_1 , upvalues : _ENV
    self:AddTrigger(eSkillTriggerType.AfterAddBuff, "bs_1032_7", 1,
                    self.OnAfterAddBuff)
    self:AddTrigger(eSkillTriggerType.AfterHurt, "bs_1032_1", 1,
                    self.OnAfterHurt)
end

bs_1032.OnAfterHurt = function(self, sender, target, skill, hurt, isMiss,
                               isCrit, isRealDmg)
    -- function num : 0_2 , upvalues : _ENV
    if sender == self.caster and skill.isCommonAttack and not isMiss then
        LuaSkillCtrl:CallBuff(self, target, (self.config).buffId1, 1)
    end
    if target.hp <= 0 and (self.caster).belongNum ~= target.belongNum and
        target:GetBuffTier((self.config).buffId1) > 0 then
        if (self.arglist)[4] > 0 then
            local targetList = LuaSkillCtrl:CallTargetSelect(self, 19, 10)
            if targetList ~= nil and targetList.Count > 0 and targetList[0] ~=
                nil then
                LuaSkillCtrl:CallEffect((targetList[0]).targetRole,
                                        (self.config).effectId1, self, nil,
                                        target)
                LuaSkillCtrl:CallEffectWithArgOverride(
                    (targetList[0]).targetRole, (self.config).effectId, self,
                    target, true, self.SkillEventFunc,
                    target:GetBuffTier((self.config).buffId1))
                LuaSkillCtrl:DispelBuff(target, (self.config).buffId1, 0)
            end
        else
            do
                LuaSkillCtrl:DispelBuff(target, (self.config).buffId1, 0)
            end
        end
    end
end

bs_1032.OnAfterAddBuff = function(self, buff, target)
    -- function num : 0_3 , upvalues : _ENV
    if buff.dataId == (self.config).buffId1 then
        local restTier = target:GetBuffTier((self.config).buffId1)
        if (self.arglist)[1] <= restTier then
            LuaSkillCtrl:CallBuff(self, target, (self.config).buffId2, 1,
                                  (self.arglist)[2])
            LuaSkillCtrl:DispelBuff(target, (self.config).buffId1,
                                    (self.arglist)[1])
            restTier = restTier - (self.arglist)[1]
        end
    end
end

bs_1032.SkillEventFunc = function(self, tier, effect, eventId, target)
    -- function num : 0_4 , upvalues : _ENV
    if eventId == eBattleEffectEvent.Trigger then
        local skillResult = LuaSkillCtrl:CallSkillResult(effect, target)
        skillResult:BuffResult((self.config).buffId1, tier)
        skillResult:EndResult()
    end
end

bs_1032.OnCasterDie = function(self)
    -- function num : 0_5
    self:RemoveAllTimers()
    self:RemoveAllBreakKillEffects()
end

return bs_1032


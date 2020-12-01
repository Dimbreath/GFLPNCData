-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_1065 = class("bs_1065", LuaSkillBase)
local base = LuaSkillBase
bs_1065.config = {
hurt_config = {hit_formula = 10010, basehurt_formula = 10090}
, 
real_Config = {basehurt_formula = 502}
, 
aoe_config = {effect_shape = 3, aoe_select_code = 4, aoe_range = 3}
, effectId = 10310, effectId1 = 10343, buffId = 113, audioId1 = 103, audioId2 = 104, audioId3 = 105}
bs_1065.ctor = function(self)
  -- function num : 0_0
end

bs_1065.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1
end

bs_1065.PlaySkill = function(self)
  -- function num : 0_2 , upvalues : _ENV
  LuaSkillCtrl:CallBreakAllSkill(self.caster)
  self:CallCasterWait(23)
  local targetList = LuaSkillCtrl:CallTargetSelect(self, 1001, 0)
  self:CallCasterLookAt(targetList)
  LuaSkillCtrl:CallRoleAction(self.caster, 1006)
  if targetList ~= nil and targetList.Count > 0 and targetList[0] ~= nil then
    LuaSkillCtrl:CallEffect((targetList[0]).targetRole, (self.config).effectId, self, self.SkillEventFunc)
  end
end

bs_1065.SkillEventFunc = function(self, effect, eventId, target)
  -- function num : 0_3 , upvalues : _ENV
  if eventId == eBattleEffectEvent.Trigger then
    LuaSkillCtrl:StartTimer(self, 5, function()
    -- function num : 0_3_0 , upvalues : _ENV, effect, self
    local skillResult = LuaSkillCtrl:CallSkillResult(effect, self.caster, (self.config).aoe_config)
    if (skillResult.roleList).Count ~= 0 then
      for i = 0, (skillResult.roleList).Count - 1 do
        local role = (skillResult.roleList)[i]
        if LuaSkillCtrl:IsAbleAttackTargetWithDir(self.caster, role, 4, 80) then
          LuaSkillCtrl:CallEffect(role, (self.config).effectId1, self, self.SkillEventFunc1, nil, 1)
        end
      end
    end
    do
      skillResult:EndResult()
    end
  end
, nil)
  end
end

bs_1065.SkillEventFunc1 = function(self, effect, eventId, target)
  -- function num : 0_4 , upvalues : _ENV
  if eventId == eBattleEffectEvent.Trigger then
    local skillResult = LuaSkillCtrl:CallSkillResult(effect, target)
    LuaSkillCtrl:HurtResult(skillResult, (self.config).hurt_config)
    skillResult:EndResult()
    local roleBuffTier = (target.targetRole):GetBuffTier((self.config).buffId)
    if roleBuffTier > 0 then
      local hurt = roleBuffTier * (self.caster).pow * (self.arglist)[2] // 1000
      if hurt <= 0 then
        hurt = 1
      end
      LuaSkillCtrl:CallRealDamage(self, target, nil, (self.config).real_Config, {hurt}, true)
    end
  end
end

bs_1065.PlayUltEffect = function(self)
  -- function num : 0_5 , upvalues : _ENV
  ((self.caster).auSource):PlayAudioById((self.config).audioId1)
  LuaSkillCtrl:CallFocusTimeLine(self.caster)
  LuaSkillCtrl:CallBuff(self, self.caster, 196, 1, 15)
  self:AddTrigger(eSkillTriggerType.AfterSelfUltMovieEnd, "bs_1065_2", 1, self.OnMovieEnd)
  self:AddTrigger(eSkillTriggerType.OnSelfUltMovieFadeOut, "bs_1065_3", 1, self.OnMovieFadeOut)
end

bs_1065.OnUltRoleAction = function(self)
  -- function num : 0_6 , upvalues : _ENV
  LuaSkillCtrl:StartTimerInUlt(7, function()
    -- function num : 0_6_0 , upvalues : _ENV, self
    LuaSkillCtrl:CallPlayUltMovie()
    ;
    ((self.caster).auSource):PlayAudioById((self.config).audioId2)
  end
, nil)
  self:CallCasterWait(20)
  LuaSkillCtrl:CallRoleAction(self.caster, 1005)
end

bs_1065.OnMovieFadeOut = function(self)
  -- function num : 0_7 , upvalues : _ENV
  ((self.caster).auSource):PlayAudioById((self.config).audioId3)
  LuaSkillCtrl:CallRoleAction(self.caster, 1006)
  self:RemoveTrigger(eSkillTriggerType.OnSelfUltMovieFadeOut)
  LuaSkillCtrl:CallBackViewTimeLine(self.caster, true)
  self:RemoveTrigger(eSkillTriggerType.AfterSelfUltMovieEnd)
end

bs_1065.OnMovieEnd = function(self)
  -- function num : 0_8
end

bs_1065.OnCasterDie = function(self)
  -- function num : 0_9 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_1065

-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_1065 = class("bs_1065", LuaSkillBase)
local base = LuaSkillBase
bs_1065.config = {
    hurt_config = {hit_formula = 10010, basehurt_formula = 10090},
    real_Config = {basehurt_formula = 502},
    aoe_config = {effect_shape = 3, aoe_select_code = 4, aoe_range = 3},
    effectId = 10310,
    effectId1 = 10343,
    buffId = 113,
    audioId1 = 103,
    audioId2 = 104,
    audioId3 = 105
}
bs_1065.ctor = function(self)
    -- function num : 0_0
end

bs_1065.InitSkill = function(self, isMidwaySkill)
    -- function num : 0_1
end

bs_1065.PlaySkill = function(self)
    -- function num : 0_2 , upvalues : _ENV
    LuaSkillCtrl:CallBreakAllSkill(self.caster)
    self:CallCasterWait(23)
    local targetList = LuaSkillCtrl:CallTargetSelect(self, 1001, 0)
    self:CallCasterLookAt(targetList)
    LuaSkillCtrl:CallRoleAction(self.caster, 1006)
    if targetList ~= nil and targetList.Count > 0 and targetList[0] ~= nil then
        LuaSkillCtrl:CallEffect((targetList[0]).targetRole,
                                (self.config).effectId, self,
                                self.SkillEventFunc)
    end
end

bs_1065.SkillEventFunc = function(self, effect, eventId, target)
    -- function num : 0_3 , upvalues : _ENV
    if eventId == eBattleEffectEvent.Trigger then
        LuaSkillCtrl:StartTimer(self, 5, function()
            -- function num : 0_3_0 , upvalues : _ENV, effect, self
            local skillResult = LuaSkillCtrl:CallSkillResult(effect,
                                                             self.caster,
                                                             (self.config).aoe_config)
            if (skillResult.roleList).Count ~= 0 then
                for i = 0, (skillResult.roleList).Count - 1 do
                    local role = (skillResult.roleList)[i]
                    if LuaSkillCtrl:IsAbleAttackTargetWithDir(self.caster, role,
                                                              4, 80) then
                        LuaSkillCtrl:CallEffect(role, (self.config).effectId1,
                                                self, self.SkillEventFunc1, nil,
                                                1)
                    end
                end
            end
            do skillResult:EndResult() end
        end, nil)
    end
end

bs_1065.SkillEventFunc1 = function(self, effect, eventId, target)
    -- function num : 0_4 , upvalues : _ENV
    if eventId == eBattleEffectEvent.Trigger then
        local skillResult = LuaSkillCtrl:CallSkillResult(effect, target)
        LuaSkillCtrl:HurtResult(skillResult, (self.config).hurt_config)
        skillResult:EndResult()
        local roleBuffTier = (target.targetRole):GetBuffTier(
                                 (self.config).buffId)
        if roleBuffTier > 0 then
            local hurt = roleBuffTier * (self.caster).pow * (self.arglist)[2] //
                             1000
            if hurt <= 0 then hurt = 1 end
            LuaSkillCtrl:CallRealDamage(self, target, nil,
                                        (self.config).real_Config, {hurt}, true)
        end
    end
end

bs_1065.PlayUltEffect = function(self)
    -- function num : 0_5 , upvalues : _ENV
    ((self.caster).auSource):PlayAudioById((self.config).audioId1)
    LuaSkillCtrl:CallFocusTimeLine(self.caster)
    LuaSkillCtrl:CallBuff(self, self.caster, 196, 1, 15)
    self:AddTrigger(eSkillTriggerType.AfterSelfUltMovieEnd, "bs_1065_2", 1,
                    self.OnMovieEnd)
    self:AddTrigger(eSkillTriggerType.OnSelfUltMovieFadeOut, "bs_1065_3", 1,
                    self.OnMovieFadeOut)
end

bs_1065.OnUltRoleAction = function(self)
    -- function num : 0_6 , upvalues : _ENV
    LuaSkillCtrl:StartTimerInUlt(7, function()
        -- function num : 0_6_0 , upvalues : _ENV, self
        LuaSkillCtrl:CallPlayUltMovie();
        ((self.caster).auSource):PlayAudioById((self.config).audioId2)
    end, nil)
    self:CallCasterWait(20)
    LuaSkillCtrl:CallRoleAction(self.caster, 1005)
end

bs_1065.OnMovieFadeOut = function(self)
    -- function num : 0_7 , upvalues : _ENV
    ((self.caster).auSource):PlayAudioById((self.config).audioId3)
    LuaSkillCtrl:CallRoleAction(self.caster, 1006)
    self:RemoveTrigger(eSkillTriggerType.OnSelfUltMovieFadeOut)
    LuaSkillCtrl:CallBackViewTimeLine(self.caster, true)
    self:RemoveTrigger(eSkillTriggerType.AfterSelfUltMovieEnd)
end

bs_1065.OnMovieEnd = function(self)
    -- function num : 0_8
end

bs_1065.OnCasterDie = function(self)
    -- function num : 0_9 , upvalues : base
    (base.OnCasterDie)(self)
end

return bs_1065


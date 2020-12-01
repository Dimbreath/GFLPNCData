-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_1058 = class("bs_1058", LuaSkillBase)
local base = LuaSkillBase
bs_1058.config = {effectId = 10262, 
hurt_config = {hit_formula = 10010, basehurt_formula = 10057}
, 
series_0 = {1, 3, 9, 15, 18}
, 
series_1 = {2, 5, 8, 14, 17}
, 
series_2 = {4, 7, 10, 13, 19}
, 
series_3 = {1, 6, 10, 15, 21}
, 
series_4 = {5, 8, 12, 20, 22}
, audioId1 = 97, audioId2 = 98, audioId3 = 99}
bs_1058.ctor = function(self)
  -- function num : 0_0
end

bs_1058.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1
  self.hurt_config = {}
end

bs_1058.PlaySkill = function(self)
  -- function num : 0_2 , upvalues : _ENV
  local effectTarget = LuaSkillCtrl:GetTargetWithGrid(3, 2)
  LuaSkillCtrl:CallEffect(effectTarget, (self.config).effectId, self)
  local targetList = LuaSkillCtrl:CallTargetSelect(self, 9, 10)
  if targetList.Count <= 0 then
    return 
  end
  for i = 0, targetList.Count - 1 do
    do
      local series = i % 5
      for n = 1, 5 do
        LuaSkillCtrl:StartTimer(self, ((self.config)["series_" .. tostring(series)])[n], function()
    -- function num : 0_2_0 , upvalues : self, targetList, i
    self:RealPlaySkill((targetList[i]).targetRole)
  end
, nil)
      end
    end
  end
end

bs_1058.RealPlaySkill = function(self, target)
  -- function num : 0_3 , upvalues : _ENV
  local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
  LuaSkillCtrl:HurtResult(skillResult, (self.config).hurt_config)
  skillResult:EndResult()
end

bs_1058.PlayUltEffect = function(self)
  -- function num : 0_4 , upvalues : _ENV
  LuaSkillCtrl:StartTimerInUlt(10, function()
    -- function num : 0_4_0 , upvalues : self
    ((self.caster).auSource):PlayAudioById((self.config).audioId1)
  end
, nil)
  LuaSkillCtrl:CallFocusTimeLine(self.caster)
  LuaSkillCtrl:CallBuff(self, self.caster, 196, 1, 15)
  self:AddTrigger(eSkillTriggerType.AfterSelfUltMovieEnd, "bs_1058_2", 1, self.OnMovieEnd)
  self:AddTrigger(eSkillTriggerType.OnSelfUltMovieFadeOut, "bs_1058_3", 1, self.OnMovieFadeOut)
end

bs_1058.OnUltRoleAction = function(self)
  -- function num : 0_5 , upvalues : _ENV
  LuaSkillCtrl:StartTimerInUlt(19, function()
    -- function num : 0_5_0 , upvalues : _ENV, self
    LuaSkillCtrl:CallPlayUltMovie()
    ;
    ((self.caster).auSource):PlayAudioById((self.config).audioId2)
  end
, nil)
  self:CallCasterWait(20)
  LuaSkillCtrl:CallRoleAction(self.caster, 1005)
end

bs_1058.OnMovieFadeOut = function(self)
  -- function num : 0_6 , upvalues : _ENV
  ((self.caster).auSource):PlayAudioById((self.config).audioId3)
  LuaSkillCtrl:CallRoleAction(self.caster, 1006)
  self:RemoveTrigger(eSkillTriggerType.OnSelfUltMovieFadeOut)
  LuaSkillCtrl:CallBackViewTimeLine(self.caster, true)
  self:RemoveTrigger(eSkillTriggerType.AfterSelfUltMovieEnd)
end

bs_1058.OnMovieEnd = function(self)
  -- function num : 0_7
end

bs_1058.OnCasterDie = function(self)
  -- function num : 0_8 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_1058

-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_1058 = class("bs_1058", LuaSkillBase)
local base = LuaSkillBase
bs_1058.config = {
    effectId = 10262,
    hurt_config = {hit_formula = 10010, basehurt_formula = 10057},
    series_0 = {1, 3, 9, 15, 18},
    series_1 = {2, 5, 8, 14, 17},
    series_2 = {4, 7, 10, 13, 19},
    series_3 = {1, 6, 10, 15, 21},
    series_4 = {5, 8, 12, 20, 22},
    audioId1 = 97,
    audioId2 = 98,
    audioId3 = 99
}
bs_1058.ctor = function(self)
    -- function num : 0_0
end

bs_1058.InitSkill = function(self, isMidwaySkill)
    -- function num : 0_1
    self.hurt_config = {}
end

bs_1058.PlaySkill = function(self)
    -- function num : 0_2 , upvalues : _ENV
    local effectTarget = LuaSkillCtrl:GetTargetWithGrid(3, 2)
    LuaSkillCtrl:CallEffect(effectTarget, (self.config).effectId, self)
    local targetList = LuaSkillCtrl:CallTargetSelect(self, 9, 10)
    if targetList.Count <= 0 then return end
    for i = 0, targetList.Count - 1 do
        do
            local series = i % 5
            for n = 1, 5 do
                LuaSkillCtrl:StartTimer(self, ((self.config)["series_" ..
                                            tostring(series)])[n], function()
                    -- function num : 0_2_0 , upvalues : self, targetList, i
                    self:RealPlaySkill((targetList[i]).targetRole)
                end, nil)
            end
        end
    end
end

bs_1058.RealPlaySkill = function(self, target)
    -- function num : 0_3 , upvalues : _ENV
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
    LuaSkillCtrl:HurtResult(skillResult, (self.config).hurt_config)
    skillResult:EndResult()
end

bs_1058.PlayUltEffect = function(self)
    -- function num : 0_4 , upvalues : _ENV
    LuaSkillCtrl:StartTimerInUlt(10, function()
        -- function num : 0_4_0 , upvalues : self
        ((self.caster).auSource):PlayAudioById((self.config).audioId1)
    end, nil)
    LuaSkillCtrl:CallFocusTimeLine(self.caster)
    LuaSkillCtrl:CallBuff(self, self.caster, 196, 1, 15)
    self:AddTrigger(eSkillTriggerType.AfterSelfUltMovieEnd, "bs_1058_2", 1,
                    self.OnMovieEnd)
    self:AddTrigger(eSkillTriggerType.OnSelfUltMovieFadeOut, "bs_1058_3", 1,
                    self.OnMovieFadeOut)
end

bs_1058.OnUltRoleAction = function(self)
    -- function num : 0_5 , upvalues : _ENV
    LuaSkillCtrl:StartTimerInUlt(19, function()
        -- function num : 0_5_0 , upvalues : _ENV, self
        LuaSkillCtrl:CallPlayUltMovie();
        ((self.caster).auSource):PlayAudioById((self.config).audioId2)
    end, nil)
    self:CallCasterWait(20)
    LuaSkillCtrl:CallRoleAction(self.caster, 1005)
end

bs_1058.OnMovieFadeOut = function(self)
    -- function num : 0_6 , upvalues : _ENV
    ((self.caster).auSource):PlayAudioById((self.config).audioId3)
    LuaSkillCtrl:CallRoleAction(self.caster, 1006)
    self:RemoveTrigger(eSkillTriggerType.OnSelfUltMovieFadeOut)
    LuaSkillCtrl:CallBackViewTimeLine(self.caster, true)
    self:RemoveTrigger(eSkillTriggerType.AfterSelfUltMovieEnd)
end

bs_1058.OnMovieEnd = function(self)
    -- function num : 0_7
end

bs_1058.OnCasterDie = function(self)
    -- function num : 0_8 , upvalues : base
    (base.OnCasterDie)(self)
end

return bs_1058


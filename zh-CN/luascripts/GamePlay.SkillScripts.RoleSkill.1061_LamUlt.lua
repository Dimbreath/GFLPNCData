-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_1061 = class("bs_1061", LuaSkillBase)
local base = LuaSkillBase
bs_1061.config = {
hurt_config = {hit_formula = 10010, basehurt_formula = 10090}
, startEffect = 10311, mainEffect = 10312, sjEffect = 10313, audioId1 = 114, audioId2 = 115, audioId3 = 116}
bs_1061.ctor = function(self)
  -- function num : 0_0
end

bs_1061.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1
  self.hurt_config = {}
end

bs_1061.PlaySkill = function(self)
  -- function num : 0_2 , upvalues : _ENV
  LuaSkillCtrl:CallBreakAllSkill(self.caster)
  local targetList = LuaSkillCtrl:CallTargetSelect(self, 7, 10)
  if targetList.Count == 0 then
    return 
  end
  self:CallCasterWait(15)
  ;
  (self.caster):LookAtTarget((targetList[0]).targetRole)
  LuaSkillCtrl:CallRoleAction(self.caster, 1010)
  LuaSkillCtrl:StartTimer(self, 10, function()
    -- function num : 0_2_0 , upvalues : _ENV, self
    LuaSkillCtrl:CallRoleAction(self.caster, 1006)
  end
)
  local emiEffict = LuaSkillCtrl:CallEffect(self.caster, 10452, self)
  LuaSkillCtrl:CallEffect((targetList[0]).targetRole, (self.config).mainEffect, self)
  local collisionTrigger = BindCallback(self, self.OnCollision)
  local skillEmission = LuaSkillCtrl:CallCircledEmissionStraightly(self, self.caster, (targetList[0]).targetRole, 70, 10, eColliderInfluenceType.Enemy, collisionTrigger, nil, nil, emiEffict, true, true)
  LuaSkillCtrl:CallBattleCamShake()
end

bs_1061.OnCollision = function(self, index, entity)
  -- function num : 0_3 , upvalues : _ENV
  LuaSkillCtrl:CallEffect(entity, (self.config).sjEffect, self, self.SkillEventFunc)
end

bs_1061.SkillEventFunc = function(self, effect, eventId, target)
  -- function num : 0_4 , upvalues : _ENV
  if eventId == eBattleEffectEvent.Trigger then
    local skillResult = LuaSkillCtrl:CallSkillResult(effect, target)
    LuaSkillCtrl:HurtResult(skillResult, (self.config).hurt_config)
    skillResult:EndResult()
  end
end

bs_1061.PlayUltEffect = function(self)
  -- function num : 0_5 , upvalues : _ENV
  ((self.caster).auSource):PlayAudioById((self.config).audioId1)
  LuaSkillCtrl:CallFocusTimeLine(self.caster)
  LuaSkillCtrl:CallBuff(self, self.caster, 196, 1, 15)
  self:AddTrigger(eSkillTriggerType.AfterSelfUltMovieEnd, "bs_1061_2", 1, self.OnMovieEnd)
  self:AddTrigger(eSkillTriggerType.OnSelfUltMovieFadeOut, "bs_1061_3", 1, self.OnMovieFadeOut)
end

bs_1061.OnUltRoleAction = function(self)
  -- function num : 0_6 , upvalues : _ENV
  LuaSkillCtrl:StartTimerInUlt(11, function()
    -- function num : 0_6_0 , upvalues : _ENV, self
    LuaSkillCtrl:CallPlayUltMovie()
    ;
    ((self.caster).auSource):PlayAudioById((self.config).audioId2)
  end
, nil)
  local targetList = LuaSkillCtrl:CallTargetSelect(self, 7, 10)
  if targetList.Count == 0 then
    return 
  end
  self:CallCasterWait(15)
  ;
  (self.caster):LookAtTarget((targetList[0]).targetRole)
  LuaSkillCtrl:CallRoleAction(self.caster, 1005)
  self.startEffect = LuaSkillCtrl:CallEffect(self.caster, (self.config).startEffect, self)
end

bs_1061.OnMovieFadeOut = function(self)
  -- function num : 0_7 , upvalues : _ENV
  ((self.caster).auSource):PlayAudioById((self.config).audioId3)
  LuaSkillCtrl:CallRoleAction(self.caster, 1006)
  self:RemoveTrigger(eSkillTriggerType.OnSelfUltMovieFadeOut)
  LuaSkillCtrl:CallBackViewTimeLine(self.caster, true)
  self:RemoveTrigger(eSkillTriggerType.AfterSelfUltMovieEnd)
end

bs_1061.OnMovieEnd = function(self)
  -- function num : 0_8
end

bs_1061.OnCasterDie = function(self)
  -- function num : 0_9 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_1061

-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_1061 = class("bs_1061", LuaSkillBase)
local base = LuaSkillBase
bs_1061.config = {
    hurt_config = {hit_formula = 10010, basehurt_formula = 10090},
    startEffect = 10311,
    mainEffect = 10312,
    sjEffect = 10313,
    audioId1 = 114,
    audioId2 = 115,
    audioId3 = 116
}
bs_1061.ctor = function(self)
    -- function num : 0_0
end

bs_1061.InitSkill = function(self, isMidwaySkill)
    -- function num : 0_1
    self.hurt_config = {}
end

bs_1061.PlaySkill = function(self)
    -- function num : 0_2 , upvalues : _ENV
    LuaSkillCtrl:CallBreakAllSkill(self.caster)
    local targetList = LuaSkillCtrl:CallTargetSelect(self, 7, 10)
    if targetList.Count == 0 then return end
    self:CallCasterWait(15);
    (self.caster):LookAtTarget((targetList[0]).targetRole)
    LuaSkillCtrl:CallRoleAction(self.caster, 1010)
    LuaSkillCtrl:StartTimer(self, 10, function()
        -- function num : 0_2_0 , upvalues : _ENV, self
        LuaSkillCtrl:CallRoleAction(self.caster, 1006)
    end)
    local emiEffict = LuaSkillCtrl:CallEffect(self.caster, 10452, self)
    LuaSkillCtrl:CallEffect((targetList[0]).targetRole,
                            (self.config).mainEffect, self)
    local collisionTrigger = BindCallback(self, self.OnCollision)
    local skillEmission = LuaSkillCtrl:CallCircledEmissionStraightly(self,
                                                                     self.caster,
                                                                     (targetList[0]).targetRole,
                                                                     70, 10,
                                                                     eColliderInfluenceType.Enemy,
                                                                     collisionTrigger,
                                                                     nil, nil,
                                                                     emiEffict,
                                                                     true, true)
    LuaSkillCtrl:CallBattleCamShake()
end

bs_1061.OnCollision = function(self, index, entity)
    -- function num : 0_3 , upvalues : _ENV
    LuaSkillCtrl:CallEffect(entity, (self.config).sjEffect, self,
                            self.SkillEventFunc)
end

bs_1061.SkillEventFunc = function(self, effect, eventId, target)
    -- function num : 0_4 , upvalues : _ENV
    if eventId == eBattleEffectEvent.Trigger then
        local skillResult = LuaSkillCtrl:CallSkillResult(effect, target)
        LuaSkillCtrl:HurtResult(skillResult, (self.config).hurt_config)
        skillResult:EndResult()
    end
end

bs_1061.PlayUltEffect = function(self)
    -- function num : 0_5 , upvalues : _ENV
    ((self.caster).auSource):PlayAudioById((self.config).audioId1)
    LuaSkillCtrl:CallFocusTimeLine(self.caster)
    LuaSkillCtrl:CallBuff(self, self.caster, 196, 1, 15)
    self:AddTrigger(eSkillTriggerType.AfterSelfUltMovieEnd, "bs_1061_2", 1,
                    self.OnMovieEnd)
    self:AddTrigger(eSkillTriggerType.OnSelfUltMovieFadeOut, "bs_1061_3", 1,
                    self.OnMovieFadeOut)
end

bs_1061.OnUltRoleAction = function(self)
    -- function num : 0_6 , upvalues : _ENV
    LuaSkillCtrl:StartTimerInUlt(11, function()
        -- function num : 0_6_0 , upvalues : _ENV, self
        LuaSkillCtrl:CallPlayUltMovie();
        ((self.caster).auSource):PlayAudioById((self.config).audioId2)
    end, nil)
    local targetList = LuaSkillCtrl:CallTargetSelect(self, 7, 10)
    if targetList.Count == 0 then return end
    self:CallCasterWait(15);
    (self.caster):LookAtTarget((targetList[0]).targetRole)
    LuaSkillCtrl:CallRoleAction(self.caster, 1005)
    self.startEffect = LuaSkillCtrl:CallEffect(self.caster,
                                               (self.config).startEffect, self)
end

bs_1061.OnMovieFadeOut = function(self)
    -- function num : 0_7 , upvalues : _ENV
    ((self.caster).auSource):PlayAudioById((self.config).audioId3)
    LuaSkillCtrl:CallRoleAction(self.caster, 1006)
    self:RemoveTrigger(eSkillTriggerType.OnSelfUltMovieFadeOut)
    LuaSkillCtrl:CallBackViewTimeLine(self.caster, true)
    self:RemoveTrigger(eSkillTriggerType.AfterSelfUltMovieEnd)
end

bs_1061.OnMovieEnd = function(self)
    -- function num : 0_8
end

bs_1061.OnCasterDie = function(self)
    -- function num : 0_9 , upvalues : base
    (base.OnCasterDie)(self)
end

return bs_1061


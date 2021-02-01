-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_1065 = class("bs_1065", LuaSkillBase)
local base = LuaSkillBase
bs_1065.config = {
hurt_config = {hit_formula = 10010, basehurt_formula = 10090}
, 
real_Config = {basehurt_formula = 502}
, effectId = 10310, effectId1 = 10343, buffId = 113, audioId1 = 103, audioId2 = 104, audioId3 = 105}
bs_1065.ctor = function(self)
  -- function num : 0_0
end

bs_1065.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1
end

bs_1065.PlaySkill = function(self, data, selectTargetCoord, selectRoles)
  -- function num : 0_2 , upvalues : _ENV
  LuaSkillCtrl:CallBreakAllSkill(self.caster)
  self:CallCasterWait(23)
  self:GetSelectTargetAndExecute(selectRoles, BindCallback(self, self.CallSelectExecute))
  if selectTargetCoord ~= nil then
    local inputTarget = LuaSkillCtrl:GetTargetWithGrid(selectTargetCoord.x, selectTargetCoord.y)
    ;
    (self.caster):LookAtTarget(inputTarget)
    LuaSkillCtrl:CallRoleAction(self.caster, 1006)
    LuaSkillCtrl:CallEffect(inputTarget, (self.config).effectId, self)
  end
end

bs_1065.CallSelectExecute = function(self, role)
  -- function num : 0_3 , upvalues : _ENV
  if role ~= nil and role ~= nil and role.belongNum ~= (self.caster).belongNum and not role.unableSelect then
    LuaSkillCtrl:StartTimer(self, 5, BindCallback(self, self.CallSingleHurtEffect, role))
  end
end

bs_1065.CallSingleHurtEffect = function(self, role)
  -- function num : 0_4 , upvalues : _ENV
  LuaSkillCtrl:CallEffect(role, (self.config).effectId1, self, self.SkillEventFunc1, nil, 1)
end

bs_1065.SkillEventFunc1 = function(self, effect, eventId, target)
  -- function num : 0_5 , upvalues : _ENV
  if eventId == eBattleEffectEvent.Trigger then
    local skillResult = LuaSkillCtrl:CallSkillResult(effect, target)
    LuaSkillCtrl:HurtResult(skillResult, (self.config).hurt_config, nil, false)
    skillResult:EndResult()
    local roleBuffTier = (target.targetRole):GetBuffTier((self.config).buffId)
    if roleBuffTier > 0 then
      local hurt = roleBuffTier * (self.caster).pow * (self.arglist)[2] // 1000
      if hurt <= 0 then
        hurt = 1
      end
      LuaSkillCtrl:CallRealDamage(self, target, nil, (self.config).real_Config, {hurt}, false)
    end
  end
end

bs_1065.PlayUltEffect = function(self)
  -- function num : 0_6 , upvalues : _ENV
  LuaSkillCtrl:PlayAuSource(self.caster, (self.config).audioId1)
  LuaSkillCtrl:CallFocusTimeLine(self.caster)
  LuaSkillCtrl:CallBuff(self, self.caster, 196, 1, 15)
  self:AddTrigger(eSkillTriggerType.OnSelfUltMovieFadeOut, "bs_1065_3", 1, self.OnMovieFadeOut)
end

bs_1065.OnUltRoleAction = function(self)
  -- function num : 0_7 , upvalues : base, _ENV
  (base.OnUltRoleAction)(self)
  LuaSkillCtrl:StartTimerInUlt(7, function()
    -- function num : 0_7_0 , upvalues : _ENV, self
    LuaSkillCtrl:CallPlayUltMovie()
    LuaSkillCtrl:PlayAuSource(self.caster, (self.config).audioId2)
  end
, nil)
  self:CallCasterWait(20)
  LuaSkillCtrl:CallRoleAction(self.caster, 1005)
  LuaSkillCtrl:PlaySkillCv((self.caster).roleDataId)
end

bs_1065.OnMovieFadeOut = function(self)
  -- function num : 0_8 , upvalues : _ENV
  LuaSkillCtrl:PlayAuSource(self.caster, (self.config).audioId3)
  LuaSkillCtrl:CallRoleAction(self.caster, 1006)
  self:RemoveTrigger(eSkillTriggerType.OnSelfUltMovieFadeOut)
  LuaSkillCtrl:CallBackViewTimeLine(self.caster, true)
  self:RemoveTrigger(eSkillTriggerType.AfterSelfUltMovieEnd)
end

bs_1065.OnCasterDie = function(self)
  -- function num : 0_9 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_1065


-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_101304 = class("bs_101304", LuaSkillBase)
local base = LuaSkillBase
bs_101304.config = {
hurt_config = {hit_formula = 10010, basehurt_formula = 10076}
, effectId = 10543, buffId = 195}
bs_101304.ctor = function(self)
  -- function num : 0_0
end

bs_101304.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1
end

bs_101304.PlaySkill = function(self, data, selectTargetCoord, selectRoles)
  -- function num : 0_2 , upvalues : _ENV
  LuaSkillCtrl:CallBreakAllSkill(self.caster)
  self:CallCasterWait(13)
  self:GetSelectTargetAndExecute(selectRoles, BindCallback(self, self.CallSelectExecute))
  if selectTargetCoord ~= nil then
    local inputTarget = LuaSkillCtrl:GetTargetWithGrid(selectTargetCoord.x, selectTargetCoord.y)
    ;
    (self.caster):LookAtTarget(inputTarget)
    -- DECOMPILER ERROR at PC27: Confused about usage of register: R5 in 'UnsetPending'

    ;
    ((self.caster).recordTable).lastAttackRole = nil
    LuaSkillCtrl:CallEffect(inputTarget, (self.config).effectId, self)
  end
end

bs_101304.CallSelectExecute = function(self, role)
  -- function num : 0_3 , upvalues : _ENV
  if role ~= nil and role ~= nil and role.belongNum ~= (self.caster).belongNum and not role.unableSelect then
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, role)
    LuaSkillCtrl:HurtResult(skillResult, (self.config).hurt_config)
    skillResult:BuffResult((self.config).buffId, 1, 45)
    skillResult:EndResult()
  end
end

bs_101304.RealPlaySkill = function(self, target)
  -- function num : 0_4 , upvalues : _ENV
  LuaSkillCtrl:CallEffect(self.caster, (self.config).effectMap, self)
end

bs_101304.PlayUltEffect = function(self)
  -- function num : 0_5 , upvalues : _ENV
  LuaSkillCtrl:CallFocusTimeLine(self.caster)
  LuaSkillCtrl:CallBuff(self, self.caster, 196, 1, 15)
  self:AddTrigger(eSkillTriggerType.AfterSelfUltMovieEnd, "bs_101304_2", 1, self.OnMovieEnd)
  self:AddTrigger(eSkillTriggerType.OnSelfUltMovieFadeOut, "bs_101304_3", 1, self.OnMovieFadeOut)
end

bs_101304.OnUltRoleAction = function(self)
  -- function num : 0_6 , upvalues : _ENV
  LuaSkillCtrl:StartTimerInUlt(7, function()
    -- function num : 0_6_0 , upvalues : _ENV
    LuaSkillCtrl:CallPlayUltMovie()
  end
, nil)
  LuaSkillCtrl:CallRoleAction(self.caster, 1005)
end

bs_101304.OnMovieFadeOut = function(self)
  -- function num : 0_7 , upvalues : _ENV
  LuaSkillCtrl:CallRoleAction(self.caster, 1006)
  self:RemoveTrigger(eSkillTriggerType.OnSelfUltMovieFadeOut)
  self:RemoveTrigger(eSkillTriggerType.AfterSelfUltMovieEnd)
  LuaSkillCtrl:CallBackViewTimeLine(self.caster, true)
end

bs_101304.OnMovieEnd = function(self)
  -- function num : 0_8
end

bs_101304.OnCasterDie = function(self)
  -- function num : 0_9 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_101304

-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_101304 = class("bs_101304", LuaSkillBase)
local base = LuaSkillBase
bs_101304.config = {
    hurt_config = {hit_formula = 10010, basehurt_formula = 10076},
    effectId = 10543,
    buffId = 195
}
bs_101304.ctor = function(self)
    -- function num : 0_0
end

bs_101304.InitSkill = function(self, isMidwaySkill)
    -- function num : 0_1
end

bs_101304.PlaySkill = function(self, data, selectTargetCoord, selectRoles)
    -- function num : 0_2 , upvalues : _ENV
    LuaSkillCtrl:CallBreakAllSkill(self.caster)
    self:CallCasterWait(13)
    self:GetSelectTargetAndExecute(selectRoles,
                                   BindCallback(self, self.CallSelectExecute))
    if selectTargetCoord ~= nil then
        local inputTarget = LuaSkillCtrl:GetTargetWithGrid(selectTargetCoord.x,
                                                           selectTargetCoord.y);
        (self.caster):LookAtTarget(inputTarget) -- DECOMPILER ERROR at PC27: Confused about usage of register: R5 in 'UnsetPending'
        ;
        ((self.caster).recordTable).lastAttackRole = nil
        LuaSkillCtrl:CallEffect(inputTarget, (self.config).effectId, self)
    end
end

bs_101304.CallSelectExecute = function(self, role)
    -- function num : 0_3 , upvalues : _ENV
    if role ~= nil and role ~= nil and role.belongNum ~= (self.caster).belongNum and
        not role.unableSelect then
        local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, role)
        LuaSkillCtrl:HurtResult(skillResult, (self.config).hurt_config)
        skillResult:BuffResult((self.config).buffId, 1, 45)
        skillResult:EndResult()
    end
end

bs_101304.RealPlaySkill = function(self, target)
    -- function num : 0_4 , upvalues : _ENV
    LuaSkillCtrl:CallEffect(self.caster, (self.config).effectMap, self)
end

bs_101304.PlayUltEffect = function(self)
    -- function num : 0_5 , upvalues : _ENV
    LuaSkillCtrl:CallFocusTimeLine(self.caster)
    LuaSkillCtrl:CallBuff(self, self.caster, 196, 1, 15)
    self:AddTrigger(eSkillTriggerType.AfterSelfUltMovieEnd, "bs_101304_2", 1,
                    self.OnMovieEnd)
    self:AddTrigger(eSkillTriggerType.OnSelfUltMovieFadeOut, "bs_101304_3", 1,
                    self.OnMovieFadeOut)
end

bs_101304.OnUltRoleAction = function(self)
    -- function num : 0_6 , upvalues : _ENV
    LuaSkillCtrl:StartTimerInUlt(7, function()
        -- function num : 0_6_0 , upvalues : _ENV
        LuaSkillCtrl:CallPlayUltMovie()
    end, nil)
    LuaSkillCtrl:CallRoleAction(self.caster, 1005)
end

bs_101304.OnMovieFadeOut = function(self)
    -- function num : 0_7 , upvalues : _ENV
    LuaSkillCtrl:CallRoleAction(self.caster, 1006)
    self:RemoveTrigger(eSkillTriggerType.OnSelfUltMovieFadeOut)
    self:RemoveTrigger(eSkillTriggerType.AfterSelfUltMovieEnd)
    LuaSkillCtrl:CallBackViewTimeLine(self.caster, true)
end

bs_101304.OnMovieEnd = function(self)
    -- function num : 0_8
end

bs_101304.OnCasterDie = function(self)
    -- function num : 0_9 , upvalues : base
    (base.OnCasterDie)(self)
end

return bs_101304


-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_1071 = class("bs_1071", LuaSkillBase)
local base = LuaSkillBase
bs_1071.config = {effectIdAttack = 10294}
bs_1071.ctor = function(self)
  -- function num : 0_0
end

bs_1071.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1
  self.hurt_config = {}
end

bs_1071.PlaySkill = function(self, passData, selectRoles)
  -- function num : 0_2 , upvalues : _ENV
  if selectRoles ~= nil and selectRoles.Count > 0 and selectRoles.Count % 2 == 0 then
    for i = 0, selectRoles.Count - 2, 2 do
      local target = LuaSkillCtrl:GetTargetWithGrid(selectRoles[i], selectRoles[i + 1])
      if target:GetRole() ~= self.caster then
        LuaSkillCtrl:CallEffect(target, (self.config).effectIdAttack, self, self.SkillEventFunc)
      end
    end
  end
end

bs_1071.SkillEventFunc = function(self, effect, eventId, target)
  -- function num : 0_3 , upvalues : _ENV
  if eventId == eBattleEffectEvent.Trigger then
    local role = target:GetRole()
    if role == nil then
      return 
    end
    LuaSkillCtrl:CallBattleCamShake(1)
    local hurt = role.pow * (self.arglist)[1] // 1000
    if hurt <= 0 then
      hurt = 1
    end
    LuaSkillCtrl:RemoveLife(hurt, self, role)
  end
end

bs_1071.PlayUltEffect = function(self)
  -- function num : 0_4 , upvalues : _ENV
  LuaSkillCtrl:CallFocusTimeLine(self.caster)
  self:AddTrigger(eSkillTriggerType.AfterSelfUltMovieEnd, "bs_1071_2", 1, self.OnMovieEnd)
  self:AddTrigger(eSkillTriggerType.OnSelfUltMovieFadeOut, "bs_1071_3", 1, self.OnMovieFadeOut)
end

bs_1071.OnUltRoleAction = function(self)
  -- function num : 0_5 , upvalues : _ENV
  LuaSkillCtrl:StartTimerInUlt(19, function()
    -- function num : 0_5_0 , upvalues : _ENV
    LuaSkillCtrl:CallPlayUltMovie()
  end
, nil)
  self:CallCasterWait(20)
  LuaSkillCtrl:CallRoleAction(self.caster, 1005)
end

bs_1071.OnMovieFadeOut = function(self)
  -- function num : 0_6 , upvalues : _ENV
  LuaSkillCtrl:CallRoleAction(self.caster, 1006)
  self:RemoveTrigger(eSkillTriggerType.OnSelfUltMovieFadeOut)
  LuaSkillCtrl:CallBackViewTimeLine(self.caster, true)
  self:RemoveTrigger(eSkillTriggerType.AfterSelfUltMovieEnd)
end

bs_1071.OnMovieEnd = function(self)
  -- function num : 0_7
end

bs_1071.OnCasterDie = function(self)
  -- function num : 0_8 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_1071

-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_1071 = class("bs_1071", LuaSkillBase)
local base = LuaSkillBase
bs_1071.config = {effectIdAttack = 10294}
bs_1071.ctor = function(self)
    -- function num : 0_0
end

bs_1071.InitSkill = function(self, isMidwaySkill)
    -- function num : 0_1
    self.hurt_config = {}
end

bs_1071.PlaySkill = function(self, passData, selectRoles)
    -- function num : 0_2 , upvalues : _ENV
    if selectRoles ~= nil and selectRoles.Count > 0 and selectRoles.Count % 2 ==
        0 then
        for i = 0, selectRoles.Count - 2, 2 do
            local target = LuaSkillCtrl:GetTargetWithGrid(selectRoles[i],
                                                          selectRoles[i + 1])
            if target:GetRole() ~= self.caster then
                LuaSkillCtrl:CallEffect(target, (self.config).effectIdAttack,
                                        self, self.SkillEventFunc)
            end
        end
    end
end

bs_1071.SkillEventFunc = function(self, effect, eventId, target)
    -- function num : 0_3 , upvalues : _ENV
    if eventId == eBattleEffectEvent.Trigger then
        local role = target:GetRole()
        if role == nil then return end
        LuaSkillCtrl:CallBattleCamShake(1)
        local hurt = role.pow * (self.arglist)[1] // 1000
        if hurt <= 0 then hurt = 1 end
        LuaSkillCtrl:RemoveLife(hurt, self, role)
    end
end

bs_1071.PlayUltEffect = function(self)
    -- function num : 0_4 , upvalues : _ENV
    LuaSkillCtrl:CallFocusTimeLine(self.caster)
    self:AddTrigger(eSkillTriggerType.AfterSelfUltMovieEnd, "bs_1071_2", 1,
                    self.OnMovieEnd)
    self:AddTrigger(eSkillTriggerType.OnSelfUltMovieFadeOut, "bs_1071_3", 1,
                    self.OnMovieFadeOut)
end

bs_1071.OnUltRoleAction = function(self)
    -- function num : 0_5 , upvalues : _ENV
    LuaSkillCtrl:StartTimerInUlt(19, function()
        -- function num : 0_5_0 , upvalues : _ENV
        LuaSkillCtrl:CallPlayUltMovie()
    end, nil)
    self:CallCasterWait(20)
    LuaSkillCtrl:CallRoleAction(self.caster, 1005)
end

bs_1071.OnMovieFadeOut = function(self)
    -- function num : 0_6 , upvalues : _ENV
    LuaSkillCtrl:CallRoleAction(self.caster, 1006)
    self:RemoveTrigger(eSkillTriggerType.OnSelfUltMovieFadeOut)
    LuaSkillCtrl:CallBackViewTimeLine(self.caster, true)
    self:RemoveTrigger(eSkillTriggerType.AfterSelfUltMovieEnd)
end

bs_1071.OnMovieEnd = function(self)
    -- function num : 0_7
end

bs_1071.OnCasterDie = function(self)
    -- function num : 0_8 , upvalues : base
    (base.OnCasterDie)(self)
end

return bs_1071


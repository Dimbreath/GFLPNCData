local bs_1060 = class("bs_1060", LuaSkillBase)
local base = LuaSkillBase
bs_1060.config = {effectId = 10293, buffId = 66, 
hurt_config = {hit_formula = 10010, basehurt_formula = 10076}
, 
hurt_config2 = {hit_formula = 10010, basehurt_formula = 10162}
, audioIdStart = 117, audioIdMovie = 118, audioIdEnd = 119, movieEndRoleActionId = 1102}
bs_1060.ctor = function(self)
  -- function num : 0_0
end

bs_1060.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1
  self.hurt_config = {}
  self.skillEffect = nil
end

bs_1060.PlaySkill = function(self, data, selectTargetCoord, selectRoles)
  -- function num : 0_2 , upvalues : _ENV
  local gridTarget = nil
  if selectTargetCoord ~= nil then
    self:CallCasterWait(20)
    local gridTarget = LuaSkillCtrl:GetTargetWithGrid(selectTargetCoord.x, selectTargetCoord.y)
    if self.skillEffect ~= nil then
      (self.skillEffect):Die()
      self.skillEffect = nil
    end
    LuaSkillCtrl:StartTimer(nil, 3, BindCallback(self, self.RealPlaySkill, gridTarget))
  end
end

bs_1060.RealPlaySkill = function(self, target)
  -- function num : 0_3 , upvalues : _ENV
  self.skillEffect = LuaSkillCtrl:CallEffect(target, (self.config).effectId, self, self.SkillEventFunc, nil, 1)
  local targetList = LuaSkillCtrl:CallTargetSelect(self, 9, 10)
  for i = 0, targetList.Count - 1 do
    do
      do
        do
          if targetList[i] ~= nil and (targetList[i]).targetRole ~= nil and ((targetList[i]).targetRole).belongNum ~= eBattleRoleBelong.neutral and not LuaSkillCtrl:RoleContainsBuffFeature((targetList[i]).targetRole, eBuffFeatureType.CtrlImmunity) then
            local emptyGrid = LuaSkillCtrl:CallFindEmptyGridClosedToTargetInRange(target.x, target.y, (targetList[i]).targetRole)
            if emptyGrid ~= nil and LuaSkillCtrl:GetGridsDistance(emptyGrid.x, emptyGrid.y, target.x, target.y) < LuaSkillCtrl:GetGridsDistance(((targetList[i]).targetRole).x, ((targetList[i]).targetRole).y, target.x, target.y) then
              ((targetList[i]).targetRole):ResetRoleState()
              LuaSkillCtrl:CallPhaseMoveWithoutTurn(self, (targetList[i]).targetRole, emptyGrid.x, emptyGrid.y, 5)
            end
            LuaSkillCtrl:CallBuff(self, (targetList[i]).targetRole, 66, 1, (self.arglist)[2])
          end
          if targetList[i] ~= nil and (targetList[i]).targetRole ~= nil and ((targetList[i]).targetRole).belongNum ~= eBattleRoleBelong.neutral then
            LuaSkillCtrl:StartTimer(nil, 5, function()
    -- function num : 0_3_0 , upvalues : targetList, i, self, _ENV
    if ((targetList[i]).targetRole).hp <= 0 then
      return 
    end
    local hurtCfg = nil
    if self:IsConsumeSkill() then
      hurtCfg = (self.config).hurt_config2
    else
      hurtCfg = (self.config).hurt_config
    end
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, (targetList[i]).targetRole)
    LuaSkillCtrl:HurtResult(self, skillResult, hurtCfg, nil, false)
    skillResult:EndResult()
  end
)
          end
        end
        -- DECOMPILER ERROR at PC118: LeaveBlock: unexpected jumping out DO_STMT

      end
    end
  end
  LuaSkillCtrl:StartTimer(nil, (self.arglist)[2], function()
    -- function num : 0_3_1 , upvalues : self
    if self.skillEffect ~= nil then
      (self.skillEffect):Die()
      self.skillEffect = nil
    end
  end
)
  if self.startEffect ~= nil then
    (self.startEffect):Die()
    self.startEffect = nil
  end
end

bs_1060.PlayUltEffect = function(self)
  -- function num : 0_4 , upvalues : base, _ENV
  (base.PlayUltEffect)(self)
  LuaSkillCtrl:CallBuff(self, self.caster, 196, 1, 15, true)
  LuaSkillCtrl:CallFocusTimeLine(self.caster)
end

bs_1060.OnUltRoleAction = function(self)
  -- function num : 0_5 , upvalues : _ENV
  LuaSkillCtrl:StartTimerInUlt(self, 15, self.PlayUltMovie)
  LuaSkillCtrl:CallRoleAction(self.caster, 1005)
  LuaSkillCtrl:CallRoleAction(self.caster, 1101)
  self.startEffect = LuaSkillCtrl:CallEffect(self.caster, 10342, self)
end

bs_1060.OnSkipUltView = function(self)
  -- function num : 0_6 , upvalues : base
  (base.OnSkipUltView)(self)
end

bs_1060.OnMovieFadeOut = function(self)
  -- function num : 0_7 , upvalues : base
  (base.OnMovieFadeOut)(self)
end

bs_1060.OnCasterDie = function(self)
  -- function num : 0_8 , upvalues : base
  (base.OnCasterDie)(self)
end

bs_1060.LuaDispose = function(self)
  -- function num : 0_9 , upvalues : base
  (base.LuaDispose)(self)
  self.skillEffect = nil
  self.startEffect = nil
end

return bs_1060


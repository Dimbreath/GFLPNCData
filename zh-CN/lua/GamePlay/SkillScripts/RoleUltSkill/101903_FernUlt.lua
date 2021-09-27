local bs_101903 = class("bs_101903", LuaSkillBase)
local base = LuaSkillBase
bs_101903.config = {
hurt_config = {hit_formula = 0, basehurt_formula = 3010, crit_formula = 0}
, 
hurt_configF = {hit_formula = 0, basehurt_formula = 3029, crit_formula = 0}
, 
aoe_config = {effect_shape = 0, aoe_select_code = 4, aoe_range = 0}
, buffId_stun = 3006, selectId = 9, select_Range = 10, effect_start = 101901, effect_hit = 101902, effect_MoveSpeed = 7, buffFeature_ignoreCtrl = 15, audioIdStart = 101901, audioIdMovie = 101902, audioIdEnd = 101903}
bs_101903.ctor = function(self)
  -- function num : 0_0
end

bs_101903.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
end

bs_101903.PlaySkill = function(self, data, selectTargetCoord, selectRoles)
  -- function num : 0_2 , upvalues : _ENV
  self:CallCasterWait(20)
  local EnemyList = LuaSkillCtrl:CallTargetSelect(self, 9, 10)
  local border = LuaSkillCtrl:GetMapBorder()
  local effectTarget = LuaSkillCtrl:GetTargetWithGrid(3, 2)
  LuaSkillCtrl:CallEffect(effectTarget, (self.config).effect_start, self, nil, nil, nil)
  LuaSkillCtrl:StartTimer(self, 6, BindCallback(self, self.BeatBackAllRoles, EnemyList))
  LuaSkillCtrl:StartTimer(self, 7, BindCallback(self, self.OnMoveEnd, EnemyList))
end

bs_101903.BeatBackAllRoles = function(self, EnemyList)
  -- function num : 0_3 , upvalues : _ENV
  for i = 0, EnemyList.Count - 1 do
    local role = (EnemyList[i]).targetRole
    if role.hp > 0 then
      local IfRoleCotainsIgnoreCtrlBuff = LuaSkillCtrl:RoleContainsBuffFeature(role, (self.config).buffFeature_ignoreCtrl)
      if role ~= nil and role.belongNum ~= eBattleRoleBelong.neutral and IfRoleCotainsIgnoreCtrlBuff == false then
        local EnemyTargetGrid = LuaSkillCtrl:GetFurthestRightEmptyGrid(role.x, role.y)
        if EnemyTargetGrid ~= nil then
          LuaSkillCtrl:CallPhaseMoveWithoutTurn(self, role, EnemyTargetGrid.x, EnemyTargetGrid.y, (self.config).effect_MoveSpeed, 63, 1)
        end
      else
        do
          do
            if role ~= nil and role.belongNum ~= eBattleRoleBelong.neutral and IfRoleCotainsIgnoreCtrlBuff == true then
              local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, role, self.aoe_config)
              LuaSkillCtrl:HurtResult(self, skillResult, (self.config).hurt_config, {(self.arglist)[1]}, false)
              skillResult:EndResult()
            end
            -- DECOMPILER ERROR at PC73: LeaveBlock: unexpected jumping out DO_STMT

            -- DECOMPILER ERROR at PC73: LeaveBlock: unexpected jumping out IF_ELSE_STMT

            -- DECOMPILER ERROR at PC73: LeaveBlock: unexpected jumping out IF_STMT

            -- DECOMPILER ERROR at PC73: LeaveBlock: unexpected jumping out IF_THEN_STMT

            -- DECOMPILER ERROR at PC73: LeaveBlock: unexpected jumping out IF_STMT

          end
        end
      end
    end
  end
end

bs_101903.OnMoveEnd = function(self, EnemyList)
  -- function num : 0_4 , upvalues : _ENV
  for i = 0, EnemyList.Count - 1 do
    local role = (EnemyList[i]).targetRole
    if role.hp > 0 then
      local skillResult = (LuaSkillCtrl:CallSkillResultNoEffect(self, role))
      local hurtCfg = nil
      if self:IsConsumeSkill() then
        hurtCfg = (self.config).hurt_configF
      else
        hurtCfg = (self.config).hurt_config
      end
      LuaSkillCtrl:HurtResult(self, skillResult, hurtCfg, {(self.arglist)[1]}, false)
      skillResult:EndResult()
      LuaSkillCtrl:CallBuff(self, role, (self.config).buffId_stun, 1, (self.arglist)[2])
      LuaSkillCtrl:CallEffect(role, (self.config).effect_hit, self)
    end
  end
end

bs_101903.PlayUltEffect = function(self)
  -- function num : 0_5 , upvalues : base, _ENV
  (base.PlayUltEffect)(self)
  LuaSkillCtrl:CallBuff(self, self.caster, 196, 1, 15, true)
  LuaSkillCtrl:CallFocusTimeLine(self.caster)
end

bs_101903.OnUltRoleAction = function(self)
  -- function num : 0_6 , upvalues : base, _ENV
  (base.OnUltRoleAction)(self)
  LuaSkillCtrl:StartTimerInUlt(self, 7, self.PlayUltMovie)
  LuaSkillCtrl:CallRoleAction(self.caster, 1005, 1)
end

bs_101903.OnSkipUltView = function(self)
  -- function num : 0_7 , upvalues : base, _ENV
  (base.OnSkipUltView)(self)
  if self.roleActionAudio ~= nil then
    LuaSkillCtrl:StopAudioByBack(self.roleActionAudio)
    self.roleActionAudio = nil
  end
end

bs_101903.OnMovieFadeOut = function(self)
  -- function num : 0_8 , upvalues : _ENV, base
  LuaSkillCtrl:CallBackViewTimeLine(self.caster, true)
  ;
  (base.OnMovieFadeOut)(self)
end

bs_101903.OnCasterDie = function(self)
  -- function num : 0_9 , upvalues : base
  (base.OnCasterDie)(self)
end

bs_101903.LuaDispose = function(self)
  -- function num : 0_10 , upvalues : base
  (base.LuaDispose)(self)
end

return bs_101903


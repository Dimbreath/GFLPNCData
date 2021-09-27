local bs_102403 = class("bs_102403", LuaSkillBase)
local base = LuaSkillBase
bs_102403.config = {
hurt_config = {hit_formula = 10010, basehurt_formula = 10076}
, effect_missile = 102401, effect_back = 102403, buff_crit = 102401, audioIdStart = 102401, audioIdMovie = 102402, audioIdEnd = 102403}
bs_102403.ctor = function(self)
  -- function num : 0_0
end

bs_102403.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
end

bs_102403.PlaySkill = function(self, data, selectTargetCoord, selectRoles)
  -- function num : 0_2 , upvalues : _ENV
  self:CallCasterWait(20)
  if selectTargetCoord ~= nil then
    local inputTarget = LuaSkillCtrl:GetTargetWithGrid(selectTargetCoord.x, selectTargetCoord.y)
    do
      (self.caster):LookAtTarget(inputTarget)
      local targetlist_enemy = LuaSkillCtrl:FindAllRolesWithinRange(inputTarget, 1, true)
      local effectTarget = LuaSkillCtrl:FindAllGridsWithinRange(inputTarget, 1, true)
      for i = 0, 2 do
        local j = LuaSkillCtrl:CallRange(0, effectTarget.Count - 1)
        local RealEffectTarget = LuaSkillCtrl:GetTargetWithGrid((effectTarget[j]).x, (effectTarget[j]).y)
        LuaSkillCtrl:CallEffect(RealEffectTarget, (self.config).effect_missile, self)
      end
      LuaSkillCtrl:StartTimerInUlt(self, 10, function()
    -- function num : 0_2_0 , upvalues : targetlist_enemy, _ENV, self
    if targetlist_enemy ~= nil and targetlist_enemy.Count > 0 then
      for i = 0, targetlist_enemy.Count - 1 do
        local targetlist_hit_enemy = targetlist_enemy[i]
        do
          do
            if targetlist_hit_enemy.belongNum ~= eBattleRoleBelong.player and not targetlist_hit_enemy.unableSelect then
              local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, targetlist_hit_enemy)
              LuaSkillCtrl:HurtResult(self, skillResult, (self.config).hurt_config, nil, false)
              skillResult:EndResult()
            end
            if targetlist_hit_enemy.belongNum == eBattleRoleBelong.enemy and not targetlist_hit_enemy.unableSelect then
              LuaSkillCtrl:CallEffect(targetlist_hit_enemy, (self.config).effect_back, self, nil, self.caster)
              LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buff_crit, 1, (self.arglist)[4], false)
            end
            -- DECOMPILER ERROR at PC64: LeaveBlock: unexpected jumping out DO_STMT

          end
        end
      end
    end
  end
)
    end
  end
end

bs_102403.PlayUltEffect = function(self)
  -- function num : 0_3 , upvalues : base, _ENV
  (base.PlayUltEffect)(self)
  LuaSkillCtrl:CallBuff(self, self.caster, 196, 1, 15, true)
  LuaSkillCtrl:CallFocusTimeLine(self.caster)
end

bs_102403.OnUltRoleAction = function(self)
  -- function num : 0_4 , upvalues : base, _ENV
  (base.OnUltRoleAction)(self)
  LuaSkillCtrl:StartTimerInUlt(self, 7, self.PlayUltMovie)
  LuaSkillCtrl:CallRoleAction(self.caster, 1005, 1)
end

bs_102403.OnSkipUltView = function(self)
  -- function num : 0_5 , upvalues : base, _ENV
  (base.OnSkipUltView)(self)
  if self.roleActionAudio ~= nil then
    LuaSkillCtrl:StopAudioByBack(self.roleActionAudio)
    self.roleActionAudio = nil
  end
end

bs_102403.OnMovieFadeOut = function(self)
  -- function num : 0_6 , upvalues : _ENV, base
  LuaSkillCtrl:CallBackViewTimeLine(self.caster, true)
  ;
  (base.OnMovieFadeOut)(self)
end

bs_102403.OnCasterDie = function(self)
  -- function num : 0_7 , upvalues : base
  (base.OnCasterDie)(self)
end

bs_102403.LuaDispose = function(self)
  -- function num : 0_8 , upvalues : base
  (base.LuaDispose)(self)
end

return bs_102403


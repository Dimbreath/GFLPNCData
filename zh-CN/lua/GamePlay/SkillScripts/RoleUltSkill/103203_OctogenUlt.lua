local bs_103203 = class("bs_103203", LuaSkillBase)
local base = LuaSkillBase
bs_103203.config = {
hurt_config = {hit_formula = 10010, basehurt_formula = 10076}
, effect_Hit = 103208, effect_Zibao = 103209, effect_tuowei = 103211, buff_unselected = 69, buffFeature_ignoreDie = 6, audioIdStart = 103207, audioIdMovie = 103208, audioIdEnd = 103209}
bs_103203.ctor = function(self)
  -- function num : 0_0
end

bs_103203.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
end

bs_103203.PlaySkill = function(self, data, selectTargetCoord, selectRoles)
  -- function num : 0_2 , upvalues : _ENV
  self:CallCasterWait(20)
  LuaSkillCtrl:CallBreakAllSkill(self.caster)
  if selectTargetCoord ~= nil then
    local targetGrid = LuaSkillCtrl:GetTargetWithGrid(selectTargetCoord.x, selectTargetCoord.y)
    do
      (self.caster):LookAtTarget(targetGrid)
      local selfGrid = LuaSkillCtrl:GetGridWithRole(self.caster)
      local distance = LuaSkillCtrl:GetGridsDistance(selfGrid.x, selfGrid.y, targetGrid.x, targetGrid.y)
      local targetlist_enemy = LuaSkillCtrl:FindAllRolesWithinRange(targetGrid, 1, true)
      LuaSkillCtrl:CallEffect(targetGrid, (self.config).effect_tuowei, self)
      local flyTime = distance * 15 // 10
      do
        if targetGrid ~= nil then
          local EmptyGrid = LuaSkillCtrl:FindEmptyGridsWithinRange(targetGrid.x, targetGrid.y, 10, false)
          if EmptyGrid ~= nil then
            LuaSkillCtrl:CallPhaseMoveWithoutTurnAndAllowCcd(self, self.caster, (EmptyGrid[0]).x, (EmptyGrid[0]).y, flyTime, (self.config).buff_unselected)
          end
        end
        if targetGrid == nil then
          LuaSkillCtrl:CallPhaseMoveWithoutTurnAndAllowCcd(self, self.caster, selectTargetCoord.x, selectTargetCoord.y, flyTime, (self.config).buff_unselected)
        end
        local effect_zibao = LuaSkillCtrl:CallEffect(self.caster, (self.config).effect_Zibao, self)
        LuaSkillCtrl:StartTimer(self, flyTime, function()
    -- function num : 0_2_0 , upvalues : _ENV, targetGrid, self, targetlist_enemy
    LuaSkillCtrl:CallEffect(targetGrid, (self.config).effect_Hit, self)
    self:Boom()
    if targetlist_enemy ~= nil and targetlist_enemy.Count > 0 then
      for i = 0, targetlist_enemy.Count - 1 do
        local targetlist_hit_enemy = targetlist_enemy[i]
        if targetlist_hit_enemy.belongNum ~= eBattleRoleBelong.player and not targetlist_hit_enemy.unableSelect then
          local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, targetlist_hit_enemy)
          LuaSkillCtrl:HurtResult(self, skillResult, (self.config).hurt_config, nil, false)
          skillResult:EndResult()
        end
      end
    end
  end
)
      end
    end
  end
end

bs_103203.Boom = function(self)
  -- function num : 0_3 , upvalues : _ENV
  local IfRoleCotainsIgnoreDieBuff = LuaSkillCtrl:RoleContainsBuffFeature(self.caster, (self.config).buffFeature_ignoreDie)
  if IfRoleCotainsIgnoreDieBuff == true then
    local buff_ignoreDie = LuaSkillCtrl:GetRoleAllBuffsByFeature(self.caster, (self.config).buffFeature_ignoreDie)
    if buff_ignoreDie.Count > 0 then
      for i = 0, buff_ignoreDie.Count - 1 do
        LuaSkillCtrl:DispelBuff(self.caster, (buff_ignoreDie[i]).dataId, 0)
        IfRoleCotainsIgnoreDieBuff = false
      end
    end
  end
  do
    if (self.caster).hp > 0 and IfRoleCotainsIgnoreDieBuff == false then
      LuaSkillCtrl:RemoveLife((self.caster).hp, self, self.caster, true, nil, false, true, eHurtType.RealDmg, true)
    end
  end
end

bs_103203.PlayUltEffect = function(self)
  -- function num : 0_4 , upvalues : base, _ENV
  (base.PlayUltEffect)(self)
  LuaSkillCtrl:CallBuff(self, self.caster, 196, 1, 15, true)
  LuaSkillCtrl:CallFocusTimeLine(self.caster)
end

bs_103203.OnUltRoleAction = function(self)
  -- function num : 0_5 , upvalues : base, _ENV
  (base.OnUltRoleAction)(self)
  LuaSkillCtrl:StartTimerInUlt(self, 7, self.PlayUltMovie)
  LuaSkillCtrl:CallRoleAction(self.caster, 1005, 1)
end

bs_103203.OnCasterDie = function(self)
  -- function num : 0_6 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_103203


local bs_101003 = class("bs_101003", LuaSkillBase)
local base = LuaSkillBase
bs_101003.config = {effectId = 101006, buffId = 101003, audioIdStart = 101005, audioIdMovie = 101006, audioIdEnd = 101007, movieEndRoleActionId = 100}
bs_101003.ctor = function(self)
  -- function num : 0_0
end

bs_101003.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1
end

bs_101003.PlaySkill = function(self, data, selectTargetCoord, selectRoles)
  -- function num : 0_2 , upvalues : _ENV
  self:CallCasterWait(5)
  if selectTargetCoord ~= nil then
    local targetGrid = LuaSkillCtrl:GetTargetWithGrid(selectTargetCoord.x, selectTargetCoord.y)
    if targetGrid ~= nil then
      self:CallTogether(targetGrid)
      self:CallShield(targetGrid)
    end
  end
end

bs_101003.CallTogether = function(self, target)
  -- function num : 0_3 , upvalues : _ENV
  local targetList = LuaSkillCtrl:CallTargetSelect(self, 6, 10)
  for i = 0, targetList.Count - 1 do
    if targetList[i] ~= nil and (targetList[i]).targetRole ~= nil and ((targetList[i]).targetRole).belongNum ~= eBattleRoleBelong.neutral then
      local emptyGrid = LuaSkillCtrl:CallFindEmptyGridClosedToTargetInRange(target.x, target.y, (targetList[i]).targetRole)
      if emptyGrid ~= nil and LuaSkillCtrl:GetGridsDistance(emptyGrid.x, emptyGrid.y, target.x, target.y) < LuaSkillCtrl:GetGridsDistance(((targetList[i]).targetRole).x, ((targetList[i]).targetRole).y, target.x, target.y) then
        ((targetList[i]).targetRole):ResetRoleState()
        LuaSkillCtrl:CallPhaseMove(self, (targetList[i]).targetRole, emptyGrid.x, emptyGrid.y, 5)
      end
    end
  end
end

bs_101003.CallShield = function(self, targetGrid)
  -- function num : 0_4 , upvalues : _ENV
  local effect = LuaSkillCtrl:CallEffect(targetGrid, (self.config).effectId, self)
  local collisionEnter = BindCallback(self, self.OnCollisionEnter)
  local collisionExit = BindCallback(self, self.OnCollisionExit)
  LuaSkillCtrl:CallAddCircleColliderForEffect(effect, 100, eColliderInfluenceType.Player, nil, collisionEnter, collisionExit)
  LuaSkillCtrl:StartTimer(nil, (self.arglist)[2], BindCallback(self, function(table, effect)
    -- function num : 0_4_0
    if effect ~= nil then
      effect:Die()
      effect = nil
    end
  end
, effect))
end

bs_101003.OnCollisionEnter = function(self, collider, index, entity)
  -- function num : 0_5 , upvalues : _ENV
  if entity ~= nil and entity.hp > 0 and entity.belongNum == (self.caster).belongNum and not entity.unableSelect and entity.belongNum ~= eBattleRoleBelong.neutral then
    LuaSkillCtrl:CallBuff(self, entity, (self.config).buffId, 1)
  end
end

bs_101003.OnCollisionExit = function(self, collider, entity)
  -- function num : 0_6 , upvalues : _ENV
  if entity ~= nil and entity.hp > 0 and entity:GetBuffTier((self.config).buffId) >= 1 and entity.belongNum == (self.caster).belongNum and not entity.unableSelect and entity.belongNum ~= eBattleRoleBelong.neutral then
    LuaSkillCtrl:DispelBuff(entity, (self.config).buffId, 1)
  end
end

bs_101003.PlayUltEffect = function(self)
  -- function num : 0_7 , upvalues : base, _ENV
  (base.PlayUltEffect)(self)
  LuaSkillCtrl:CallBuff(self, self.caster, 196, 1, 15, true)
  LuaSkillCtrl:CallFocusTimeLine(self.caster)
end

bs_101003.OnUltRoleAction = function(self)
  -- function num : 0_8 , upvalues : base, _ENV
  (base.OnUltRoleAction)(self)
  LuaSkillCtrl:StartTimerInUlt(self, 7, self.PlayUltMovie, self)
  LuaSkillCtrl:CallRoleAction(self.caster, 1005)
end

bs_101003.OnSkipUltView = function(self)
  -- function num : 0_9 , upvalues : base
  (base.OnSkipUltView)(self)
end

bs_101003.OnMovieFadeOut = function(self)
  -- function num : 0_10 , upvalues : base
  (base.OnMovieFadeOut)(self)
end

bs_101003.OnCasterDie = function(self)
  -- function num : 0_11 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_101003


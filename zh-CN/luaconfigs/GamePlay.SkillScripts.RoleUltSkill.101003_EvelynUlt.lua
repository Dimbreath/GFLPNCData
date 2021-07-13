-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_101003 = class("bs_101003", LuaSkillBase)
local base = LuaSkillBase
bs_101003.config = {
hurt_config = {hit_formula = 10010, basehurt_formula = 10076}
, effectId = 10857, buffId = 277}
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
      local emptyGrid = LuaSkillCtrl:CallFindEmptyGridClosedToTarget(target.x, target.y, (targetList[i]).targetRole)
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
  LuaSkillCtrl:CallFocusTimeLine(self.caster)
  LuaSkillCtrl:CallBuff(self, self.caster, 196, 1, 15, true)
  self:AddTrigger(eSkillTriggerType.OnSelfUltMovieFadeOut, "bs_101003_3", 1, self.OnMovieFadeOut)
end

bs_101003.OnUltRoleAction = function(self)
  -- function num : 0_8 , upvalues : base, _ENV
  (base.OnUltRoleAction)(self)
  LuaSkillCtrl:StartTimerInUlt(self, 7, function()
    -- function num : 0_8_0 , upvalues : _ENV
    LuaSkillCtrl:CallPlayUltMovie()
  end
, nil)
  LuaSkillCtrl:CallRoleAction(self.caster, 1005)
end

bs_101003.OnMovieFadeOut = function(self)
  -- function num : 0_9 , upvalues : _ENV
  LuaSkillCtrl:CallRoleAction(self.caster, 100)
  self:RemoveSkillTrigger(eSkillTriggerType.OnSelfUltMovieFadeOut)
  LuaSkillCtrl:CallBackViewTimeLine(self.caster, true)
end

bs_101003.OnCasterDie = function(self)
  -- function num : 0_10 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_101003


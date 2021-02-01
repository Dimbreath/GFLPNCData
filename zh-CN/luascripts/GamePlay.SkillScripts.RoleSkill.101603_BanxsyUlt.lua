-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_101603 = class("bs_101603", LuaSkillBase)
local base = LuaSkillBase
bs_101603.config = {
hurt_config = {hit_formula = 10010, basehurt_formula = 10076}
, effectId = 10677, effectId_road = 10676, buffId = 222}
bs_101603.ctor = function(self)
  -- function num : 0_0
end

bs_101603.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1
end

bs_101603.PlaySkill = function(self, data, selectTargetCoord, selectRoles)
  -- function num : 0_2 , upvalues : _ENV
  if selectTargetCoord ~= nil then
    local targetGrid = LuaSkillCtrl:GetTargetWithGrid(selectTargetCoord.x, selectTargetCoord.y)
    if targetGrid ~= nil then
      local fromGrid = LuaSkillCtrl:GetTargetWithGrid((self.caster).x, (self.caster).y)
      LuaSkillCtrl:CallEffect(targetGrid, (self.config).effectId_road, self, nil)
      LuaSkillCtrl:CallPhaseMove(self, self.caster, selectTargetCoord.x, selectTargetCoord.y, 8)
      self:GetSelectTargetAndExecute(selectRoles, BindCallback(self, self.CallSelectExecute))
      -- DECOMPILER ERROR at PC41: Confused about usage of register: R6 in 'UnsetPending'

      ;
      ((self.caster).recordTable).lastAttackRole = nil
    end
  end
end

bs_101603.CallSelectExecute = function(self, role)
  -- function num : 0_3 , upvalues : _ENV
  if role ~= nil and role.belongNum ~= (self.caster).belongNum and not role.unableSelect and role.belongNum ~= eBattleRoleBelong.neutral then
    self:PaintGrid(role)
  end
end

bs_101603.PaintGrid = function(self, role)
  -- function num : 0_4 , upvalues : _ENV
  local effect = LuaSkillCtrl:CallEffect(role, (self.config).effectId, self)
  local collisionEnter = BindCallback(self, self.OnCollisionEnter)
  local collisionExit = BindCallback(self, self.OnCollisionExit)
  LuaSkillCtrl:CallAddCircleColliderForEffect(effect, 100, eColliderInfluenceType.Enemy, nil, collisionEnter, collisionExit)
  LuaSkillCtrl:StartTimer(self, 75, BindCallback(self, function(table, effect)
    -- function num : 0_4_0
    if effect ~= nil then
      effect:Die()
      effect = nil
    end
  end
, effect))
end

bs_101603.OnCollisionEnter = function(self, index, entity)
  -- function num : 0_5 , upvalues : _ENV
  if entity ~= nil and entity.hp > 0 and entity.belongNum ~= (self.caster).belongNum and not entity.unableSelect and entity.belongNum ~= eBattleRoleBelong.neutral then
    LuaSkillCtrl:CallBuff(self, entity, (self.config).buffId, 1)
  end
end

bs_101603.OnCollisionExit = function(self, entity)
  -- function num : 0_6 , upvalues : _ENV
  if entity ~= nil and entity.hp > 0 and entity:GetBuffTier((self.config).buffId) >= 1 and entity.belongNum ~= (self.caster).belongNum and not entity.unableSelect and entity.belongNum ~= eBattleRoleBelong.neutral then
    LuaSkillCtrl:DispelBuff(entity, (self.config).buffId, 1)
  end
end

bs_101603.PlayUltEffect = function(self)
  -- function num : 0_7 , upvalues : _ENV
  LuaSkillCtrl:CallFocusTimeLine(self.caster)
  LuaSkillCtrl:CallBuff(self, self.caster, 196, 1, 15)
  self:AddTrigger(eSkillTriggerType.OnSelfUltMovieFadeOut, "bs_101603_3", 1, self.OnMovieFadeOut)
end

bs_101603.OnUltRoleAction = function(self)
  -- function num : 0_8 , upvalues : base, _ENV
  (base.OnUltRoleAction)(self)
  LuaSkillCtrl:StartTimerInUlt(7, function()
    -- function num : 0_8_0 , upvalues : _ENV
    LuaSkillCtrl:CallPlayUltMovie()
  end
, nil)
  LuaSkillCtrl:CallRoleAction(self.caster, 1005)
  LuaSkillCtrl:PlaySkillCv((self.caster).roleDataId)
end

bs_101603.OnMovieFadeOut = function(self)
  -- function num : 0_9 , upvalues : _ENV
  LuaSkillCtrl:CallRoleAction(self.caster, 1005)
  self:RemoveTrigger(eSkillTriggerType.OnSelfUltMovieFadeOut)
  self:RemoveTrigger(eSkillTriggerType.AfterSelfUltMovieEnd)
  LuaSkillCtrl:CallBackViewTimeLine(self.caster, true)
end

bs_101603.OnCasterDie = function(self)
  -- function num : 0_10 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_101603


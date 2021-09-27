local bs_102603 = class("bs_102603", LuaSkillBase)
local base = LuaSkillBase
bs_102603.config = {
heal_config = {baseheal_formula = 10088}
, 
heal_configF = {baseheal_formula = 102601}
, effectId_Start = 102601, effectId_Loop = 102602, effectId_End = 102603, buffID = 102603, audioIdStart = 102601, audioIdMovie = 102602}
bs_102603.ctor = function(self)
  -- function num : 0_0
end

bs_102603.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
end

bs_102603.PlaySkill = function(self, data, selectTargetCoord, selectRolesdata)
  -- function num : 0_2 , upvalues : _ENV
  self:CallCasterWait(5)
  if selectTargetCoord ~= nil then
    local targetGrid = LuaSkillCtrl:GetTargetWithGrid(selectTargetCoord.x, selectTargetCoord.y)
    do
      local effect = LuaSkillCtrl:CallEffect(targetGrid, (self.config).effectId_Loop, self)
      local collisionEnter = BindCallback(self, self.OnCollisionEnter)
      local collisionExit = BindCallback(self, self.OnCollisionExit)
      LuaSkillCtrl:CallAddCircleColliderForEffect(effect, 100, eColliderInfluenceType.Player, nil, collisionEnter, collisionExit)
      LuaSkillCtrl:StartTimer(nil, (self.arglist)[1], function()
    -- function num : 0_2_0 , upvalues : effect, _ENV, targetGrid, self
    if effect ~= nil then
      effect:Die()
      effect = nil
      local targetlist_heal = LuaSkillCtrl:FindAllRolesWithinRange(targetGrid, 1, true)
      if targetlist_heal ~= nil and targetlist_heal.Count > 0 then
        for i = 0, targetlist_heal.Count - 1 do
          local targetlist_heal_ally = targetlist_heal[i]
          if targetlist_heal_ally.belongNum == (self.caster).belongNum then
            local skillResult = (LuaSkillCtrl:CallSkillResultNoEffect(self, targetlist_heal_ally))
            local healCfg = nil
            if self:IsConsumeSkill() then
              healCfg = (self.config).heal_configF
            else
              healCfg = (self.config).heal_config
            end
            LuaSkillCtrl:HealResult(skillResult, healCfg)
            skillResult:EndResult()
          end
        end
      end
    end
  end
)
    end
  end
end

bs_102603.OnCollisionEnter = function(self, collider, index, entity)
  -- function num : 0_3 , upvalues : _ENV
  if entity ~= nil and entity.hp > 0 and entity.belongNum == (self.caster).belongNum and not entity.unableSelect and entity.belongNum ~= eBattleRoleBelong.neutral then
    LuaSkillCtrl:CallBuff(self, entity, (self.config).buffID, 1)
  end
end

bs_102603.OnCollisionExit = function(self, collider, entity)
  -- function num : 0_4 , upvalues : _ENV
  if entity ~= nil and entity.hp > 0 and entity:GetBuffTier((self.config).buffID) >= 1 then
    LuaSkillCtrl:DispelBuff(entity, (self.config).buffID, 1)
  end
end

bs_102603.PlayUltEffect = function(self)
  -- function num : 0_5 , upvalues : base, _ENV
  (base.PlayUltEffect)(self)
  LuaSkillCtrl:CallBuff(self, self.caster, 196, 1, 15, true)
  LuaSkillCtrl:CallFocusTimeLine(self.caster)
end

bs_102603.OnUltRoleAction = function(self)
  -- function num : 0_6 , upvalues : base, _ENV
  (base.OnUltRoleAction)(self)
  LuaSkillCtrl:StartTimerInUlt(self, 7, self.PlayUltMovie)
  LuaSkillCtrl:CallRoleAction(self.caster, 1005, 1)
  LuaSkillCtrl:CallEffect(self.caster, (self.config).effectId_Start, self)
end

bs_102603.OnSkipUltView = function(self)
  -- function num : 0_7 , upvalues : base
  (base.OnSkipUltView)(self)
end

bs_102603.OnMovieFadeOut = function(self)
  -- function num : 0_8 , upvalues : base
  (base.OnMovieFadeOut)(self)
end

bs_102603.OnCasterDie = function(self)
  -- function num : 0_9 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_102603


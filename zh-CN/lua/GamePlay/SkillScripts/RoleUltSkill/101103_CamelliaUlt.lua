local bs_101103 = class("bs_101103", LuaSkillBase)
local base = LuaSkillBase
bs_101103.config = {
hurt_config = {hit_formula = 10010, basehurt_formula = 10076}
, 
hurt_configF = {hit_formula = 10010, basehurt_formula = 10164}
, effectStart = 101101, effectEnd = 101102, selectTargetId = 9, buffID_jifei = 101104, buffID_dingshen = 101101, audioIdStart = 101106, audioIdMovie = 101107, audioIdEnd = 101108}
bs_101103.ctor = function(self)
  -- function num : 0_0
end

bs_101103.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
end

bs_101103.PlaySkill = function(self, data, selectTargetCoord, selectRoles)
  -- function num : 0_2 , upvalues : _ENV
  self:CallCasterWait(5)
  if selectTargetCoord ~= nil then
    local targetGrid = LuaSkillCtrl:GetTargetWithGrid(selectTargetCoord.x, selectTargetCoord.y)
    do
      local effect = LuaSkillCtrl:CallEffect(targetGrid, (self.config).effectStart, self)
      local collisionEnter = BindCallback(self, self.OnCollisionEnter)
      local collisionExit = BindCallback(self, self.OnCollisionExit)
      local targetlist_jifei = LuaSkillCtrl:FindAllRolesWithinRange(targetGrid, 1, true)
      if targetlist_jifei ~= nil and targetlist_jifei.Count > 0 then
        for i = 0, targetlist_jifei.Count - 1 do
          local targetlist_jifei_enemy = targetlist_jifei[i]
          if targetlist_jifei_enemy.belongNum ~= eBattleRoleBelong.player then
            local skillResult = (LuaSkillCtrl:CallSkillResultNoEffect(self, targetlist_jifei_enemy))
            local hurtCfg = nil
            if self:IsConsumeSkill() then
              hurtCfg = (self.config).hurt_configF
            else
              hurtCfg = (self.config).hurt_config
            end
            LuaSkillCtrl:HurtResult(self, skillResult, hurtCfg, nil, false)
            LuaSkillCtrl:CallBuff(self, targetlist_jifei_enemy, (self.config).buffID_jifei, 1, 15)
            skillResult:EndResult()
          end
        end
      end
      do
        LuaSkillCtrl:CallAddCircleColliderForEffect(effect, 100, eColliderInfluenceType.Enemy, nil, collisionEnter, collisionExit)
        LuaSkillCtrl:StartTimer(nil, (self.arglist)[2], function()
    -- function num : 0_2_0 , upvalues : effect
    if effect ~= nil then
      effect:Die()
      effect = nil
    end
  end
)
      end
    end
  end
end

bs_101103.OnCollisionEnter = function(self, collider, index, entity)
  -- function num : 0_3 , upvalues : _ENV
  if entity ~= nil and entity.hp > 0 and entity.belongNum ~= (self.caster).belongNum and not entity.unableSelect and entity.belongNum == eBattleRoleBelong.enemy then
    LuaSkillCtrl:CallBuff(self, entity, (self.config).buffID_dingshen, 1)
  end
end

bs_101103.OnCollisionExit = function(self, collider, entity)
  -- function num : 0_4 , upvalues : _ENV
  if entity ~= nil and entity.hp > 0 and entity:GetBuffTier((self.config).buffID_dingshen) >= 1 then
    LuaSkillCtrl:DispelBuff(entity, (self.config).buffID_dingshen, 1)
  end
end

bs_101103.PlayUltEffect = function(self)
  -- function num : 0_5 , upvalues : base, _ENV
  (base.PlayUltEffect)(self)
  LuaSkillCtrl:CallBuff(self, self.caster, 196, 1, 15, true)
  LuaSkillCtrl:CallFocusTimeLine(self.caster)
end

bs_101103.OnUltRoleAction = function(self)
  -- function num : 0_6 , upvalues : base, _ENV
  (base.OnUltRoleAction)(self)
  LuaSkillCtrl:StartTimerInUlt(self, 7, self.PlayUltMovie)
  LuaSkillCtrl:CallRoleAction(self.caster, 1005, 1)
end

bs_101103.OnSkipUltView = function(self)
  -- function num : 0_7 , upvalues : base, _ENV
  (base.OnSkipUltView)(self)
  if self.roleActionAudio ~= nil then
    LuaSkillCtrl:StopAudioByBack(self.roleActionAudio)
    self.roleActionAudio = nil
  end
end

bs_101103.OnMovieFadeOut = function(self)
  -- function num : 0_8 , upvalues : base
  (base.OnMovieFadeOut)(self)
end

bs_101103.OnCasterDie = function(self)
  -- function num : 0_9 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_101103


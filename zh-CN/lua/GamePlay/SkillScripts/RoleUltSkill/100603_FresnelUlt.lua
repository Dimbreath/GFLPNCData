local bs_100603 = class("bs_100603", LuaSkillBase)
local base = LuaSkillBase
bs_100603.config = {
hurt_config = {hit_formula = 0, basehurt_formula = 3010, crit_formula = 0}
, 
hurt_configF = {hit_formula = 0, basehurt_formula = 3029, crit_formula = 0}
, 
real_Config = {basehurt_formula = 3010, lifesteal_formula = 0, spell_lifesteal_formula = 0, returndamage_formula = 0, hurt_type = 2}
, 
real_ConfigF = {basehurt_formula = 3029, lifesteal_formula = 0, spell_lifesteal_formula = 0, returndamage_formula = 0, hurt_type = 2}
, effectId_start = 100611, buffId_lz1 = 100601, selectId = 9, select_range = 10, start_time = 5, buffId = 3011, audioIdStart = 100606, audioIdMovie = 100607, audioIdEnd = 100608, movieEndRoleActionId = 1006}
bs_100603.ctor = function(self)
  -- function num : 0_0
end

bs_100603.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1
end

bs_100603.PlaySkill = function(self, data, selectTargetCoord, selectRoles)
  -- function num : 0_2 , upvalues : _ENV
  LuaSkillCtrl:CallBreakAllSkill(self.caster)
  self:CallCasterWait(20)
  if selectTargetCoord ~= nil then
    local inputTarget = LuaSkillCtrl:GetTargetWithGrid(selectTargetCoord.x, selectTargetCoord.y)
    do
      (self.caster):LookAtTarget(inputTarget)
      local effect = LuaSkillCtrl:CallEffect(inputTarget, (self.config).effectId_start, self)
      LuaSkillCtrl:StartTimer(nil, (self.arglist)[1], BindCallback(self, self.DelEffect, effect))
      local loopSteps = (self.arglist)[1] // 15 - 1
      for i = 0, loopSteps do
        LuaSkillCtrl:StartTimer(self, i * 15, function()
    -- function num : 0_2_0 , upvalues : _ENV, inputTarget, self
    local targetlist_enemy = LuaSkillCtrl:FindAllRolesWithinRange(inputTarget, 1, true)
    if targetlist_enemy.Count <= 0 then
      return 
    end
    for i = 0, targetlist_enemy.Count - 1 do
      local target = targetlist_enemy[i]
      if target ~= nil and target.hp > 0 and target.belongNum ~= eBattleRoleBelong.player and not target.unableSelect then
        local skillResult = (LuaSkillCtrl:CallSkillResultNoEffect(self, target))
        local hurtCfg, hurtCfg2 = nil, nil
        if self:IsConsumeSkill() then
          hurtCfg = (self.config).hurt_configF
          hurtCfg2 = (self.config).real_ConfigF
        else
          hurtCfg = (self.config).hurt_config
          hurtCfg2 = (self.config).real_Config
        end
        LuaSkillCtrl:HurtResult(self, skillResult, hurtCfg, {(self.arglist)[2]})
        skillResult:EndResult()
        local roleBuffTier = (targetlist_enemy[i]):GetBuffTier((self.config).buffId)
        if roleBuffTier > 0 then
          local hurt = roleBuffTier * (self.arglist)[3]
          LuaSkillCtrl:CallRealDamage(self, target, nil, hurtCfg2, {hurt}, true)
        end
      end
    end
  end
)
      end
    end
  end
end

bs_100603.DelEffect = function(self, effect)
  -- function num : 0_3
  if effect ~= nil then
    effect:Die()
    effect = nil
  end
end

bs_100603.PlayUltEffect = function(self)
  -- function num : 0_4 , upvalues : base, _ENV
  (base.PlayUltEffect)(self)
  LuaSkillCtrl:CallBuff(self, self.caster, 3003, 1, 15, true)
  LuaSkillCtrl:CallFocusTimeLine(self.caster)
end

bs_100603.OnUltRoleAction = function(self)
  -- function num : 0_5 , upvalues : base, _ENV
  (base.OnUltRoleAction)(self)
  LuaSkillCtrl:StartTimerInUlt(self, 8, self.PlayUltMovie, self)
  LuaSkillCtrl:CallRoleAction(self.caster, 1005)
end

bs_100603.OnSkipUltView = function(self)
  -- function num : 0_6 , upvalues : base
  (base.OnSkipUltView)(self)
end

bs_100603.OnMovieFadeOut = function(self)
  -- function num : 0_7 , upvalues : base
  (base.OnMovieFadeOut)(self)
end

bs_100603.OnCasterDie = function(self)
  -- function num : 0_8 , upvalues : _ENV
  LuaSkillCtrl:RemoveHandleAllTrigger(self.cskill)
  self:RemoveAllBreakKillEffects()
  self:RemoveAllLuaTrigger()
end

return bs_100603


local bs_102803 = class("bs_102803", LuaSkillBase)
local base = LuaSkillBase
bs_102803.config = {
hurt_config = {hit_formula = 0, basehurt_formula = 10076}
, 
hurt_configF = {hit_formula = 0, basehurt_formula = 10164}
, 
hurt_config1F = {hit_formula = 0, basehurt_formula = 10165}
, 
hurt_config1 = {hit_formula = 0, basehurt_formula = 10159}
, 
aoe_config = {effect_shape = 2, aoe_select_code = 4, aoe_range = 1}
, effectId = 10869, effectId_hit = 10871, movieEndRoleActionId = 100, audioIdStart = 102801, audioIdMovie = 102802, audioIdEnd = 102803}
bs_102803.ctor = function(self)
  -- function num : 0_0
end

bs_102803.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1
end

bs_102803.PlaySkill = function(self, data, selectTargetCoord, selectRoles)
  -- function num : 0_2 , upvalues : _ENV
  self:CallCasterWait(5)
  if selectTargetCoord ~= nil then
    local targetGrid = LuaSkillCtrl:GetTargetWithGrid(selectTargetCoord.x, selectTargetCoord.y)
    if targetGrid ~= nil then
      local effect = LuaSkillCtrl:CallEffect(targetGrid, (self.config).effectId, self)
      LuaSkillCtrl:StartTimer(self, (self.arglist)[3], BindCallback(self, self.DelEffect, effect))
      self:CallFace(targetGrid)
    end
  end
  do
    return self:GetSelectTargetAndExecute(selectRoles, BindCallback(self, self.CallSelectExecute))
  end
end

bs_102803.DelEffect = function(self, effect)
  -- function num : 0_3
  if effect ~= nil then
    effect:Die()
    effect = nil
  end
end

bs_102803.CallSelectExecute = function(self, target)
  -- function num : 0_4 , upvalues : _ENV
  if target ~= nil and target.belongNum ~= (self.caster).belongNum and not target.unableSelect then
    LuaSkillCtrl:StartTimer(nil, 3, BindCallback(self, function()
    -- function num : 0_4_0 , upvalues : _ENV, self, target
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
    for i = 0, (skillResult.roleList).Count - 1 do
      LuaSkillCtrl:CallEffect((skillResult.roleList)[i], (self.config).effectId_hit, self)
    end
    local hurtCfg = nil
    if self:IsConsumeSkill() then
      hurtCfg = (self.config).hurt_configF
    else
      hurtCfg = (self.config).hurt_config
    end
    LuaSkillCtrl:HurtResult(self, skillResult, hurtCfg, nil, false)
    skillResult:EndResult()
  end
))
  end
end

bs_102803.CallFace = function(self, targetGrid)
  -- function num : 0_5 , upvalues : _ENV
  LuaSkillCtrl:StartTimer(nil, 15, BindCallback(self, function()
    -- function num : 0_5_0 , upvalues : _ENV, self, targetGrid
    local skillResult = (LuaSkillCtrl:CallSkillResultNoEffect(self, targetGrid, (self.config).aoe_config))
    local hurtCfg1 = nil
    if self:IsConsumeSkill() then
      hurtCfg1 = (self.config).hurt_config1F
    else
      hurtCfg1 = (self.config).hurt_config1
    end
    LuaSkillCtrl:HurtResult(self, skillResult, hurtCfg1, nil, false)
    skillResult:EndResult()
  end
), self, (self.arglist)[3] // 15 - 1)
end

bs_102803.PlayUltEffect = function(self)
  -- function num : 0_6 , upvalues : base, _ENV
  (base.PlayUltEffect)(self)
  LuaSkillCtrl:CallBuff(self, self.caster, 196, 1, 15, true)
  LuaSkillCtrl:CallFocusTimeLine(self.caster)
end

bs_102803.OnUltRoleAction = function(self)
  -- function num : 0_7 , upvalues : base, _ENV
  (base.OnUltRoleAction)(self)
  LuaSkillCtrl:StartTimerInUlt(self, 7, self.PlayUltMovie)
  LuaSkillCtrl:CallRoleAction(self.caster, 1004)
end

bs_102803.OnMovieFadeOut = function(self)
  -- function num : 0_8 , upvalues : base
  (base.OnMovieFadeOut)(self)
end

bs_102803.OnCasterDie = function(self)
  -- function num : 0_9 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_102803


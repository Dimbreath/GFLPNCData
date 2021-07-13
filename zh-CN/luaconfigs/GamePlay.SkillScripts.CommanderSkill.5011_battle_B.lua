-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_5011 = class("bs_5011", LuaSkillBase)
local base = LuaSkillBase
bs_5011.config = {effectIdAttack = 10308, buffId = 251, buffTier = 1, effectId_bnfffire = 10165, 
HurtConfig = {basehurt_formula = 10127}
, 
HurtConfig_ex = {hit_formula = 0, basehurt_formula = 10133, crit_formula = 0, lifesteal_formula = 0, spell_lifesteal_formula = 0, returndamage_formula = 0}
, audioId_start = 133, audioId_hit = 134}
bs_5011.ctor = function(self)
  -- function num : 0_0
end

bs_5011.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
end

bs_5011.PlaySkill = function(self, data, selectTargetCoord, selectRoles)
  -- function num : 0_2 , upvalues : _ENV
  return self:GetSelectTargetAndExecute(selectRoles, BindCallback(self, self.CallSelectExecute))
end

bs_5011.CallSelectExecute = function(self, role)
  -- function num : 0_3 , upvalues : _ENV
  if role ~= nil and role ~= nil and role.belongNum ~= (self.caster).belongNum and not role.unableSelect then
    LuaSkillCtrl:CallEffect(role, (self.config).effectIdAttack, self, self.SkillEventFunc)
    LuaSkillCtrl:PlayAuSource(role, (self.config).audioId_start)
  end
end

bs_5011.SkillEventFunc = function(self, effect, eventId, target)
  -- function num : 0_4 , upvalues : _ENV
  if eventId == eBattleEffectEvent.Trigger then
    LuaSkillCtrl:CallBattleCamShake(2)
    local highAttRole = LuaSkillCtrl:CallTargetSelect(self, 46, 20)
    if highAttRole ~= nil and highAttRole.Count > 0 and highAttRole[0] ~= nil then
      local skill_intensity = ((highAttRole[0]).targetRole).skill_intensity
      do
        LuaSkillCtrl:StartTimer(self, 6, function()
    -- function num : 0_4_0 , upvalues : target, _ENV, self, skill_intensity
    local role = target:GetRole()
    if role == nil then
      return 
    end
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
    LuaSkillCtrl:HurtResult(self, skillResult, (self.config).HurtConfig, {skill_intensity}, true)
    skillResult:EndResult()
    if (self.arglist)[6] >= 1 then
      LuaSkillCtrl:CallBuffRepeated(self, role, (self.config).buffId, (self.config).buffTier, (self.arglist)[4], nil, self.OnBuffExecute, skill_intensity)
    else
      LuaSkillCtrl:CallBuffRepeated(self, role, (self.config).buffId, (self.config).buffTier, (self.arglist)[2], nil, self.OnBuffExecute, skill_intensity)
    end
    LuaSkillCtrl:PlayAuSource(role, (self.config).audioId_hit)
  end
)
      end
    end
  end
end

bs_5011.OnBuffExecute = function(self, skill_intensity, buff, targetRole)
  -- function num : 0_5 , upvalues : _ENV
  local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, targetRole)
  LuaSkillCtrl:HurtResult(self, skillResult, (self.config).HurtConfig_ex, {skill_intensity}, true)
  skillResult:EndResult()
  LuaSkillCtrl:CallEffect(targetRole, (self.config).effectId_bnfffire, self)
end

bs_5011.OnCasterDie = function(self)
  -- function num : 0_6 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_5011


local bs_5142 = class("bs_5142", LuaSkillBase)
local base = LuaSkillBase
bs_5142.config = {effectIdAttack = 514201, buffId = 66, buffTier = 1, buffId_hurt = 252, 
HurtConfig = {hit_formula = 0, basehurt_formula = 10127}
, audioId_start = 131, audioId_hit = 132}
bs_5142.ctor = function(self)
  -- function num : 0_0
end

bs_5142.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
end

bs_5142.PlaySkill = function(self, data, selectTargetCoord, selectRoles)
  -- function num : 0_2 , upvalues : _ENV
  return self:GetSelectTargetAndExecute(selectRoles, BindCallback(self, self.CallSelectExecute))
end

bs_5142.CallSelectExecute = function(self, role)
  -- function num : 0_3 , upvalues : _ENV
  if role ~= nil and role ~= nil and role.belongNum ~= (self.caster).belongNum and not role.unableSelect then
    LuaSkillCtrl:CallEffect(role, (self.config).effectIdAttack, self, self.SkillEventFunc)
    LuaSkillCtrl:PlayAuSource(role, (self.config).audioId_start)
  end
end

bs_5142.SkillEventFunc = function(self, effect, eventId, target)
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
    skillResult:BuffResult((self.config).buffId, (self.config).buffTier, (self.arglist)[2])
    LuaSkillCtrl:HurtResult(self, skillResult, (self.config).HurtConfig, {skill_intensity}, true)
    skillResult:EndResult()
    LuaSkillCtrl:CallBuff(self, role, (self.config).buffId_hurt, (self.arglist)[3])
    LuaSkillCtrl:PlayAuSource(role, (self.config).audioId_hit)
  end
)
      end
    end
  end
end

bs_5142.OnCasterDie = function(self)
  -- function num : 0_5 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_5142


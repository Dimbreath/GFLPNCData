-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_5002 = class("bs_5002", LuaSkillBase)
local base = LuaSkillBase
bs_5002.config = {effectIdAttack = 10296, buffId = 246, buffTier = 1, 
HurtConfig_1 = {basehurt_formula = 10128}
, 
HurtConfig_2 = {basehurt_formula = 10129}
, audioId_start = 122, audioId_hit = 123}
bs_5002.ctor = function(self)
  -- function num : 0_0
end

bs_5002.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  if (self.cskill).level == 3 then
    self:AddTrigger(eSkillTriggerType.RoleDie, "5002_1", 1, self.OnRoleDie)
  end
end

bs_5002.PlaySkill = function(self, data)
  -- function num : 0_2
  return self:RealPlaySkill()
end

bs_5002.RealPlaySkill = function(self)
  -- function num : 0_3 , upvalues : _ENV
  local targetList = LuaSkillCtrl:CallTargetSelect(self, 7, 20)
  if targetList.Count >= 1 and targetList[0] ~= nil then
    LuaSkillCtrl:CallEffect((targetList[0]).targetRole, (self.config).effectIdAttack, self, self.SkillEventFunc)
    LuaSkillCtrl:PlayAuSource((targetList[0]).targetRole, (self.config).audioId_start)
    return true
  else
    return false
  end
end

bs_5002.SkillEventFunc = function(self, effect, eventId, target)
  -- function num : 0_4 , upvalues : _ENV
  if eventId == eBattleEffectEvent.Trigger then
    LuaSkillCtrl:CallBattleCamShake(1)
    local highAttRole = LuaSkillCtrl:CallTargetSelect(self, 46, 20)
    if highAttRole ~= nil and highAttRole.Count > 0 and highAttRole[0] ~= nil then
      if (self.cskill).level == 1 then
        local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
        LuaSkillCtrl:HurtResult(self, skillResult, (self.config).HurtConfig_1, {((highAttRole[0]).targetRole).skill_intensity}, true)
        skillResult:EndResult()
      else
        do
          if (self.cskill).level == 2 then
            local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
            LuaSkillCtrl:HurtResult(self, skillResult, (self.config).HurtConfig_2, {((highAttRole[0]).targetRole).skill_intensity}, true)
            skillResult:EndResult()
          else
            do
              do
                if (self.cskill).level == 3 then
                  local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
                  LuaSkillCtrl:HurtResult(self, skillResult, (self.config).HurtConfig_2, {((highAttRole[0]).targetRole).skill_intensity}, true)
                  skillResult:BuffResult((self.config).buffId, (self.config).buffTier, (self.arglist)[5])
                  skillResult:EndResult()
                end
                LuaSkillCtrl:PlayAuSource(target, (self.config).audioId_hit)
              end
            end
          end
        end
      end
    end
  end
end

bs_5002.OnRoleDie = function(self, killer, role, killSkill)
  -- function num : 0_5 , upvalues : _ENV
  if role.belongNum ~= (self.caster).belongNum and role:GetBuffTier((self.config).buffId) ~= 0 then
    LuaSkillCtrl:StartTimer(self, 7, function()
    -- function num : 0_5_0 , upvalues : self
    self:RealPlaySkill()
  end
, nil)
  end
end

bs_5002.OnCasterDie = function(self)
  -- function num : 0_6 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_5002


-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_102602 = class("bs_102602", LuaSkillBase)
local base = LuaSkillBase
bs_102602.config = {effectId = 10721, effectId2 = 10724, 
HurtConfig = {hit_formula = 0, basehurt_formula = 10077, crit_formula = 0}
, skill_time = 27, start_time = 10, actionId = 1002, action_speed = 1, buffId_232 = 232, buffId_170 = 170, selectId = 24, effectId_heal = 10807, 
heal_config = {baseheal_formula = 10089}
}
bs_102602.ctor = function(self)
  -- function num : 0_0
end

bs_102602.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
end

bs_102602.PlaySkill = function(self, data)
  -- function num : 0_2 , upvalues : _ENV
  local attackTrigger = BindCallback(self, self.OnAttackTrigger)
  self:CallCasterWait((self.config).skill_time)
  LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, (self.config).actionId, (self.config).action_speed, (self.config).start_time, attackTrigger)
  LuaSkillCtrl:CallEffect(self.caster, (self.config).effectId, self)
  LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId_170, 1, (self.arglist)[4] + 15, true)
end

bs_102602.OnAttackTrigger = function(self)
  -- function num : 0_3 , upvalues : _ENV
  LuaSkillCtrl:StartShowSkillDurationTime(self, (self.arglist)[4])
  LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId_232, 1, (self.arglist)[4])
  local skill_heal = BindCallback(self, self.Onskillheal)
  local time = (self.arglist)[4] // (self.arglist)[1] - 1
  LuaSkillCtrl:StartTimer(nil, (self.arglist)[1], skill_heal, self, time, (self.arglist)[1])
end

bs_102602.Onskillheal = function(self)
  -- function num : 0_4 , upvalues : _ENV
  local targetlist = LuaSkillCtrl:CallTargetSelect(self, (self.config).selectId, 10)
  if targetlist.Count > 0 then
    local role = (targetlist[0]).targetRole
    if targetlist.Count > 1 and role == self.caster and role.hp == role.maxHp then
      role = (targetlist[1]).targetRole
    end
    LuaSkillCtrl:CallEffect(role, (self.config).effectId_heal, self, self.SkillEventFunc)
    if (self.arglist)[2] > 0 then
      if targetlist.Count > 1 then
        local role_2 = (targetlist[1]).targetRole
        if role_2 == self.caster and role_2.hp == role_2.maxHp then
          role_2 = nil
        end
        if role_2 ~= nil then
          LuaSkillCtrl:CallEffect(role_2, (self.config).effectId_heal, self, self.SkillEventFunc)
        else
          LuaSkillCtrl:StartTimer(nil, 5, function()
    -- function num : 0_4_0 , upvalues : _ENV, targetlist, self
    LuaSkillCtrl:CallEffect((targetlist[0]).targetRole, (self.config).effectId_heal, self, self.SkillEventFunc)
  end
)
        end
      else
        do
          LuaSkillCtrl:StartTimer(nil, 5, function()
    -- function num : 0_4_1 , upvalues : _ENV, targetlist, self
    LuaSkillCtrl:CallEffect((targetlist[0]).targetRole, (self.config).effectId_heal, self, self.SkillEventFunc)
  end
)
        end
      end
    end
  end
end

bs_102602.SkillEventFunc = function(self, effect, eventId, target)
  -- function num : 0_5 , upvalues : _ENV
  if eventId == eBattleEffectEvent.Trigger then
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
    LuaSkillCtrl:HealResult(skillResult, (self.config).heal_config)
    skillResult:EndResult()
  end
end

bs_102602.OnCasterDie = function(self)
  -- function num : 0_6 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_102602


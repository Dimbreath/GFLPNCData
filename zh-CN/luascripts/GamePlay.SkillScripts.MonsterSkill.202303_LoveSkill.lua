-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_202303 = class("bs_202303", LuaSkillBase)
local base = LuaSkillBase
bs_202303.config = {antion1 = 1008, antion2 = 1007, antion3 = 1009, effectHithurt = 10491, effectHitheal = 10491, effectId = 10492, buffId196 = 196, 
HurtConfig = {hit_formula = 0, basehurt_formula = 10083, crit_formula = 0}
, 
HealConfig = {baseheal_formula = 10083}
}
bs_202303.ctor = function(self)
  -- function num : 0_0
end

bs_202303.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
end

bs_202303.PlaySkill = function(self, data)
  -- function num : 0_2 , upvalues : _ENV
  self:CallCasterWait(80)
  local attackTrigger = BindCallback(self, self.OnAttackTrigger)
  LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, (self.config).antion1, 1, 24, attackTrigger)
  self.loop = LuaSkillCtrl:CallEffect(self.caster, (self.config).effectId, self, nil, nil, nil, true)
  LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId196, 1, 80)
end

bs_202303.OnAttackTrigger = function(self)
  -- function num : 0_3 , upvalues : _ENV
  LuaSkillCtrl:CallRoleAction(self.caster, (self.config).antion2)
  local hurt = BindCallback(self, self.Onhurt)
  local heal = BindCallback(self, self.Onheal)
  local Over = BindCallback(self, self.OnOver)
  LuaSkillCtrl:StartTimer(self, 6, hurt, self, (self.arglist)[1] - 1, 5)
  LuaSkillCtrl:StartTimer(self, 6, heal, self, (self.arglist)[1] - 1, 3)
  LuaSkillCtrl:StartTimer(self, 48, Over, self)
end

bs_202303.Onhurt = function(self)
  -- function num : 0_4 , upvalues : _ENV
  local range = 2 - (self.caster).attackRange
  local target_hurt = LuaSkillCtrl:CallTargetSelect(self, 42, range)
  if target_hurt.Count > 0 then
    LuaSkillCtrl:CallEffect((target_hurt[0]).targetRole, (self.config).effectHithurt, self)
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, (target_hurt[0]).targetRole)
    LuaSkillCtrl:HurtResult(skillResult, (self.config).HurtConfig)
    skillResult:EndResult()
  end
end

bs_202303.Onheal = function(self)
  -- function num : 0_5 , upvalues : _ENV
  local range = 2 - (self.caster).attackRange
  local target_heal = LuaSkillCtrl:CallTargetSelect(self, 24, range)
  if target_heal.Count > 0 then
    LuaSkillCtrl:CallEffect((target_heal[0]).targetRole, (self.config).effectHitheal, self)
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, (target_heal[0]).targetRole)
    LuaSkillCtrl:HealResult(skillResult, (self.config).HealConfig)
    skillResult:EndResult()
  else
    do
      LuaSkillCtrl:CallEffect(self.caster, (self.config).effectHitheal, self)
      local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, self.caster)
      LuaSkillCtrl:HealResult(skillResult, (self.config).HealConfig)
      skillResult:EndResult()
    end
  end
end

bs_202303.OnOver = function(self)
  -- function num : 0_6 , upvalues : _ENV
  LuaSkillCtrl:CallRoleAction(self.caster, (self.config).antion3)
  if self.loop ~= nil then
    (self.loop):Die()
    self.loop = nil
  end
  LuaSkillCtrl:DispelBuff(self.caster, (self.config).buffId196, 1)
  LuaSkillCtrl:StartTimer(self, 5, function()
    -- function num : 0_6_0 , upvalues : self
    self:CancleCasterWait()
  end
)
end

bs_202303.OnBreakSkill = function(self, role)
  -- function num : 0_7 , upvalues : base
  (base.OnBreakSkill)(self, role)
end

bs_202303.OnCasterDie = function(self)
  -- function num : 0_8 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_202303


local bs_104002 = class("bs_104002", LuaSkillBase)
local base = LuaSkillBase
bs_104002.config = {buffId_170 = 170, skill_time = 53, start_time = 22, actionId = 1002, action_speed = 1.5, effectId_big = 104002, effectId_small = 104001, buffId_1 = 104004, buffId_2 = 104005, selectId_player = 34, selectId_enemy = 33, 
Aoe_all = {effect_shape = 3, aoe_select_code = 4, aoe_range = 10}
, 
hurt_config = {hit_formula = 0, basehurt_formula = 3010, crit_formula = 0, crithur_ratio = 0, returndamage_formula = 0}
, buffId_skill = 104007, actionId_start = 104009}
bs_104002.ctor = function(self)
  -- function num : 0_0
end

bs_104002.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.caster).recordTable).skill_open = false
end

bs_104002.PlaySkill = function(self, data)
  -- function num : 0_2 , upvalues : _ENV
  local skilltime = (self.config).skill_time * 100 // ((self.config).action_speed * 100)
  local starttime = (self.config).start_time * 100 // ((self.config).action_speed * 100)
  self:CallCasterWait(skilltime)
  local attackTrigger = BindCallback(self, self.OnAttackTrigger)
  LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, (self.config).actionId, (self.config).action_speed, starttime, attackTrigger)
  LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId_170, 1, (self.arglist)[1] + starttime, true)
end

bs_104002.OnAttackTrigger = function(self)
  -- function num : 0_3 , upvalues : _ENV
  LuaSkillCtrl:StartShowSkillDurationTime(self, (self.arglist)[1])
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.caster).recordTable).skill_open = true
  LuaSkillCtrl:StartTimer(nil, (self.arglist)[1], function()
    -- function num : 0_3_0 , upvalues : self
    -- DECOMPILER ERROR at PC2: Confused about usage of register: R0 in 'UnsetPending'

    ((self.caster).recordTable).skill_open = false
  end
)
  LuaSkillCtrl:CallEffect(self.caster, (self.config).effectId_big, self, self.SkillEventFunc)
  LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId_skill, 1, 1)
end

bs_104002.SkillEventFunc = function(self, effect, eventId, target)
  -- function num : 0_4 , upvalues : _ENV
  if eventId ~= eBattleEffectEvent.Create then
    return 
  end
  if ((self.caster).recordTable).skill_open == true then
    local _Cskill = ((self.caster).recordTable).cs_Skill
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffectWithCSkill(_Cskill, target, (self.config).Aoe_all)
    LuaSkillCtrl:HurtResult(self, skillResult, (self.config).hurt_config, {((self.caster).recordTable)["arglist[3]"]})
    skillResult:EndResult()
    LuaSkillCtrl:PlayAuSource(target, (self.config).audioId_hit)
  end
end

bs_104002.OnCasterDie = function(self)
  -- function num : 0_5 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_104002


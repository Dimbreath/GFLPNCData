local bs_203204 = class("bs_203204", LuaSkillBase)
local base = LuaSkillBase
bs_203204.config = {skill_time = 31, start_time = 17, actionId = 1002, action_speed = 1, audioId1 = 251, buffId_Hua = 102502, buffId_CH = 102501, buffId_170 = 170, effectId_trail = 102503, effectId_P = 105791, effectId_hit2 = 102505, 
HurtConfig = {hit_formula = 0, basehurt_formula = 3000, crit_formula = 0, crithur_ratio = 0}
, ex_hurttime = 3, buffId_tip = 102503, commonAttackId = 532}
bs_203204.ctor = function(self)
  -- function num : 0_0
end

bs_203204.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddSelfTrigger(eSkillTriggerType.AfterPlaySkill, "bs_203204_2", 1, self.OnAfterPlaySkill)
  -- DECOMPILER ERROR at PC13: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.caster).recordTable)["203204_attakflag"] = false
  -- DECOMPILER ERROR at PC18: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.caster).recordTable)["203204_arg"] = (self.arglist)[1]
  self.attackNum = 0
end

bs_203204.OnAfterPlaySkill = function(self, skill, role)
  -- function num : 0_2
  if role == self.caster and skill.isCommonAttack then
    self.attackNum = self.attackNum + 1
    if self.attackNum >= 2 then
      self.attackNum = 0
      -- DECOMPILER ERROR at PC15: Confused about usage of register: R3 in 'UnsetPending'

      ;
      ((self.caster).recordTable)["203204_attakflag"] = true
    end
  end
end

bs_203204.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_203204


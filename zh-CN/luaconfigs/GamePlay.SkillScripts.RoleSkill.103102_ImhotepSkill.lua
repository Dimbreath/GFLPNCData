-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_103102 = class("bs_103102", LuaSkillBase)
local base = LuaSkillBase
bs_103102.config = {birdId = 12, snakeId = 13, buff_bird = 200, buff_snake = 201, buffId = 88, buffId2 = 196, effect_bird_birth = 10546, effect_snake_birth = 10548, effectId_bird = 10840, effectId_snake = 10841, selectId = 59, buffId_200 = 200, buffId_201 = 201, buffId_275 = 275, buffId_276 = 276}
bs_103102.ctor = function(self)
  -- function num : 0_0
end

bs_103102.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
end

bs_103102.PlaySkill = function(self, data)
  -- function num : 0_2 , upvalues : _ENV
  local targetlist = LuaSkillCtrl:CallTargetSelect(self, (self.config).selectId, 10)
  if targetlist.Count == 0 then
    return 
  end
  local target_skill = nil
  for i = 0, targetlist.Count - 1 do
    local _target = (targetlist[i]).targetRole
    local bool = _target.maxHp * (self.arglist)[2] // 1000 - _target.maxHp + _target.hp
    if bool >= 0 and _target:GetBuffTier((self.config).buffId_200) == 0 then
      target_skill = _target
      break
    end
    if bool < 0 and _target:GetBuffTier((self.config).buffId_201) == 0 then
      target_skill = _target
      break
    end
  end
  do
    if target_skill == nil then
      target_skill = (targetlist[0]).targetRole
    end
    self:CallCasterWait(15)
    local attackTrigger = BindCallback(self, self.OnAttackTrigger, target_skill)
    if target_skill ~= self.caster and target_skill ~= nil then
      (self.caster):LookAtTarget(target_skill)
    end
    if target_skill ~= nil then
      LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, 1002, 1.5, 1, attackTrigger)
    end
  end
end

bs_103102.OnAttackTrigger = function(self, target)
  -- function num : 0_3 , upvalues : _ENV
  local bool = target.maxHp * (self.arglist)[2] // 1000 - target.maxHp + target.hp
  local buff = 0
  if bool >= 0 then
    buff = (self.config).buffId_200
    -- DECOMPILER ERROR at PC17: Confused about usage of register: R4 in 'UnsetPending'

    ;
    (target.recordTable).Atk_arg = (self.arglist)[5]
    -- DECOMPILER ERROR at PC21: Confused about usage of register: R4 in 'UnsetPending'

    ;
    (target.recordTable).skill_int = (self.caster).skill_intensity
    -- DECOMPILER ERROR at PC24: Confused about usage of register: R4 in 'UnsetPending'

    ;
    (target.recordTable).caster_cskill = self.cskill
    if (self.arglist)[3] > 0 then
      LuaSkillCtrl:CallBuff(self, target, (self.config).buffId_275, 1, (self.arglist)[1])
    end
    LuaSkillCtrl:CallEffect(target, (self.config).effectId_bird, self)
  else
    buff = (self.config).buffId_201
    -- DECOMPILER ERROR at PC52: Confused about usage of register: R4 in 'UnsetPending'

    ;
    (target.recordTable)["2_Atk_arg_ex"] = (self.arglist)[9]
    -- DECOMPILER ERROR at PC56: Confused about usage of register: R4 in 'UnsetPending'

    ;
    (target.recordTable)["2_skill_int"] = (self.caster).skill_intensity
    -- DECOMPILER ERROR at PC59: Confused about usage of register: R4 in 'UnsetPending'

    ;
    (target.recordTable)["2_caster_cskill"] = self.cskill
    if (self.arglist)[3] > 0 then
      LuaSkillCtrl:CallBuff(self, target, (self.config).buffId_276, 1, (self.arglist)[1])
    end
    LuaSkillCtrl:CallEffect(target, (self.config).effectId_snake, self)
  end
  LuaSkillCtrl:CallBuff(self, target, buff, 1, (self.arglist)[1])
end

bs_103102.OnCasterDie = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_103102


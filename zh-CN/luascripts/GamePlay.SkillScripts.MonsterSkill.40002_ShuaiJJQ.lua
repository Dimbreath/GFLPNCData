-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_40002 = class("bs_40002", LuaSkillBase)
local base = LuaSkillBase
bs_40002.config = {damageEffectId = 10024, healEffectId = 10022, damageFormula = 10011, skillCount = 0, totalDamage = 0}
bs_40002.ctor = function(self)
  -- function num : 0_0
end

bs_40002.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : _ENV
  self:AddTrigger(eSkillTriggerType.AfterHurt, "bs_40002_1", 100, self.OnAfterHurt)
end

bs_40002.PlaySkill = function(self, data)
  -- function num : 0_2 , upvalues : _ENV
  local targetlist = LuaSkillCtrl:CallTargetSelect(self, 9, 0)
  local damage = 0
  -- DECOMPILER ERROR at PC12: Confused about usage of register: R4 in 'UnsetPending'

  if targetlist.Count > 0 then
    (self.config).skillCount = targetlist.Count
    for i = 0, targetlist.Count - 1 do
      damage = LuaSkillCtrl:CallFormulaNumberWithSkill((self.config).damageFormula, self.caster, (targetlist[i]).targetRole, self)
      LuaSkillCtrl:RemoveLife(damage, self, (targetlist[i]).targetRole)
    end
    LuaSkillCtrl:CallEffect(self.caster, (self.config).damageEffectId, self)
  end
  self.damTimer = LuaSkillCtrl:StartTimer(self, 3, self.CallBack, self, 0, 3)
end

bs_40002.OnAfterHurt = function(self, sender, target, skill, hurt, isMiss, isCrit, isRealDmg)
  -- function num : 0_3
  -- DECOMPILER ERROR at PC14: Confused about usage of register: R8 in 'UnsetPending'

  if sender == self.caster and skill.dataId == 40002 and (self.config).skillCount ~= 0 then
    (self.config).totalDamage = (self.config).totalDamage + hurt
    -- DECOMPILER ERROR at PC19: Confused about usage of register: R8 in 'UnsetPending'

    ;
    (self.config).skillCount = (self.config).skillCount - 1
  end
end

bs_40002.CallBack = function(self)
  -- function num : 0_4 , upvalues : _ENV
  LuaSkillCtrl:CallHeal((self.config).totalDamage, self, self.caster)
  LuaSkillCtrl:CallEffect(self.caster, (self.config).healEffectId, self)
  -- DECOMPILER ERROR at PC15: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self.config).totalDamage = 0
  -- DECOMPILER ERROR at PC17: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self.config).skillCount = 0
end

bs_40002.OnCasterDie = function(self)
  -- function num : 0_5 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_40002

-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_40002 = class("bs_40002", LuaSkillBase)
local base = LuaSkillBase
bs_40002.config = {
    damageEffectId = 10024,
    healEffectId = 10022,
    damageFormula = 10011,
    skillCount = 0,
    totalDamage = 0
}
bs_40002.ctor = function(self)
    -- function num : 0_0
end

bs_40002.InitSkill = function(self, isMidwaySkill)
    -- function num : 0_1 , upvalues : _ENV
    self:AddTrigger(eSkillTriggerType.AfterHurt, "bs_40002_1", 100,
                    self.OnAfterHurt)
end

bs_40002.PlaySkill = function(self, data)
    -- function num : 0_2 , upvalues : _ENV
    local targetlist = LuaSkillCtrl:CallTargetSelect(self, 9, 0)
    local damage = 0
    -- DECOMPILER ERROR at PC12: Confused about usage of register: R4 in 'UnsetPending'

    if targetlist.Count > 0 then
        (self.config).skillCount = targetlist.Count
        for i = 0, targetlist.Count - 1 do
            damage = LuaSkillCtrl:CallFormulaNumberWithSkill(
                         (self.config).damageFormula, self.caster,
                         (targetlist[i]).targetRole, self)
            LuaSkillCtrl:RemoveLife(damage, self, (targetlist[i]).targetRole)
        end
        LuaSkillCtrl:CallEffect(self.caster, (self.config).damageEffectId, self)
    end
    self.damTimer = LuaSkillCtrl:StartTimer(self, 3, self.CallBack, self, 0, 3)
end

bs_40002.OnAfterHurt = function(self, sender, target, skill, hurt, isMiss,
                                isCrit, isRealDmg)
    -- function num : 0_3
    -- DECOMPILER ERROR at PC14: Confused about usage of register: R8 in 'UnsetPending'

    if sender == self.caster and skill.dataId == 40002 and
        (self.config).skillCount ~= 0 then
        (self.config).totalDamage = (self.config).totalDamage + hurt -- DECOMPILER ERROR at PC19: Confused about usage of register: R8 in 'UnsetPending'
        ;
        (self.config).skillCount = (self.config).skillCount - 1
    end
end

bs_40002.CallBack = function(self)
    -- function num : 0_4 , upvalues : _ENV
    LuaSkillCtrl:CallHeal((self.config).totalDamage, self, self.caster)
    LuaSkillCtrl:CallEffect(self.caster, (self.config).healEffectId, self) -- DECOMPILER ERROR at PC15: Confused about usage of register: R1 in 'UnsetPending'
    ;
    (self.config).totalDamage = 0 -- DECOMPILER ERROR at PC17: Confused about usage of register: R1 in 'UnsetPending'
    ;
    (self.config).skillCount = 0
end

bs_40002.OnCasterDie = function(self)
    -- function num : 0_5 , upvalues : base
    (base.OnCasterDie)(self)
end

return bs_40002


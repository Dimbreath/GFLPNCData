-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_1010 = class("bs_1010", LuaSkillBase)
local base = LuaSkillBase
bs_1010.config = {formula = "(@speed-#speed)*GetSkillArg(1)*1"}
bs_1010.compare = function(self, sender, target)
  -- function num : 0_0
  if target.speed < sender.speed then
    return true
  else
    return false
  end
end

bs_1010.ctor = function(self)
  -- function num : 0_1
end

bs_1010.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_2 , upvalues : _ENV
  self:AddTrigger(eSkillTriggerType.AfterHurt, "bs_1010_3", 1, self.OnAfterHurt)
  self:AddTrigger(eSkillTriggerType.HurtResultStart, "bs_1010_14", 1, self.OnHurtResultStart)
  -- DECOMPILER ERROR at PC21: Confused about usage of register: R2 in 'UnsetPending'

  if ((self.caster).recordTable)[3] == nil then
    ((self.caster).recordTable)[3] = 0
  end
end

bs_1010.OnAfterHurt = function(self, sender, target, skill, hurt, isMiss, isCrit, isRealDmg)
  -- function num : 0_3
  -- DECOMPILER ERROR at PC21: Confused about usage of register: R8 in 'UnsetPending'

  if sender == self.caster and target ~= self.caster and self:compare(sender, target) then
    ((self.caster).recordTable)[3] = ((self.caster).recordTable)[3] - ((self.caster).recordTable).damageup
  end
end

bs_1010.OnHurtResultStart = function(self, skill, context)
  -- function num : 0_4 , upvalues : _ENV
  if context.sender == self.caster and context.target ~= self.caster and self:compare(context.sender, context.target) then
    local damageup = LuaSkillCtrl:CallFormulaNumberWithSkill((self.config).formula, self.caster, context.target, self)
    -- DECOMPILER ERROR at PC24: Confused about usage of register: R4 in 'UnsetPending'

    ;
    ((self.caster).recordTable).damageup = damageup
    -- DECOMPILER ERROR at PC31: Confused about usage of register: R4 in 'UnsetPending'

    ;
    ((self.caster).recordTable)[3] = ((self.caster).recordTable)[3] + damageup
  end
end

bs_1010.OnCasterDie = function(self)
  -- function num : 0_5 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_1010


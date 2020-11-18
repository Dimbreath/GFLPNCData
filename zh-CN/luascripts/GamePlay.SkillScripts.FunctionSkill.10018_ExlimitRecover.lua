-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_10018 = class("bs_10018", LuaSkillBase)
local base = LuaSkillBase
bs_10018.config = {baseheal_formula = 0, correct_formula = 9990, effectId = 1008, conditionCheck = "$1>max(GetSkillArg(1),50)/1000*@maxHp", hpRecover = "$1-max(GetSkillArg(1),50)/1000*@maxHp"}
bs_10018.ctor = function(self)
  -- function num : 0_0
end

bs_10018.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : _ENV
  self:AddTrigger(eSkillTriggerType.AfterHurt, "bs_10018_3", 1, self.OnAfterHurt)
  self.heal_config = {}
end

bs_10018.OnAfterHurt = function(self, sender, target, skill, hurt, isMiss, isCrit, isRealDmg)
  -- function num : 0_2 , upvalues : _ENV
  -- DECOMPILER ERROR at PC28: Confused about usage of register: R8 in 'UnsetPending'

  if target == self.caster and (self.caster).hp > 0 and LuaSkillCtrl:CallFormulaBoolWithSkill((self.config).conditionCheck, self.caster, self.caster, self, hurt) then
    (self.heal_config).heal_number = LuaSkillCtrl:CallFormulaNumberWithSkill((self.config).hpRecover, self.caster, self.caster, self, hurt)
    -- DECOMPILER ERROR at PC32: Confused about usage of register: R8 in 'UnsetPending'

    ;
    (self.heal_config).correct_formula = (self.config).correct_formula
    if (self.heal_config).heal_number > 0 then
      self:PlayChipEffect()
      LuaSkillCtrl:CallEffect(self.caster, (self.config).effectId, self, self.SkillBack)
    end
  end
end

bs_10018.SkillBack = function(self, effect, eventId, target)
  -- function num : 0_3 , upvalues : _ENV
  if eventId == eBattleEffectEvent.Trigger then
    local skillResult = LuaSkillCtrl:CallSkillResult(effect, self.caster)
    LuaSkillCtrl:HealResult(skillResult, self.heal_config)
    skillResult:EndResult()
  end
end

bs_10018.OnCasterDie = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10018


local bs_6008 = class("bs_6008", LuaSkillBase)
local base = LuaSkillBase
bs_6008.config = {buffId1 = 128, buffId2 = 129, buffId3 = 197, 
heal_config = {baseheal_formula = 501}
}
bs_6008.ctor = function(self)
  -- function num : 0_0
end

bs_6008.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddSelfTrigger(eSkillTriggerType.AfterHurt, "bs_6008_3", 1, self.OnAfterHurt)
  -- DECOMPILER ERROR at PC13: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.caster).recordTable).pre_hp = 0
  -- DECOMPILER ERROR at PC16: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.caster).recordTable).pre_pow = 0
  -- DECOMPILER ERROR at PC19: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.caster).recordTable).pre_skill = 0
end

bs_6008.OnAfterHurt = function(self, sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  -- function num : 0_2 , upvalues : _ENV
  if target.hp <= 0 and hurt > 0 and sender == self.caster and target.belongNum == 2 then
    local add_hp = (self.arglist)[1] * target.maxHp // 100
    local add_pow = (self.arglist)[2] * target.pow // 100
    local add_skill_intensity = (self.arglist)[2] * target.skill_intensity // 100
    local pre_hp = ((self.caster).recordTable).pre_hp
    local pre_pow = ((self.caster).recordTable).pre_pow
    local pre_skill = ((self.caster).recordTable).pre_skill
    if pre_hp < add_hp then
      (self.caster):AddRoleProperty(eHeroAttr.maxHp, add_hp - pre_hp, eHeroAttrType.Extra)
      -- DECOMPILER ERROR at PC47: Confused about usage of register: R15 in 'UnsetPending'

      ;
      ((self.caster).recordTable).pre_hp = add_hp
    end
    if pre_pow < add_pow then
      (self.caster):AddRoleProperty(eHeroAttr.pow, add_pow - pre_pow, eHeroAttrType.Extra)
      -- DECOMPILER ERROR at PC60: Confused about usage of register: R15 in 'UnsetPending'

      ;
      ((self.caster).recordTable).pre_pow = add_pow
    end
    if pre_skill < add_skill_intensity then
      (self.caster):AddRoleProperty(eHeroAttr.skill_intensity, add_skill_intensity - pre_skill, eHeroAttrType.Extra)
      -- DECOMPILER ERROR at PC73: Confused about usage of register: R15 in 'UnsetPending'

      ;
      ((self.caster).recordTable).pre_skill = add_skill_intensity
    end
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, self.caster)
    LuaSkillCtrl:HealResult(skillResult, (self.config).heal_config, {add_hp})
    skillResult:EndResult()
  end
end

bs_6008.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_6008


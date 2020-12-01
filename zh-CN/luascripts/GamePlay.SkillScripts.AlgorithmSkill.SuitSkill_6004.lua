-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_6004 = class("bs_6004", LuaSkillBase)
local base = LuaSkillBase
bs_6004.config = {
{baseheal_formula = 10027, heal_number = 0, correct_formula = 0}
; formulaId = 10027}
bs_6004.ctor = function(self)
  -- function num : 0_0
end

bs_6004.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterHurt, "bs_6004_3", 1, self.OnAfterHurt)
end

bs_6004.OnAfterHurt = function(self, sender, target, skill, hurt, isMiss, isCrit, isRealDmg)
  -- function num : 0_2 , upvalues : _ENV
  if target == self.caster and self:IsReadyToTake() and (self.caster).hp <= (self.caster).maxHp * (self.arglist)[1] // 100 then
    local healNum = LuaSkillCtrl:CallFormulaNumberWithSkill((self.config).formulaId, self.caster, self.caster, self)
    LuaSkillCtrl:CallHeal(healNum, self, self.caster)
    self:OnSkillTake()
  end
end

bs_6004.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_6004

-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_6004 = class("bs_6004", LuaSkillBase)
local base = LuaSkillBase
bs_6004.config = {
    {baseheal_formula = 10027, heal_number = 0, correct_formula = 0},
    formulaId = 10027
}
bs_6004.ctor = function(self)
    -- function num : 0_0
end

bs_6004.InitSkill = function(self, isMidwaySkill)
    -- function num : 0_1 , upvalues : base, _ENV
    (base.InitSkill)(self, isMidwaySkill)
    self:AddTrigger(eSkillTriggerType.AfterHurt, "bs_6004_3", 1,
                    self.OnAfterHurt)
end

bs_6004.OnAfterHurt = function(self, sender, target, skill, hurt, isMiss,
                               isCrit, isRealDmg)
    -- function num : 0_2 , upvalues : _ENV
    if target == self.caster and self:IsReadyToTake() and (self.caster).hp <=
        (self.caster).maxHp * (self.arglist)[1] // 100 then
        local healNum = LuaSkillCtrl:CallFormulaNumberWithSkill(
                            (self.config).formulaId, self.caster, self.caster,
                            self)
        LuaSkillCtrl:CallHeal(healNum, self, self.caster)
        self:OnSkillTake()
    end
end

bs_6004.OnCasterDie = function(self)
    -- function num : 0_3 , upvalues : base
    (base.OnCasterDie)(self)
end

return bs_6004


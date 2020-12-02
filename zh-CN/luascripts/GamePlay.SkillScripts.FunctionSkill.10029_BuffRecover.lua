-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_10029 = class("bs_10029", LuaSkillBase)
local base = LuaSkillBase
bs_10029.config = {healEffectId = 1005, healNumFormula = 10007}
bs_10029.ctor = function(self)
  -- function num : 0_0
end

bs_10029.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : _ENV
  self:AddTrigger(eSkillTriggerType.AfterAddBuff, "bs_10029_2", 1, self.OnAfterAddBuff)
end

bs_10029.OnAfterAddBuff = function(self, buff, target, isOverlay)
  -- function num : 0_2 , upvalues : _ENV
  if buff.buffType == 2 and isOverlay and buff.maker == self.caster then
    local healNum = (math.max)(LuaSkillCtrl:CallFormulaNumberWithSkill((self.config).healNumFormula, self.caster, target, self), 1)
    self:PlayChipEffect()
    LuaSkillCtrl:CallHeal(healNum, self, self.caster)
    LuaSkillCtrl:CallEffect(self.caster, (self.config).healEffectId, self)
  end
end

bs_10029.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10029


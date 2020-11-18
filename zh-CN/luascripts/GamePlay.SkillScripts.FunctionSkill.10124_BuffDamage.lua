-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_10124 = class("bs_10124", LuaSkillBase)
local base = LuaSkillBase
bs_10124.config = {basehurt_formula = 10034, effectId = 1002}
bs_10124.ctor = function(self)
  -- function num : 0_0
end

bs_10124.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterAddBuff, "bs_10124_1", 1, self.OnAfterAddBuff)
end

bs_10124.OnAfterAddBuff = function(self, buff, target, isOverlay)
  -- function num : 0_2 , upvalues : _ENV
  if buff.buffType == 2 and isOverlay and buff.maker == self.caster then
    LuaSkillCtrl:CallEffect(target, (self.config).effectId, self)
    local damageNum = (math.max)(1, LuaSkillCtrl:CallFormulaNumberWithSkill((self.config).basehurt_formula, self.caster, target, self))
    LuaSkillCtrl:RemoveLife(damageNum, self, target, true, true)
    self:PlayChipEffect()
  end
end

bs_10124.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10124


-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_1048 = class("bs_1048", LuaSkillBase)
local base = LuaSkillBase
bs_1048.config = {buffId = 149, dmgReduceFormula = 10049, beatBackBuff = 151, beatChanceFormula = 10050}
bs_1048.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_0 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_1048_btlStart", 1, self.OnAfterBattleStart)
  self:AddTrigger(eSkillTriggerType.SetHurt, "bs_1048_setHurt", 1, self.OnSetHurt)
end

bs_1048.OnAfterBattleStart = function(self)
  -- function num : 0_1 , upvalues : _ENV
  LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId, 1)
end

bs_1048.OnSetHurt = function(self, context)
  -- function num : 0_2 , upvalues : _ENV
  do
    if context.target == self.caster then
      local hurtResult = LuaSkillCtrl:CallFormulaNumberWithSkill((self.config).dmgReduceFormula, self.caster, context.sender, self, context.hurt)
      context.hurt = hurtResult
    end
    if (self.arglist)[5] > 0 and LuaSkillCtrl:GetGridsDistance((context.sender).x, (context.sender).y, (self.caster).x, (self.caster).y) <= 1 and LuaSkillCtrl:CallRange(1, 1000) <= (self.arglist)[4] then
      LuaSkillCtrl:CallBuff(self, context.sender, (self.config).beatBackBuff, 1, 3)
    end
  end
end

bs_1048.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_1048


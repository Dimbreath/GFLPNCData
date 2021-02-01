-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_10036 = class("bs_10036", LuaSkillBase)
local base = LuaSkillBase
bs_10036.config = {healDelay = 30, startTime = 30, healEffectId = 10092, healFormula = 10006}
bs_10036.ctor = function(self)
  -- function num : 0_0
end

bs_10036.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : _ENV
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_10036_1", 1, self.OnAfterBattleStart)
end

bs_10036.OnAfterBattleStart = function(self)
  -- function num : 0_2 , upvalues : _ENV
  self.damTimer = LuaSkillCtrl:StartTimer(self, (self.config).healDelay, self.CallBack, self, -1, (self.config).healDelay)
end

bs_10036.CallBack = function(self)
  -- function num : 0_3 , upvalues : _ENV
  local healNum = (math.max)(LuaSkillCtrl:CallFormulaNumberWithSkill((self.config).healFormula, self.caster, self.caster, self), 1)
  LuaSkillCtrl:CallHeal(healNum, self, self.caster, nil, true)
  LuaSkillCtrl:CallEffect(self.caster, (self.config).healEffectId, self)
end

bs_10036.OnCasterDie = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnCasterDie)(self)
  if self.damTimer then
    (self.damTimer):Stop()
    self.damTimer = nil
  end
end

return bs_10036


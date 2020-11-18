-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_1027 = class("bs_1027", LuaSkillBase)
local base = LuaSkillBase
bs_1027.config = {
HurtConfig1 = {hit_formula = 0, def_formula = 0, basehurt_formula = 502, minhurt_formula = 9994, crit_formula = 0, crithur_ratio = 0, correct_formula = 9989, lifesteal_formula = 1001, spell_lifesteal_formula = 1002, returndamage_formula = 1000}
}
bs_1027.ctor = function(self)
  -- function num : 0_0
end

bs_1027.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : _ENV
  self:AddTrigger(eSkillTriggerType.AfterHurt, "bs_1027_3", 1, self.OnAfterHurt)
end

bs_1027.OnAfterHurt = function(self, sender, target, skill, hurt, isMiss, isCrit, isRealDmg)
  -- function num : 0_2 , upvalues : _ENV
  if sender == self.caster and skill.dataId == 3 and not isMiss then
    local targets = (self:GetBehindTargetsPos(2, (self.caster).x, (self.caster).y, target.x, target.y))
    do
      local targetNext = nil
      if targets ~= nil and (table.length)(targets) >= 2 and (targets[2]).belongNum ~= (self.caster).belongNum then
        targetNext = targets[2]
      end
      local hurt1 = hurt * (self.arglist)[1] // 1000
      local hurt2 = hurt * (self.arglist)[5] // 1000
      local hurt3 = hurt2 * (self.arglist)[1] // 1000
      if hurt1 < 1 then
        hurt1 = 1
      end
      if hurt2 < 1 then
        hurt2 = 1
      end
      if hurt3 < 1 then
        hurt3 = 1
      end
      local Times = (self.arglist)[3] // (self.arglist)[4] - 1
      self.damTimer = LuaSkillCtrl:StartTimer(self, (self.arglist)[4], function()
    -- function num : 0_2_0 , upvalues : _ENV, self, target, hurt1
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
    LuaSkillCtrl:HurtResult(skillResult, (self.config).HurtConfig1, {hurt1})
    skillResult:EndResult()
    if target.hp < hurt1 and self.damTimer ~= nil then
      (self.damTimer):Stop()
      self.damTimer = nil
    end
  end
, nil, Times)
      if targetNext ~= nil and (self.arglist)[2] == 1 then
        LuaSkillCtrl:CallEffect(targetNext, 10013, self)
        local skillResult2 = LuaSkillCtrl:CallSkillResultNoEffect(self, targetNext)
        LuaSkillCtrl:HurtResult(skillResult2, (self.config).HurtConfig1, {hurt2})
        skillResult2:EndResult()
        self.damTimer2 = LuaSkillCtrl:StartTimer(self, (self.arglist)[4], function()
    -- function num : 0_2_1 , upvalues : _ENV, self, targetNext, hurt3
    local skillResult3 = LuaSkillCtrl:CallSkillResultNoEffect(self, targetNext)
    LuaSkillCtrl:HurtResult(skillResult3, (self.config).HurtConfig1, {hurt3})
    skillResult3:EndResult()
    if targetNext.hp < hurt3 and self.damTimer2 ~= nil then
      (self.damTimer2):Stop()
      self.damTimer2 = nil
    end
  end
, nil, Times)
      end
    end
  end
end

bs_1027.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_1027


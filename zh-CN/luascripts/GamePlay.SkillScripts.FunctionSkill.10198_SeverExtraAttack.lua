-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_10198 = class("bs_10198", LuaSkillBase)
local base = LuaSkillBase
bs_10198.config = {damageFormula = 10011}
bs_10198.ctor = function(self)
  -- function num : 0_0
end

bs_10198.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.SetHurt, "bs_10198_2", 1, self.OnSetHurt)
end

bs_10198.OnSetHurt = function(self, context)
  -- function num : 0_2 , upvalues : _ENV
  if (context.sender).belongNum == 0 and (context.target).belongNum == 2 and not context.isTriggerSet then
    local damage = (math.max)(1, LuaSkillCtrl:CallFormulaNumberWithSkill((self.config).damageFormula, self.caster, context.target, self))
    LuaSkillCtrl:RemoveLife(damage, self, context.target, true, true)
  end
end

bs_10198.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10198

-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_10198 = class("bs_10198", LuaSkillBase)
local base = LuaSkillBase
bs_10198.config = {damageFormula = 10011}
bs_10198.ctor = function(self)
    -- function num : 0_0
end

bs_10198.InitSkill = function(self, isMidwaySkill)
    -- function num : 0_1 , upvalues : base, _ENV
    (base.InitSkill)(self, isMidwaySkill)
    self:AddTrigger(eSkillTriggerType.SetHurt, "bs_10198_2", 1, self.OnSetHurt)
end

bs_10198.OnSetHurt = function(self, context)
    -- function num : 0_2 , upvalues : _ENV
    if (context.sender).belongNum == 0 and (context.target).belongNum == 2 and
        not context.isTriggerSet then
        local damage = (math.max)(1,
                                  LuaSkillCtrl:CallFormulaNumberWithSkill(
                                      (self.config).damageFormula, self.caster,
                                      context.target, self))
        LuaSkillCtrl:RemoveLife(damage, self, context.target, true, true)
    end
end

bs_10198.OnCasterDie = function(self)
    -- function num : 0_3 , upvalues : base
    (base.OnCasterDie)(self)
end

return bs_10198


-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_10194 = class("bs_10194", LuaSkillBase)
local base = LuaSkillBase
bs_10194.config = {
hurt_config = {basehurt_formula = 10076, crit_formula = 10084}
, effectIdAttack = 10254}
bs_10194.ctor = function(self)
  -- function num : 0_0
end

bs_10194.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddLuaTrigger(eSkillLuaTrigger.OnDoodad, self.OnDoodad)
end

bs_10194.OnDoodad = function(self, sender, targetRole)
  -- function num : 0_2 , upvalues : _ENV
  if targetRole.belongNum == 2 then
    LuaSkillCtrl:CallEffect(targetRole, (self.config).effectIdAttack, self, self.SkillEventFunc)
  end
end

bs_10194.SkillEventFunc = function(self, effect, eventId, target)
  -- function num : 0_3 , upvalues : _ENV
  if eventId == eBattleEffectEvent.Trigger then
    local skillResult = LuaSkillCtrl:CallSkillResult(effect, target)
    LuaSkillCtrl:HurtResult(skillResult, (self.config).hurt_config)
    skillResult:EndResult()
  end
end

bs_10194.OnCasterDie = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10194

-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_10194 = class("bs_10194", LuaSkillBase)
local base = LuaSkillBase
bs_10194.config = {
    hurt_config = {basehurt_formula = 10076, crit_formula = 10084},
    effectIdAttack = 10254
}
bs_10194.ctor = function(self)
    -- function num : 0_0
end

bs_10194.InitSkill = function(self, isMidwaySkill)
    -- function num : 0_1 , upvalues : base, _ENV
    (base.InitSkill)(self, isMidwaySkill)
    self:AddLuaTrigger(eSkillLuaTrigger.OnDoodad, self.OnDoodad)
end

bs_10194.OnDoodad = function(self, sender, targetRole)
    -- function num : 0_2 , upvalues : _ENV
    if targetRole.belongNum == 2 then
        LuaSkillCtrl:CallEffect(targetRole, (self.config).effectIdAttack, self,
                                self.SkillEventFunc)
    end
end

bs_10194.SkillEventFunc = function(self, effect, eventId, target)
    -- function num : 0_3 , upvalues : _ENV
    if eventId == eBattleEffectEvent.Trigger then
        local skillResult = LuaSkillCtrl:CallSkillResult(effect, target)
        LuaSkillCtrl:HurtResult(skillResult, (self.config).hurt_config)
        skillResult:EndResult()
    end
end

bs_10194.OnCasterDie = function(self)
    -- function num : 0_4 , upvalues : base
    (base.OnCasterDie)(self)
end

return bs_10194


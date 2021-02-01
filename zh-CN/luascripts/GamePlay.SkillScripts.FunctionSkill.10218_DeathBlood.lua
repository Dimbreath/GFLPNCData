-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_10218 = class("bs_10218", LuaSkillBase)
local base = LuaSkillBase
bs_10218.config = {baseheal_formula = 10011, effectId = 1008}
bs_10218.ctor = function(self)
  -- function num : 0_0
end

bs_10218.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.RoleDie, "bs_10218_10", 1, self.OnRoleDie)
end

bs_10218.OnRoleDie = function(self, killer, role)
  -- function num : 0_2 , upvalues : _ENV
  if role.belongNum == eBattleRoleBelong.enemy then
    local healNum = LuaSkillCtrl:CallFormulaNumberWithSkill((self.config).baseheal_formula, self.caster, role, self)
    LuaSkillCtrl:CallEffect(self.caster, (self.config).effectId, self)
    LuaSkillCtrl:CallHeal(healNum, self, self.caster, true)
  end
end

bs_10218.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10218


-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_10173 = class("bs_10173", LuaSkillBase)
local base = LuaSkillBase
bs_10173.config = {buffId = 1037, heal_formula = 1047}
bs_10173.ctor = function(self)
  -- function num : 0_0
end

bs_10173.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddSelfTrigger(eSkillTriggerType.RoleDie, "bs_10173_4", 1, self.OnKillNeutral)
end

bs_10173.OnKillNeutral = function(self, killer, role)
  -- function num : 0_2 , upvalues : _ENV
  if killer == self.caster and role.intensity == 0 and role.belongNum == eBattleRoleBelong.neutral then
    local healNum = LuaSkillCtrl:CallFormulaNumberWithSkill((self.config).heal_formula, self.caster, self.caster, self)
    local targetlist = LuaSkillCtrl:CallTargetSelect(self, 14, 10)
    if targetlist.Count < 1 then
      return 
    end
    LuaSkillCtrl:CallHeal(healNum, self, (targetlist[0]).targetRole, true)
  end
end

bs_10173.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10173


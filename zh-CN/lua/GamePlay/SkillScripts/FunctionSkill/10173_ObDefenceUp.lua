local bs_10173 = class("bs_10173", LuaSkillBase)
local base = LuaSkillBase
bs_10173.config = {buffId = 1037, heal_formula = 1047, effectId = 10634}
bs_10173.ctor = function(self)
  -- function num : 0_0
end

bs_10173.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.RoleDie, "bs_10173_4", 1, self.OnKillNeutral)
  self.flag = true
end

bs_10173.OnKillNeutral = function(self, killer, role)
  -- function num : 0_2 , upvalues : _ENV
  if role.intensity == 0 and role.belongNum == eBattleRoleBelong.neutral and self.flag then
    self.flag = false
    local targetlist = LuaSkillCtrl:CallTargetSelect(self, 14, 10)
    if targetlist.Count < 1 then
      return 
    end
    local healNum = LuaSkillCtrl:CallFormulaNumberWithSkill((self.config).heal_formula, (targetlist[0]).targetRole, (targetlist[0]).targetRole, self)
    LuaSkillCtrl:CallHeal(healNum, self, (targetlist[0]).targetRole, true)
    LuaSkillCtrl:CallEffect((targetlist[0]).targetRole, (self.config).effectId, self)
  end
end

bs_10173.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10173


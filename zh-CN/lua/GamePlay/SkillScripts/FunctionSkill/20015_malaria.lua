local bs_20015 = class("bs_20015", LuaSkillBase)
local base = LuaSkillBase
bs_20015.config = {}
bs_20015.ctor = function(self)
  -- function num : 0_0
end

bs_20015.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_20015_1", 1, self.OnAfterBattleStart)
end

bs_20015.OnAfterBattleStart = function(self)
  -- function num : 0_2 , upvalues : _ENV
  local attr = (self.caster).battleEnd_hp_regen
  LuaSkillCtrl:CallAddRoleProperty(self.caster, eHeroAttr.battleEnd_hp_regen, -attr, eHeroAttrType.Extra)
  LuaSkillCtrl:CallAddRoleProperty(self.caster, eHeroAttr.battleEnd_hp_regen, 1, eHeroAttrType.Extra)
end

bs_20015.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_20015


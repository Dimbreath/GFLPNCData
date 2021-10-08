local bs_20112 = class("bs_20112", LuaSkillBase)
local base = LuaSkillBase
bs_20112.config = {}
bs_20112.ctor = function(self)
  -- function num : 0_0
end

bs_20112.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_20112_1", 1, self.OnAfterBattleStart)
end

bs_20112.OnAfterBattleStart = function(self)
  -- function num : 0_2 , upvalues : _ENV
  local atk_range = (self.caster).attackRange
  print(atk_range)
  if atk_range > 2 then
    local change_range = (math.min)((math.max)(2 - atk_range, -2), 0)
    ;
    (self.caster):AddRoleProperty(eHeroAttr.attackRange, change_range, eHeroAttrType.Extra)
    ;
    (self.caster):AddRoleProperty(eHeroAttr.damage_increase, -change_range * (self.arglist)[1], eHeroAttrType.Extra)
  end
end

bs_20112.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_20112


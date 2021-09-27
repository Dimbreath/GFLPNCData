local bs_10167 = class("bs_10167", LuaSkillBase)
local base = LuaSkillBase
bs_10167.config = {
aoe_config = {effect_shape = 3, aoe_select_code = 4, aoe_range = 1}
, 
realDamageConfig = {basehurt_formula = 10034}
, effectId = 10866}
bs_10167.ctor = function(self)
  -- function num : 0_0
end

bs_10167.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
end

bs_10167.OnCasterDie = function(self)
  -- function num : 0_2 , upvalues : _ENV, base
  self:PlayChipEffect()
  local targetlist = LuaSkillCtrl:CallTargetSelect(self, 8, 0)
  local checkList = LuaSkillCtrl:CallTargetSelect(self, 6, 10)
  if targetlist.Count <= 0 or checkList.Count <= 1 then
    return 
  end
  local target = (targetlist[0]).targetRole
  local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target, (self.config).aoe_config)
  if (skillResult.roleList).Count > 0 then
    for i = 0, (skillResult.roleList).Count - 1 do
      local role = (skillResult.roleList)[i]
      LuaSkillCtrl:CallRealDamage(self, role, nil, (self.config).realDamageConfig, nil, true)
    end
  end
  do
    LuaSkillCtrl:CallEffect(self.caster, (self.config).effectId, self)
    ;
    (base.OnCasterDie)(self)
  end
end

return bs_10167


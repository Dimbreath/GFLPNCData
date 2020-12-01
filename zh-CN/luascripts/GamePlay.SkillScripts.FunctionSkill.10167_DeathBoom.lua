-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_10167 = class("bs_10167", LuaSkillBase)
local base = LuaSkillBase
bs_10167.config = {
aoe_config = {effect_shape = 3, aoe_select_code = 4, aoe_range = 1}
, 
realDamageConfig = {basehurt_formula = 1047}
, effectId = 10274, buffId = 66}
bs_10167.ctor = function(self)
  -- function num : 0_0
end

bs_10167.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.RoleDie, "bs_10167_10", 1, self.OnRoleDie)
end

bs_10167.OnRoleDie = function(self, killer, role)
  -- function num : 0_2
end

bs_10167.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : _ENV, base
  self:PlayChipEffect()
  local targetlist = LuaSkillCtrl:CallTargetSelect(self, 8, 0)
  local checkList = LuaSkillCtrl:CallTargetSelect(self, 6, 0)
  if targetlist.Count <= 0 or checkList.Count <= 1 then
    return 
  end
  local target = (targetlist[0]).targetRole
  local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target, (self.config).aoe_config)
  if (skillResult.roleList).Count > 0 then
    for i = 0, (skillResult.roleList).Count - 1 do
      local role = (skillResult.roleList)[i]
      LuaSkillCtrl:CallBuff(self, role, (self.config).buffId, 1, (self.arglist)[2] // 10)
      LuaSkillCtrl:CallRealDamage(self, role, nil, (self.config).realDamageConfig, nil, true)
    end
  end
  do
    ;
    (base.OnCasterDie)(self)
  end
end

return bs_10167

-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_10167 = class("bs_10167", LuaSkillBase)
local base = LuaSkillBase
bs_10167.config = {
    aoe_config = {effect_shape = 3, aoe_select_code = 4, aoe_range = 1},
    realDamageConfig = {basehurt_formula = 1047},
    effectId = 10274,
    buffId = 66
}
bs_10167.ctor = function(self)
    -- function num : 0_0
end

bs_10167.InitSkill = function(self, isMidwaySkill)
    -- function num : 0_1 , upvalues : base, _ENV
    (base.InitSkill)(self, isMidwaySkill)
    self:AddTrigger(eSkillTriggerType.RoleDie, "bs_10167_10", 1, self.OnRoleDie)
end

bs_10167.OnRoleDie = function(self, killer, role)
    -- function num : 0_2
end

bs_10167.OnCasterDie = function(self)
    -- function num : 0_3 , upvalues : _ENV, base
    self:PlayChipEffect()
    local targetlist = LuaSkillCtrl:CallTargetSelect(self, 8, 0)
    local checkList = LuaSkillCtrl:CallTargetSelect(self, 6, 0)
    if targetlist.Count <= 0 or checkList.Count <= 1 then return end
    local target = (targetlist[0]).targetRole
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target,
                                                             (self.config).aoe_config)
    if (skillResult.roleList).Count > 0 then
        for i = 0, (skillResult.roleList).Count - 1 do
            local role = (skillResult.roleList)[i]
            LuaSkillCtrl:CallBuff(self, role, (self.config).buffId, 1,
                                  (self.arglist)[2] // 10)
            LuaSkillCtrl:CallRealDamage(self, role, nil,
                                        (self.config).realDamageConfig, nil,
                                        true)
        end
    end
    do

        (base.OnCasterDie)(self)
    end
end

return bs_10167


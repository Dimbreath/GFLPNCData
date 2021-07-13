-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_60003 = class("bs_60003", LuaSkillBase)
local base = LuaSkillBase
bs_60003.config = {buffId = 110, 
aoe_config = {effect_shape = 3, aoe_select_code = 4, aoe_range = 1}
}
bs_60003.ctor = function(self)
  -- function num : 0_0
end

bs_60003.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  if isMidwaySkill then
    LuaSkillCtrl:StartTimer(self, (self.arglist)[1], self.CallBack, self, -1, 0)
  end
end

bs_60003.CallBack = function(self)
  -- function num : 0_2 , upvalues : _ENV
  local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, self.caster, (self.config).aoe_config)
  if (skillResult.roleList).Count > 0 then
    for i = 0, (skillResult.roleList).Count - 1 do
      local role = (skillResult.roleList)[i]
      if role.belongNum == 1 then
        local roleBuffTier = role:GetBuffTier((self.config).buffId)
        if roleBuffTier > 0 then
          LuaSkillCtrl:DispelBuff(role, (self.config).buffId, 1)
        end
      end
    end
  end
  do
    skillResult:EndResult()
  end
end

bs_60003.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_60003


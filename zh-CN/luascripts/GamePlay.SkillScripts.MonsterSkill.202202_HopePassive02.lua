-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_202202 = class("bs_202202", LuaSkillBase)
local base = LuaSkillBase
bs_202202.config = {
realDamageConfig = {basehurt_formula = 502}
}
bs_202202.ctor = function(self)
  -- function num : 0_0
end

bs_202202.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
end

bs_202202.OnCasterDie = function(self)
  -- function num : 0_2 , upvalues : base, _ENV
  (base.OnCasterDie)(self)
  LuaSkillCtrl:StartTimer(nil, 3, function()
    -- function num : 0_2_0 , upvalues : _ENV, self
    LuaSkillCtrl:CallEffect(self.caster, 10433, self, nil, nil, nil, false)
    local targetList = LuaSkillCtrl:CallTargetSelect(self, 9, 0)
    if targetList.Count > 0 then
      for i = 0, targetList.Count - 1 do
        LuaSkillCtrl:CallEffect((targetList[i]).targetRole, 10434, self)
        local number = (self.arglist)[1] * (self.caster).skill_intensity // 1000
        if number <= 0 then
          number = 1
        end
        LuaSkillCtrl:CallRealDamage(self, (targetList[i]).targetRole, nil, (self.config).realDamageConfig, {number}, true)
      end
    end
    do
      local targetlist2 = LuaSkillCtrl:CallTargetSelect(self, 2, 0)
      if targetlist2.Count > 0 then
        for i = 0, targetlist2.Count - 1 do
          local number2 = (self.arglist)[1] * (self.caster).skill_intensity // 1000
          if number2 <= 0 then
            number2 = 1
          end
          LuaSkillCtrl:CallHeal(number2, self, (targetlist2[i]).targetRole)
        end
      end
    end
  end
)
end

return bs_202202


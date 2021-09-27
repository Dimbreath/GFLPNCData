local bs_1066 = class("bs_1066", LuaSkillBase)
local base = LuaSkillBase
bs_1066.config = {effectId_loop = 101204, 
aoe_config = {effect_shape = 3, aoe_select_code = 4, aoe_range = 1}
}
bs_1066.ctor = function(self)
  -- function num : 0_0
end

bs_1066.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_1066_2", 1, self.OnAfterHurt, self.caster)
end

bs_1066.OnAfterHurt = function(self, sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  -- function num : 0_2 , upvalues : _ENV
  if sender == self.caster and skill.isCommonAttack and not isMiss then
    local effectId_loop = LuaSkillCtrl:CallEffect(target, (self.config).effectId_loop, self)
    do
      LuaSkillCtrl:StartTimer(nil, (self.arglist)[1], function()
    -- function num : 0_2_0 , upvalues : self, _ENV, target, effectId_loop
    local hurt = (self.caster).skill_intensity * (self.arglist)[2] // 1000
    LuaSkillCtrl:RemoveLife(hurt, self, target, true, nil, true, false, eHurtType.RealDmg)
    if effectId_loop ~= nil then
      effectId_loop:Die()
      effectId_loop = nil
    end
  end
, effectId_loop)
      local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target, (self.config).aoe_config)
      if (skillResult.roleList).Count ~= 0 then
        for i = 0, (self.arglist)[4] - 1 do
          if (skillResult.roleList)[i] ~= nil then
            local role = (skillResult.roleList)[i]
            do
              local effectLoop = LuaSkillCtrl:CallEffect(role, (self.config).effectId_loop, self)
              LuaSkillCtrl:StartTimer(nil, (self.arglist)[1], function()
    -- function num : 0_2_1 , upvalues : self, _ENV, role, effectLoop
    local hurt = (self.caster).skill_intensity * (self.arglist)[2] // 1000
    LuaSkillCtrl:RemoveLife(hurt, self, role, true)
    if effectLoop ~= nil then
      effectLoop:Die()
      effectLoop = nil
    end
  end
, effectLoop)
            end
          end
        end
      end
      do
        skillResult:EndResult()
      end
    end
  end
end

bs_1066.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_1066


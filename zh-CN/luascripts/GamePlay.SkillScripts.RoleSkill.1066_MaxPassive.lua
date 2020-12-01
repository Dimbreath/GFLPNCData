-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_1066 = class("bs_1066", LuaSkillBase)
local base = LuaSkillBase
bs_1066.config = {effectloop = 10368, baseHurtFormula = 10087, 
aoe_config = {effect_shape = 3, aoe_select_code = 4, aoe_range = 1}
}
bs_1066.ctor = function(self)
  -- function num : 0_0
end

bs_1066.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.SetHurt, "bs_1066_2", 1, self.OnSetHurt)
end

bs_1066.OnSetHurt = function(self, context)
  -- function num : 0_2 , upvalues : _ENV
  if context.sender == self.caster and (context.skill).isCommonAttack and not context.isMiss then
    self.loopEffect = LuaSkillCtrl:CallEffect(context.target, (self.config).effectloop, self)
    LuaSkillCtrl:StartTimer(nil, (self.arglist)[1], function()
    -- function num : 0_2_0 , upvalues : self, _ENV, context
    local hurt = (self.caster).skill_intensity * (self.arglist)[2] // 1000
    LuaSkillCtrl:RemoveLife(hurt, self, context.target, true, true)
    if self.loopEffect ~= nil then
      (self.loopEffect):Die()
      self.loopEffect = nil
    end
  end
)
    if (self.arglist)[3] > 0 then
      self.loopeffectpro = {}
      local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, context.target, (self.config).aoe_config)
      if (skillResult.roleList).Count ~= 0 then
        for i = 0, (self.arglist)[4] - 1 do
          do
            if (skillResult.roleList)[i] ~= nil then
              local role = (skillResult.roleList)[i]
              -- DECOMPILER ERROR at PC63: Confused about usage of register: R8 in 'UnsetPending'

              ;
              (self.loopeffectpro)[i] = LuaSkillCtrl:CallEffect(role, (self.config).effectloop, self)
              LuaSkillCtrl:StartTimer(nil, (self.arglist)[1], function()
    -- function num : 0_2_1 , upvalues : self, _ENV, role, i
    local hurt = (self.caster).skill_intensity * (self.arglist)[2] // 1000
    LuaSkillCtrl:RemoveLife(hurt, self, role, true, true)
    if (self.loopeffectpro)[i] ~= nil then
      ((self.loopeffectpro)[i]):Die()
      -- DECOMPILER ERROR at PC26: Confused about usage of register: R1 in 'UnsetPending'

      ;
      (self.loopeffectpro)[i] = nil
    end
  end
)
            end
          end
        end
      end
      do
        skillResult:EndResult()
        -- DECOMPILER ERROR at PC76: Confused about usage of register R3 for local variables in 'ReleaseLocals'

      end
    end
  end
end

bs_1066.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_1066

-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_1066 = class("bs_1066", LuaSkillBase)
local base = LuaSkillBase
bs_1066.config = {
    effectloop = 10368,
    baseHurtFormula = 10087,
    aoe_config = {effect_shape = 3, aoe_select_code = 4, aoe_range = 1}
}
bs_1066.ctor = function(self)
    -- function num : 0_0
end

bs_1066.InitSkill = function(self, isMidwaySkill)
    -- function num : 0_1 , upvalues : base, _ENV
    (base.InitSkill)(self, isMidwaySkill)
    self:AddTrigger(eSkillTriggerType.SetHurt, "bs_1066_2", 1, self.OnSetHurt)
end

bs_1066.OnSetHurt = function(self, context)
    -- function num : 0_2 , upvalues : _ENV
    if context.sender == self.caster and (context.skill).isCommonAttack and
        not context.isMiss then
        self.loopEffect = LuaSkillCtrl:CallEffect(context.target,
                                                  (self.config).effectloop, self)
        LuaSkillCtrl:StartTimer(nil, (self.arglist)[1], function()
            -- function num : 0_2_0 , upvalues : self, _ENV, context
            local hurt = (self.caster).skill_intensity * (self.arglist)[2] //
                             1000
            LuaSkillCtrl:RemoveLife(hurt, self, context.target, true, true)
            if self.loopEffect ~= nil then
                (self.loopEffect):Die()
                self.loopEffect = nil
            end
        end)
        if (self.arglist)[3] > 0 then
            self.loopeffectpro = {}
            local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self,
                                                                     context.target,
                                                                     (self.config).aoe_config)
            if (skillResult.roleList).Count ~= 0 then
                for i = 0, (self.arglist)[4] - 1 do
                    do
                        if (skillResult.roleList)[i] ~= nil then
                            local role = (skillResult.roleList)[i] -- DECOMPILER ERROR at PC63: Confused about usage of register: R8 in 'UnsetPending'
                            ;
                            (self.loopeffectpro)[i] =
                                LuaSkillCtrl:CallEffect(role,
                                                        (self.config).effectloop,
                                                        self)
                            LuaSkillCtrl:StartTimer(nil, (self.arglist)[1],
                                                    function()
                                -- function num : 0_2_1 , upvalues : self, _ENV, role, i
                                local hurt =
                                    (self.caster).skill_intensity *
                                        (self.arglist)[2] // 1000
                                LuaSkillCtrl:RemoveLife(hurt, self, role, true,
                                                        true)
                                if (self.loopeffectpro)[i] ~= nil then
                                    ((self.loopeffectpro)[i]):Die() -- DECOMPILER ERROR at PC26: Confused about usage of register: R1 in 'UnsetPending'
                                    ;
                                    (self.loopeffectpro)[i] = nil
                                end
                            end)
                        end
                    end
                end
            end
            do
                skillResult:EndResult()
                -- DECOMPILER ERROR at PC76: Confused about usage of register R3 for local variables in 'ReleaseLocals'

            end
        end
    end
end

bs_1066.OnCasterDie = function(self)
    -- function num : 0_3 , upvalues : base
    (base.OnCasterDie)(self)
end

return bs_1066


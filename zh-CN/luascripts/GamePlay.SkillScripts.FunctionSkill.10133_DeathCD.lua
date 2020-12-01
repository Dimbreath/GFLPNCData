-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_10133 = class("bs_10133", LuaSkillBase)
local base = LuaSkillBase
bs_10133.config = {buffId = 1043}
bs_10133.ctor = function(self)
  -- function num : 0_0
end

bs_10133.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.SetHurt, "bs_10133_1", 1, self.OnSetHurt)
  -- DECOMPILER ERROR at PC13: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.caster).recordTable)["10133_Time"] = 1
end

bs_10133.OnSetHurt = function(self, context)
  -- function num : 0_2 , upvalues : _ENV
  if (context.target).belongNum == (self.caster).belongNum and (context.target).roleType == 1 and self:IsReadyToTake() and (context.target).hp <= context.hurt and (context.target).hp > 0 and ((self.caster).recordTable)["10133_Time"] > 0 then
    self:PlayChipEffect()
    local skills = (self.caster):GetBattleSkillList()
    if skills ~= nil then
      local skillCount = skills.Count
      if skillCount > 0 then
        for j = 0, skillCount - 1 do
          local curTotalCd = (skills[j]).totalCDTime
          LuaSkillCtrl:CallResetCDForSingleSkill(skills[j], curTotalCd)
        end
      end
    end
    do
      -- DECOMPILER ERROR at PC56: Confused about usage of register: R3 in 'UnsetPending'

      ;
      ((self.caster).recordTable)["10133_Time"] = ((self.caster).recordTable)["10133_Time"] - 1
      LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId, (self.arglist)[1])
      self:OnSkillTake()
    end
  end
end

bs_10133.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10133

-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_10133 = class("bs_10133", LuaSkillBase)
local base = LuaSkillBase
bs_10133.config = {buffId = 1043}
bs_10133.ctor = function(self)
    -- function num : 0_0
end

bs_10133.InitSkill = function(self, isMidwaySkill)
    -- function num : 0_1 , upvalues : base, _ENV
    (base.InitSkill)(self, isMidwaySkill)
    self:AddTrigger(eSkillTriggerType.SetHurt, "bs_10133_1", 1, self.OnSetHurt) -- DECOMPILER ERROR at PC13: Confused about usage of register: R2 in 'UnsetPending'
    ;
    ((self.caster).recordTable)["10133_Time"] = 1
end

bs_10133.OnSetHurt = function(self, context)
    -- function num : 0_2 , upvalues : _ENV
    if (context.target).belongNum == (self.caster).belongNum and
        (context.target).roleType == 1 and self:IsReadyToTake() and
        (context.target).hp <= context.hurt and (context.target).hp > 0 and
        ((self.caster).recordTable)["10133_Time"] > 0 then
        self:PlayChipEffect()
        local skills = (self.caster):GetBattleSkillList()
        if skills ~= nil then
            local skillCount = skills.Count
            if skillCount > 0 then
                for j = 0, skillCount - 1 do
                    local curTotalCd = (skills[j]).totalCDTime
                    LuaSkillCtrl:CallResetCDForSingleSkill(skills[j], curTotalCd)
                end
            end
        end
        do
            -- DECOMPILER ERROR at PC56: Confused about usage of register: R3 in 'UnsetPending'


            ((self.caster).recordTable)["10133_Time"] =
                ((self.caster).recordTable)["10133_Time"] - 1
            LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId,
                                  (self.arglist)[1])
            self:OnSkillTake()
        end
    end
end

bs_10133.OnCasterDie = function(self)
    -- function num : 0_3 , upvalues : base
    (base.OnCasterDie)(self)
end

return bs_10133


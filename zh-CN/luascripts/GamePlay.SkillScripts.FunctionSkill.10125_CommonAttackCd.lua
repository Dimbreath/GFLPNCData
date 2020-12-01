-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_10125 = class("bs_10125", LuaSkillBase)
local base = LuaSkillBase
bs_10125.config = {}
bs_10125.ctor = function(self)
  -- function num : 0_0
end

bs_10125.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterPlaySkill, "bs_10125_2", 2, self.OnAfterPlaySkill)
end

bs_10125.OnAfterPlaySkill = function(self, skill, role)
  -- function num : 0_2 , upvalues : _ENV
  if skill.maker == self.caster and skill.isCommonAttack and LuaSkillCtrl:CallRange(1, 1000) < (self.arglist)[1] then
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
      self:PlayChipEffect()
    end
  end
end

bs_10125.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10125

-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_10125 = class("bs_10125", LuaSkillBase)
local base = LuaSkillBase
bs_10125.config = {}
bs_10125.ctor = function(self)
    -- function num : 0_0
end

bs_10125.InitSkill = function(self, isMidwaySkill)
    -- function num : 0_1 , upvalues : base, _ENV
    (base.InitSkill)(self, isMidwaySkill)
    self:AddTrigger(eSkillTriggerType.AfterPlaySkill, "bs_10125_2", 2,
                    self.OnAfterPlaySkill)
end

bs_10125.OnAfterPlaySkill = function(self, skill, role)
    -- function num : 0_2 , upvalues : _ENV
    if skill.maker == self.caster and skill.isCommonAttack and
        LuaSkillCtrl:CallRange(1, 1000) < (self.arglist)[1] then
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
        do self:PlayChipEffect() end
    end
end

bs_10125.OnCasterDie = function(self)
    -- function num : 0_3 , upvalues : base
    (base.OnCasterDie)(self)
end

return bs_10125


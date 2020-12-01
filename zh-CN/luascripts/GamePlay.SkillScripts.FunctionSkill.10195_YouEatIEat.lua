-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_10195 = class("bs_10195", LuaSkillBase)
local base = LuaSkillBase
bs_10195.config = {eatEffectId = 10376}
bs_10195.ctor = function(self)
  -- function num : 0_0
end

bs_10195.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddLuaTrigger(eSkillLuaTrigger.OnDoodad, self.OnDoodad)
end

bs_10195.OnDoodad = function(self, sender, targetRole)
  -- function num : 0_2 , upvalues : _ENV
  if targetRole.belongNum == 2 and ((self.caster).recordTable).lastAttackRole == targetRole then
    local skills = (self.caster):GetBattleSkillList()
    if skills ~= nil then
      local skillCount = skills.Count
      if skillCount > 0 then
        for j = 0, skillCount - 1 do
          local curTotalCd = (skills[j]).totalCDTime
          if not (skills[j]).isCommonAttack then
            LuaSkillCtrl:CallResetCDForSingleSkill(skills[j], curTotalCd)
            self.flag = false
            LuaSkillCtrl:CallEffect(self.caster, (self.config).eatEffectId, self)
          end
        end
        LuaSkillCtrl:CallDoodad(nil, self.caster)
      end
    end
  end
end

bs_10195.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10195

-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_10195 = class("bs_10195", LuaSkillBase)
local base = LuaSkillBase
bs_10195.config = {eatEffectId = 10376}
bs_10195.ctor = function(self)
    -- function num : 0_0
end

bs_10195.InitSkill = function(self, isMidwaySkill)
    -- function num : 0_1 , upvalues : base, _ENV
    (base.InitSkill)(self, isMidwaySkill)
    self:AddLuaTrigger(eSkillLuaTrigger.OnDoodad, self.OnDoodad)
end

bs_10195.OnDoodad = function(self, sender, targetRole)
    -- function num : 0_2 , upvalues : _ENV
    if targetRole.belongNum == 2 and ((self.caster).recordTable).lastAttackRole ==
        targetRole then
        local skills = (self.caster):GetBattleSkillList()
        if skills ~= nil then
            local skillCount = skills.Count
            if skillCount > 0 then
                for j = 0, skillCount - 1 do
                    local curTotalCd = (skills[j]).totalCDTime
                    if not (skills[j]).isCommonAttack then
                        LuaSkillCtrl:CallResetCDForSingleSkill(skills[j],
                                                               curTotalCd)
                        self.flag = false
                        LuaSkillCtrl:CallEffect(self.caster,
                                                (self.config).eatEffectId, self)
                    end
                end
                LuaSkillCtrl:CallDoodad(nil, self.caster)
            end
        end
    end
end

bs_10195.OnCasterDie = function(self)
    -- function num : 0_3 , upvalues : base
    (base.OnCasterDie)(self)
end

return bs_10195


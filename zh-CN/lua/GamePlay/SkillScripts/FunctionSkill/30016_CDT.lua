local bs_30016 = class("bs_30016", LuaSkillBase)
local base = LuaSkillBase
bs_30016.config = {buffId = 170}
bs_30016.ctor = function(self)
  -- function num : 0_0
end

bs_30016.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddSelfTrigger(eSkillTriggerType.AfterPlaySkill, "bs_30016_2", 2, self.OnAfterPlaySkill)
end

bs_30016.OnAfterPlaySkill = function(self, skill, role)
  -- function num : 0_2 , upvalues : _ENV
  local buffTier = (self.caster):GetBuffTier((self.config).buffId)
  if buffTier > 0 then
    return 
  end
  if skill.maker == self.caster and skill.isCommonAttack then
    local skills = (self.caster):GetBattleSkillList()
    if skills ~= nil then
      local skillCount = skills.Count
      if skillCount > 0 then
        for j = 0, skillCount - 1 do
          local curTotalCd = (skills[j]).totalCDTime * (self.arglist)[1] // 1000
          LuaSkillCtrl:CallResetCDForSingleSkill(skills[j], curTotalCd)
        end
      end
    end
    do
      self:PlayChipEffect()
    end
  end
end

bs_30016.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_30016


local bs_10226 = class("bs_10226", LuaSkillBase)
local base = LuaSkillBase
bs_10226.config = {effectId = 10164}
bs_10226.ctor = function(self)
  -- function num : 0_0
end

bs_10226.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddSelfTrigger(eSkillTriggerType.AfterPlaySkill, "bs_10226_1", 2, self.OnAfterPlaySkill)
end

bs_10226.OnAfterPlaySkill = function(self, skill, role)
  -- function num : 0_2 , upvalues : _ENV
  if skill.maker == self.caster and not skill.isCommonAttack then
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
      LuaSkillCtrl:CallEffect(self.caster, (self.config).effectId, self)
    end
  end
end

bs_10226.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10226


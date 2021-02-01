-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_20014 = class("bs_20014", LuaSkillBase)
local base = LuaSkillBase
bs_20014.config = {}
bs_20014.ctor = function(self)
  -- function num : 0_0
end

bs_20014.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_20014_1", 1, self.OnAfterBattleStart)
end

bs_20014.OnAfterBattleStart = function(self)
  -- function num : 0_2 , upvalues : _ENV
  local skills = (self.caster):GetBattleSkillList()
  if skills ~= nil then
    local count = skills.Count
    if count > 0 then
      for i = 0, count - 1 do
        local startCd = (skills[i]).curCDTime
        LuaSkillCtrl:CallResetCDForSingleSkill(skills[i], -startCd)
      end
      self:PlayChipEffect()
    end
  end
end

bs_20014.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_20014


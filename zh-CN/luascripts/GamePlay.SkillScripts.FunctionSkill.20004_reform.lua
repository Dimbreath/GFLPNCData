-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_20004 = class("bs_20004", LuaSkillBase)
local base = LuaSkillBase
bs_20004.config = {}
bs_20004.ctor = function(self)
  -- function num : 0_0
end

bs_20004.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.RoleDie, "bs_20004_10", 1, self.OnRoleDie)
end

bs_20004.OnRoleDie = function(self, killer, role)
  -- function num : 0_2 , upvalues : _ENV
  if role.belongNum == 2 then
    local skills = (self.caster):GetBattleSkillList()
    if skills ~= nil then
      local count = skills.Count
      if count > 0 then
        for i = 0, count - 1 do
          local curCd = (skills[i]).totalCDTime
          LuaSkillCtrl:CallResetCDForSingleSkill(skills[i], curCd)
        end
        self:PlayChipEffect()
      end
    end
  end
end

bs_20004.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_20004


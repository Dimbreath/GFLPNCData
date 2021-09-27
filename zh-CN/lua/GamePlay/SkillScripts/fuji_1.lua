local bs_fuji = class("bs_fuji", LuaSkillBase)
local base = LuaSkillBase
bs_fuji.config = {player = 1, enemy = 2}
bs_fuji.ctor = function(self)
  -- function num : 0_0
end

bs_fuji.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : _ENV
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_fuji_1", 9999, self.OnAfterBattleStart)
end

bs_fuji.OnAfterBattleStart = function(self)
  -- function num : 0_2 , upvalues : _ENV
  local roles = ((LuaSkillCtrl.battleCtrl).PlayerTeamController).battleOriginRoleList
  if roles == nil then
    return 
  end
  local roleCount = roles.Count
  if roleCount > 0 then
    for i = 0, roleCount - 1 do
      if roles[i] ~= nil then
        local skills = (roles[i]):GetBattleSkillList()
        if skills ~= nil then
          local skillCount = skills.Count
          if skillCount > 0 then
            for j = 0, skillCount - 1 do
              local startCd = (skills[j]).startCdTime
              local curTotalCd = (skills[j]).totalCDTime
              LuaSkillCtrl:CallResetCDForSingleSkill(skills[j], (curTotalCd + startCd) // 2)
            end
          end
        end
      end
    end
  end
end

bs_fuji.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_fuji


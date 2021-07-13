-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_5020 = class("bs_5020", LuaSkillBase)
local base = LuaSkillBase
bs_5020.config = {}
bs_5020.ctor = function(self)
  -- function num : 0_0
end

bs_5020.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
  self:AddOnPlayerMpCostedTrigger("bs_5020_1", 1, self.OnMpCostToTargetValue, (self.arglist)[1])
end

bs_5020.OnMpCostToTargetValue = function(self)
  -- function num : 0_2 , upvalues : _ENV
  local targetList = LuaSkillCtrl:CallTargetSelect(self, 6, 10)
  for i = 0, targetList.Count - 1 do
    local skills = ((targetList[i]).targetRole):GetBattleSkillList()
    if skills ~= nil then
      local skillCount = skills.Count
      if skillCount > 0 then
        for j = 0, skillCount - 1 do
          if not (skills[j]).isCommonAttack then
            local curTotalCd = (skills[j]).totalCDTime * (self.arglist)[2] // 1000
            LuaSkillCtrl:CallResetCDForSingleSkill(skills[j], curTotalCd)
          end
        end
      end
    end
  end
  self:RemoveSkillTrigger(eSkillTriggerType.OnPlayerMpCostToTargetValue)
end

bs_5020.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_5020


local bs_30042 = class("bs_30042", LuaSkillBase)
local base = LuaSkillBase
bs_30042.config = {}
bs_30042.ctor = function(self)
  -- function num : 0_0
end

bs_30042.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.RoleDie, "bs_30042_10", 1, self.OnRoleDie)
end

bs_30042.OnRoleDie = function(self, killer, role)
  -- function num : 0_2 , upvalues : _ENV
  if role.belongNum == (self.caster).belongNum and role.roleType == 1 then
    self:PlayChipEffect()
    local targetlist = LuaSkillCtrl:CallTargetSelect(self, 6, 0)
    if targetlist.Count < 1 then
      return 
    end
    for i = 0, targetlist.Count - 1 do
      local targetRole = (targetlist[i]).targetRole
      local skills = targetRole:GetBattleSkillList()
      if skills ~= nil then
        local skillCount = skills.Count
        if skillCount > 0 then
          for j = 0, skillCount - 1 do
            local curTotalCd = (skills[j]).totalCDTime
            LuaSkillCtrl:CallResetCDForSingleSkill(skills[j], curTotalCd)
          end
        end
      end
    end
  end
end

bs_30042.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_30042


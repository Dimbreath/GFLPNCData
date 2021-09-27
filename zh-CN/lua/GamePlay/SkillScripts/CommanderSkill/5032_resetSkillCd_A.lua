local bs_5032 = class("bs_5032", LuaSkillBase)
local base = LuaSkillBase
bs_5032.config = {effectId_reduce = 503201}
bs_5032.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_0 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
end

bs_5032.CheckManualSkillTakeAvailable = function(self, role)
  -- function num : 0_1 , upvalues : base
  local skills = role:GetBattleSkillList()
  local num = 0
  if skills ~= nil then
    local skillCount = skills.Count
    if skillCount > 0 then
      for j = 0, skillCount - 1 do
        if (skills[j]).isNormalSkill then
          num = num + 1
        end
      end
    end
  end
  do
    if num == 0 then
      return false
    end
    return (base.CheckManualSkillTakeAvailable)(self, role)
  end
end

bs_5032.PlaySkill = function(self, data, selectTargetCoord, selectRoles)
  -- function num : 0_2 , upvalues : _ENV
  return self:GetSelectTargetAndExecute(selectRoles, BindCallback(self, self.CallSelectExecute))
end

bs_5032.CallSelectExecute = function(self, role)
  -- function num : 0_3 , upvalues : _ENV
  if role.hp <= 0 then
    return 
  end
  if role.belongNum == eBattleRoleBelong.enemy then
    local curCd = self:GetCurMainSkillCd(role)
    local offset = (self.arglist)[1]
    if offset > 1000 then
      offset = 1000
    end
    curCd = -curCd * (1000 - offset) // 1000
    LuaSkillCtrl:CallEffect(role, (self.config).effectId_reduce, self)
    LuaSkillCtrl:CallResetCDNumForRole(role, curCd)
  end
end

bs_5032.GetCurMainSkillCd = function(self, role)
  -- function num : 0_4
  local skillMgr = role:GetSkillComponent()
  if skillMgr == nil then
    return 0
  end
  if skillMgr.currentFixedSkill ~= nil then
    return (skillMgr.currentFixedSkill).CurCDTime
  end
  return role:GetMainSkillCurCd()
end

bs_5032.OnCasterDie = function(self)
  -- function num : 0_5 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_5032


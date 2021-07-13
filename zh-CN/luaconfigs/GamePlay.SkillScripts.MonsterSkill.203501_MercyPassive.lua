-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_203501 = class("bs_203501", LuaSkillBase)
local base = LuaSkillBase
bs_203501.config = {}
bs_203501.ctor = function(self)
  -- function num : 0_0
end

bs_203501.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.RoleDie, "bs_203501_11", 1, self.OnRoleDie)
end

bs_203501.OnRoleDie = function(self, killer, role, killSkill)
  -- function num : 0_2 , upvalues : _ENV
  if role.belongNum == (self.caster).belongNum and role.name ~= "仁慈-召唤" and self:IsReadyToTake() then
    local skills = (self.caster):GetBattleSkillList()
    if skills ~= nil then
      local skillCount = skills.Count
      if skillCount > 0 then
        for j = 0, skillCount - 1 do
          local curTotalCd = (skills[j]).totalCDTime
          if not (skills[j]).isCommonAttack then
            LuaSkillCtrl:CallResetCDForSingleSkill(skills[j], curTotalCd)
            self:OnSkillTake()
          end
        end
      end
    end
  end
end

bs_203501.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_203501


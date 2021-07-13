-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_10250 = class("bs_10250", LuaSkillBase)
local base = LuaSkillBase
bs_10250.config = {buffId = 1088, buffTier = 1, 
heal_config = {baseheal_formula = 10076, heal_number = 0, correct_formula = 9990}
, effectId = 10634, effectId2 = 10787}
bs_10250.ctor = function(self)
  -- function num : 0_0
end

bs_10250.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterPlaySkill, "bs_10250_3", 3, self.OnAfterPlaySkill)
end

bs_10250.OnAfterPlaySkill = function(self, skill, role)
  -- function num : 0_2 , upvalues : _ENV
  if not skill.isCommonAttack and role.belongNum == (self.caster).belongNum and role.roleType == 1 and self:IsReadyToTake() then
    self:OnSkillTake()
    LuaSkillCtrl:CallEffect(role, (self.config).effectId2, self, self.SkillEventFunc)
    self:PlayChipEffect()
  end
end

bs_10250.SkillEventFunc = function(self, effect, eventId, target)
  -- function num : 0_3 , upvalues : _ENV
  if eventId == eBattleEffectEvent.Trigger then
    local skillResult = LuaSkillCtrl:CallSkillResult(effect, target)
    if (skillResult.roleList).Count < 1 then
      return 
    end
    local role = (skillResult.roleList)[0]
    LuaSkillCtrl:CallBuffRepeated(self, role, (self.config).buffId, (self.config).buffTier, 90, false, self.OnBuffExecute)
    local skills = role:GetBattleSkillList()
    if skills ~= nil then
      local skillCount = skills.Count
      if skillCount > 0 then
        for j = 0, skillCount - 1 do
          local curTotalCd = (skills[j]).totalCDTime * (self.arglist)[1] // 1000
          if not (skills[j]).isCommonAttack then
            LuaSkillCtrl:CallResetCDForSingleSkill(skills[j], curTotalCd)
          end
        end
      end
    end
    do
      skillResult:EndResult()
    end
  end
end

bs_10250.OnBuffExecute = function(self, buff, targetRole)
  -- function num : 0_4 , upvalues : _ENV
  LuaSkillCtrl:CallEffect(targetRole, (self.config).effectId, self)
  local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, targetRole)
  LuaSkillCtrl:HealResult(skillResult, (self.config).heal_config, nil, true, true)
  skillResult:EndResult()
end

bs_10250.OnCasterDie = function(self)
  -- function num : 0_5 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10250


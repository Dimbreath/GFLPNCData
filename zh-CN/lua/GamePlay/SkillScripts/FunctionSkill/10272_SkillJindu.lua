local bs_10272 = class("bs_10272", LuaSkillBase)
local base = LuaSkillBase
bs_10272.config = {eatEffectId = 10735, effectId = 10892}
bs_10272.ctor = function(self)
  -- function num : 0_0
end

bs_10272.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddSelfTrigger(eSkillTriggerType.AfterPlaySkill, "bs_10272_12", 1, self.OnAfterPlaySkill)
end

bs_10272.OnAfterPlaySkill = function(self, skill, role)
  -- function num : 0_2 , upvalues : _ENV
  if role == self.caster and not skill.isCommonAttack and self:IsReadyToTake() then
    local targetlist = LuaSkillCtrl:CallTargetSelect(self, 61, 10)
    if targetlist.Count < 1 then
      return 
    end
    local targetRole = (targetlist[0]).targetRole
    if targetRole == self.caster and targetlist.Count > 1 and ((targetlist[1]).targetRole).roleType == 1 then
      targetRole = (targetlist[1]).targetRole
    end
    if targetRole.roleType ~= 1 then
      return 
    end
    local skills = targetRole:GetBattleSkillList()
    if skills ~= nil then
      local skillCount = skills.Count
      if skillCount > 0 then
        for j = 0, skillCount - 1 do
          local curTotalCd = (skills[j]).totalCDTime * (self.arglist)[1] // 1000
          if not (skills[j]).isCommonAttack then
            LuaSkillCtrl:CallResetCDForSingleSkill(skills[j], curTotalCd)
          end
        end
        LuaSkillCtrl:CallEffect(targetRole, (self.config).eatEffectId, self)
        self:OnSkillTake()
        LuaSkillCtrl:CallChipSuitInvoke(self.caster, targetRole)
        LuaSkillCtrl:CallEffect(targetRole, (self.config).effectId, self, self.SkillEventFunc)
        self:PlayChipEffect()
      end
    end
  end
end

bs_10272.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10272


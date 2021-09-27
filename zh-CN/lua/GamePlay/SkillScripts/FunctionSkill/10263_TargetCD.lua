local bs_10263 = class("bs_10263", LuaSkillBase)
local base = LuaSkillBase
bs_10263.config = {effectId = 10735}
bs_10263.ctor = function(self)
  -- function num : 0_0
end

bs_10263.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_10263_3", 1, self.OnAfterHurt, self.caster)
end

bs_10263.OnAfterHurt = function(self, sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  -- function num : 0_2 , upvalues : _ENV
  if sender == self.caster and skill.isCommonAttack and target.hp * 1000 // target.maxHp < (self.arglist)[1] and self:IsReadyToTake() then
    self:OnSkillTake()
    self:PlayChipEffect()
    local skills = (self.caster):GetBattleSkillList()
    if skills ~= nil then
      local skillCount = skills.Count
      if skillCount > 0 then
        for j = 0, skillCount - 1 do
          local curTotalCd = (skills[j]).totalCDTime * (self.arglist)[2] // 1000
          if not (skills[j]).isCommonAttack then
            LuaSkillCtrl:CallResetCDForSingleSkill(skills[j], curTotalCd)
            LuaSkillCtrl:CallEffect(self.caster, (self.config).effectId, self)
          end
        end
      end
    end
  end
end

bs_10263.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10263


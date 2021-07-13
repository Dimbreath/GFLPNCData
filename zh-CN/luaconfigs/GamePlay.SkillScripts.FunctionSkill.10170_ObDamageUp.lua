-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_10170 = class("bs_10170", LuaSkillBase)
local base = LuaSkillBase
bs_10170.config = {effectId = 10164}
bs_10170.ctor = function(self)
  -- function num : 0_0
end

bs_10170.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddSetHurtTrigger("bs_10170_2", 1, self.OnSetHurt, self.caster, nil, nil, eBattleRoleBelong.neutral)
  self:AddTrigger(eSkillTriggerType.RoleDie, "bs_10170_1", 2, self.OnRoleDie)
end

bs_10170.OnSetHurt = function(self, context)
  -- function num : 0_2
  if context.sender == self.caster and (context.target).belongNum == 0 and (context.target).intensity == 0 then
    context.hurt = context.hurt + context.hurt * (self.arglist)[1] // 1000
  end
end

bs_10170.OnRoleDie = function(self, killer, role)
  -- function num : 0_3 , upvalues : _ENV
  if role.intensity == 0 and killer == self.caster then
    local skills = (self.caster):GetBattleSkillList()
    if skills ~= nil then
      local skillCount = skills.Count
      if skillCount > 0 then
        for j = 0, skillCount - 1 do
          local curTotalCd = (skills[j]).totalCDTime
          if not (skills[j]).isCommonAttack then
            LuaSkillCtrl:CallResetCDForSingleSkill(skills[j], curTotalCd)
            self:PlayChipEffect()
            LuaSkillCtrl:CallEffect(self.caster, (self.config).effectId, self)
          end
        end
      end
    end
  end
end

bs_10170.OnCasterDie = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10170


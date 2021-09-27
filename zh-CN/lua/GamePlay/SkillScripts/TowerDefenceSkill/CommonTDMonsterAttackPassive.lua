local CommonTDMonsterAttackPassive = class("CommonTDMonsterAttackPassive", LuaSkillBase)
local base = LuaSkillBase
CommonTDMonsterAttackPassive.config = {effect_id = 10100}
CommonTDMonsterAttackPassive.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_0 , upvalues : _ENV
  self:AddTrigger(eSkillTriggerType.BeforePlaySkill, "CommonTDMonsterAttackPassive_checkPlaySkill", 1, self.OnBeforePlaySkill)
end

CommonTDMonsterAttackPassive.OnBeforePlaySkill = function(self, role, context)
  -- function num : 0_1
  if role ~= self.caster then
    return 
  end
  local campRole = (self.caster):GetRoleMoveFollowTarget()
  if ((context.skill).moveSelectTarget).targetRole == campRole and self:IsReadyToTake() then
    context.active = false
    self:AttackTowerCamp()
    if self.cskill ~= nil then
      self:OnSkillTake()
    end
  end
end

CommonTDMonsterAttackPassive.AttackTowerCamp = function(self)
  -- function num : 0_2 , upvalues : _ENV
  LuaSkillCtrl:CallEffect(self.caster, (self.config).effect_id, self)
  local campRole = (self.caster):GetRoleMoveFollowTarget()
  local isboss = ((self.caster).recordTable).isTowerBoss
  do
    if campRole ~= nil and campRole.hp > 0 then
      local hurt = campRole.maxHp // 8 + 1
      if isboss then
        hurt = campRole.maxHp + 1
      end
      LuaSkillCtrl:RemoveLife(hurt, self, campRole, true, nil, true, true)
    end
    if not isboss then
      LuaSkillCtrl:RemoveLife((self.caster).hp + 1, self, self.caster, true, nil, true, true)
    end
  end
end

return CommonTDMonsterAttackPassive


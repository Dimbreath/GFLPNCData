local bs_103101 = class("bs_103101", LuaSkillBase)
local base = LuaSkillBase
bs_103101.config = {selectId = 33, 
hurtConfig = {hit_formula = 0, basehurt_formula = 3010, crit_formula = 0, crithur_ratio = 0, returndamage_formula = 0}
, 
heal_config = {baseheal_formula = 501}
, effectId_heal = 103105, audioId1 = 103101, audioId2 = 103102}
bs_103101.ctor = function(self)
  -- function num : 0_0
end

bs_103101.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_103101_3", 1, self.OnAfterHurt, self.caster)
end

bs_103101.OnAfterHurt = function(self, sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  -- function num : 0_2 , upvalues : _ENV
  do
    if sender == self.caster and skill.isCommonAttack then
      local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
      LuaSkillCtrl:HurtResult(self, skillResult, (self.config).hurtConfig, {(self.arglist)[1]})
      skillResult:EndResult()
    end
    if hurtType == 1 and sender == self.caster and skill.dataId == 103101 then
      local target_heal = nil
      local hp = 0
      local long = 0
      local targetList = LuaSkillCtrl:CallTargetSelect(self, (self.config).selectId, 10, target)
      if targetList.Count > 0 then
        for i = 0, targetList.Count - 1 do
          local role = (targetList[i]).targetRole
          if role.belongNum == (self.caster).belongNum then
            local num = role.hp * 100 // role.maxHp
            local long_role = LuaSkillCtrl:GetRoleGridsDistance(target, role)
            if i == 0 then
              target_heal = role
              hp = num
              long = long_role
            else
              if long >= long_role then
                do
                  if num < hp then
                    target_heal = role
                    hp = num
                  end
                  -- DECOMPILER ERROR at PC79: LeaveBlock: unexpected jumping out IF_THEN_STMT

                  -- DECOMPILER ERROR at PC79: LeaveBlock: unexpected jumping out IF_STMT

                  -- DECOMPILER ERROR at PC79: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                  -- DECOMPILER ERROR at PC79: LeaveBlock: unexpected jumping out IF_STMT

                  -- DECOMPILER ERROR at PC79: LeaveBlock: unexpected jumping out IF_THEN_STMT

                  -- DECOMPILER ERROR at PC79: LeaveBlock: unexpected jumping out IF_STMT

                end
              end
            end
          end
        end
      end
      if target_heal ~= nil and target_heal.hp > 0 then
        LuaSkillCtrl:PlayAuSource(self.caster, (self.config).audioId1)
        LuaSkillCtrl:CallEffectWithArgOverride(target_heal, (self.config).effectId_heal, self, target, nil, nil, self.SkillEventFunc, hurt)
      end
    end
  end
end

bs_103101.SkillEventFunc = function(self, hurt, effect, eventId, target)
  -- function num : 0_3 , upvalues : _ENV
  if eventId == eBattleEffectEvent.Trigger and target ~= nil and (target.targetRole).hp > 0 then
    local heal = hurt * (self.arglist)[2] // 1000
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target.targetRole)
    LuaSkillCtrl:HealResult(skillResult, (self.config).heal_config, {heal})
    skillResult:EndResult()
    LuaSkillCtrl:PlayAuSource(self.caster, (self.config).audioId2)
  end
end

bs_103101.OnCasterDie = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_103101


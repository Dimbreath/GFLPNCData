-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_101501 = class("bs_101501", LuaSkillBase)
local base = LuaSkillBase
bs_101501.config = {buffId_216 = 216, 
HealConfig = {baseheal_formula = 10144}
, effectId_heal = 10660, effectId_p = 10658}
bs_101501.ctor = function(self)
  -- function num : 0_0
end

bs_101501.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_101501_12", 5, self.OnAfterHurt, self.caster)
end

bs_101501.OnAfterHurt = function(self, sender, target, skill, hurt, isMiss, isCrit, isRealDmg, isTriggerSet)
  -- function num : 0_2 , upvalues : _ENV
  if sender == self.caster and skill.isCommonAttack and target.belongNum ~= (self.caster).belongNum then
    if (self.arglist)[3] > 0 and LuaSkillCtrl:CallRange(1, 1000) <= (self.arglist)[4] and target:GetBuffTier((self.config).buffId_216) > 0 then
      local num = 1 - target.attackRange
      local targetlist = LuaSkillCtrl:CallTargetSelect(self, 9, num, target)
      LuaSkillCtrl:CallEffect(target, (self.config).effectId_heal, self)
      if targetlist.Count > 0 then
        local heal_Count = targetlist.Count
        for i = 0, targetlist.Count - 1 do
          local _role = (targetlist[i]).targetRole
          if _role.intensity == 0 then
            heal_Count = heal_Count - 1
          end
        end
        if heal_Count > 0 then
          for i = 0, targetlist.Count - 1 do
            local _role = (targetlist[i]).targetRole
            if _role.intensity ~= 0 then
              local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, _role)
              LuaSkillCtrl:HealResult(skillResult, (self.config).HealConfig, {heal_Count})
              skillResult:EndResult()
            end
          end
        end
      end
    end
    do
      LuaSkillCtrl:CallBuff(self, target, (self.config).buffId_216, 1, (self.arglist)[6])
      LuaSkillCtrl:CallEffect(target, (self.config).effectId_p, self)
      if ((self.caster).recordTable).skill_ex == true and sender == self.caster and skill.dataId == 101502 and target.belongNum ~= (self.caster).belongNum then
        LuaSkillCtrl:CallBuff(self, target, (self.config).buffId_216, 1, (self.arglist)[6])
        LuaSkillCtrl:CallEffect(target, (self.config).effectId_p, self)
        if target:GetBuffTier((self.config).buffId_216) > 0 then
          local num = 1 - target.attackRange
          local targetlist = LuaSkillCtrl:CallTargetSelect(self, 9, num, target)
          LuaSkillCtrl:CallEffect(target, (self.config).effectId_heal, self)
          if targetlist.Count > 0 then
            local heal_Count = targetlist.Count
            for i = 0, targetlist.Count - 1 do
              local _role = (targetlist[i]).targetRole
              if _role.intensity == 0 then
                heal_Count = heal_Count - 1
              end
            end
            if heal_Count > 0 then
              for i = 0, targetlist.Count - 1 do
                local _role = (targetlist[i]).targetRole
                if _role.intensity ~= 0 then
                  local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, _role)
                  LuaSkillCtrl:HealResult(skillResult, (self.config).HealConfig, {heal_Count})
                  skillResult:EndResult()
                end
              end
            end
          end
        end
      end
    end
  end
end

bs_101501.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_101501


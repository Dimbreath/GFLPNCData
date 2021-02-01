-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_101501 = class("bs_101501", LuaSkillBase)
local base = LuaSkillBase
bs_101501.config = {buffId = 216, 
HealConfig = {baseheal_formula = 501}
, effectId_heal = 10660}
bs_101501.ctor = function(self)
  -- function num : 0_0
end

bs_101501.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.caster).recordTable).rool_num = (self.arglist)[1]
  -- DECOMPILER ERROR at PC13: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.caster).recordTable).heal_num = (self.arglist)[2]
  -- DECOMPILER ERROR at PC18: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.caster).recordTable).skill = (self.arglist)[3]
  -- DECOMPILER ERROR at PC23: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.caster).recordTable).skill_rool = (self.arglist)[4]
  self:AddTrigger(eSkillTriggerType.AfterHurt, "bs_101501_12", 5, self.OnAfterHurt)
end

bs_101501.OnAfterHurt = function(self, sender, target, skill, hurt, isMiss, isCrit, isRealDmg, isTriggerSet)
  -- function num : 0_2 , upvalues : _ENV
  if target.hp <= 0 and (self.caster).belongNum ~= target.belongNum then
    local num_1 = target:GetBuffTier((self.config).buffId)
    if num_1 <= 0 then
      return 
    end
    local num = 1 - target.attackRange
    local targetlist = LuaSkillCtrl:CallTargetSelect(self, 9, num, target)
    local selectCount = targetlist.Count
    if selectCount > 0 then
      for i = 0, targetlist.Count - 1 do
        local target_num = (targetlist[i]).targetRole
        if target_num.intensity == 0 then
          selectCount = selectCount - 1
        end
      end
      local arg = ((self.caster).recordTable).heal_num
      if selectCount > 0 then
        local heal_num = (self.caster).skill_intensity * arg * num_1 // (selectCount) // 1000
        for i = 0, targetlist.Count - 1 do
          local target_heal = (targetlist[i]).targetRole
          if target_heal.intensity ~= 0 then
            local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, (targetlist[i]).targetRole)
            LuaSkillCtrl:HealResult(skillResult, (self.config).HealConfig, {heal_num})
            skillResult:EndResult()
          end
        end
        LuaSkillCtrl:DispelBuff(target, (self.config).buffId, 0, true)
        LuaSkillCtrl:CallEffect(target, (self.config).effectId_heal, self)
      end
    end
    do
      if selectCount <= 0 then
        LuaSkillCtrl:DispelBuff(target, (self.config).buffId, 0, true)
        LuaSkillCtrl:CallEffect(target, (self.config).effectId_heal, self)
      end
    end
  end
end

bs_101501.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_101501


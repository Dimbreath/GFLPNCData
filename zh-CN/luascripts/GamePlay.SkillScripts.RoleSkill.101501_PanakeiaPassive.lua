-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_101501 = class("bs_101501", LuaSkillBase)
local base = LuaSkillBase
bs_101501.config = {}
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
  self:AddTrigger(eSkillTriggerType.RoleDie, "bs_101501_10", 4, self.OnRoleDie)
end

bs_101501.OnRoleDie = function(self, killer, role)
  -- function num : 0_2 , upvalues : _ENV
  if role:GetBuffTier((self.config).buffId) > 0 then
    local num = 1 - role.attackRange
    local targetlist = LuaSkillCtrl:CallTargetSelect(self, 9, num, role)
    if targetlist.Count > 0 then
      local num_1 = role:GetBuffTier((self.config).buffId)
      local num_2 = targetlist.Count
      local arg = ((self.caster).recordTable).heal_num
      local heal_num = (self.caster).skill_intensity * arg * num_1 // num_2 // 1000
      for i = 0, targetlist.Count - 1 do
        local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, (targetlist[i]).targetRole)
        LuaSkillCtrl:HealResult(skillResult, (self.config).HealConfig, {heal_num})
        skillResult:EndResult()
      end
      LuaSkillCtrl:DispelBuff(role, (self.config).buffId, 0, true)
      LuaSkillCtrl:CallEffect(role, (self.config).effectId_heal, self)
    else
      do
        if targetlist.Count == 0 then
          LuaSkillCtrl:DispelBuff(role, (self.config).buffId, 0, true)
          LuaSkillCtrl:CallEffect(role, (self.config).effectId_heal, self)
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


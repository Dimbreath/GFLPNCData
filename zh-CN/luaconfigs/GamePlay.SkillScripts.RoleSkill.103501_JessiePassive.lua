-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_103501 = class("bs_103501", LuaSkillBase)
local base = LuaSkillBase
bs_103501.config = {restBuffId = 147, effectId_passive = 10195}
bs_103501.ctor = function(self)
  -- function num : 0_0
end

bs_103501.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddSelfTrigger(eSkillTriggerType.AfterPlaySkill, "bs_103501_atk", 1, self.OnAfterPlaySkill)
  -- DECOMPILER ERROR at PC13: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.caster).recordTable).Time = 0
end

bs_103501.OnAfterPlaySkill = function(self, skill, role)
  -- function num : 0_2 , upvalues : _ENV
  -- DECOMPILER ERROR at PC12: Confused about usage of register: R3 in 'UnsetPending'

  if skill.isCommonAttack and role == self.caster then
    ((self.caster).recordTable).Time = ((self.caster).recordTable).Time + 1
    -- DECOMPILER ERROR at PC22: Confused about usage of register: R3 in 'UnsetPending'

    if ((self.caster).recordTable).Time == (self.arglist)[1] then
      ((self.caster).recordTable).Time = 0
      LuaSkillCtrl:CallEffect(role, (self.config).effectId_passive, self)
      local duration = (self.arglist)[6]
      LuaSkillCtrl:CallBuff(self, role, (self.config).restBuffId, 1, duration, true)
      local roleEntityList = LuaSkillCtrl:FindRolesAroundRole(role)
      if roleEntityList ~= nil and roleEntityList.Count > 0 then
        for i = 0, roleEntityList.Count - 1 do
          if (roleEntityList[i]).belongNum == role.belongNum then
            LuaSkillCtrl:CallEffect(roleEntityList[i], (self.config).effectId_passive, self)
            LuaSkillCtrl:CallBuff(self, roleEntityList[i], (self.config).restBuffId, 1, duration, true)
          end
        end
      end
    end
  end
end

bs_103501.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_103501


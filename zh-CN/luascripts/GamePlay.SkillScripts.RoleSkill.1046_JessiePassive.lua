-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_1046 = class("bs_1046", LuaSkillBase)
local base = LuaSkillBase
bs_1046.config = {restBuffId = 147, effectId = 10195}
bs_1046.ctor = function(self)
  -- function num : 0_0
end

bs_1046.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterPlaySkill, "bs_1046_atk", 1, self.OnAfterPlaySkill)
end

bs_1046.OnAfterPlaySkill = function(self, skill, role)
  -- function num : 0_2 , upvalues : _ENV
  if skill.isCommonAttack and role == self.caster then
    LuaSkillCtrl:CallEffect(role, (self.config).effectId, self)
    local duration = (self.arglist)[6]
    LuaSkillCtrl:CallBuff(self, role, (self.config).restBuffId, 1, duration)
    local roleEntityList = LuaSkillCtrl:FindRolesAroundRole(role)
    if roleEntityList ~= nil and roleEntityList.Count > 0 then
      for i = 0, roleEntityList.Count - 1 do
        if (roleEntityList[i]).belongNum == role.belongNum then
          LuaSkillCtrl:CallBuff(self, roleEntityList[i], (self.config).restBuffId, 1, duration)
        end
      end
    end
  end
end

bs_1046.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_1046


-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_5013 = class("bs_5013", LuaSkillBase)
local base = LuaSkillBase
bs_5013.config = {buffId = 153}
bs_5013.ctor = function(self)
  -- function num : 0_0
end

bs_5013.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.RoleDie, "5013_1", 1, self.OnRoleDie)
end

bs_5013.OnRoleDie = function(self, role)
  -- function num : 0_2 , upvalues : _ENV
  if (self.caster).belongNum ~= role.belongNum then
    local targetList = LuaSkillCtrl:CallTargetSelect(self, 6, 20)
    if targetList.Count >= 1 then
      for i = 0, targetList.Count - 1 do
        local targetRole = (targetList[i]).targetRole
        LuaSkillCtrl:CallBuff(self, targetRole, (self.config).buffId, 1, (self.arglist)[2])
      end
    end
  end
end

bs_5013.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_5013


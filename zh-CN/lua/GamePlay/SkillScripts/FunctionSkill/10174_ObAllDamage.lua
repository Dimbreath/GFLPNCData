local bs_10174 = class("bs_10174", LuaSkillBase)
local base = LuaSkillBase
bs_10174.config = {}
bs_10174.ctor = function(self)
  -- function num : 0_0
end

bs_10174.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
  self:AddSetHurtTrigger("bs_10174_2", 1, self.OnSetHurt, self.caster)
end

bs_10174.OnSetHurt = function(self, context)
  -- function num : 0_2 , upvalues : _ENV
  if not context.isMiss and (context.target).intensity == 0 and not context.isTriggerSet and (context.sender).roleType ~= eBattleRoleType.skillCaster and context.sender == self.caster then
    local targetlist = LuaSkillCtrl:CallTargetSelect(self, 9, 10)
    if targetlist.Count <= 0 then
      return 
    end
    for i = 0, targetlist.Count - 1 do
      local targetRole = (targetlist[i]).targetRole
      if targetRole ~= context.target and targetRole.intensity == 0 then
        local damage = context.hurt * (self.arglist)[1] // 1000
        LuaSkillCtrl:RemoveLife(damage, self, targetRole, true)
      end
    end
  end
end

bs_10174.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10174


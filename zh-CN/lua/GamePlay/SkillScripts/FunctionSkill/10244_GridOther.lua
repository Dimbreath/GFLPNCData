local bs_10244 = class("bs_10244", LuaSkillBase)
local base = LuaSkillBase
bs_10244.config = {effectId = 10636}
bs_10244.ctor = function(self)
  -- function num : 0_0
end

bs_10244.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
  self:AddSetHurtTrigger("bs_10244_2", 1, self.OnSetHurt, self.caster)
end

bs_10244.OnSetHurt = function(self, context)
  -- function num : 0_2 , upvalues : _ENV
  if context.sender == self.caster and LuaSkillCtrl:GetRoleEfcGrid(context.target) ~= 0 and not context.isTriggerSet then
    local targetlist = LuaSkillCtrl:CallTargetSelect(self, 9, 10)
    if targetlist.Count < 1 then
      return 
    end
    for i = 0, targetlist.Count - 1 do
      local targetRole = (targetlist[i]).targetRole
      if targetRole ~= context.target and LuaSkillCtrl:GetRoleEfcGrid(targetRole) ~= 0 then
        local damageNum = (math.max)(1, context.hurt * (self.arglist)[1] // 1000)
        LuaSkillCtrl:RemoveLife(damageNum, self, targetRole, true)
        LuaSkillCtrl:CallEffect(targetRole, (self.config).effectId, self, nil, context.target)
      end
    end
  end
end

bs_10244.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10244


-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_6005 = class("bs_6005", LuaSkillBase)
local base = LuaSkillBase
bs_6005.config = {}
bs_6005.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_0 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.SetHurt, "10136_ShareDamage_14", 99, self.OnSetHurt)
end

bs_6005.OnSetHurt = function(self, context)
  -- function num : 0_1 , upvalues : _ENV
  if context.isTriggerSet then
    return 
  end
  local shieldKey = ((self.caster).recordTable).shieldKey
  if shieldKey ~= nil and (((self.caster).recordTable)[shieldKey] ~= nil or ((self.caster).recordTable)[shieldKey] > 0) then
    return 
  end
  local targetRole = context.target
  if targetRole ~= nil and targetRole ~= self.caster and targetRole.belongNum == (self.caster).belongNum and LuaSkillCtrl:IsRoleAdjacent(self.caster, targetRole) then
    local selfHurt = (self.arglist)[1] * context.hurt // 100
    if context.isShared == nil then
      context.isShared = true
    end
    context.hurtAfterShare = (math.max)(0, context.hurt - selfHurt)
    LuaSkillCtrl:RemoveLife(selfHurt, self, self.caster, false, true)
  end
end

bs_6005.OnCasterDie = function(self)
  -- function num : 0_2 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_6005


-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_6005 = class("bs_6005", LuaSkillBase)
local base = LuaSkillBase
bs_6005.config = {}
bs_6005.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_0 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
  self:AddSetHurtTrigger("10136_ShareDamage_14", 80, self.OnSetHurt, nil, nil, nil, (self.caster).belongNum)
end

bs_6005.OnSetHurt = function(self, context)
  -- function num : 0_1 , upvalues : _ENV
  if context.isTriggerSet then
    return 
  end
  local shieldKey = ((self.caster).recordTable).shieldKey
  if shieldKey ~= nil and (((self.caster).recordTable)[shieldKey] ~= nil or ((self.caster).recordTable)[shieldKey] > 0) and (((self.caster).recordTable)[shieldKey] ~= nil or ((self.caster).recordTable)[shieldKey] > 0) then
    return 
  end
  local check_target = LuaSkillCtrl:CallTargetSelect(self, 3, 10)
  if check_target.Count == 0 then
    return 
  end
  local res_target = (check_target[0]).targetRole
  local targetRole = context.target
  -- DECOMPILER ERROR at PC56: Confused about usage of register: R6 in 'UnsetPending'

  if targetRole ~= nil and targetRole ~= self.caster and targetRole.belongNum == (self.caster).belongNum and targetRole == res_target then
    (targetRole.recordTable).isShare = true
    local selfHurt = (self.arglist)[1] * context.hurt // 100
    if context.isShared == nil then
      context.isShared = true
      context.hurtAfterShare = (math.max)(1, context.hurt - selfHurt)
    else
      context.hurtAfterShare = (math.max)(1, context.hurtAfterShare - selfHurt)
    end
    LuaSkillCtrl:RemoveLife(selfHurt, self, self.caster, false, true, nil, true, true)
  end
end

bs_6005.OnCasterDie = function(self)
  -- function num : 0_2 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_6005


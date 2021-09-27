local bs_10283 = class("bs_10283", LuaSkillBase)
local base = LuaSkillBase
bs_10283.config = {effectId = 10906, effectId2 = 10908}
bs_10283.ctor = function(self)
  -- function num : 0_0
end

bs_10283.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddSetHurtTrigger("bs_10283_2", 99, self.OnSetHurt, nil, nil, nil, (self.caster).belongNum)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_10283_1", 1, self.OnAfterBattleStart)
end

bs_10283.OnAfterBattleStart = function(self)
  -- function num : 0_2 , upvalues : _ENV
  if ((self.caster).recordTable)["30021_Flag"] then
    self.effect = LuaSkillCtrl:CallEffect(self.caster, (self.config).effectId2, self)
  else
    self.effect = LuaSkillCtrl:CallEffect(self.caster, (self.config).effectId, self)
  end
end

bs_10283.OnSetHurt = function(self, context)
  -- function num : 0_3 , upvalues : _ENV
  if context.target ~= self.caster and not context.isTriggerSet and (context.target).roleType == 1 then
    local dis = 1
    if ((self.caster).recordTable)["30021_Flag"] then
      dis = 100
    end
    if LuaSkillCtrl:GetRoleGridsDistance(context.target, self.caster) <= dis then
      local tanHurt = context.hurt * (self.arglist)[1] // 1000
      context.hurt = context.hurt - tanHurt
      LuaSkillCtrl:RemoveLife(tanHurt, self, self.caster, true, nil, true)
    end
  end
end

bs_10283.OnCasterDie = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnCasterDie)(self)
  if self.effect ~= nil then
    (self.effect):Die()
    self.effect = nil
  end
end

return bs_10283


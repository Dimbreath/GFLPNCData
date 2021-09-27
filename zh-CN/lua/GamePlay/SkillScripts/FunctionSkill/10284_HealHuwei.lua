local bs_10284 = class("bs_10284", LuaSkillBase)
local base = LuaSkillBase
bs_10284.config = {effectId = 10907}
bs_10284.ctor = function(self)
  -- function num : 0_0
end

bs_10284.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddSetHealTrigger("bs_10284_4", 1, self.OnSetHeal, nil, nil, nil, (self.caster).belongNum)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_10284_2", 2, self.OnAfterBattleStart)
end

bs_10284.OnAfterBattleStart = function(self)
  -- function num : 0_2 , upvalues : _ENV
  self.effect = LuaSkillCtrl:CallEffect(self.caster, (self.config).effectId, self)
end

bs_10284.OnSetHeal = function(self, context)
  -- function num : 0_3 , upvalues : _ENV
  if context.target ~= self.caster and not context.isTriggerSet and (context.target).roleType == 1 then
    local dis = 1
    if LuaSkillCtrl:GetRoleGridsDistance(context.target, self.caster) <= dis then
      local healNum = context.heal * (self.arglist)[1] // 1000
      LuaSkillCtrl:CallHeal(healNum, self, self.caster, true)
    end
  end
end

bs_10284.OnCasterDie = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnCasterDie)(self)
  if self.effect ~= nil then
    (self.effect):Die()
    self.effect = nil
  end
end

return bs_10284


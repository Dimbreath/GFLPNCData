-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_10213 = class("bs_10213", LuaSkillBase)
local base = LuaSkillBase
bs_10213.config = {checkBuffId = 26, buffId = 1063}
bs_10213.ctor = function(self)
  -- function num : 0_0
end

bs_10213.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.SetHurt, "bs_10213_2", 1, self.OnSetHurt)
end

bs_10213.OnSetHurt = function(self, context)
  -- function num : 0_2 , upvalues : _ENV
  if context.sender == self.caster and not context.isMiss and LuaSkillCtrl:RoleContainsCtrlBuff(context.target) then
    self:PlayChipEffect()
    local targetList = LuaSkillCtrl:CallTargetSelect(self, 6, 10)
    if targetList.Count > 0 then
      for i = 0, targetList.Count - 1 do
        local target = (targetList[i]).targetRole
        local preTier = target:GetBuffTier((self.config).buffId)
        local tier = 1
        if (self.arglist)[3] <= preTier then
          LuaSkillCtrl:DispelBuff(target, (self.config).buffId, tier)
        end
        LuaSkillCtrl:CallBuff(self, target, (self.config).buffId, tier, (self.arglist)[2])
      end
    end
  end
end

bs_10213.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10213


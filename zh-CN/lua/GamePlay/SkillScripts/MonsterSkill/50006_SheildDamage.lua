local bs_50006 = class("bs_50006", LuaSkillBase)
local base = LuaSkillBase
bs_50006.config = {sheildBuffId = 174, shieldKeyYuan = "50002_HuDun", shieldKeyJin = "50003_HuDun", buffIdYuan = 1047, effectIdYuan = 10371, buffIdJin = 1048, effectIdJin = 10373, fakeYuanId = 1055, fakeJinId = 1056}
bs_50006.ctor = function(self)
  -- function num : 0_0
end

bs_50006.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.OnAfterShieldHurt, "bs_50006_1", 1, self.OnAfterShieldHurt)
end

bs_50006.OnAfterShieldHurt = function(self, context)
  -- function num : 0_2 , upvalues : _ENV
  if context.shield_cost_hurt > 0 and context.target ~= self.caster and context.sender == self.caster and (context.target).belongNum ~= (self.caster).belongNum and (context.shield_type == 1 or context.shield_type == 2) then
    LuaSkillCtrl:RemoveLife(context.shield_cost_hurt, self, context.target, true, nil, true, false, ((context.skill).skillCfg).HurtType, true)
  end
end

bs_50006.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_50006


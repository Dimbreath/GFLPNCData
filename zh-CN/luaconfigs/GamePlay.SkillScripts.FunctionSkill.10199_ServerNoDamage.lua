-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_10199 = class("bs_10199", LuaSkillBase)
local base = LuaSkillBase
bs_10199.config = {effectId = 10634}
bs_10199.ctor = function(self)
  -- function num : 0_0
end

bs_10199.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddSetHurtTrigger("bs_10199_2", 1, self.OnSetHurt, nil, nil, eBattleRoleBelong.neutral, eBattleRoleBelong.player)
end

bs_10199.OnSetHurt = function(self, context)
  -- function num : 0_2 , upvalues : _ENV
  if context.sender ~= nil and (context.sender).belongNum == eBattleRoleBelong.neutral and (context.target).belongNum == eBattleRoleBelong.player then
    local heal = context.hurt * (self.arglist)[1] // 1000
    if heal > 0 then
      LuaSkillCtrl:CallEffect(context.target, (self.config).effectId, self)
      LuaSkillCtrl:CallHeal(heal, self, context.target, true)
    end
    context.hurt = 0
    self:PlayChipEffect()
  end
end

bs_10199.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10199


-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_10199 = class("bs_10199", LuaSkillBase)
local base = LuaSkillBase
bs_10199.config = {}
bs_10199.ctor = function(self)
  -- function num : 0_0
end

bs_10199.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.SetHurt, "bs_10199_2", 1, self.OnSetHurt)
end

bs_10199.OnSetHurt = function(self, context)
  -- function num : 0_2 , upvalues : _ENV
  if context.sender ~= nil and (context.sender).belongNum == 0 and (context.target).belongNum == eBattleRoleBelong.enemy then
    context.hurt = (math.max)(1, context.hurt + context.hurt * (self.arglist)[2] // 1000)
  else
    if context.sender ~= nil and (context.sender).belongNum == 0 and (context.target).belongNum == eBattleRoleBelong.player then
      context.hurt = (math.max)(1, context.hurt - context.hurt * (self.arglist)[1] // 1000)
    end
  end
end

bs_10199.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10199


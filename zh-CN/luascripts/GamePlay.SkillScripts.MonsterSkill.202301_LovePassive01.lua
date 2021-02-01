-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_202301 = class("bs_202301", LuaSkillBase)
local base = LuaSkillBase
bs_202301.config = {buffId = 190}
bs_202301.ctor = function(self)
  -- function num : 0_0
end

bs_202301.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.SetHurt, "bs_202301_3", 1, self.OnSetHurt)
  self.time = 1
end

bs_202301.OnSetHurt = function(self, context)
  -- function num : 0_2 , upvalues : _ENV
  if (context.target).belongNum == (self.caster).belongNum and (context.target).hp < context.hurt and self.time > 0 and context.target ~= self.caster then
    context.hurt = (context.target).hp
    local number = (self.caster).maxHp * (self.arglist)[1] // 1000
    LuaSkillCtrl:RemoveLife(number, self, self.caster, true)
    LuaSkillCtrl:CallHeal(number, self, context.target, true)
    self.time = 0
  end
end

bs_202301.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_202301


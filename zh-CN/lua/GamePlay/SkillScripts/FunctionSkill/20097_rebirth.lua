local bs_20097 = class("bs_20097", LuaSkillBase)
local base = LuaSkillBase
bs_20097.config = {}
bs_20097.ctor = function(self)
  -- function num : 0_0
end

bs_20097.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.SetHurt, "bs_20097_2", 1, self.OnSetHurt)
end

bs_20097.OnSetHurt = function(self, context)
  -- function num : 0_2
  if context.target == self.caster then
    local Hp = (self.caster).hp
    local maxHp = (self.caster).maxHp
    local resist = 700 * (maxHp - Hp) // maxHp
    context.hurt = context.hurt * (1000 - resist) // 1000
    if (self.caster).hp <= context.hurt then
      context.hurt = (self.caster).hp - 1
    end
  end
end

bs_20097.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_20097


-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_40007 = class("bs_40007", LuaSkillBase)
local base = LuaSkillBase
bs_40007.config = {hurtformula = 10093}
bs_40007.ctor = function(self)
  -- function num : 0_0
end

bs_40007.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : _ENV
  self:AddSelfTrigger(eSkillTriggerType.SetHurt, "bs_40007_2", 2, self.OnSetHurt)
end

bs_40007.OnSetHurt = function(self, context)
  -- function num : 0_2 , upvalues : _ENV
  if context.sender == self.caster and not context.isCrit then
    local num = ((context.target).maxHp - (context.target).hp) * 1000 // (context.target).maxHp
    local crit_num = num // (self.arglist)[1] * (self.arglist)[2]
    local crit_real = crit_num * 1000 // (1000 - (self.caster).crit)
    local crit_hurt_num = 0
    if LuaSkillCtrl:CallRange(1, 1000) <= crit_real then
      context.isCrit = true
      context.hurt = context.hurt * (1000 + (self.caster).critDamage + crit_hurt_num) // 1000
      return 
    end
  end
  do
    if context.sender == self.caster and context.Crit then
      local num = (context.target).maxHp - (context.target).hp * 1000 // (context.target).maxHp
      local crit_hurt_num = 0
      local hurt = context.hurt * 1000 // (1000 + (self.caster).critDamage)
      context.hurt = hurt * (1000 + (self.caster).critDamage + crit_hurt_num) // 1000
    end
  end
end

bs_40007.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_40007


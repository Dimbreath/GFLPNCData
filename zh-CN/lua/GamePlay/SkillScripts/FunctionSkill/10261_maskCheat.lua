local bs_10261 = class("bs_10261", LuaSkillBase)
local base = LuaSkillBase
bs_10261.config = {damageIncreaseFmId = 10161}
bs_10261.ctor = function(self)
  -- function num : 0_0
end

bs_10261.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
  self:AddSetHurtTrigger("bs_1026_ob_damage", 99, self.OnSetHurt, self.caster)
end

bs_10261.OnSetHurt = function(self, context)
  -- function num : 0_2 , upvalues : _ENV
  if (context.target).hp <= 0 then
    return 
  end
  if (context.target).hp < (context.target).maxHp then
    local fHurt = LuaSkillCtrl:CallFormulaNumberWithSkill((self.config).damageIncreaseFmId, self.caster, context.target, self, context.hurt)
    context.hurt = fHurt
  end
end

bs_10261.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10261


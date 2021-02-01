-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_20016 = class("bs_20016", LuaSkillBase)
local base = LuaSkillBase
bs_20016.config = {formula = 10106}
bs_20016.ctor = function(self)
  -- function num : 0_0
end

bs_20016.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.SetHurt, "bs_20016_2", 1, self.OnSetHurt)
  -- DECOMPILER ERROR at PC13: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.caster).recordTable).time_limit_20016 = 1
end

bs_20016.OnSetHurt = function(self, context)
  -- function num : 0_2 , upvalues : _ENV
  -- DECOMPILER ERROR at PC16: Confused about usage of register: R2 in 'UnsetPending'

  if (context.target).belongNum == 2 and (context.target).hp <= context.hurt and ((self.caster).recordTable).time_limit_20016 > 0 then
    ((self.caster).recordTable).time_limit_20016 = 0
    local healNum = LuaSkillCtrl:CallFormulaNumberWithSkill((self.config).formula, nil, context.target, self)
    LuaSkillCtrl:CallHeal(healNum, self, context.target, true)
  end
end

bs_20016.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_20016


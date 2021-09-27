local bs_20016 = class("bs_20016", LuaSkillBase)
local base = LuaSkillBase
bs_20016.config = {formula = 10106, effectId = 10865}
bs_20016.ctor = function(self)
  -- function num : 0_0
end

bs_20016.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddSetDeadHurtTrigger("bs_20016_2", 1, self.OnSetDeadHurt, nil, nil, nil, eBattleRoleBelong.enemy)
  -- DECOMPILER ERROR at PC14: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.caster).recordTable).time_limit_20016 = 1
end

bs_20016.OnSetDeadHurt = function(self, context)
  -- function num : 0_2 , upvalues : _ENV
  if (context.target).belongNum == 2 and (context.target).hp <= context.hurt and ((self.caster).recordTable).time_limit_20016 > 0 then
    context.hurt = (context.target).maxHp * (self.arglist)[1] // 1000
    -- DECOMPILER ERROR at PC23: Confused about usage of register: R2 in 'UnsetPending'

    ;
    ((self.caster).recordTable).time_limit_20016 = 0
    local healNum = (context.target).maxHp
    LuaSkillCtrl:CallHeal(healNum, self, context.target, true)
    LuaSkillCtrl:CallEffect(context.target, (self.config).effectId, self)
  end
end

bs_20016.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_20016


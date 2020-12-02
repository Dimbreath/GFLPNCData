-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_307 = class("bs_307", LuaSkillBase)
local base = LuaSkillBase
bs_307.config = {buffId1 = 138, effectId1 = 10150, effectId2 = 10151, effectId3 = 10152, effectId4 = 10153, effectId5 = 10154, effectId6 = 10155, effectId7 = 10156}
bs_307.ctor = function(self)
  -- function num : 0_0
end

bs_307.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.SetHurt, "bs_307_1", 1, self.OnSetHurt)
end

bs_307.PlaySkill = function(self, data)
  -- function num : 0_2 , upvalues : _ENV
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R2 in 'UnsetPending'

  ((self.caster).recordTable)["307_hurt"] = 0
  LuaSkillCtrl:CallBreakAllSkill(self.caster)
  self:CallCasterWait(30)
  local attackTrigger = BindCallback(self, self.OnAttackTrigger, data)
  LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, 1002, 1, 20, attackTrigger)
end

bs_307.OnAttackTrigger = function(self, data)
  -- function num : 0_3 , upvalues : _ENV
  LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId1, 1)
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.caster).recordTable)["307_hurt"] = 3
  local effectconfig = (self.config)["effectId" .. tostring(((self.caster).recordTable)["307_hurt"])]
  self.effectBJ = LuaSkillCtrl:CallEffect(self.caster, effectconfig, self)
end

bs_307.OnSetHurt = function(self, context)
  -- function num : 0_4 , upvalues : _ENV
  if (self.caster):GetBuffTier((self.config).buffId1) ~= 0 and context.sender == self.caster and ((self.caster).recordTable)["307_hurt"] > 0 then
    context.hurt = context.hurt * (self.arglist)[1] * 10 // 1000
    if self.effectBJ ~= nil then
      (self.effectBJ):Die()
      self.effectBJ = nil
    end
    -- DECOMPILER ERROR at PC36: Confused about usage of register: R2 in 'UnsetPending'

    ;
    ((self.caster).recordTable)["307_hurt"] = ((self.caster).recordTable)["307_hurt"] - 1
    -- DECOMPILER ERROR at PC59: Confused about usage of register: R2 in 'UnsetPending'

    if (context.target).hp <= context.hurt and (self.caster):GetBuffTier((self.config).buffId1) > 0 and context.sender == self.caster then
      ((self.caster).recordTable)["307_hurt"] = ((self.caster).recordTable)["307_hurt"] + 2
      if (self.arglist)[2] >= 0 then
        LuaSkillCtrl:CallHeal(context.hurt * 500 // 1000, self, self.caster)
      end
    end
    print(((self.caster).recordTable)["307_hurt"])
    if ((self.caster).recordTable)["307_hurt"] > 0 then
      print("biubiu")
      local effectconfig = (self.config)["effectId" .. tostring(((self.caster).recordTable)["307_hurt"])]
      self.effectBJ = LuaSkillCtrl:CallEffect(self.caster, effectconfig, self)
    end
    do
      if ((self.caster).recordTable)["307_hurt"] == 0 then
        print("end")
        LuaSkillCtrl:DispelBuff(self.caster, (self.config).buffId1, 1)
      end
    end
  end
end

bs_307.OnCasterDie = function(self)
  -- function num : 0_5 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_307


-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_10177 = class("bs_10177", LuaSkillBase)
local base = LuaSkillBase
local ShieldSkillBase = require("GamePlay.SkillScripts.BaseSkill.ShieldSkillBase")
bs_10177.config = {sheildBuffId = 174, buffIdYuan = 1047, shieldKey = "50002_HuDun", effectIdYuan = 10371}
bs_10177.ctor = function(self)
  -- function num : 0_0
end

bs_10177.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.SetHurt, "bs_10177_1", 100, self.OnSetHurt)
end

bs_10177.OnSetHurt = function(self, context)
  -- function num : 0_2 , upvalues : _ENV, ShieldSkillBase
  if context.sender == self.caster and (self.caster).attackRange == 1 then
    local restTier = (context.target):GetBuffTier((self.config).buffIdYuan)
    if restTier > 0 and ((context.target).recordTable).sheildValue_50002 ~= nil then
      local sheildHurt = context.hurt * (self.arglist)[1] // 1000
      -- DECOMPILER ERROR at PC36: Confused about usage of register: R4 in 'UnsetPending'

      ;
      ((context.target).recordTable).sheildValue_50002 = (math.max)(0, ((context.target).recordTable).sheildValue_50002 - sheildHurt // 1000)
      ;
      (ShieldSkillBase.ShieldBaseFunc)(sheildHurt, context.target, (self.config).shieldKey)
      if ((context.target).recordTable).sheildValue_50002 == 0 and (context.target):GetBuffTier((self.config).sheildBuffId) > 0 then
        LuaSkillCtrl:DispelBuff(context.target, (self.config).buffIdYuan)
        LuaSkillCtrl:DispelBuff(context.target, (self.config).sheildBuffId)
        LuaSkillCtrl:CallSheldBroken(context.sender, context.target)
        LuaSkillCtrl:CallEffect(context.target, (self.config).effectIdYuan, self)
      end
    end
  end
end

bs_10177.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10177

-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_10177 = class("bs_10177", LuaSkillBase)
local base = LuaSkillBase
local ShieldSkillBase = require(
                            "GamePlay.SkillScripts.BaseSkill.ShieldSkillBase")
bs_10177.config = {
    sheildBuffId = 174,
    buffIdYuan = 1047,
    shieldKey = "50002_HuDun",
    effectIdYuan = 10371
}
bs_10177.ctor = function(self)
    -- function num : 0_0
end

bs_10177.InitSkill = function(self, isMidwaySkill)
    -- function num : 0_1 , upvalues : base, _ENV
    (base.InitSkill)(self, isMidwaySkill)
    self:AddTrigger(eSkillTriggerType.SetHurt, "bs_10177_1", 100, self.OnSetHurt)
end

bs_10177.OnSetHurt = function(self, context)
    -- function num : 0_2 , upvalues : _ENV, ShieldSkillBase
    if context.sender == self.caster and (self.caster).attackRange == 1 then
        local restTier = (context.target):GetBuffTier((self.config).buffIdYuan)
        if restTier > 0 and ((context.target).recordTable).sheildValue_50002 ~=
            nil then
            local sheildHurt = context.hurt * (self.arglist)[1] // 1000 -- DECOMPILER ERROR at PC36: Confused about usage of register: R4 in 'UnsetPending'
            ;
            ((context.target).recordTable).sheildValue_50002 =
                (math.max)(0, ((context.target).recordTable).sheildValue_50002 -
                               sheildHurt // 1000);
            (ShieldSkillBase.ShieldBaseFunc)(sheildHurt, context.target,
                                             (self.config).shieldKey)
            if ((context.target).recordTable).sheildValue_50002 == 0 and
                (context.target):GetBuffTier((self.config).sheildBuffId) > 0 then
                LuaSkillCtrl:DispelBuff(context.target, (self.config).buffIdYuan)
                LuaSkillCtrl:DispelBuff(context.target,
                                        (self.config).sheildBuffId)
                LuaSkillCtrl:CallSheldBroken(context.sender, context.target)
                LuaSkillCtrl:CallEffect(context.target,
                                        (self.config).effectIdYuan, self)
            end
        end
    end
end

bs_10177.OnCasterDie = function(self)
    -- function num : 0_3 , upvalues : base
    (base.OnCasterDie)(self)
end

return bs_10177


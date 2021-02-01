-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_50003 = class("bs_50003", LuaSkillBase)
local base = LuaSkillBase
local ShieldSkillBase = require("GamePlay.SkillScripts.BaseSkill.ShieldSkillBase")
bs_50003.config = {buffId = 1048, reBuffId = 1049, sheildBuffId = 174, effectId = 10373, shieldKey = "50003_HuDun"}
bs_50003.ctor = function(self)
  -- function num : 0_0
end

bs_50003.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV, ShieldSkillBase
  (base.InitSkill)(self, isMidwaySkill)
  self:AddSelfTrigger(eSkillTriggerType.SetHurt, "bs_50003_1", 1, self.OnSetHurt)
  -- DECOMPILER ERROR at PC17: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.caster).recordTable).sheildValue_50003 = (self.caster).hp * 500 // 1000
  ;
  (ShieldSkillBase.UpdateShieldView)(self.caster, (self.config).shieldKey, ((self.caster).recordTable).sheildValue_50003)
end

bs_50003.OnSetHurt = function(self, context)
  -- function num : 0_2 , upvalues : _ENV, ShieldSkillBase
  -- DECOMPILER ERROR at PC29: Confused about usage of register: R2 in 'UnsetPending'

  if context.sender ~= self.caster and (context.sender).roleType ~= eBattleRoleType.skillCaster and context.target == self.caster and (context.sender).attackRange == 1 and not context.isMiss and ((self.caster).recordTable).sheildValue_50003 then
    ((self.caster).recordTable).sheildValue_50003hurt = context.hurt
    local realHurt = context.hurt - ((self.caster).recordTable).sheildValue_50003
    if realHurt >= 0 then
      (ShieldSkillBase.ClearShieldType)(self.caster, (self.config).shieldKey)
      context.hurt = realHurt
      -- DECOMPILER ERROR at PC45: Confused about usage of register: R3 in 'UnsetPending'

      ;
      ((self.caster).recordTable).sheildValue_50003 = 0
    else
      ;
      (ShieldSkillBase.ShieldBaseFunc)(context.hurt, self.caster, (self.config).shieldKey)
      context.hurt = 0
      -- DECOMPILER ERROR at PC57: Confused about usage of register: R3 in 'UnsetPending'

      ;
      ((self.caster).recordTable).sheildValue_50003 = 0 - realHurt
    end
    if ((self.caster).recordTable).sheildValue_50003 == 0 and (self.caster):GetBuffTier((self.config).buffId) > 0 then
      LuaSkillCtrl:DispelBuff(self.caster, (self.config).buffId)
      LuaSkillCtrl:DispelBuff(self.caster, (self.config).sheildBuffId)
      LuaSkillCtrl:CallSheldBroken(context.sender, context.target)
      LuaSkillCtrl:CallEffect(self.caster, (self.config).effectId, self)
    end
  end
end

bs_50003.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base, ShieldSkillBase
  (base.OnCasterDie)(self)
  ;
  (ShieldSkillBase.ClearShieldType)(self.caster, (self.config).shieldKey)
end

return bs_50003


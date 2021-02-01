-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_50009 = class("bs_50009", LuaSkillBase)
local base = LuaSkillBase
local ShieldSkillBase = require("GamePlay.SkillScripts.BaseSkill.ShieldSkillBase")
bs_50009.config = {buffId = 1076, reBuffId = 1049, sheildBuffId = 174, effectId = 10371, shieldKey = "50009_HuDun"}
bs_50009.ctor = function(self)
  -- function num : 0_0
end

bs_50009.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV, ShieldSkillBase
  (base.InitSkill)(self, isMidwaySkill)
  self:AddSelfTrigger(eSkillTriggerType.SetHurt, "bs_50009_1", 1, self.OnSetHurt)
  -- DECOMPILER ERROR at PC21: Confused about usage of register: R2 in 'UnsetPending'

  if ((self.caster).recordTable).sheildValue_50009 == nil then
    ((self.caster).recordTable).sheildValue_50009 = ((self.caster).recordTable)["10136_arg"]
  end
  -- DECOMPILER ERROR at PC35: Confused about usage of register: R2 in 'UnsetPending'

  if ((self.caster).recordTable).sheildValue_50009 < ((self.caster).recordTable)["10136_arg"] then
    ((self.caster).recordTable).sheildValue_50009 = ((self.caster).recordTable)["10136_arg"]
  end
  ;
  (ShieldSkillBase.UpdateShieldView)(self.caster, (self.config).shieldKey, ((self.caster).recordTable).sheildValue_50009)
end

bs_50009.OnSetHurt = function(self, context)
  -- function num : 0_2 , upvalues : _ENV, ShieldSkillBase
  -- DECOMPILER ERROR at PC25: Confused about usage of register: R2 in 'UnsetPending'

  if context.sender ~= self.caster and (context.sender).roleType ~= eBattleRoleType.skillCaster and context.target == self.caster and not context.isMiss and ((self.caster).recordTable).sheildValue_50009 ~= 0 then
    ((self.caster).recordTable).sheildValue_50009hurt = context.hurt
    local realHurt = context.hurt - ((self.caster).recordTable).sheildValue_50009
    if realHurt >= 0 then
      (ShieldSkillBase.ClearShieldType)(self.caster, (self.config).shieldKey)
      context.hurt = realHurt
      -- DECOMPILER ERROR at PC41: Confused about usage of register: R3 in 'UnsetPending'

      ;
      ((self.caster).recordTable).sheildValue_50009 = 0
    else
      ;
      (ShieldSkillBase.ShieldBaseFunc)(context.hurt, self.caster, (self.config).shieldKey)
      context.hurt = 0
      -- DECOMPILER ERROR at PC53: Confused about usage of register: R3 in 'UnsetPending'

      ;
      ((self.caster).recordTable).sheildValue_50009 = 0 - realHurt
    end
    if ((self.caster).recordTable).sheildValue_50009 == 0 and (self.caster):GetBuffTier((self.config).buffId) > 0 then
      LuaSkillCtrl:DispelBuff(self.caster, (self.config).buffId)
      LuaSkillCtrl:DispelBuff(self.caster, (self.config).sheildBuffId)
      LuaSkillCtrl:CallSheldBroken(context.sender, context.target)
      LuaSkillCtrl:CallEffect(self.caster, (self.config).effectId, self)
    end
  end
end

bs_50009.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_50009


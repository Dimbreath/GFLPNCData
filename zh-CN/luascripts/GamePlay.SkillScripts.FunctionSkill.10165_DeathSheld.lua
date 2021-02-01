-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_10065 = class("bs_10065", LuaSkillBase)
local base = LuaSkillBase
local ShieldSkillBase = require("GamePlay.SkillScripts.BaseSkill.ShieldSkillBase")
bs_10065.config = {buffId = 103, buffTier = 1, damageFormula = 10006, shieldKey = "10165_HuDun"}
bs_10065.ctor = function(self)
  -- function num : 0_0
end

bs_10065.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : _ENV
  self:AddSelfTrigger(eSkillTriggerType.SetHurt, "bs_10065_2", 1, self.OnSetHurt)
  self:AddTrigger(eSkillTriggerType.RoleDie, "bs_10065_10", 1, self.OnRoleDie)
  -- DECOMPILER ERROR at PC16: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.caster).recordTable).sheildValue_10044 = 0
end

bs_10065.OnSetHurt = function(self, context)
  -- function num : 0_2 , upvalues : ShieldSkillBase, _ENV
  if context.target == self.caster and ((self.caster).recordTable).sheildValue_10044 ~= 0 and (context.target).roleType == 1 then
    local realHurt = context.hurt - ((self.caster).recordTable).sheildValue_10044
    if realHurt >= 0 then
      context.hurt = realHurt
      -- DECOMPILER ERROR at PC23: Confused about usage of register: R3 in 'UnsetPending'

      ;
      ((self.caster).recordTable).sheildValue_10044 = 0
    else
      context.hurt = 0
      -- DECOMPILER ERROR at PC29: Confused about usage of register: R3 in 'UnsetPending'

      ;
      ((self.caster).recordTable).sheildValue_10044 = 0 - realHurt
    end
    if ((self.caster).recordTable).sheildValue_10044 >= 0 then
      (ShieldSkillBase.UpdateShieldView)(self.caster, (self.config).shieldKey, ((self.caster).recordTable).sheildValue_10044)
    end
    if ((self.caster).recordTable).sheildValue_10044 == 0 and (self.caster):GetBuffTier((self.config).buffId) > 0 then
      LuaSkillCtrl:DispelBuff(self.caster, (self.config).buffId)
    end
  end
end

bs_10065.OnRoleDie = function(self, killer, role)
  -- function num : 0_3 , upvalues : _ENV, ShieldSkillBase
  if (self.caster).belongNum == role.belongNum and role.roleType == 1 then
    self:PlayChipEffect()
    LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId, 1)
    local sheildValue = LuaSkillCtrl:CallFormulaNumberWithSkill((self.config).damageFormula, role, role, self)
    -- DECOMPILER ERROR at PC32: Confused about usage of register: R4 in 'UnsetPending'

    ;
    ((self.caster).recordTable).sheildValue_10044 = ((self.caster).recordTable).sheildValue_10044 + sheildValue
    if ((self.caster).recordTable).sheildValue_10044 >= 0 then
      (ShieldSkillBase.UpdateShieldView)(self.caster, (self.config).shieldKey, ((self.caster).recordTable).sheildValue_10044)
    end
  end
end

bs_10065.OnCasterDie = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10065


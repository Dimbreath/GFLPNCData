-- params : ...
-- function num : 0 , upvalues : _ENV
local ShieldSkillBase = require("GamePlay.SkillScripts.BaseSkill.ShieldSkillBase")
local bs_6007 = class("bs_6007", LuaSkillBase)
local base = LuaSkillBase
bs_6007.config = {buffId = 103, formulaID = 10024, shieldKey = "6007_Shield"}
bs_6007.ctor = function(self)
  -- function num : 0_0
end

bs_6007.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_6007_1", 1, self.OnAfterBattleStart)
  self:AddTrigger(eSkillTriggerType.SetHurt, "bs_6007_2", 2, self.OnSetHurt)
  -- DECOMPILER ERROR at PC22: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.caster).recordTable)[(self.config).shieldKey] = 0
end

bs_6007.OnSetHurt = function(self, context)
  -- function num : 0_2 , upvalues : ShieldSkillBase, _ENV
  if context.target == self.caster then
    local retHurt = (ShieldSkillBase.ShieldBaseFunc)(context.hurt, self.caster, (self.config).shieldKey)
    if retHurt ~= context.hurt then
      context.hurt = retHurt
    end
    if ((self.caster).recordTable)[(self.config).shieldKey] == 0 and (self.caster):GetBuffTier((self.config).buffId) > 0 then
      LuaSkillCtrl:DispelBuff(self.caster, (self.config).buffId)
    end
  end
end

bs_6007.OnAfterBattleStart = function(self)
  -- function num : 0_3 , upvalues : _ENV, ShieldSkillBase
  local shieldValue = LuaSkillCtrl:CallFormulaNumberWithSkill((self.config).formulaID, self.caster, self.caster, self)
  ;
  (ShieldSkillBase.UpdateShieldView)(self.caster, (self.config).shieldKey, shieldValue)
  LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId, 1)
end

bs_6007.OnCasterDie = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_6007

-- params : ...
-- function num : 0 , upvalues : _ENV
local ShieldSkillBase = require(
                            "GamePlay.SkillScripts.BaseSkill.ShieldSkillBase")
local bs_6007 = class("bs_6007", LuaSkillBase)
local base = LuaSkillBase
bs_6007.config = {buffId = 103, formulaID = 10024, shieldKey = "6007_Shield"}
bs_6007.ctor = function(self)
    -- function num : 0_0
end

bs_6007.InitSkill = function(self, isMidwaySkill)
    -- function num : 0_1 , upvalues : base, _ENV
    (base.InitSkill)(self, isMidwaySkill)
    self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_6007_1", 1,
                    self.OnAfterBattleStart)
    self:AddTrigger(eSkillTriggerType.SetHurt, "bs_6007_2", 2, self.OnSetHurt) -- DECOMPILER ERROR at PC22: Confused about usage of register: R2 in 'UnsetPending'
    ;
    ((self.caster).recordTable)[(self.config).shieldKey] = 0
end

bs_6007.OnSetHurt = function(self, context)
    -- function num : 0_2 , upvalues : ShieldSkillBase, _ENV
    if context.target == self.caster then
        local retHurt = (ShieldSkillBase.ShieldBaseFunc)(context.hurt,
                                                         self.caster,
                                                         (self.config).shieldKey)
        if retHurt ~= context.hurt then context.hurt = retHurt end
        if ((self.caster).recordTable)[(self.config).shieldKey] == 0 and
            (self.caster):GetBuffTier((self.config).buffId) > 0 then
            LuaSkillCtrl:DispelBuff(self.caster, (self.config).buffId)
        end
    end
end

bs_6007.OnAfterBattleStart = function(self)
    -- function num : 0_3 , upvalues : _ENV, ShieldSkillBase
    local shieldValue = LuaSkillCtrl:CallFormulaNumberWithSkill(
                            (self.config).formulaID, self.caster, self.caster,
                            self);
    (ShieldSkillBase.UpdateShieldView)(self.caster, (self.config).shieldKey,
                                       shieldValue)
    LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId, 1)
end

bs_6007.OnCasterDie = function(self)
    -- function num : 0_4 , upvalues : base
    (base.OnCasterDie)(self)
end

return bs_6007


-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_50004 = class("bs_50004", LuaSkillBase)
local base = LuaSkillBase
bs_50004.config = {buffId = 1051, effectId = 10481}
bs_50004.ctor = function(self)
  -- function num : 0_0
end

bs_50004.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.BeforeAddBuff, "bs_50004_2", 1, self.OnBeforeAddBuff)
end

bs_50004.OnBeforeAddBuff = function(self, target, context)
  -- function num : 0_2 , upvalues : _ENV
  if (context.buff).buffType == 2 and target == self.caster then
    local restTier = (self.caster):GetBuffTier((self.config).buffId)
    -- DECOMPILER ERROR at PC15: Confused about usage of register: R4 in 'UnsetPending'

    if restTier > 0 then
      (context.buff).tier = 0
      LuaSkillCtrl:DispelBuff(self.caster, (self.config).buffId, 1)
    else
      LuaSkillCtrl:CallEffect(self.caster, (self.config).effectId, self)
    end
  end
end

bs_50004.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_50004

-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_50004 = class("bs_50004", LuaSkillBase)
local base = LuaSkillBase
bs_50004.config = {buffId = 1051, effectId = 10481}
bs_50004.ctor = function(self)
    -- function num : 0_0
end

bs_50004.InitSkill = function(self, isMidwaySkill)
    -- function num : 0_1 , upvalues : base, _ENV
    (base.InitSkill)(self, isMidwaySkill)
    self:AddTrigger(eSkillTriggerType.BeforeAddBuff, "bs_50004_2", 1,
                    self.OnBeforeAddBuff)
end

bs_50004.OnBeforeAddBuff = function(self, target, context)
    -- function num : 0_2 , upvalues : _ENV
    if (context.buff).buffType == 2 and target == self.caster then
        local restTier = (self.caster):GetBuffTier((self.config).buffId)
        -- DECOMPILER ERROR at PC15: Confused about usage of register: R4 in 'UnsetPending'

        if restTier > 0 then
            (context.buff).tier = 0
            LuaSkillCtrl:DispelBuff(self.caster, (self.config).buffId, 1)
        else
            LuaSkillCtrl:CallEffect(self.caster, (self.config).effectId, self)
        end
    end
end

bs_50004.OnCasterDie = function(self)
    -- function num : 0_3 , upvalues : base
    (base.OnCasterDie)(self)
end

return bs_50004


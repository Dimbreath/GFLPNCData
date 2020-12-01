-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_10031 = class("bs_10031", LuaSkillBase)
local base = LuaSkillBase
bs_10031.config = {buffId = 105, buffTier = 1}
bs_10031.ctor = function(self)
  -- function num : 0_0
end

bs_10031.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : _ENV
  self:AddTrigger(eSkillTriggerType.HurtResultStart, "bs_10031_1", 1, self.OnHurtResultStart)
end

bs_10031.OnHurtResultStart = function(self, skill, context)
  -- function num : 0_2 , upvalues : _ENV
  if context.sender == self.caster and (context.target).maxHp < (context.sender).maxHp then
    LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId, (self.config).buffTier)
  else
    if context.sender == self.caster and (context.sender).maxHp <= (context.target).maxHp then
      LuaSkillCtrl:DispelBuff(self.caster, (self.config).buffId, 0)
    end
  end
end

bs_10031.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10031

-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_10031 = class("bs_10031", LuaSkillBase)
local base = LuaSkillBase
bs_10031.config = {buffId = 105, buffTier = 1}
bs_10031.ctor = function(self)
    -- function num : 0_0
end

bs_10031.InitSkill = function(self, isMidwaySkill)
    -- function num : 0_1 , upvalues : _ENV
    self:AddTrigger(eSkillTriggerType.HurtResultStart, "bs_10031_1", 1,
                    self.OnHurtResultStart)
end

bs_10031.OnHurtResultStart = function(self, skill, context)
    -- function num : 0_2 , upvalues : _ENV
    if context.sender == self.caster and (context.target).maxHp <
        (context.sender).maxHp then
        LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId,
                              (self.config).buffTier)
    else
        if context.sender == self.caster and (context.sender).maxHp <=
            (context.target).maxHp then
            LuaSkillCtrl:DispelBuff(self.caster, (self.config).buffId, 0)
        end
    end
end

bs_10031.OnCasterDie = function(self)
    -- function num : 0_3 , upvalues : base
    (base.OnCasterDie)(self)
end

return bs_10031


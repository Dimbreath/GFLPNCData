-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_103801 = class("bs_103801", LuaSkillBase)
local base = LuaSkillBase
bs_103801.config = {buffId = 195}
bs_103801.ctor = function(self)
  -- function num : 0_0
end

bs_103801.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterHurt, "bs_103801_3", 1, self.OnAfterHurt)
  if (self.arglist)[2] == 1 then
    self:AddTrigger(eSkillTriggerType.SetHurt, "bs_103801_2", 2, self.OnSetHurt)
  end
end

bs_103801.OnSetHurt = function(self, context)
  -- function num : 0_2
  if (context.skill).isCommonAttack and context.sender == self.caster and context.target ~= self.caster and (context.target):GetBuffTier((self.config).buffId) > 0 then
    local hurtOffSet = context.hurt * 1000 // 1000
    if hurtOffSet < 1 then
      hurtOffSet = 1
    end
    context.hurt = context.hurt + hurtOffSet
  end
end

bs_103801.OnAfterHurt = function(self, sender, target, skill, hurt, isMiss, isCrit, isRealDmg)
  -- function num : 0_3 , upvalues : _ENV
  if sender == self.caster and skill.isCommonAttack and LuaSkillCtrl:CallRange(1, 1000) <= (self.arglist)[1] then
    LuaSkillCtrl:CallBuff(self, target, (self.config).buffId, 1, 45)
  end
end

bs_103801.OnCasterDie = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_103801

-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_103801 = class("bs_103801", LuaSkillBase)
local base = LuaSkillBase
bs_103801.config = {buffId = 195}
bs_103801.ctor = function(self)
    -- function num : 0_0
end

bs_103801.InitSkill = function(self, isMidwaySkill)
    -- function num : 0_1 , upvalues : base, _ENV
    (base.InitSkill)(self, isMidwaySkill)
    self:AddTrigger(eSkillTriggerType.AfterHurt, "bs_103801_3", 1,
                    self.OnAfterHurt)
    if (self.arglist)[2] == 1 then
        self:AddTrigger(eSkillTriggerType.SetHurt, "bs_103801_2", 2,
                        self.OnSetHurt)
    end
end

bs_103801.OnSetHurt = function(self, context)
    -- function num : 0_2
    if (context.skill).isCommonAttack and context.sender == self.caster and
        context.target ~= self.caster and
        (context.target):GetBuffTier((self.config).buffId) > 0 then
        local hurtOffSet = context.hurt * 1000 // 1000
        if hurtOffSet < 1 then hurtOffSet = 1 end
        context.hurt = context.hurt + hurtOffSet
    end
end

bs_103801.OnAfterHurt = function(self, sender, target, skill, hurt, isMiss,
                                 isCrit, isRealDmg)
    -- function num : 0_3 , upvalues : _ENV
    if sender == self.caster and skill.isCommonAttack and
        LuaSkillCtrl:CallRange(1, 1000) <= (self.arglist)[1] then
        LuaSkillCtrl:CallBuff(self, target, (self.config).buffId, 1, 45)
    end
end

bs_103801.OnCasterDie = function(self)
    -- function num : 0_4 , upvalues : base
    (base.OnCasterDie)(self)
end

return bs_103801


-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_100901 = class("bs_100901", LuaSkillBase)
local base = LuaSkillBase
bs_100901.config = {buffId1 = 130}
bs_100901.ctor = function(self)
  -- function num : 0_0
end

bs_100901.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterHurt, "bs_100901_3", 1, self.OnAfterHurt)
end

bs_100901.OnAfterHurt = function(self, sender, target, skill, hurt, isMiss, isCrit, isRealDmg)
  -- function num : 0_2 , upvalues : _ENV
  if sender == self.caster and skill.isCommonAttack and not isMiss and LuaSkillCtrl:CallRange(1, 1000) <= (self.arglist)[1] then
    LuaSkillCtrl:CallBuff(self, target, (self.config).buffId1, 1, (self.arglist)[2])
    if (self.arglist)[3] >= 1 then
      LuaSkillCtrl:StartTimer(self, (self.arglist)[2], function()
    -- function num : 0_2_0 , upvalues : _ENV, self, target
    LuaSkillCtrl:CallBuff(self, target, 26, 1, (self.arglist)[4])
  end
)
    end
  end
end

bs_100901.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_100901

-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_100901 = class("bs_100901", LuaSkillBase)
local base = LuaSkillBase
bs_100901.config = {buffId1 = 130}
bs_100901.ctor = function(self)
    -- function num : 0_0
end

bs_100901.InitSkill = function(self, isMidwaySkill)
    -- function num : 0_1 , upvalues : base, _ENV
    (base.InitSkill)(self, isMidwaySkill)
    self:AddTrigger(eSkillTriggerType.AfterHurt, "bs_100901_3", 1,
                    self.OnAfterHurt)
end

bs_100901.OnAfterHurt = function(self, sender, target, skill, hurt, isMiss,
                                 isCrit, isRealDmg)
    -- function num : 0_2 , upvalues : _ENV
    if sender == self.caster and skill.isCommonAttack and not isMiss and
        LuaSkillCtrl:CallRange(1, 1000) <= (self.arglist)[1] then
        LuaSkillCtrl:CallBuff(self, target, (self.config).buffId1, 1,
                              (self.arglist)[2])
        if (self.arglist)[3] >= 1 then
            LuaSkillCtrl:StartTimer(self, (self.arglist)[2], function()
                -- function num : 0_2_0 , upvalues : _ENV, self, target
                LuaSkillCtrl:CallBuff(self, target, 26, 1, (self.arglist)[4])
            end)
        end
    end
end

bs_100901.OnCasterDie = function(self)
    -- function num : 0_3 , upvalues : base
    (base.OnCasterDie)(self)
end

return bs_100901


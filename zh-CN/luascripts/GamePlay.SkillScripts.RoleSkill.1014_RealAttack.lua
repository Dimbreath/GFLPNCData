-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_1014 = class("bs_1014", LuaSkillBase)
local base = LuaSkillBase
bs_1014.config = {buffId = 93}
bs_1014.ctor = function(self)
  -- function num : 0_0
end

bs_1014.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : _ENV
  self:AddTrigger(eSkillTriggerType.AfterHurt, "bs_1014_3", 1, self.OnAfterHurt)
  self:AddTrigger(eSkillTriggerType.BuffDie, "bs_1014_9", 1, self.OnBuffDie)
  self.count = 0
end

bs_1014.OnAfterHurt = function(self, sender, target, skill, hurt, isMiss, isCrit, isRealDmg)
  -- function num : 0_2 , upvalues : _ENV
  if sender == self.caster and skill.isCommonAttack then
    self.count = self.count + 1
    if self.count == 4 then
      LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId, (self.arglist)[1], (self.arglist)[2])
    end
  end
end

bs_1014.OnBuffDie = function(self, buff, target, removeType)
  -- function num : 0_3 , upvalues : _ENV
  if target == self.caster and buff.dataId == (self.config).buffId and removeType == eBuffRemoveType.Timeout then
    self.count = 0
  end
end

bs_1014.OnCasterDie = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_1014

-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_1014 = class("bs_1014", LuaSkillBase)
local base = LuaSkillBase
bs_1014.config = {buffId = 93}
bs_1014.ctor = function(self)
    -- function num : 0_0
end

bs_1014.InitSkill = function(self, isMidwaySkill)
    -- function num : 0_1 , upvalues : _ENV
    self:AddTrigger(eSkillTriggerType.AfterHurt, "bs_1014_3", 1,
                    self.OnAfterHurt)
    self:AddTrigger(eSkillTriggerType.BuffDie, "bs_1014_9", 1, self.OnBuffDie)
    self.count = 0
end

bs_1014.OnAfterHurt = function(self, sender, target, skill, hurt, isMiss,
                               isCrit, isRealDmg)
    -- function num : 0_2 , upvalues : _ENV
    if sender == self.caster and skill.isCommonAttack then
        self.count = self.count + 1
        if self.count == 4 then
            LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId,
                                  (self.arglist)[1], (self.arglist)[2])
        end
    end
end

bs_1014.OnBuffDie = function(self, buff, target, removeType)
    -- function num : 0_3 , upvalues : _ENV
    if target == self.caster and buff.dataId == (self.config).buffId and
        removeType == eBuffRemoveType.Timeout then self.count = 0 end
end

bs_1014.OnCasterDie = function(self)
    -- function num : 0_4 , upvalues : base
    (base.OnCasterDie)(self)
end

return bs_1014


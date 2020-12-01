-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_1015 = class("bs_1015", LuaSkillBase)
local base = LuaSkillBase
bs_1015.config = {ctrlBuffNum = 3, buffStun = 66, buffBewitch = 90, buffNoskill = 58, effectIdSelf = 1001, effectIdAttack = 1002}
bs_1015.ctor = function(self)
  -- function num : 0_0
end

bs_1015.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : _ENV
  self:AddTrigger(eSkillTriggerType.AfterHurt, "bs_1015_3", 1, self.OnAfterHurt)
  self.random = 0
end

bs_1015.OnAfterHurt = function(self, sender, target, skill, hurt, isMiss, isCrit, isRealDmg)
  -- function num : 0_2 , upvalues : _ENV
  if target == self.caster and skill.isCommonAttack and not isMiss and LuaSkillCtrl:CallRange(1, 1000) <= (self.arglist)[1] then
    self.random = LuaSkillCtrl:CallRange(1, (self.config).ctrlBuffNum)
    LuaSkillCtrl:CallEffect(self.caster, (self.config).effectIdSelf, self)
    LuaSkillCtrl:CallEffect(sender, (self.config).effectIdAttack, self)
    if self.random == 1 then
      LuaSkillCtrl:CallBuff(self, sender, (self.config).buffStun, 1, (self.arglist)[2])
    else
      if self.random == 2 then
        LuaSkillCtrl:CallBuff(self, sender, (self.config).buffBewitch, 1, (self.arglist)[2])
      else
        if self.random == 3 then
          LuaSkillCtrl:CallBuff(self, sender, (self.config).buffNoskill, 1, (self.arglist)[2])
        end
      end
    end
    self.random = 0
  end
end

bs_1015.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_1015

-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_1015 = class("bs_1015", LuaSkillBase)
local base = LuaSkillBase
bs_1015.config = {
    ctrlBuffNum = 3,
    buffStun = 66,
    buffBewitch = 90,
    buffNoskill = 58,
    effectIdSelf = 1001,
    effectIdAttack = 1002
}
bs_1015.ctor = function(self)
    -- function num : 0_0
end

bs_1015.InitSkill = function(self, isMidwaySkill)
    -- function num : 0_1 , upvalues : _ENV
    self:AddTrigger(eSkillTriggerType.AfterHurt, "bs_1015_3", 1,
                    self.OnAfterHurt)
    self.random = 0
end

bs_1015.OnAfterHurt = function(self, sender, target, skill, hurt, isMiss,
                               isCrit, isRealDmg)
    -- function num : 0_2 , upvalues : _ENV
    if target == self.caster and skill.isCommonAttack and not isMiss and
        LuaSkillCtrl:CallRange(1, 1000) <= (self.arglist)[1] then
        self.random = LuaSkillCtrl:CallRange(1, (self.config).ctrlBuffNum)
        LuaSkillCtrl:CallEffect(self.caster, (self.config).effectIdSelf, self)
        LuaSkillCtrl:CallEffect(sender, (self.config).effectIdAttack, self)
        if self.random == 1 then
            LuaSkillCtrl:CallBuff(self, sender, (self.config).buffStun, 1,
                                  (self.arglist)[2])
        else
            if self.random == 2 then
                LuaSkillCtrl:CallBuff(self, sender, (self.config).buffBewitch,
                                      1, (self.arglist)[2])
            else
                if self.random == 3 then
                    LuaSkillCtrl:CallBuff(self, sender,
                                          (self.config).buffNoskill, 1,
                                          (self.arglist)[2])
                end
            end
        end
        self.random = 0
    end
end

bs_1015.OnCasterDie = function(self)
    -- function num : 0_3 , upvalues : base
    (base.OnCasterDie)(self)
end

return bs_1015


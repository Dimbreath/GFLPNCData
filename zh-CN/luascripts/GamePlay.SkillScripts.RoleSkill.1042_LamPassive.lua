-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_1042 = class("bs_1042", LuaSkillBase)
local base = LuaSkillBase
bs_1042.config = {buffId = 142, buffId2 = 143, buffId3 = 144}
bs_1042.ctor = function(self)
  -- function num : 0_0
end

bs_1042.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self.lastSpeedOfs = 0
  self:OnCasterAttributeChange()
  self:AddTrigger(eSkillTriggerType.OnSelfAttrChanged, "bs_1042_attrObs", 1, self.OnCasterAttributeChange)
end

bs_1042.OnCasterAttributeChange = function(self)
  -- function num : 0_2 , upvalues : _ENV
  local speedOfs = (self.arglist)[1] - (self.caster).speed
  if speedOfs ~= 0 and self.lastSpeedOfs ~= speedOfs then
    (self.caster):AddRoleProperty(eHeroAttr.speed, speedOfs, eHeroAttrType.Extra)
    do
      if speedOfs ~= 0 and self.lastSpeedOfs ~= speedOfs then
        local ret = (Mathf.Min)(1000, -speedOfs * (self.arglist)[3] // (self.arglist)[2])
        ;
        (self.caster):AddRoleProperty(eHeroAttr.crit, ret, eHeroAttrType.Extra)
      end
      do
        if (self.arglist)[5] > 0 and speedOfs < 0 and self.lastSpeedOfs ~= speedOfs then
          local rett = -speedOfs * (self.arglist)[4] // (self.arglist)[2]
          ;
          (self.caster):AddRoleProperty(eHeroAttr.crit_damage, rett, eHeroAttrType.Extra)
          self.lastSpeedOfs = speedOfs
        end
        self.lastSpeedOfs = speedOfs
      end
    end
  end
end

bs_1042.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_1042

-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_1042 = class("bs_1042", LuaSkillBase)
local base = LuaSkillBase
bs_1042.config = {buffId = 142, buffId2 = 143, buffId3 = 144}
bs_1042.ctor = function(self)
    -- function num : 0_0
end

bs_1042.InitSkill = function(self, isMidwaySkill)
    -- function num : 0_1 , upvalues : base, _ENV
    (base.InitSkill)(self, isMidwaySkill)
    self.lastSpeedOfs = 0
    self:OnCasterAttributeChange()
    self:AddTrigger(eSkillTriggerType.OnSelfAttrChanged, "bs_1042_attrObs", 1,
                    self.OnCasterAttributeChange)
end

bs_1042.OnCasterAttributeChange = function(self)
    -- function num : 0_2 , upvalues : _ENV
    local speedOfs = (self.arglist)[1] - (self.caster).speed
    if speedOfs ~= 0 and self.lastSpeedOfs ~= speedOfs then
        (self.caster):AddRoleProperty(eHeroAttr.speed, speedOfs,
                                      eHeroAttrType.Extra)
        do
            if speedOfs ~= 0 and self.lastSpeedOfs ~= speedOfs then
                local ret = (Mathf.Min)(1000, -speedOfs * (self.arglist)[3] //
                                            (self.arglist)[2]);
                (self.caster):AddRoleProperty(eHeroAttr.crit, ret,
                                              eHeroAttrType.Extra)
            end
            do
                if (self.arglist)[5] > 0 and speedOfs < 0 and self.lastSpeedOfs ~=
                    speedOfs then
                    local rett = -speedOfs * (self.arglist)[4] //
                                     (self.arglist)[2];
                    (self.caster):AddRoleProperty(eHeroAttr.crit_damage, rett,
                                                  eHeroAttrType.Extra)
                    self.lastSpeedOfs = speedOfs
                end
                self.lastSpeedOfs = speedOfs
            end
        end
    end
end

bs_1042.OnCasterDie = function(self)
    -- function num : 0_3 , upvalues : base
    (base.OnCasterDie)(self)
end

return bs_1042


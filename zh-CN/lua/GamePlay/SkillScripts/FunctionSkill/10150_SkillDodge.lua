local bs_10150 = class("bs_10150", LuaSkillBase)
local base = LuaSkillBase
bs_10150.config = {buffId = 1122, buffTier = 1}
bs_10150.ctor = function(self)
  -- function num : 0_0
end

bs_10150.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddSelfTrigger(eSkillTriggerType.AfterPlaySkill, "bs_10150_2", 2, self.OnAfterPlaySkill)
end

bs_10150.OnAfterPlaySkill = function(self, skill, role)
  -- function num : 0_2 , upvalues : _ENV
  if skill.maker == self.caster and not skill.isCommonAttack then
    local targetlist = LuaSkillCtrl:CallTargetSelect(self, 24, 10)
    if targetlist.Count > 0 then
      local layer = ((targetlist[0]).targetRole):GetBuffTier((self.config).buffId)
      if layer ~= (self.arglist)[2] then
        if layer <= (self.arglist)[2] then
          LuaSkillCtrl:CallBuff(self, (targetlist[0]).targetRole, (self.config).buffId, (self.config).buffTier, nil, true)
        else
          if (self.arglist)[2] < layer then
            LuaSkillCtrl:DispelBuff((targetlist[0]).targetRole, (self.config).buffId, 0)
            LuaSkillCtrl:CallBuff(self, (targetlist[0]).targetRole, (self.config).buffId, (self.arglist)[2], nil, true)
          end
        end
      end
      if ((self.caster).recordTable)["30039_Flag"] and targetlist.Count > 1 then
        local layer = ((targetlist[1]).targetRole):GetBuffTier((self.config).buffId)
        if layer ~= (self.arglist)[2] then
          if layer <= (self.arglist)[2] then
            LuaSkillCtrl:CallBuff(self, (targetlist[1]).targetRole, (self.config).buffId, (self.config).buffTier, nil, true)
          else
            if (self.arglist)[2] < layer then
              LuaSkillCtrl:DispelBuff((targetlist[1]).targetRole, (self.config).buffId, 0)
              LuaSkillCtrl:CallBuff(self, (targetlist[1]).targetRole, (self.config).buffId, (self.arglist)[2], nil, true)
            end
          end
        end
      end
    end
  end
end

bs_10150.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10150


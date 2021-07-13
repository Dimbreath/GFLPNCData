-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_10224 = class("bs_10224", LuaSkillBase)
local base = LuaSkillBase
bs_10224.config = {buffId = 1080, effectId1 = 10749, effectId2 = 10750, effectId3 = 10751, effectId4 = 10752}
bs_10224.ctor = function(self)
  -- function num : 0_0
end

bs_10224.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_10224_1", 1, self.OnAfterBattleStart)
  self:AddSelfTrigger(eSkillTriggerType.AfterPlaySkill, "bs_10224_3", 3, self.OnAfterPlaySkill)
end

bs_10224.OnAfterBattleStart = function(self)
  -- function num : 0_2 , upvalues : _ENV
  self:PlayChipEffect()
  LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId, (self.arglist)[1], nil, true)
  self.effect = LuaSkillCtrl:CallEffect(self.caster, (self.config).effectId3, self)
end

bs_10224.OnAfterPlaySkill = function(self, skill, role)
  -- function num : 0_3 , upvalues : _ENV
  if skill.maker == self.caster and not skill.isCommonAttack then
    local tier = (self.caster):GetBuffTier((self.config).buffId)
    if tier > 0 then
      if tier == 1 then
        if self.effect ~= nil then
          (self.effect):Die()
          self.effect = nil
        end
        self.effect = LuaSkillCtrl:CallEffect(self.caster, (self.config).effectId4, self)
      else
        if tier == 2 then
          if self.effect ~= nil then
            (self.effect):Die()
            self.effect = nil
          end
          self.effect = LuaSkillCtrl:CallEffect(self.caster, (self.config).effectId1, self)
        else
          if tier == 3 then
            if self.effect ~= nil then
              (self.effect):Die()
              self.effect = nil
            end
            self.effect = LuaSkillCtrl:CallEffect(self.caster, (self.config).effectId2, self)
          end
        end
      end
      LuaSkillCtrl:DispelBuff(self.caster, (self.config).buffId, 1)
    end
  end
end

bs_10224.OnCasterDie = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnCasterDie)(self)
  if self.effect ~= nil then
    (self.effect):Die()
    self.effect = nil
  end
end

bs_10224.LuaDispose = function(self)
  -- function num : 0_5 , upvalues : base
  (base.LuaDispose)(self)
  self.effect = nil
end

return bs_10224


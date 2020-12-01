-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_10138 = class("bs_10138", LuaSkillBase)
local base = LuaSkillBase
bs_10138.config = {
realDamageConfig = {basehurt_formula = 10038}
, effectId = 10248}
bs_10138.ctor = function(self)
  -- function num : 0_0
end

bs_10138.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterHurt, "bs_10138", 1, self.OnAfterHurt)
end

bs_10138.OnAfterHurt = function(self, sender, target, skill, hurt, isMiss, isCrit, isRealDmg)
  -- function num : 0_2 , upvalues : _ENV
  if sender == self.caster and skill.isCommonAttack then
    local debuffNum = 0
    local buffs = LuaSkillCtrl:GetRoleBuffs(target)
    if buffs.Count > 0 then
      for i = 0, buffs.Count - 1 do
        if (buffs[i]).buffType == 2 then
          debuffNum = debuffNum + (buffs[i]).tier
        end
      end
    end
    do
      if debuffNum > 0 then
        LuaSkillCtrl:CallEffectWithArg(target, (self.config).effectId, self, true, self.SkillEventFunc, debuffNum)
      end
    end
  end
end

bs_10138.SkillEventFunc = function(self, debuffNum, effect, eventId, target)
  -- function num : 0_3 , upvalues : _ENV
  if eventId == eBattleEffectEvent.Trigger then
    LuaSkillCtrl:CallRealDamage(self, target, nil, (self.config).realDamageConfig, {debuffNum})
  end
end

bs_10138.OnCasterDie = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10138

-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_10138 = class("bs_10138", LuaSkillBase)
local base = LuaSkillBase
bs_10138.config = {
    realDamageConfig = {basehurt_formula = 10038},
    effectId = 10248
}
bs_10138.ctor = function(self)
    -- function num : 0_0
end

bs_10138.InitSkill = function(self, isMidwaySkill)
    -- function num : 0_1 , upvalues : base, _ENV
    (base.InitSkill)(self, isMidwaySkill)
    self:AddTrigger(eSkillTriggerType.AfterHurt, "bs_10138", 1, self.OnAfterHurt)
end

bs_10138.OnAfterHurt = function(self, sender, target, skill, hurt, isMiss,
                                isCrit, isRealDmg)
    -- function num : 0_2 , upvalues : _ENV
    if sender == self.caster and skill.isCommonAttack then
        local debuffNum = 0
        local buffs = LuaSkillCtrl:GetRoleBuffs(target)
        if buffs.Count > 0 then
            for i = 0, buffs.Count - 1 do
                if (buffs[i]).buffType == 2 then
                    debuffNum = debuffNum + (buffs[i]).tier
                end
            end
        end
        do
            if debuffNum > 0 then
                LuaSkillCtrl:CallEffectWithArg(target, (self.config).effectId,
                                               self, true, self.SkillEventFunc,
                                               debuffNum)
            end
        end
    end
end

bs_10138.SkillEventFunc = function(self, debuffNum, effect, eventId, target)
    -- function num : 0_3 , upvalues : _ENV
    if eventId == eBattleEffectEvent.Trigger then
        LuaSkillCtrl:CallRealDamage(self, target, nil,
                                    (self.config).realDamageConfig, {debuffNum})
    end
end

bs_10138.OnCasterDie = function(self)
    -- function num : 0_4 , upvalues : base
    (base.OnCasterDie)(self)
end

return bs_10138


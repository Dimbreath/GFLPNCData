local bs_50011 = class("bs_50011", LuaSkillBase)
local base = LuaSkillBase
bs_50011.config = {
hurt_config = {basehurt_formula = 10109}
, effectId = 10628, effectId2 = 10630}
bs_50011.ctor = function(self)
  -- function num : 0_0
end

bs_50011.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  if isMidwaySkill then
    if self.damTimer then
      return 
    end
    local loopJiange = (self.arglist)[1] // (self.arglist)[3]
    self.damTimer = LuaSkillCtrl:StartTimer(nil, loopJiange, self.CallBack, self, -1, 0)
    self.damTimer2 = LuaSkillCtrl:StartTimer(nil, ((self.caster).recordTable)["10228_time"], self.CallBack2, self, 1, 0)
  end
end

bs_50011.CallBack2 = function(self)
  -- function num : 0_2
  if self.damTimer then
    (self.damTimer):Stop()
    self.damTimer = nil
  end
end

bs_50011.CallBack = function(self)
  -- function num : 0_3 , upvalues : _ENV
  if self.caster == nil then
    if self.damTimer then
      (self.damTimer):Stop()
      self.damTimer = nil
    end
    return 
  end
  if (self.caster).hp == 0 and self.damTimer then
    (self.damTimer):Stop()
    self.damTimer = nil
  end
  local targetlist = LuaSkillCtrl:CallTargetSelect(self, 19, 10)
  if targetlist.Count < 1 then
    return 
  end
  LuaSkillCtrl:CallEffect((targetlist[0]).targetRole, (self.config).effectId, self, self.SkillEventFunc)
  if self.caster == nil or (self.caster).hp <= 0 then
    return 
  end
  LuaSkillCtrl:CallEffect(self.caster, (self.config).effectId2, self)
end

bs_50011.SkillEventFunc = function(self, effect, eventId, target)
  -- function num : 0_4 , upvalues : _ENV
  if eventId == eBattleEffectEvent.Trigger then
    local damageArg = ((self.caster).recordTable)["10228_Damage"]
    local skillResult = LuaSkillCtrl:CallSkillResult(effect, target, (self.config).aoe_config)
    LuaSkillCtrl:HurtResult(self, skillResult, (self.config).hurt_config, {damageArg}, true)
    skillResult:EndResult()
  end
end

bs_50011.OnCasterDie = function(self)
  -- function num : 0_5 , upvalues : base
  (base.OnCasterDie)(self)
  if self.damTimer then
    (self.damTimer):Stop()
    self.damTimer = nil
  end
  if self.damTimer2 then
    (self.damTimer2):Stop()
    self.damTimer2 = nil
  end
end

return bs_50011


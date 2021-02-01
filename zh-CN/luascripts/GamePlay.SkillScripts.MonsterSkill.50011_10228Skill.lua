-- params : ...
-- function num : 0 , upvalues : _ENV
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
    self.damTimer = LuaSkillCtrl:StartTimer(nil, (self.arglist)[3], self.CallBack, self, -1, 0)
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
  local targetlist = LuaSkillCtrl:CallTargetSelect(self, 19, 10)
  if targetlist.Count < 1 then
    return 
  end
  if (self.caster).hp == 0 and self.damTimer then
    (self.damTimer):Stop()
    self.damTimer = nil
  end
  LuaSkillCtrl:CallEffect((targetlist[0]).targetRole, (self.config).effectId, self, self.SkillEventFunc)
  LuaSkillCtrl:CallEffect(self.caster, (self.config).effectId2, self)
end

bs_50011.SkillEventFunc = function(self, effect, eventId, target)
  -- function num : 0_4 , upvalues : _ENV
  if eventId == eBattleEffectEvent.Trigger then
    local buffNum = 0
    local buffs = LuaSkillCtrl:GetRoleBuffs(self.caster)
    if buffs.Count > 0 then
      for i = 0, buffs.Count - 1 do
        if (buffs[i]).buffType == 1 then
          buffNum = buffNum + (buffs[i]).tier
        end
      end
    end
    do
      if buffNum > 20 then
        buffNum = 20
      end
      local damageArg = ((self.caster).recordTable)["10228_Damage"]
      local skillResult = LuaSkillCtrl:CallSkillResult(effect, target, (self.config).aoe_config)
      LuaSkillCtrl:HurtResult(skillResult, (self.config).hurt_config, {buffNum, damageArg}, true)
      skillResult:EndResult()
    end
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


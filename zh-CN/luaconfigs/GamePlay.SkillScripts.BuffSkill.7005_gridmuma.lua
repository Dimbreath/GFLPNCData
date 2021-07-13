-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_7005 = class("bs_7005", LuaSkillBase)
local base = LuaSkillBase
bs_7005.config = {buffId = 110, buffStun = 66, 
aoe_config = {effect_shape = 3, aoe_select_code = 4, aoe_range = 1}
, effectId = 10504, effectId2 = 10508}
bs_7005.ctor = function(self)
  -- function num : 0_0
end

bs_7005.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self.damTimer = LuaSkillCtrl:StartTimer(nil, (self.arglist)[1], self.CallBack, self, -1)
  self:AddAfterAddBuffTrigger("bs_7005_7", 1, self.OnAfterAddBuff, nil, nil, nil, nil, (self.config).buffId)
end

bs_7005.CallBack = function(self)
  -- function num : 0_2 , upvalues : _ENV
  if self.damTimer ~= nil and (self.damTimer):IsOver() then
    self.damTimer = nil
  end
  if self.caster == nil then
    if self.damTimer ~= nil then
      (self.damTimer):Stop()
      self.damTimer = nil
    end
    return 
  end
  LuaSkillCtrl:CallEffect(self.caster, (self.config).effectId, self, self.SkillEventFunc)
end

bs_7005.SkillEventFunc = function(self, effect, eventId, target)
  -- function num : 0_3 , upvalues : _ENV
  if eventId == eBattleEffectEvent.Trigger then
    local skillResult = LuaSkillCtrl:CallSkillResult(effect, target, (self.config).aoe_config)
    skillResult:BuffResult((self.config).buffId, 1)
    if (skillResult.roleList).Count > 0 then
      for i = 0, (skillResult.roleList).Count - 1 do
        local role = (skillResult.roleList)[i]
        LuaSkillCtrl:CallEffect(role, (self.config).effectId2, self)
      end
    end
    do
      skillResult:EndResult()
    end
  end
end

bs_7005.OnAfterAddBuff = function(self, buff, target)
  -- function num : 0_4 , upvalues : _ENV
  if buff.dataId == (self.config).buffId then
    local restTier = target:GetBuffTier((self.config).buffId)
    if restTier >= 6 then
      LuaSkillCtrl:CallBuff(self, target, (self.config).buffStun, 1, 30, true)
      LuaSkillCtrl:DispelBuff(target, (self.config).buffId, 0, true)
      restTier = 0
    end
  end
end

bs_7005.OnCasterDie = function(self)
  -- function num : 0_5 , upvalues : base
  if self.damTimer ~= nil then
    (self.damTimer):Stop()
    self.damTimer = nil
  end
  ;
  (base.OnCasterDie)(self)
end

return bs_7005


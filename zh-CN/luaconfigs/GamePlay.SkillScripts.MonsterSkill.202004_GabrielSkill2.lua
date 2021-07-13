-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_202004 = class("bs_202004", LuaSkillBase)
local base = LuaSkillBase
bs_202004.config = {
hurtConfig = {hit_formula = 0, def_formula = 0, basehurt_formula = 1047, crit_formula = 0, correct_formula = 0, minhurt_formula = 0}
, hurt_delay = 15, effectId = 10758}
bs_202004.ctor = function(self)
  -- function num : 0_0
end

bs_202004.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_202004_1", 1, self.OnAfterBattleStart)
end

bs_202004.OnAfterBattleStart = function(self)
  -- function num : 0_2 , upvalues : _ENV
  local arriveCallBack = BindCallback(self, self.OnArriveAction, role)
  self.caoTimer = LuaSkillCtrl:StartTimer(nil, (self.arglist)[2], arriveCallBack, nil, -1, (self.config).hurt_delay)
end

bs_202004.OnArriveAction = function(self, role)
  -- function num : 0_3 , upvalues : _ENV
  if self.caoTimer ~= nil and (self.caoTimer):IsOver() then
    self.caoTimer = nil
  end
  LuaSkillCtrl:CallEffect(self.caster, (self.config).effectId, self, self.SkillEventFunc)
end

bs_202004.SkillEventFunc = function(self, effect, eventId, target)
  -- function num : 0_4 , upvalues : _ENV
  if eventId == eBattleEffectEvent.Trigger then
    local skillResult = LuaSkillCtrl:CallSkillResult(effect, target)
    LuaSkillCtrl:PlayAuHit(self, target)
    LuaSkillCtrl:HurtResult(self, skillResult, (self.config).hurtConfig, nil, true)
    skillResult:EndResult()
  end
end

bs_202004.OnCasterDie = function(self)
  -- function num : 0_5 , upvalues : base
  (base.OnCasterDie)(self)
  if self.caoTimer ~= nil then
    (self.caoTimer):Stop()
    self.caoTimer = nil
  end
end

return bs_202004


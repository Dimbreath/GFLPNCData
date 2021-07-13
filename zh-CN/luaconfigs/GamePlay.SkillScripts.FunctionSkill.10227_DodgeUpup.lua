-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_10227 = class("bs_10227", LuaSkillBase)
local base = LuaSkillBase
bs_10227.config = {buffId = 1082, effectId = 10625}
bs_10227.ctor = function(self)
  -- function num : 0_0
end

bs_10227.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_10227_1", 1, self.OnAfterBattleStart)
end

bs_10227.OnAfterBattleStart = function(self)
  -- function num : 0_2 , upvalues : _ENV
  local targetlist = LuaSkillCtrl:CallTargetSelect(self, 6, 10)
  if targetlist.Count < 1 then
    return 
  end
  for i = 0, targetlist.Count - 1 do
    local role = (targetlist[i]).targetRole
    local buffTier = role:GetBuffTier((self.config).buffId)
    if buffTier == 0 then
      LuaSkillCtrl:CallBuff(self, role, (self.config).buffId, 1, (self.arglist)[1], true)
    end
    local arriveCallBack1 = BindCallback(self, self.OnArriveAction1, self.caster)
    LuaSkillCtrl:StartTimer(nil, (self.arglist)[1] - 2, arriveCallBack1)
  end
end

bs_10227.OnArriveAction1 = function(self, role)
  -- function num : 0_3 , upvalues : _ENV
  self.effect = LuaSkillCtrl:CallEffect(self.caster, (self.config).effectId, self)
end

bs_10227.OnCasterDie = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnCasterDie)(self)
  if self.effect ~= nil then
    (self.effect):Die()
    self.effect = nil
  end
end

return bs_10227


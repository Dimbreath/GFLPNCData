local bs_10188 = class("bs_10188", LuaSkillBase)
local base = LuaSkillBase
bs_10188.config = {buffId = 175}
bs_10188.ctor = function(self)
  -- function num : 0_0
end

bs_10188.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_10188_2", 10, self.OnAfterBattleStart)
end

bs_10188.OnAfterBattleStart = function(self)
  -- function num : 0_2 , upvalues : _ENV
  local arriveCallBack = BindCallback(self, self.OnArriveAction)
  self.caoTimer = LuaSkillCtrl:StartTimer(nil, (self.arglist)[1], arriveCallBack)
end

bs_10188.OnArriveAction = function(self)
  -- function num : 0_3 , upvalues : _ENV
  if self.caoTimer ~= nil and (self.caoTimer):IsOver() then
    self.caoTimer = nil
  end
  local grid = LuaSkillCtrl:GetNearestEmptyEfcGrid(self.caster, 10)
  if grid ~= nil then
    LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId, 1, (self.arglist)[2])
    LuaSkillCtrl:CallEffect(self.caster, 10263, self)
    LuaSkillCtrl:SetRolePos(grid, self.caster)
    LuaSkillCtrl:CallEffect(self.caster, 10264, self)
  end
end

bs_10188.OnCasterDie = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10188


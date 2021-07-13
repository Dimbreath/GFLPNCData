-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_5014 = class("bs_5014", LuaSkillBase)
local base = LuaSkillBase
bs_5014.config = {buffId = 154}
bs_5014.ctor = function(self)
  -- function num : 0_0
end

bs_5014.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
  self:AddOnPlayerMpCostedTrigger("bs_5014_1", 1, self.OnMpCostToTargetValue, (self.arglist)[1])
end

bs_5014.OnMpCostToTargetValue = function(self, curMpCost)
  -- function num : 0_2 , upvalues : _ENV
  local targetList = LuaSkillCtrl:CallTargetSelect(self, 6, 10)
  for i = 0, targetList.Count - 1 do
    LuaSkillCtrl:CallBuff(self, (targetList[i]).targetRole, (self.config).buffId, 1, (self.arglist)[2])
  end
  self:RemoveSkillTrigger(eSkillTriggerType.OnPlayerMpCostToTargetValue)
end

bs_5014.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_5014


-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_5015 = class("bs_5015", LuaSkillBase)
local base = LuaSkillBase
bs_5015.config = {}
bs_5015.ctor = function(self)
  -- function num : 0_0
end

bs_5015.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
  self:AddOnPlayerMpCostedTrigger("bs_5015_1", 1, self.OnMpCostToTargetValue, (self.arglist)[1])
end

bs_5015.OnMpCostToTargetValue = function(self, curMpCost)
  -- function num : 0_2 , upvalues : _ENV
  LuaSkillCtrl:StartTimer(self, 3, function()
    -- function num : 0_2_0 , upvalues : _ENV, self
    LuaSkillCtrl:CallAddPlayerMp((self.arglist)[2])
    LuaSkillCtrl:CallResetCDNumForRole(self.caster, 1500)
  end
)
  self:RemoveSkillTrigger(eSkillTriggerType.OnPlayerMpCostToTargetValue)
end

bs_5015.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_5015


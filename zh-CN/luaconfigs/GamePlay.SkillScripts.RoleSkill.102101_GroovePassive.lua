-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_102101 = class("bs_102101", LuaSkillBase)
local base = LuaSkillBase
bs_102101.config = {buffId_171 = 171, 
AOE = {effect_shape = 3, aoe_select_code = 4, aoe_range = 10}
, 
HurtConfig = {basehurt_formula = 10058, minhurt_formula = 9994, correct_formula = 9989}
, audioId1 = 77, effectId_Grid = 10709}
bs_102101.ctor = function(self)
  -- function num : 0_0
end

bs_102101.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_102101_2", 10, self.OnAfterBattleStart)
end

bs_102101.OnAfterBattleStart = function(self)
  -- function num : 0_2 , upvalues : _ENV
  self.timerhurt = LuaSkillCtrl:StartTimer(nil, (self.arglist)[1], function()
    -- function num : 0_2_0 , upvalues : self, _ENV
    local tier = 0
    do
      if (self.arglist)[4] > 0 then
        local targetList = LuaSkillCtrl:CallTargetSelect(self, 2, 10)
        tier = targetList.Count * (self.arglist)[3]
      end
      local target_grid = LuaSkillCtrl:GetTargetWithGrid(3, 2)
      self.effectQ = LuaSkillCtrl:CallEffect(target_grid, (self.config).effectId_Grid, self)
      LuaSkillCtrl:StartTimer(nil, 7, function()
      -- function num : 0_2_0_0 , upvalues : _ENV, self, tier
      LuaSkillCtrl:PlayAuSource(self.caster, (self.config).audioId1)
      local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, self.caster, (self.config).AOE)
      LuaSkillCtrl:HurtResult(self, skillResult, (self.config).HurtConfig, {tier})
      skillResult:EndResult()
    end
)
    end
  end
, self, -1, 39)
end

bs_102101.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base, _ENV
  (base.OnCasterDie)(self)
  if self.timerhurt ~= nil then
    (self.timerhurt):Stop()
    self.timerhurt = nil
  end
  if self.loop ~= nil then
    LuaSkillCtrl:StopAudioByBack(self.loop)
    self.loop = nil
  end
end

bs_102101.LuaDispose = function(self)
  -- function num : 0_4 , upvalues : base
  (base.LuaDispose)(self)
  self.loop = nil
  self.effectQ = nil
end

return bs_102101


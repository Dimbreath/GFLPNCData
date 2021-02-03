-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_1063 = class("bs_1063", LuaSkillBase)
local base = LuaSkillBase
bs_1063.config = {buffId = 171, 
AOE = {effect_shape = 3, aoe_select_code = 4, aoe_range = 10}
, 
HurtConfig = {basehurt_formula = 10058, minhurt_formula = 9994, correct_formula = 9989}
, audioId1 = 77, effectGrid = 10709}
bs_1063.ctor = function(self)
  -- function num : 0_0
end

bs_1063.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_1063_2", 10, self.OnAfterBattleStart)
end

bs_1063.OnAfterBattleStart = function(self)
  -- function num : 0_2 , upvalues : _ENV
  self.loop = LuaSkillCtrl:PlayAuSource(self.caster, (self.config).audioId1)
  self.timerhurt = LuaSkillCtrl:StartTimer(nil, (self.arglist)[1], function()
    -- function num : 0_2_0 , upvalues : self, _ENV
    local tier = 0
    do
      if (self.arglist)[4] > 0 then
        local targetList = LuaSkillCtrl:CallTargetSelect(self, 2, 10)
        tier = targetList.Count * (self.arglist)[3]
      end
      local target_grid = LuaSkillCtrl:GetTargetWithGrid(3, 2)
      self.effectQ = LuaSkillCtrl:CallEffect(target_grid, (self.config).effectGrid, self)
      local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, self.caster, (self.config).AOE)
      LuaSkillCtrl:HurtResult(skillResult, (self.config).HurtConfig, {tier})
      skillResult:EndResult()
    end
  end
, self, -1)
end

bs_1063.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base, _ENV
  (base.OnCasterDie)(self)
  if self.timerhurt ~= nil then
    (self.timerhurt):Stop()
    self.timerhurt = nil
  end
  if self.loop ~= nil then
    AudioManager:StopAudioByBack(self.loop)
    self.loop = nil
  end
end

return bs_1063


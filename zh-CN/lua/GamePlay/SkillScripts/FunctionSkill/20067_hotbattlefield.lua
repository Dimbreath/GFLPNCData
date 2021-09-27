local bs_20067 = class("bs_20067", LuaSkillBase)
local base = LuaSkillBase
bs_20067.config = {buffId = 1166}
bs_20067.ctor = function(self)
  -- function num : 0_0
end

bs_20067.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_20067_1", 1, self.OnAfterBattleStart)
  LuaSkillCtrl:StartTimer(nil, 150, function()
    -- function num : 0_1_0 , upvalues : _ENV, self
    local targetList = LuaSkillCtrl:CallTargetSelect(self, 5, 0)
    if targetList ~= nil and targetList.Count > 0 then
      for i = 0, targetList.Count - 1 do
        local target = (targetList[i]).targetRole
        if target.intensity > 0 then
          LuaSkillCtrl:CallBuff(self, target, (self.config).buffId, 1, nil, true)
        end
      end
    end
  end
)
end

bs_20067.OnAfterBattleStart = function(self)
  -- function num : 0_2
end

bs_20067.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_20067


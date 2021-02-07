-- params : ...
-- function num : 0 , upvalues : _ENV
local Hotfix_LogicTimeBattleBuff = class("Hotfix_LogicTimeBattleBuff", HotfixBase)
local RefreshBuffDuration = function(self, init)
  -- function num : 0_0
  self:RefreshBuffDuration(init)
  self.curDuration = self.durationTime
end

Hotfix_LogicTimeBattleBuff.Register = function(self)
  -- function num : 0_1 , upvalues : _ENV, RefreshBuffDuration
  self:RegisterHotfix(CS.LogicTimeBattleBuff, "RefreshBuffDuration", RefreshBuffDuration, true)
end

return Hotfix_LogicTimeBattleBuff


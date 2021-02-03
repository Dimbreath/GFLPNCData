-- params : ...
-- function num : 0 , upvalues : _ENV
local Hotfix_BattleInitState = class("Hotfix_BattleInitState", HotfixBase)
;
(xlua.private_accessible)(CS.BattleInitState)
local CheckOrExchangePlayerPosNew = function(self, dynRole)
  -- function num : 0_0 , upvalues : _ENV
  if dynRole.x == (ConfigData.buildinConfig).BenchX then
    dynRole.onBench = true
  end
  return self:CheckOrExchangePlayerPos(dynRole)
end

Hotfix_BattleInitState.Register = function(self)
  -- function num : 0_1 , upvalues : _ENV, CheckOrExchangePlayerPosNew
  self:RegisterHotfix(CS.BattleInitState, "CheckOrExchangePlayerPos", CheckOrExchangePlayerPosNew, true)
end

return Hotfix_BattleInitState


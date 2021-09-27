local HotfixBattleInitState = class("HotfixBattleInitState", HotfixBase)
local cs_BattleInitState = CS.BattleInitState
local InitBossLifeBar = function(self)
  -- function num : 0_0
  if ((self.enemyTeamController).battleOriginRoleList).Count <= (self.CurBattleMapCfg).BossIndex then
    return 
  end
  self:InitBossLifeBar()
end

HotfixBattleInitState.Register = function(self)
  -- function num : 0_1 , upvalues : cs_BattleInitState, InitBossLifeBar
  self:RegisterHotfix(cs_BattleInitState, "InitBossLifeBar", InitBossLifeBar, true)
end

return HotfixBattleInitState


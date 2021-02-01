-- params : ...
-- function num : 0 , upvalues : _ENV
local PlayerLevelData = class("PlayerLevelData")
PlayerLevelData.ctor = function(self)
  -- function num : 0_0
  self.level = 1
  self.exp = 0
end

PlayerLevelData.UpdatePlayerLevelData = function(self, level, exp)
  -- function num : 0_1 , upvalues : _ENV
  if not level then
    level = 1
  end
  if not exp then
    exp = 0
  end
  if self.level == level and self.exp == exp then
    return 
  end
  if self.level ~= level then
    self:__AddLevelBunos(level)
    self.level = level
    ;
    (PlayerDataCenter.achivLevelData):UpdateLevelRewardRedDot()
  end
  self.exp = exp
  MsgCenter:Broadcast(eMsgEventId.UpdatePlayerLevel, false, true)
end

PlayerLevelData.GetNextLevelExp = function(self)
  -- function num : 0_2
  local cfg = self:GetAchivLevelCfg(self.level)
  return cfg.exp
end

PlayerLevelData.GetAchivLevelCfg = function(self, level)
  -- function num : 0_3 , upvalues : _ENV
  local cfg = (ConfigData.achievement_level)[level]
  if cfg == nil then
    error("can\'t find achievement_level by level, level = " .. tostring(level))
    return 
  end
  return cfg
end

PlayerLevelData.__AddLevelBunos = function(self, level)
  -- function num : 0_4 , upvalues : _ENV
  local levelCfg = self:GetAchivLevelCfg(level)
  for k,logic in ipairs(levelCfg.logic) do
    local para1 = (levelCfg.para1)[k]
    local para2 = (levelCfg.para2)[k]
    local para3 = (levelCfg.para3)[k]
    ;
    (PlayerDataCenter.playerBonus):InstallPlayerBonus(proto_csmsg_SystemFunctionID.SystemFunctionID_Achievement, 0, logic, para1, para2, para3)
  end
  ;
  (PlayerDataCenter.playerBonus):CheckPlayerBonusBroadcast()
end

return PlayerLevelData


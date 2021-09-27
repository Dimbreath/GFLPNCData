local base = require("Game.BattleDungeon.Data.DungeonDynPlayer")
local TdDungeonDynPlayer = class("TdDungeonDynPlayer", base)
local CS_BattleManager = (CS.BattleManager).Instance
TdDungeonDynPlayer.CreateTdDungeonPlayer = function(roles, playerData, dungeonCfg, lastDeployData, treeId)
  -- function num : 0_0 , upvalues : TdDungeonDynPlayer
  local player = (TdDungeonDynPlayer.New)()
  player.__lastHeroPos = lastDeployData and lastDeployData.hero_pos or nil
  player:InitDynPlayer(roles, dungeonCfg, playerData, treeId)
  return player
end

TdDungeonDynPlayer.InitDynPlayer = function(self, roles, dungeonCfg, playerData, treeId)
  -- function num : 0_1 , upvalues : _ENV
  local heroDatas = {}
  for k,v in pairs(roles) do
    heroDatas[k] = v.stc
  end
  self:InitHeroTeam(roles)
  self.playerSkillMp = (playerData.dyc).mp
  self.playerUltSkillMp = (playerData.dyc).hmp
  self.playerTDMp = (playerData.dyc).tdmp
  self:InitPlayerSkill((playerData.stc).skillGroup, treeId)
  local benchX = (ConfigData.buildinConfig).BenchX
  for k,dynHero in pairs(self.heroList) do
    dynHero:SetCoord(((roles[k]).dyc).coordination, benchX)
  end
  self:UpdateHeroAttr(heroDatas)
end

TdDungeonDynPlayer.ApplyPlayerDungeonRoleHpPer = function(self, csPlayerDungeonRoleHpPerDic)
  -- function num : 0_2 , upvalues : _ENV
  if csPlayerDungeonRoleHpPerDic == nil or csPlayerDungeonRoleHpPerDic.Count <= 0 then
    return 
  end
  self.dungeonRoleHpPerDic = {}
  for k,v in pairs(csPlayerDungeonRoleHpPerDic) do
    -- DECOMPILER ERROR at PC13: Confused about usage of register: R7 in 'UnsetPending'

    (self.dungeonRoleHpPerDic)[k] = v
  end
end

return TdDungeonDynPlayer


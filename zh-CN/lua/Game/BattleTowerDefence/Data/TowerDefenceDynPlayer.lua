local base = require("Game.Exploration.Data.DynPlayer")
local TowerDefenceDynPlayer = class("TowerDefenceDynPlayer", base)
local CS_BattleManager = (CS.BattleManager).Instance
TowerDefenceDynPlayer.UpdateFormationDetail = function(self, epRoleDyc)
  -- function num : 0_0 , upvalues : CS_BattleManager, _ENV
  if epRoleDyc.player ~= nil then
    if self.playerUltSkillMp ~= (epRoleDyc.player).hmp then
      self.playerUltSkillMp = (epRoleDyc.player).hmp
      local playerCtrl = CS_BattleManager:GetBattlePlayerController()
      if playerCtrl ~= nil then
        (playerCtrl.UltSkillHandle):UpdateUltMpFromItem(self.playerUltSkillMp)
      end
    end
    do
      if self.playerSkillMp ~= (epRoleDyc.player).mp then
        self.playerSkillMp = (epRoleDyc.player).mp
      end
      if self.playerTDMp ~= (epRoleDyc.player).tdmp then
        self.playerTDMp = (epRoleDyc.player).tdmp
      end
      CS_BattleManager:UpdatePlayerData()
      if epRoleDyc.role ~= nil then
        local benchX = (ConfigData.buildinConfig).BenchX
        for k,v in pairs((epRoleDyc.role).role) do
          local dynHero = self:GetDynHeroByUid(k)
          if dynHero == nil then
            error("Can\'t find dynHero, id = " .. tostring(k))
          else
            dynHero:UpdateHpPer((v.dync).hpPer)
            if (epRoleDyc.role).initial then
              dynHero:SetCoordXY(benchX, 0, benchX)
            else
              dynHero:SetCoord((v.dync).coordination, benchX)
            end
          end
        end
        CS_BattleManager:UpdateBattleRoleData()
        MsgCenter:Broadcast(eMsgEventId.OnEpPlayerHeroDataChange)
        self:RefreshCacheFightPower()
      end
    end
  end
end

TowerDefenceDynPlayer.ApplyPlayerDungeonRoleHpPer = function(self, csPlayerDungeonRoleHpPerDic)
  -- function num : 0_1 , upvalues : _ENV
  if csPlayerDungeonRoleHpPerDic == nil or csPlayerDungeonRoleHpPerDic.Count <= 0 then
    return 
  end
  self.dungeonRoleHpPerDic = {}
  for k,v in pairs(csPlayerDungeonRoleHpPerDic) do
    -- DECOMPILER ERROR at PC13: Confused about usage of register: R7 in 'UnsetPending'

    (self.dungeonRoleHpPerDic)[k] = v
  end
end

return TowerDefenceDynPlayer


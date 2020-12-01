-- params : ...
-- function num : 0 , upvalues : _ENV
local DynPlayer = class("DynPlayer")
local CommanderSkillData = require("Game.CommanderSkill.CommanderSkillData")
local ItemData = require("Game.PlayerData.Item.ItemData")
local ChipData = require("Game.PlayerData.Item.ChipData")
local DynHero = require("Game.Exploration.Data.DynHero")
local DynPlayerData = require("Game.PlayerData.DynPlayer.DynPlayerData")
local DynEpBuffChip = require("Game.Exploration.Data.DynEpBuffChip")
local DynBattleSkill = require("Game.Exploration.Data.DynBattleSkill")
local DynCampFetter = require("Game.Exploration.Data.DynCampFetter")
local DynEpBuff = require("Game.Exploration.Data.DynEpBuff")
local CS_BattleManager = (CS.BattleManager).Instance
local cs_GameData = (CS.GameData).instance
local ExplorationEnum = require("Game.Exploration.ExplorationEnum")
local MoneyId = 1
local UltMpId = 10
local banchPosArray = {1, 3, 2, 0, 4}
DynPlayer.ctor = function(self)
  -- function num : 0_0 , upvalues : DynPlayerData, _ENV
  self.money = 0
  self.energy = 0
  self.dynData = (DynPlayerData.New)()
  self.playerSkillMp = 0
  self.playerUltSkillMp = 0
  self.playerItemSkillDict = {}
  self.playerOriginSkillList = {}
  self.tempChips = {}
  self.ownedChips = {}
  self.dynName = self:__getDynName()
  self.allItemDic = {}
  self.allItemTypeDic = {}
  for k,v in pairs(eItemType) do
    -- DECOMPILER ERROR at PC28: Confused about usage of register: R6 in 'UnsetPending'

    (self.allItemTypeDic)[v] = {}
  end
  self.chipLimitInfo = {count = 0, limit = 0, firstLimit = true, discardId = nil}
  self.chipList = {}
  self.chipDic = {}
  self.chipSpecifyDic = {}
  self.epBuffChipDic = {}
  self.hiddenChipDic = {}
  self.campFetterDic = {}
  self.epBuffList = {}
  self.epSaveMoneyList = {}
  self.epCurPostion = nil
  self.epPath = {}
  self.epBattleSkillLockDic = {}
  self.__cacheFightPower = nil
  self.__isHeroInitReady = false
end

DynPlayer.CreateDefaultPlayer = function(self, epForm)
  -- function num : 0_1 , upvalues : _ENV
  local ok, heroDic, playerSkillDic, CST = PlayerDataCenter:TryGetFormation(epForm.formId)
  if not ok then
    error("Get Formation error!formationId:" .. tostring(epForm.formId))
    return 
  end
  self:InitDynPlayer(0, epForm.data, playerSkillDic, CST)
  self:UpdateFormationDetail(epForm)
end

DynPlayer.InitDynPlayerAttr = function(self, attrData)
  -- function num : 0_2
  if self.dynData == nil then
    return 
  end
  ;
  (self.dynData):RefreshDynData(attrData)
end

DynPlayer.InitDynPlayer = function(self, money, heroDatas, playerSkillDic, CST)
  -- function num : 0_3
  self.money = money
  self:InitHeroTeam(heroDatas)
  self:InitPlayerSkill(playerSkillDic, CST)
end

DynPlayer.__getDynName = function(self)
  -- function num : 0_4 , upvalues : _ENV
  return ConfigData:GetTipContent(TipContent.CommanderDPSName)
end

DynPlayer.InitHeroTeam = function(self, heroDatas)
  -- function num : 0_5 , upvalues : _ENV, DynHero
  self.heroList = {}
  self.heroDic = {}
  local tmpHeroIndexDic = {}
  local battleRoleCount = (ConfigData.game_config).max_stage_hero
  for heroId,heroElem in pairs(heroDatas) do
    if heroElem ~= nil then
      local heroTeamIndex = heroElem.idx
      local heroData = (PlayerDataCenter.heroDic)[heroId]
      if heroData ~= nil then
        local dynHeroData = (DynHero.New)(heroData)
        dynHeroData.onBench = battleRoleCount < heroTeamIndex
        -- DECOMPILER ERROR at PC29: Confused about usage of register: R12 in 'UnsetPending'

        ;
        (self.heroDic)[heroId] = dynHeroData
        tmpHeroIndexDic[dynHeroData] = heroTeamIndex
        ;
        (table.insert)(self.heroList, dynHeroData)
      else
        error("player not have hero:" .. tostring(heroId))
      end
    end
  end
  ;
  (table.sort)(self.heroList, function(hero1, hero2)
    -- function num : 0_5_0 , upvalues : tmpHeroIndexDic
    do return tmpHeroIndexDic[hero1] < tmpHeroIndexDic[hero2] end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  self:InitMirrorHeroTeam()
  -- DECOMPILER ERROR: 3 unprocessed JMP targets
end

DynPlayer.InitMirrorHeroTeam = function(self)
  -- function num : 0_6 , upvalues : _ENV, DynHero, DynPlayer
  self.mirrorHeroList = {}
  for k,dynHero in pairs(self.heroList) do
    local heroData = (PlayerDataCenter.heroDic)[dynHero.dataId]
    local dynHeroData = (DynHero.New)(heroData)
    ;
    (table.insert)(self.mirrorHeroList, dynHeroData)
  end
  self.mirrorDynPlayer = (DynPlayer.New)()
end

DynPlayer.GetDeployAliveHeroCount = function(self)
  -- function num : 0_7 , upvalues : _ENV
  local count = 0
  for k,dynHero in pairs(self.heroList) do
    if not dynHero.onBench and not dynHero:IsDead() then
      count = count + 1
    end
  end
  return count
end

DynPlayer.InitPlayerSkill = function(self, playerSkillDic, CST)
  -- function num : 0_8 , upvalues : _ENV, DynBattleSkill, ExplorationEnum, CommanderSkillData
  self.playerOriginSkillList = {}
  if playerSkillDic ~= nil then
    for k,skillId in pairs(playerSkillDic) do
      local data = (DynBattleSkill.New)(skillId, 1, (ExplorationEnum.eBattleSkillType).Original)
      ;
      (table.insert)(self.playerOriginSkillList, data)
    end
  end
  do
    if PlayerDataCenter.CommanderSkillModualData ~= nil and CST ~= nil then
      local treeData = ((PlayerDataCenter.CommanderSkillModualData).CommanderSkillTreeDataDic)[CST.treeId]
      if treeData.commanderSkillDataDic ~= nil then
        for skillId,skillData in pairs(treeData.commanderSkillDataDic) do
          if skillData.isUnlock and skillData.type == (CommanderSkillData.skillType).passive then
            local data = (DynBattleSkill.New)(skillId, 1, (ExplorationEnum.eBattleSkillType).Original)
            ;
            (table.insert)(self.playerOriginSkillList, data)
          end
        end
      end
      do
        local masterSkillDic = (CST.saving).skillProficient
        if masterSkillDic ~= nil then
          for skillId,data in pairs(masterSkillDic) do
            local data = (DynBattleSkill.New)(skillId, data.level, (ExplorationEnum.eBattleSkillType).Original)
            ;
            (table.insert)(self.playerOriginSkillList, data)
          end
        end
      end
    end
  end
end

DynPlayer.ContainChip = function(self, chipData)
  -- function num : 0_9
  local contain = (self.ownedChips)[chipData] ~= nil
  do return contain end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

DynPlayer.AddChip = function(self, chipData)
  -- function num : 0_10
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R2 in 'UnsetPending'

  (self.ownedChips)[chipData] = true
end

DynPlayer.RemoveChip = function(self, chipData)
  -- function num : 0_11
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R2 in 'UnsetPending'

  (self.ownedChips)[chipData] = nil
end

DynPlayer.GetItemSkillList = function(self)
  -- function num : 0_12 , upvalues : _ENV
  local skillList = {}
  local skillDic = {}
  for k,v in pairs(self.playerItemSkillDict) do
    local oldSkill = skillDic[k.dataId]
    if oldSkill == nil or oldSkill.level < k.level then
      if oldSkill then
        (table.removebyvalue)(skillList, oldSkill)
      end
      ;
      (table.insert)(skillList, k)
      skillDic[k.dataId] = k
    end
  end
  return skillList
end

DynPlayer.GetItemSkillDic = function(self)
  -- function num : 0_13
  return self.playerItemSkillDict
end

DynPlayer.AddItemSkill = function(self, dynSkill)
  -- function num : 0_14
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R2 in 'UnsetPending'

  (self.playerItemSkillDict)[dynSkill] = true
end

DynPlayer.RemoveItemSkill = function(self, dynSkill)
  -- function num : 0_15
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R2 in 'UnsetPending'

  (self.playerItemSkillDict)[dynSkill] = nil
end

DynPlayer.ContainTempChip = function(self, tempChip)
  -- function num : 0_16
  local contain = (self.tempChips)[tempChip] ~= nil
  do return contain end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

DynPlayer.AddTempChip = function(self, tempChip)
  -- function num : 0_17
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R2 in 'UnsetPending'

  (self.tempChips)[tempChip] = true
end

DynPlayer.RemoveTempChip = function(self, tempChip)
  -- function num : 0_18
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R2 in 'UnsetPending'

  (self.tempChips)[tempChip] = nil
end

DynPlayer.DeployHeroTeam = function(self, stageCfg)
  -- function num : 0_19 , upvalues : _ENV, banchPosArray
  local longRangeRoles = {}
  local defendRoles = {}
  local benchRoles = {}
  for k,heroData in pairs(self.heroList) do
    if heroData.onBench then
      (table.insert)(benchRoles, heroData)
    else
      if heroData.attackRange <= 1 then
        (table.insert)(defendRoles, heroData)
      else
        ;
        (table.insert)(longRangeRoles, heroData)
      end
    end
  end
  local mapSizeX = stageCfg.size_row
  local mapDeployX = stageCfg.deploy_rows
  local mapSizeY = stageCfg.size_col
  local deployDic = {}
  local totalHeroCount = #self.heroList
  local defendRoleCount = #defendRoles
  local longRangeRoleCount = #longRangeRoles
  if defendRoleCount > 3 or longRangeRoleCount > 3 then
    if #defendRoles > 0 then
      for x = mapDeployX - 1, 0, -1 do
        for y = 0, mapSizeY - 1 do
          if #defendRoles ~= 0 then
            local coord = x << 16 | y
            if not deployDic[coord] then
              deployDic[coord] = true
              local role = (table.remove)(defendRoles)
              role:SetCoordXY(x, y, mapSizeX)
            end
            do
              -- DECOMPILER ERROR at PC73: LeaveBlock: unexpected jumping out IF_THEN_STMT

              -- DECOMPILER ERROR at PC73: LeaveBlock: unexpected jumping out IF_STMT

            end
          end
        end
      end
    end
    do
      if #longRangeRoles > 0 then
        for x = 0, mapDeployX - 1 do
          for y = 0, mapSizeY - 1 do
            if #longRangeRoles ~= 0 then
              local coord = x << 16 | y
              if not deployDic[coord] then
                deployDic[coord] = true
                local role = (table.remove)(longRangeRoles)
                role:SetCoordXY(x, y, mapSizeX)
              end
              do
                -- DECOMPILER ERROR at PC104: LeaveBlock: unexpected jumping out IF_THEN_STMT

                -- DECOMPILER ERROR at PC104: LeaveBlock: unexpected jumping out IF_STMT

              end
            end
          end
        end
      end
      do
        do
          local index = 1
          for k,role in pairs(benchRoles) do
            role:SetCoordXY(mapSizeX, banchPosArray[index], mapSizeX)
            index = index + 1
          end
          do return  end
          if defendRoleCount > 0 then
            local curRow = mapDeployX - 1
            if totalHeroCount <= defendRoleCount then
              curRow = 0
            end
            if defendRoleCount > 2 then
              for c = mapSizeY - 1, 0, -1 do
                -- DECOMPILER ERROR at PC140: Unhandled construct in 'MakeBoolean' P1

                if c % 2 == 0 and #defendRoles ~= 0 then
                  local coord = curRow << 16 | c
                  if not deployDic[coord] then
                    deployDic[coord] = true
                    local role = (table.remove)(defendRoles)
                    role:SetCoordXY(curRow, c, mapSizeX)
                  end
                  do
                    -- DECOMPILER ERROR at PC153: LeaveBlock: unexpected jumping out IF_THEN_STMT

                    -- DECOMPILER ERROR at PC153: LeaveBlock: unexpected jumping out IF_STMT

                  end
                end
              end
            else
              if defendRoleCount == 2 then
                if totalHeroCount - defendRoleCount == 3 then
                  local role = (table.remove)(defendRoles)
                  role:SetCoordXY(1, 0, mapSizeX)
                  role = (table.remove)(defendRoles)
                  role:SetCoordXY(1, 4, mapSizeX)
                else
                  do
                    for c = mapSizeY - 1, 0, -1 do
                      -- DECOMPILER ERROR at PC192: Unhandled construct in 'MakeBoolean' P1

                      if c % 2 == 1 and #defendRoles ~= 0 then
                        local coord = curRow << 16 | c
                        if not deployDic[coord] then
                          deployDic[coord] = true
                          local role = (table.remove)(defendRoles)
                          role:SetCoordXY(curRow, c, mapSizeX)
                        end
                        do
                          -- DECOMPILER ERROR at PC205: LeaveBlock: unexpected jumping out IF_THEN_STMT

                          -- DECOMPILER ERROR at PC205: LeaveBlock: unexpected jumping out IF_STMT

                        end
                      end
                    end
                    if defendRoleCount == 1 then
                      local curCow = (mapSizeY - 1) // 2
                      local coord = curRow << 16 | curCow
                      if not deployDic[coord] then
                        deployDic[coord] = true
                        local role = (table.remove)(defendRoles)
                        role:SetCoordXY(curRow, curCow, mapSizeX)
                      end
                    end
                    do
                      if longRangeRoleCount > 0 then
                        local curRow = 0
                        if longRangeRoleCount >= 5 then
                          for c = mapSizeY - 1, 0, -1 do
                            if #longRangeRoles ~= 0 then
                              local coord = curRow << 16 | c
                              if not deployDic[coord] then
                                deployDic[coord] = true
                                local role = (table.remove)(longRangeRoles)
                                role:SetCoordXY(curRow, c, mapSizeX)
                              end
                              do
                                -- DECOMPILER ERROR at PC253: LeaveBlock: unexpected jumping out IF_THEN_STMT

                                -- DECOMPILER ERROR at PC253: LeaveBlock: unexpected jumping out IF_STMT

                              end
                            end
                          end
                        else
                          if longRangeRoleCount == 4 then
                            for c = 0, 1 do
                              if #longRangeRoles ~= 0 then
                                local coord = curRow << 16 | c
                                if not deployDic[coord] then
                                  deployDic[coord] = true
                                  local role = (table.remove)(longRangeRoles)
                                  role:SetCoordXY(curRow, c, mapSizeX)
                                end
                                do
                                  -- DECOMPILER ERROR at PC279: LeaveBlock: unexpected jumping out IF_THEN_STMT

                                  -- DECOMPILER ERROR at PC279: LeaveBlock: unexpected jumping out IF_STMT

                                end
                              end
                            end
                            for c = mapSizeY - 1, 3, -1 do
                              if #longRangeRoles ~= 0 then
                                local coord = curRow << 16 | c
                                if not deployDic[coord] then
                                  deployDic[coord] = true
                                  local role = (table.remove)(longRangeRoles)
                                  role:SetCoordXY(curRow, c, mapSizeX)
                                end
                                do
                                  -- DECOMPILER ERROR at PC302: LeaveBlock: unexpected jumping out IF_THEN_STMT

                                  -- DECOMPILER ERROR at PC302: LeaveBlock: unexpected jumping out IF_STMT

                                end
                              end
                            end
                          else
                            if longRangeRoleCount == 3 then
                              for c = mapSizeY - 1, 0, -1 do
                                -- DECOMPILER ERROR at PC318: Unhandled construct in 'MakeBoolean' P1

                                if c % 2 == 0 and #longRangeRoles ~= 0 then
                                  local coord = curRow << 16 | c
                                  if not deployDic[coord] then
                                    deployDic[coord] = true
                                    local role = (table.remove)(longRangeRoles)
                                    role:SetCoordXY(curRow, c, mapSizeX)
                                  end
                                  do
                                    -- DECOMPILER ERROR at PC331: LeaveBlock: unexpected jumping out IF_THEN_STMT

                                    -- DECOMPILER ERROR at PC331: LeaveBlock: unexpected jumping out IF_STMT

                                  end
                                end
                              end
                            else
                              if longRangeRoleCount == 2 then
                                if defendRoleCount > 0 then
                                  if #longRangeRoles > 0 then
                                    local coord = curRow << 16 | 0
                                    if not deployDic[coord] then
                                      deployDic[coord] = true
                                      local role = (table.remove)(longRangeRoles)
                                      role:SetCoordXY(curRow, 0, mapSizeX)
                                    end
                                  end
                                  do
                                    if #longRangeRoles > 0 then
                                      local coord = curRow << 16 | mapSizeY - 1
                                      if not deployDic[coord] then
                                        deployDic[coord] = true
                                        local role = (table.remove)(longRangeRoles)
                                        role:SetCoordXY(curRow, mapSizeY - 1, mapSizeX)
                                      end
                                    end
                                    do
                                      for c = mapSizeY - 1, 0, -1 do
                                        -- DECOMPILER ERROR at PC387: Unhandled construct in 'MakeBoolean' P1

                                        if c % 2 == 1 and #longRangeRoles ~= 0 then
                                          local coord = curRow << 16 | c
                                          if not deployDic[coord] then
                                            deployDic[coord] = true
                                            local role = (table.remove)(longRangeRoles)
                                            role:SetCoordXY(curRow, c, mapSizeX)
                                          end
                                          do
                                            -- DECOMPILER ERROR at PC400: LeaveBlock: unexpected jumping out IF_THEN_STMT

                                            -- DECOMPILER ERROR at PC400: LeaveBlock: unexpected jumping out IF_STMT

                                          end
                                        end
                                      end
                                      if longRangeRoleCount == 1 and #longRangeRoles > 0 then
                                        local curCow = (mapSizeY - 1) // 2
                                        local coord = curRow << 16 | curCow
                                        if not deployDic[coord] then
                                          deployDic[coord] = true
                                          local role = (table.remove)(longRangeRoles)
                                          role:SetCoordXY(curRow, curCow, mapSizeX)
                                        end
                                      end
                                      do
                                        local index = 1
                                        for k,role in pairs(benchRoles) do
                                          role:SetCoordXY(mapSizeX, banchPosArray[index], mapSizeX)
                                          index = index + 1
                                        end
                                      end
                                    end
                                  end
                                end
                              end
                            end
                          end
                        end
                      end
                    end
                  end
                end
              end
            end
          end
        end
      end
    end
  end
end

DynPlayer.RefreshCacheFightPower = function(self)
  -- function num : 0_20 , upvalues : _ENV
  if not self.__isHeroInitReady then
    return 
  end
  local curPower = self:GetTotalFightingPower()
  if self.__cacheFightPower == curPower then
    return 
  end
  self.__cacheFightPower = curPower
  MsgCenter:Broadcast(eMsgEventId.OnEpPlayerFightPowerChang, curPower)
end

DynPlayer.GetCacheFightPower = function(self)
  -- function num : 0_21
  return self.__cacheFightPower or 0
end

DynPlayer.UpdateHeroAttr = function(self, heroBattleData)
  -- function num : 0_22 , upvalues : _ENV
  for k,dynHero in ipairs(self.heroList) do
    local battle = heroBattleData[dynHero.dataId]
    if battle ~= nil then
      dynHero:UpdateBaseHeroData(battle.attr, battle.baseSkill, battle.athSkill)
      local mirrorDynHero = (self.mirrorHeroList)[k]
      mirrorDynHero:UpdateBaseHeroData(battle.attr, battle.baseSkill, battle.athSkill)
    end
  end
  self.__isHeroInitReady = true
  self:RefreshCacheFightPower()
end

DynPlayer.UpdateOperatorDetail = function(self, operatorDetail)
  -- function num : 0_23
  self.operatorDetail = operatorDetail
end

DynPlayer.GetOperatorDetail = function(self)
  -- function num : 0_24
  return self.operatorDetail
end

DynPlayer.GetOperatorDetailState = function(self)
  -- function num : 0_25
  return (self.operatorDetail).state
end

DynPlayer.UpdateEpBackpack = function(self, epBackpack)
  -- function num : 0_26 , upvalues : _ENV, ItemData, MoneyId, UltMpId, CS_BattleManager
  if epBackpack == nil then
    return 
  end
  self.allItemDic = {}
  for k,v in pairs(self.allItemTypeDic) do
    -- DECOMPILER ERROR at PC11: Confused about usage of register: R7 in 'UnsetPending'

    (self.allItemTypeDic)[k] = {}
  end
  for k,num in pairs(epBackpack.item) do
    local itemData = (ItemData.New)(k, num)
    -- DECOMPILER ERROR at PC23: Confused about usage of register: R8 in 'UnsetPending'

    ;
    (self.allItemDic)[k] = itemData
    local typeDic = (self.allItemTypeDic)[itemData.type]
    if typeDic == nil then
      error("Can\'t find itemType:" .. tostring(itemData.type))
    else
      typeDic[k] = itemData
    end
  end
  local focusItemNum = self:GetItemCount((ConfigData.game_config).RandomBeforeBatteleRejudgeItem) or 0
  local focusLimit = epBackpack.focusLimit or 0
  if self.focusItemNum ~= focusItemNum or self.focusLimit ~= focusLimit then
    self.focusItemNum = focusItemNum
    self.focusLimit = focusLimit
    MsgCenter:Broadcast(eMsgEventId.EpFocusPointChange, self.focusItemNum, focusLimit)
  end
  local money = self:GetItemCount(MoneyId)
  if self.money ~= money then
    self.money = money
    MsgCenter:Broadcast(eMsgEventId.EpMoneyChange, self.money)
  end
  local ultMp = self:GetItemCount(UltMpId)
  if self.playerUltSkillMp ~= ultMp then
    self.playerUltSkillMp = ultMp
    local playerCtrl = CS_BattleManager:GetBattlePlayerController()
    if playerCtrl ~= nil then
      (playerCtrl.UltSkillHandle):UpdateUltMpFromItem(self.playerUltSkillMp)
    end
  end
  do
    if epBackpack.algData ~= nil then
      if ExplorationManager.epCtrl ~= nil then
        (ExplorationManager.epCtrl):RollbackNormalChipBattleRoom()
        ;
        (ExplorationManager.epCtrl):RollbackTempChipCurBattleRoom(self.epBuffChipDic)
        ;
        (ExplorationManager.epCtrl):RollbackTempChipCurBattleRoom(self.hiddenChipDic)
        ;
        (ExplorationManager.epCtrl):RollbackTempChipNextBattleRoom(self.hiddenChipDic)
      end
      for k,chipData in pairs(self.chipDic) do
        self:__RollBackChipInternal(chipData)
      end
      self.chipDic = {}
      for k,chipData in pairs(self.chipSpecifyDic) do
        self:__RollBackChipInternal(chipData)
      end
      self.chipSpecifyDic = {}
      for k,buffChip in pairs(self.epBuffChipDic) do
        self:__RollBackBuffChip(buffChip)
      end
      self.epBuffChipDic = {}
      for k,buffChip in pairs(self.hiddenChipDic) do
        self:__RollBackBuffChip(buffChip)
      end
      self.hiddenChipDic = {}
      self.chipList = {}
      self:__UpdateAllChip((epBackpack.algData).alg, nil, (epBackpack.algData).tmpAlg, nil, (epBackpack.algData).hiddenAlg, nil)
    end
    -- DECOMPILER ERROR at PC186: Confused about usage of register: R6 in 'UnsetPending'

    if epBackpack.algUpperLimit ~= (self.chipLimitInfo).limit then
      (self.chipLimitInfo).limit = epBackpack.algUpperLimit
      MsgCenter:Broadcast(eMsgEventId.OnChipLimitChange)
    end
  end
end

DynPlayer.UpdateChipDiff = function(self, diffData)
  -- function num : 0_27
  self:__UpdateAllChip(diffData.update, diffData.delete, diffData.tmpUpdate, diffData.tmpDelete, diffData.hiddenUpdate, diffData.hiddenDelete)
end

DynPlayer.__UpdateAllChip = function(self, chipUpdate, chipDelete, tmpChipUpdate, tmpChipDelete, hiddenUpdate, hiddenDelete)
  -- function num : 0_28 , upvalues : _ENV, ChipData, DynEpBuffChip, CS_BattleManager
  local haveHiddenChipUpdate = (hiddenUpdate ~= nil and (table.count)(hiddenUpdate) > 0) or (hiddenDelete ~= nil and (table.count)(hiddenDelete) > 0)
  if ExplorationManager.epCtrl ~= nil then
    (ExplorationManager.epCtrl):RollbackNormalChipBattleRoom()
    if haveHiddenChipUpdate then
      (ExplorationManager.epCtrl):RollbackTempChipCurBattleRoom(self.hiddenChipDic)
      ;
      (ExplorationManager.epCtrl):RollbackTempChipNextBattleRoom(self.hiddenChipDic)
    end
  end
  local haveTmpChipUpdate = false
  if (tmpChipUpdate ~= nil and (table.count)(tmpChipUpdate) > 0) or tmpChipDelete ~= nil and (table.count)(tmpChipDelete) > 0 then
    haveTmpChipUpdate = true
    if ExplorationManager.epCtrl ~= nil then
      (ExplorationManager.epCtrl):RollbackTempChipCurBattleRoom(self.epBuffChipDic)
    end
  end
  if chipDelete ~= nil then
    for k,v in pairs(chipDelete) do
      local chipId = k >> 32
      local heroId = k & CommonUtil.UInt32Max
      if heroId > 0 then
        local chipData = (self.chipSpecifyDic)[k]
        if chipData ~= nil then
          self:__RollBackChipInternal(chipData)
        end
        -- DECOMPILER ERROR at PC85: Confused about usage of register: R17 in 'UnsetPending'

        ;
        (self.chipSpecifyDic)[k] = nil
      else
        local chipData = (self.chipDic)[chipId]
        if chipData ~= nil then
          self:__RollBackChipInternal(chipData)
        end
        -- DECOMPILER ERROR at PC95: Confused about usage of register: R17 in 'UnsetPending'

        ;
        (self.chipDic)[chipId] = nil
      end
    end
  end
  if tmpChipDelete ~= nil then
    for chipId,num in pairs(tmpChipDelete) do
      local buffChip = (self.epBuffChipDic)[chipId]
      if buffChip ~= nil then
        self:__RollBackBuffChip(buffChip)
      end
      -- DECOMPILER ERROR at PC112: Confused about usage of register: R15 in 'UnsetPending'

      ;
      (self.epBuffChipDic)[chipId] = nil
    end
  end
  if hiddenDelete ~= nil then
    for chipId,num in pairs(hiddenDelete) do
      local buffChip = (self.hiddenChipDic)[chipId]
      if buffChip ~= nil then
        self:__RollBackBuffChip(buffChip)
      end
      -- DECOMPILER ERROR at PC129: Confused about usage of register: R15 in 'UnsetPending'

      ;
      (self.hiddenChipDic)[chipId] = nil
    end
  end
  if chipUpdate ~= nil then
    for k,num in pairs(chipUpdate) do
      local chipId = k >> 32
      local heroId = k & CommonUtil.UInt32Max
      if heroId > 0 then
        local chipData = (self.chipSpecifyDic)[k]
        if chipData ~= nil then
          self:__RollBackChipInternal(chipData)
          chipData:SetCount(num)
          self:__ExecuteChipInternal(chipData)
        else
          local dynHero = (self.heroDic)[heroId]
          if dynHero == nil then
            error("Can\'t find dynHero, id = " .. tostring(heroId))
          else
            local chipData = (ChipData.NewChipForOneHero)(dynHero, chipId, num)
            -- DECOMPILER ERROR at PC176: Confused about usage of register: R19 in 'UnsetPending'

            ;
            (self.chipSpecifyDic)[k] = chipData
            self:__ExecuteChipInternal(chipData)
          end
        end
      else
        local chipData = (self.chipDic)[chipId]
        if chipData ~= nil then
          self:__RollBackChipInternal(chipData)
          chipData:SetCount(num)
          self:__ExecuteChipInternal(chipData)
        else
          local chipData = (ChipData.New)(chipId, num)
          -- DECOMPILER ERROR at PC200: Confused about usage of register: R18 in 'UnsetPending'

          ;
          (self.chipDic)[chipId] = chipData
          self:__ExecuteChipInternal(chipData)
        end
      end
    end
  end
  if tmpChipUpdate ~= nil then
    for chipId,num in pairs(tmpChipUpdate) do
      local buffChip = (self.epBuffChipDic)[chipId]
      if buffChip ~= nil then
        self:__RollBackBuffChip(buffChip)
        buffChip:SetCount(num)
        self:__ExecuteBuffChip(buffChip)
      else
        local buffChip = (DynEpBuffChip.New)(chipId, num)
        -- DECOMPILER ERROR at PC231: Confused about usage of register: R16 in 'UnsetPending'

        ;
        (self.epBuffChipDic)[chipId] = buffChip
        self:__ExecuteBuffChip(buffChip)
      end
    end
  end
  if hiddenUpdate ~= nil then
    for chipId,num in pairs(hiddenUpdate) do
      local buffChip = (self.hiddenChipDic)[chipId]
      if buffChip ~= nil then
        self:__RollBackBuffChip(buffChip)
        buffChip:SetCount(num)
        self:__ExecuteBuffChip(buffChip)
      else
        local buffChip = (DynEpBuffChip.New)(chipId, num)
        -- DECOMPILER ERROR at PC262: Confused about usage of register: R16 in 'UnsetPending'

        ;
        (self.hiddenChipDic)[chipId] = buffChip
        self:__ExecuteBuffChip(buffChip)
      end
    end
  end
  local chipList = {}
  for chipId,chipData in pairs(self.chipDic) do
    (table.insert)(chipList, chipData)
  end
  for k,chipData in pairs(self.chipSpecifyDic) do
    (table.insert)(chipList, chipData)
  end
  self.chipList = chipList
  self:__SortChipList()
  self:UpdateChipLimitNum()
  if ExplorationManager.epCtrl ~= nil then
    (ExplorationManager.epCtrl):ExecuteNormalChipBattleRoom()
    if haveHiddenChipUpdate then
      (ExplorationManager.epCtrl):ExecuteTempChipCurBattleRoom(self.hiddenChipDic)
      ;
      (ExplorationManager.epCtrl):ExecuteTempChipNextBattleRoom(self.hiddenChipDic)
    end
  end
  if haveTmpChipUpdate and ExplorationManager.epCtrl ~= nil then
    (ExplorationManager.epCtrl):ExecuteTempChipCurBattleRoom(self:GetEpBuffChipDic())
  end
  CS_BattleManager:UpdateBattleRoleData()
  MsgCenter:Broadcast(eMsgEventId.OnEpChipListChange, self.chipList)
  self:RefreshCacheFightPower()
  -- DECOMPILER ERROR: 32 unprocessed JMP targets
end

DynPlayer.__SortChipList = function(self)
  -- function num : 0_29 , upvalues : _ENV
  (table.sort)(self.chipList, function(a, b)
    -- function num : 0_29_0
    do return a.dataId < b.dataId end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
end

DynPlayer.SetChipDiscardId = function(self, id)
  -- function num : 0_30
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R2 in 'UnsetPending'

  (self.chipLimitInfo).discardId = id
end

DynPlayer.GetChipDiscardId = function(self)
  -- function num : 0_31
  return (self.chipLimitInfo).discardId
end

DynPlayer.GetChipDiscardLimit = function(self)
  -- function num : 0_32
  return (self.chipLimitInfo).limit
end

DynPlayer.UpdateChipLimitNum = function(self)
  -- function num : 0_33 , upvalues : _ENV
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R1 in 'UnsetPending'

  (self.chipLimitInfo).count = (table.count)(self.chipDic)
end

DynPlayer.IsChipOverLimitNum = function(self)
  -- function num : 0_34
  do return (self.chipLimitInfo).limit < (self.chipLimitInfo).count, (self.chipLimitInfo).count, (self.chipLimitInfo).limit end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

DynPlayer.GetItemBag = function(self, type)
  -- function num : 0_35
  return (self.allItemTypeDic)[type]
end

DynPlayer.GetItemCount = function(self, dataId)
  -- function num : 0_36
  local itemData = self:GetItemById(dataId)
  if itemData ~= nil or not 0 then
    return itemData:GetCount()
  end
end

DynPlayer.GetItemCountByType = function(self, type, dataId)
  -- function num : 0_37
  local itemData = self:GetItemById(type, dataId)
  if itemData ~= nil or not 0 then
    return itemData:GetCount()
  end
end

DynPlayer.GetItemById = function(self, dataId)
  -- function num : 0_38 , upvalues : _ENV
  local itemCfg = (ConfigData.item)[dataId]
  if itemCfg == nil then
    error("item cfg is null,Id:" .. tostring(dataId))
    return 
  end
  return (self.allItemDic)[dataId]
end

DynPlayer.GetMoneyIconId = function(self)
  -- function num : 0_39 , upvalues : _ENV, MoneyId
  local cfg = (ConfigData.item)[MoneyId]
  return cfg ~= nil and cfg.icon or nil
end

DynPlayer.GetMoneyCount = function(self)
  -- function num : 0_40
  return self.money
end

DynPlayer.GetChipList = function(self)
  -- function num : 0_41
  return self.chipList
end

DynPlayer.GetChipLimitInfo = function(self)
  -- function num : 0_42
  return self.chipLimitInfo
end

DynPlayer.GetNormalChipDic = function(self)
  -- function num : 0_43
  return self.chipDic
end

DynPlayer.GetEpBuffChipDic = function(self)
  -- function num : 0_44
  return self.epBuffChipDic
end

DynPlayer.GetHiddenChipDic = function(self)
  -- function num : 0_45
  return self.hiddenChipDic
end

DynPlayer.__RollBackChipInternal = function(self, chipData, isMirror)
  -- function num : 0_46 , upvalues : _ENV
  if isMirror then
    if (self.mirrorDynPlayer):ContainChip(chipData) then
      chipData:RollbackChipDynPlayer(self.mirrorDynPlayer)
      return 
    end
    for k,v in pairs(self.mirrorHeroList) do
      chipData:RollbackChipHero(v)
    end
  else
    do
      if self:ContainChip(chipData) then
        chipData:RollbackChipDynPlayer(self)
        return 
      end
      for k,v in pairs(self.heroList) do
        chipData:RollbackChipHero(v)
      end
    end
  end
end

DynPlayer.__ExecuteChipInternal = function(self, chipData, isMirror)
  -- function num : 0_47 , upvalues : _ENV
  local isForDynPlayer = chipData:IsValidDynPlayer()
  if isForDynPlayer then
    if isMirror then
      chipData:ExecuteChipDynPlayer(self.mirrorDynPlayer)
    else
      chipData:ExecuteChipDynPlayer(self)
    end
    return 
  end
  local validRoleList = nil
  if isMirror then
    validRoleList = chipData:GetValidRoleList(self.mirrorHeroList, eBattleRoleBelong.player)
  else
    validRoleList = chipData:GetValidRoleList(self.heroList, eBattleRoleBelong.player)
  end
  for k,v in pairs(validRoleList) do
    chipData:ExecuteChipHero(v)
  end
end

DynPlayer.ExecuteChip = function(self, chipData, isOwnData)
  -- function num : 0_48 , upvalues : _ENV
  local oldChip = nil
  if chipData:IsCopyItem() then
    oldChip = (self.chipSpecifyDic)[chipData.dataId]
  else
    oldChip = (self.chipDic)[chipData.dataId]
  end
  if oldChip ~= nil then
    self:__RollBackChipInternal(oldChip)
    if not isOwnData or not 1 then
      local count = chipData:GetCount()
    end
    oldChip:AddCount(count)
    self:__ExecuteChipInternal(oldChip)
  else
    do
      self:__ExecuteChipInternal(chipData)
      -- DECOMPILER ERROR at PC40: Confused about usage of register: R4 in 'UnsetPending'

      if chipData:IsCopyItem() then
        (self.chipSpecifyDic)[chipData.dataId] = chipData
      else
        -- DECOMPILER ERROR at PC44: Confused about usage of register: R4 in 'UnsetPending'

        ;
        (self.chipDic)[chipData.dataId] = chipData
      end
      ;
      (table.insert)(self.chipList, chipData)
      ;
      (table.sort)(self.chipList, function(a, b)
    -- function num : 0_48_0
    do return a.dataId < b.dataId end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
    end
  end
end

DynPlayer.RollBackChip = function(self, chipData, isOwnData)
  -- function num : 0_49 , upvalues : _ENV
  local oldChip = nil
  if chipData:IsCopyItem() then
    oldChip = (self.chipSpecifyDic)[chipData.dataId]
  else
    oldChip = (self.chipDic)[chipData.dataId]
  end
  if oldChip ~= nil then
    if not isOwnData or not 1 then
      local chipCount = chipData:GetCount()
    end
    local count = oldChip:GetCount() - chipCount
    if count < 0 then
      error("Chip:卸载的数量大于已有的数量")
      return 
    end
    self:__RollBackChipInternal(oldChip)
    if count > 0 then
      oldChip:SetCount(count)
      self:__ExecuteChipInternal(oldChip)
    else
      -- DECOMPILER ERROR at PC48: Confused about usage of register: R6 in 'UnsetPending'

      if chipData:IsCopyItem() then
        (self.chipSpecifyDic)[chipData.dataId] = nil
      else
        -- DECOMPILER ERROR at PC52: Confused about usage of register: R6 in 'UnsetPending'

        ;
        (self.chipDic)[chipData.dataId] = nil
      end
      ;
      (table.removebyvalue)(self.chipList, oldChip)
    end
  else
    do
      error("没有该芯片可以卸载,id = " .. tostring(chipData.dataId))
    end
  end
end

DynPlayer.__RollBackBuffChip = function(self, buffChip)
  -- function num : 0_50 , upvalues : _ENV
  if self:ContainTempChip(buffChip) then
    buffChip:RollbackChipDynPlayer(self)
    return 
  end
  for k,v in pairs(self.heroList) do
    buffChip:RollbackChipHero(v)
  end
end

DynPlayer.__ExecuteBuffChip = function(self, buffChip)
  -- function num : 0_51 , upvalues : _ENV
  if buffChip:IsValidDynPlayer() then
    buffChip:ExecuteChipDynPlayer(self)
    return 
  end
  local validRoleList = buffChip:GetValidRoleList(self.heroList, eBattleRoleBelong.player)
  for k,v in pairs(validRoleList) do
    buffChip:ExecuteChipHero(v)
  end
end

DynPlayer.GetChipCount = function(self, chipId)
  -- function num : 0_52
  local chipData = (self.chipDic)[chipId]
  if chipData ~= nil then
    return chipData:GetCount()
  else
    return 0
  end
end

DynPlayer.GetChipCombatEffect = function(self, chipData, isOwnData)
  -- function num : 0_53
  local originPower = self:GetMirrorTeamFightPower(true, true)
  local oldPower = self:GetTotalFightingPower(true, true)
  self:ExecuteChip(chipData, isOwnData)
  local powerChange = self:GetTotalFightingPower(true, true) - oldPower
  self:RollBackChip(chipData, isOwnData)
  local combatEffect = 0
  if originPower > 0 then
    combatEffect = powerChange / originPower
  end
  return combatEffect
end

DynPlayer.GetChipOriginFightPower = function(self, chipData)
  -- function num : 0_54
  local originPower = self:GetMirrorTeamFightPower(true, true)
  self:__ExecuteChipInternal(chipData, true)
  local newPower = self:GetMirrorTeamFightPower(true, true)
  self:__RollBackChipInternal(chipData, true)
  local powerChange = newPower - originPower
  if originPower <= 0 then
    return 0
  end
  return powerChange / originPower
end

DynPlayer.GetMirrorTeamFightPower = function(self, fullHpPower, includeOnBench)
  -- function num : 0_55 , upvalues : _ENV
  if not fullHpPower then
    fullHpPower = false
  end
  local fightingPower = 0
  for k,mirrDynHero in ipairs(self.mirrorHeroList) do
    local dynHero = (self.heroList)[k]
    if (not dynHero:IsDead() or fullHpPower) and (not dynHero.onBench or includeOnBench) then
      fightingPower = fightingPower + mirrDynHero:GetFightingPower(fullHpPower)
    end
  end
  local dynPlayerFightingPower = (self.mirrorDynPlayer):GetFightingPower(fullHpPower, fightingPower)
  fightingPower = fightingPower + dynPlayerFightingPower
  return fightingPower
end

DynPlayer.GetTotalFightingPower = function(self, fullHpPower, includeOnBench)
  -- function num : 0_56 , upvalues : _ENV
  if not fullHpPower then
    fullHpPower = false
  end
  local fightingPower = 0
  for k,dynHero in pairs(self.heroList) do
    if (not dynHero:IsDead() or fullHpPower) and (not dynHero.onBench or includeOnBench) then
      fightingPower = fightingPower + dynHero:GetFightingPower(fullHpPower)
    end
  end
  local dynPlayerFightingPower = self:GetFightingPower(fullHpPower, fightingPower)
  fightingPower = fightingPower + dynPlayerFightingPower
  return fightingPower
end

DynPlayer.UpdateFormationDetail = function(self, epForm)
  -- function num : 0_57 , upvalues : _ENV, CS_BattleManager
  local stageCfg = ExplorationManager:GetSectorStageCfg()
  if epForm.initial then
    self:DeployHeroTeam(stageCfg)
  end
  for k,v in pairs(epForm.data) do
    local dynHero = (self.heroDic)[k]
    if dynHero == nil then
      error("Can\'t find dynHero, id = " .. tostring(k))
    else
      dynHero:UpdateHpPer(v.hpPer)
      if not epForm.initial then
        dynHero:SetCoord(v.position, stageCfg.size_row)
      end
      dynHero:UpdateTotalDamage(v.damage)
    end
  end
  self.playerSkillMp = epForm.mp
  CS_BattleManager:UpdateBattleRoleData()
  MsgCenter:Broadcast(eMsgEventId.OnEpPlayerHeroDataChange)
  self:RefreshCacheFightPower()
end

DynPlayer.GetFightingPower = function(self, fullHp, rolesFighter)
  -- function num : 0_58 , upvalues : _ENV
  local fightingPower = 0
  if not rolesFighter then
    fightingPower = ((((((CS.BattleConsts).BattleDynPlayerFightPowerFormula).battleFormula):BindOption(((CS.BattleFormula).eFormationOption).ReplaceHpWithMaxHp)):BindArgData(((CS.FormulaOperand).OperandValue)(not fullHp or 0))):GetValue(self, self)):AsLong()
    fightingPower = (((((CS.BattleConsts).BattleDynPlayerFightPowerFormula).battleFormula):BindArgData(((CS.FormulaOperand).OperandValue)(rolesFighter or 0))):GetValue(self, self)):AsLong()
    local skillFight = self:GetSkillFightingPower(fullHp, rolesFighter)
    fightingPower = fightingPower + skillFight
    self.fightingPower = fightingPower
    return fightingPower
  end
end

DynPlayer.GetSkillFightingPower = function(self, fullHp, herosFighter)
  -- function num : 0_59 , upvalues : _ENV, cs_GameData
  local skillList = {}
  local skillDic = {}
  if self.playerOriginSkillList ~= nil then
    for k,v in pairs(self.playerOriginSkillList) do
      (table.insert)(skillList, v)
      skillDic[v.dataId] = v
    end
  end
  do
    if self.playerItemSkillDict ~= nil then
      for k,v in pairs(self.playerItemSkillDict) do
        local oldSkill = skillDic[k.dataId]
        if oldSkill == nil or oldSkill.level < k.level then
          if oldSkill then
            (table.removebyvalue)(skillList, oldSkill)
          end
          ;
          (table.insert)(skillList, k)
          skillDic[k.dataId] = k
        end
      end
    end
    do
      local fightingPower = 0
      for k,battleSkill in pairs(skillList) do
        local skillCfg = (cs_GameData.listBattleSkillDatas):GetDataById(battleSkill.dataId)
        if skillCfg == nil then
          error("battle skill cfg is null,id:" .. tostring(battleSkill.dataId))
        else
          if skillCfg.combatFormula ~= nil then
            if fullHp then
              fightingPower = fightingPower + (((((skillCfg.combatFormula):BindOption(((CS.BattleFormula).eFormationOption).ReplaceHpWithMaxHp)):BindData(((CS.BattleFormula).eFormulaBindType).SkillLevel, ((CS.FormulaOperand).OperandValue)(battleSkill.level))):BindArgData(herosFighter)):GetValue(self, self)):AsLong()
            else
              fightingPower = fightingPower + ((((skillCfg.combatFormula):BindData(((CS.BattleFormula).eFormulaBindType).SkillLevel, ((CS.FormulaOperand).OperandValue)(battleSkill.level))):BindArgData(herosFighter)):GetValue(self, self)):AsLong()
            end
          end
        end
      end
      return fightingPower
    end
  end
end

DynPlayer.GetFormulaAttr = function(self, attrEnum)
  -- function num : 0_60 , upvalues : _ENV, ExplorationEnum
  local attrId = (GR.EnumToInt)(attrEnum)
  if attrId == eHeroAttr.hp then
    local maxHp = (self.dynData):GetRealAttr(eHeroAttr.maxHp)
    local hp = (self.dynData).hpPer * maxHp // ExplorationEnum.eHeroHpPercent
    if hp == 0 and (self.dynData).hpPer > 0 then
      hp = 1
    end
    return hp
  else
    do
      if attrId == eHeroAttr.intensity then
        return (self.dynData).intensity
      else
        if attrId == eHeroAttr.attack_range then
          return (self.dynData).attackRange
        else
          return (self.dynData):GetRealAttr(attrId)
        end
      end
    end
  end
end

DynPlayer.UpdateEpBuff = function(self, epBuff)
  -- function num : 0_61 , upvalues : _ENV, DynEpBuff
  if epBuff == nil then
    return 
  end
  self.epBuffList = {}
  for groupId,buffGroup in pairs(epBuff.data) do
    for _,buff in pairs(buffGroup.data) do
      local epBuff = (DynEpBuff.New)(buff)
      ;
      (table.insert)(self.epBuffList, epBuff)
    end
  end
  MsgCenter:Broadcast(eMsgEventId.OnEpBuffListChange, self.epBuffList)
end

DynPlayer.GetEpBuffList = function(self)
  -- function num : 0_62
  return self.epBuffList
end

DynPlayer.RecordLastMoney = function(self)
  -- function num : 0_63
  self.__lastMoney = self:GetMoneyCount()
end

DynPlayer.GetLastMoney = function(self)
  -- function num : 0_64
  return self.__lastMoney
end

DynPlayer.GetPlayerSkillMp = function(self)
  -- function num : 0_65
  return self.playerSkillMp
end

DynPlayer.GetDynPlayerName = function(self)
  -- function num : 0_66 , upvalues : _ENV
  return ConfigData.GetTipCp
end

DynPlayer.GetOriginAttr = function(self, attrId)
  -- function num : 0_67
  if self.dynData ~= nil then
    return (self.dynData):GetOriginAttr(attrId)
  end
end

DynPlayer.GetBaseAttr = function(self, attrId)
  -- function num : 0_68
  if self.dynData ~= nil then
    return (self.dynData):GetBaseAttr(attrId)
  end
end

DynPlayer.GetRatioAttr = function(self, attrId)
  -- function num : 0_69
  if self.dynData ~= nil then
    return (self.dynData):GetRatioAttr(attrId)
  end
end

DynPlayer.GetExtraAttr = function(self, attrId)
  -- function num : 0_70
  if self.dynData ~= nil then
    return (self.dynData):GetExtraAttr(attrId)
  end
end

DynPlayer.UpdateEpEventData = function(self, epOp)
  -- function num : 0_71
  if epOp.deco then
    if (epOp.deco)[1] then
      self:UpdateEpSaveMoneyList(((epOp.deco)[1]).arrParams, epOp.curPostion, epOp.path)
    else
      self:UpdateEpSaveMoneyList()
    end
    if (epOp.deco)[2] then
      self:UpdateEpBattleSkillLockDic(((epOp.deco)[2]).mapParams)
    else
      self:UpdateEpBattleSkillLockDic()
    end
  else
    self:UpdateEpSaveMoneyList()
    self:UpdateEpBattleSkillLockDic()
  end
end

DynPlayer.UpdateEpSaveMoneyList = function(self, arrParams, curPostion, path)
  -- function num : 0_72
  self.epSaveMoneyList = arrParams
  self.epCurPostion = curPostion
  self.epPath = path
end

DynPlayer.GetEpSaveMoney = function(self)
  -- function num : 0_73 , upvalues : _ENV
  local saveMoney = 0
  if not self.epSaveMoneyList or not self.epCurPostion or not self.epPath then
    return saveMoney
  end
  if #self.epSaveMoneyList % 3 ~= 0 then
    error("#self.epSaveMoneyList % 3 ~= 0")
    return saveMoney
  end
  for index = 1, #self.epSaveMoneyList, 3 do
    local param1 = (self.epSaveMoneyList)[index]
    local param2 = (self.epSaveMoneyList)[index + 1]
    local param3 = (self.epSaveMoneyList)[index + 2]
    local pathCount = #self.epPath - param1 - 1
    saveMoney = saveMoney + param2 * (1 + pathCount * param3 / 100)
  end
  return saveMoney
end

DynPlayer.UpdateEpBattleSkillLockDic = function(self, mapParams)
  -- function num : 0_74
  self.epBattleSkillLockDic = mapParams
end

DynPlayer.IsEpBattleSkillLock = function(self, skillId)
  -- function num : 0_75
  if self.epBattleSkillLockDic then
    return (self.epBattleSkillLockDic)[skillId]
  else
    return false
  end
end

return DynPlayer

-- params : ...
-- function num : 0 , upvalues : _ENV
local DynPlayer = class("DynPlayer")
local CommanderSkillData = require("Game.CommanderSkill.CommanderSkillData")
local ItemData = require("Game.PlayerData.Item.ItemData")
local ChipData = require("Game.PlayerData.Item.ChipData")
local DynHero = require("Game.Exploration.Data.DynHero")
local DynPlayerData = require("Game.PlayerData.DynPlayer.DynPlayerData")
local DynEpBuffChip = require("Game.Exploration.Data.DynEpBuffChip")
local DynBattleSkill = require("Game.Exploration.Data.DynBattleSkill")
local DynCampFetter = require("Game.Exploration.Data.DynCampFetter")
local DynEpBuff = require("Game.Exploration.Data.DynEpBuff")
local CS_BattleManager = (CS.BattleManager).Instance
local cs_GameData = (CS.GameData).instance
local ExplorationEnum = require("Game.Exploration.ExplorationEnum")
local MoneyId = 1
local UltMpId = 10
local banchPosArray = {1, 3, 2, 0, 4}
DynPlayer.ctor = function(self)
    -- function num : 0_0 , upvalues : DynPlayerData, _ENV
    self.money = 0
    self.energy = 0
    self.dynData = (DynPlayerData.New)()
    self.playerSkillMp = 0
    self.playerUltSkillMp = 0
    self.playerItemSkillDict = {}
    self.playerOriginSkillList = {}
    self.tempChips = {}
    self.ownedChips = {}
    self.dynName = self:__getDynName()
    self.allItemDic = {}
    self.allItemTypeDic = {}
    for k, v in pairs(eItemType) do
        -- DECOMPILER ERROR at PC28: Confused about usage of register: R6 in 'UnsetPending'

        (self.allItemTypeDic)[v] = {}
    end
    self.chipLimitInfo = {
        count = 0,
        limit = 0,
        firstLimit = true,
        discardId = nil
    }
    self.chipList = {}
    self.chipDic = {}
    self.chipSpecifyDic = {}
    self.epBuffChipDic = {}
    self.hiddenChipDic = {}
    self.campFetterDic = {}
    self.epBuffList = {}
    self.epSaveMoneyList = {}
    self.epCurPostion = nil
    self.epPath = {}
    self.epBattleSkillLockDic = {}
    self.__cacheFightPower = nil
    self.__isHeroInitReady = false
end

DynPlayer.CreateDefaultPlayer = function(self, epForm)
    -- function num : 0_1 , upvalues : _ENV
    local ok, heroDic, playerSkillDic, CST =
        PlayerDataCenter:TryGetFormation(epForm.formId)
    if not ok then
        error("Get Formation error!formationId:" .. tostring(epForm.formId))
        return
    end
    self:InitDynPlayer(0, epForm.data, playerSkillDic, CST)
    self:UpdateFormationDetail(epForm)
end

DynPlayer.InitDynPlayerAttr = function(self, attrData)
    -- function num : 0_2
    if self.dynData == nil then return end
    (self.dynData):RefreshDynData(attrData)
end

DynPlayer.InitDynPlayer = function(self, money, heroDatas, playerSkillDic, CST)
    -- function num : 0_3
    self.money = money
    self:InitHeroTeam(heroDatas)
    self:InitPlayerSkill(playerSkillDic, CST)
end

DynPlayer.__getDynName = function(self)
    -- function num : 0_4 , upvalues : _ENV
    return ConfigData:GetTipContent(TipContent.CommanderDPSName)
end

DynPlayer.InitHeroTeam = function(self, heroDatas)
    -- function num : 0_5 , upvalues : _ENV, DynHero
    self.heroList = {}
    self.heroDic = {}
    local tmpHeroIndexDic = {}
    local battleRoleCount = (ConfigData.game_config).max_stage_hero
    for heroId, heroElem in pairs(heroDatas) do
        if heroElem ~= nil then
            local heroTeamIndex = heroElem.idx
            local heroData = (PlayerDataCenter.heroDic)[heroId]
            if heroData ~= nil then
                local dynHeroData = (DynHero.New)(heroData)
                dynHeroData.onBench = battleRoleCount < heroTeamIndex -- DECOMPILER ERROR at PC29: Confused about usage of register: R12 in 'UnsetPending'
                ;
                (self.heroDic)[heroId] = dynHeroData
                tmpHeroIndexDic[dynHeroData] = heroTeamIndex;
                (table.insert)(self.heroList, dynHeroData)
            else
                error("player not have hero:" .. tostring(heroId))
            end
        end
    end
    (table.sort)(self.heroList, function(hero1, hero2)
        -- function num : 0_5_0 , upvalues : tmpHeroIndexDic
        do return tmpHeroIndexDic[hero1] < tmpHeroIndexDic[hero2] end
        -- DECOMPILER ERROR: 1 unprocessed JMP targets
    end)
    self:InitMirrorHeroTeam()
    -- DECOMPILER ERROR: 3 unprocessed JMP targets
end

DynPlayer.InitMirrorHeroTeam = function(self)
    -- function num : 0_6 , upvalues : _ENV, DynHero, DynPlayer
    self.mirrorHeroList = {}
    for k, dynHero in pairs(self.heroList) do
        local heroData = (PlayerDataCenter.heroDic)[dynHero.dataId]
        local dynHeroData = (DynHero.New)(heroData);
        (table.insert)(self.mirrorHeroList, dynHeroData)
    end
    self.mirrorDynPlayer = (DynPlayer.New)()
end

DynPlayer.GetDeployAliveHeroCount = function(self)
    -- function num : 0_7 , upvalues : _ENV
    local count = 0
    for k, dynHero in pairs(self.heroList) do
        if not dynHero.onBench and not dynHero:IsDead() then
            count = count + 1
        end
    end
    return count
end

DynPlayer.InitPlayerSkill = function(self, playerSkillDic, CST)
    -- function num : 0_8 , upvalues : _ENV, DynBattleSkill, ExplorationEnum, CommanderSkillData
    self.playerOriginSkillList = {}
    if playerSkillDic ~= nil then
        for k, skillId in pairs(playerSkillDic) do
            local data = (DynBattleSkill.New)(skillId, 1,
                                              (ExplorationEnum.eBattleSkillType).Original);
            (table.insert)(self.playerOriginSkillList, data)
        end
    end
    do
        if PlayerDataCenter.CommanderSkillModualData ~= nil and CST ~= nil then
            local treeData =
                ((PlayerDataCenter.CommanderSkillModualData).CommanderSkillTreeDataDic)[CST.treeId]
            if treeData.commanderSkillDataDic ~= nil then
                for skillId, skillData in pairs(treeData.commanderSkillDataDic) do
                    if skillData.isUnlock and skillData.type ==
                        (CommanderSkillData.skillType).passive then
                        local data = (DynBattleSkill.New)(skillId, 1,
                                                          (ExplorationEnum.eBattleSkillType).Original);
                        (table.insert)(self.playerOriginSkillList, data)
                    end
                end
            end
            do
                local masterSkillDic = (CST.saving).skillProficient
                if masterSkillDic ~= nil then
                    for skillId, data in pairs(masterSkillDic) do
                        local data = (DynBattleSkill.New)(skillId, data.level,
                                                          (ExplorationEnum.eBattleSkillType).Original);
                        (table.insert)(self.playerOriginSkillList, data)
                    end
                end
            end
        end
    end
end

DynPlayer.ContainChip = function(self, chipData)
    -- function num : 0_9
    local contain = (self.ownedChips)[chipData] ~= nil
    do return contain end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

DynPlayer.AddChip = function(self, chipData)
    -- function num : 0_10
    -- DECOMPILER ERROR at PC1: Confused about usage of register: R2 in 'UnsetPending'

    (self.ownedChips)[chipData] = true
end

DynPlayer.RemoveChip = function(self, chipData)
    -- function num : 0_11
    -- DECOMPILER ERROR at PC1: Confused about usage of register: R2 in 'UnsetPending'

    (self.ownedChips)[chipData] = nil
end

DynPlayer.GetItemSkillList = function(self)
    -- function num : 0_12 , upvalues : _ENV
    local skillList = {}
    local skillDic = {}
    for k, v in pairs(self.playerItemSkillDict) do
        local oldSkill = skillDic[k.dataId]
        if oldSkill == nil or oldSkill.level < k.level then
            if oldSkill then
                (table.removebyvalue)(skillList, oldSkill)
            end
            (table.insert)(skillList, k)
            skillDic[k.dataId] = k
        end
    end
    return skillList
end

DynPlayer.GetItemSkillDic = function(self)
    -- function num : 0_13
    return self.playerItemSkillDict
end

DynPlayer.AddItemSkill = function(self, dynSkill)
    -- function num : 0_14
    -- DECOMPILER ERROR at PC1: Confused about usage of register: R2 in 'UnsetPending'

    (self.playerItemSkillDict)[dynSkill] = true
end

DynPlayer.RemoveItemSkill = function(self, dynSkill)
    -- function num : 0_15
    -- DECOMPILER ERROR at PC1: Confused about usage of register: R2 in 'UnsetPending'

    (self.playerItemSkillDict)[dynSkill] = nil
end

DynPlayer.ContainTempChip = function(self, tempChip)
    -- function num : 0_16
    local contain = (self.tempChips)[tempChip] ~= nil
    do return contain end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

DynPlayer.AddTempChip = function(self, tempChip)
    -- function num : 0_17
    -- DECOMPILER ERROR at PC1: Confused about usage of register: R2 in 'UnsetPending'

    (self.tempChips)[tempChip] = true
end

DynPlayer.RemoveTempChip = function(self, tempChip)
    -- function num : 0_18
    -- DECOMPILER ERROR at PC1: Confused about usage of register: R2 in 'UnsetPending'

    (self.tempChips)[tempChip] = nil
end

DynPlayer.DeployHeroTeam = function(self, stageCfg)
    -- function num : 0_19 , upvalues : _ENV, banchPosArray
    local longRangeRoles = {}
    local defendRoles = {}
    local benchRoles = {}
    for k, heroData in pairs(self.heroList) do
        if heroData.onBench then
            (table.insert)(benchRoles, heroData)
        else
            if heroData.attackRange <= 1 then
                (table.insert)(defendRoles, heroData)
            else

                (table.insert)(longRangeRoles, heroData)
            end
        end
    end
    local mapSizeX = stageCfg.size_row
    local mapDeployX = stageCfg.deploy_rows
    local mapSizeY = stageCfg.size_col
    local deployDic = {}
    local totalHeroCount = #self.heroList
    local defendRoleCount = #defendRoles
    local longRangeRoleCount = #longRangeRoles
    if defendRoleCount > 3 or longRangeRoleCount > 3 then
        if #defendRoles > 0 then
            for x = mapDeployX - 1, 0, -1 do
                for y = 0, mapSizeY - 1 do
                    if #defendRoles ~= 0 then
                        local coord = x << 16 | y
                        if not deployDic[coord] then
                            deployDic[coord] = true
                            local role = (table.remove)(defendRoles)
                            role:SetCoordXY(x, y, mapSizeX)
                        end
                        do
                            -- DECOMPILER ERROR at PC73: LeaveBlock: unexpected jumping out IF_THEN_STMT

                            -- DECOMPILER ERROR at PC73: LeaveBlock: unexpected jumping out IF_STMT

                        end
                    end
                end
            end
        end
        do
            if #longRangeRoles > 0 then
                for x = 0, mapDeployX - 1 do
                    for y = 0, mapSizeY - 1 do
                        if #longRangeRoles ~= 0 then
                            local coord = x << 16 | y
                            if not deployDic[coord] then
                                deployDic[coord] = true
                                local role = (table.remove)(longRangeRoles)
                                role:SetCoordXY(x, y, mapSizeX)
                            end
                            do
                                -- DECOMPILER ERROR at PC104: LeaveBlock: unexpected jumping out IF_THEN_STMT

                                -- DECOMPILER ERROR at PC104: LeaveBlock: unexpected jumping out IF_STMT

                            end
                        end
                    end
                end
            end
            do
                do
                    local index = 1
                    for k, role in pairs(benchRoles) do
                        role:SetCoordXY(mapSizeX, banchPosArray[index], mapSizeX)
                        index = index + 1
                    end
                    do return end
                    if defendRoleCount > 0 then
                        local curRow = mapDeployX - 1
                        if totalHeroCount <= defendRoleCount then
                            curRow = 0
                        end
                        if defendRoleCount > 2 then
                            for c = mapSizeY - 1, 0, -1 do
                                -- DECOMPILER ERROR at PC140: Unhandled construct in 'MakeBoolean' P1

                                if c % 2 == 0 and #defendRoles ~= 0 then
                                    local coord = curRow << 16 | c
                                    if not deployDic[coord] then
                                        deployDic[coord] = true
                                        local role = (table.remove)(defendRoles)
                                        role:SetCoordXY(curRow, c, mapSizeX)
                                    end
                                    do
                                        -- DECOMPILER ERROR at PC153: LeaveBlock: unexpected jumping out IF_THEN_STMT

                                        -- DECOMPILER ERROR at PC153: LeaveBlock: unexpected jumping out IF_STMT

                                    end
                                end
                            end
                        else
                            if defendRoleCount == 2 then
                                if totalHeroCount - defendRoleCount == 3 then
                                    local role = (table.remove)(defendRoles)
                                    role:SetCoordXY(1, 0, mapSizeX)
                                    role = (table.remove)(defendRoles)
                                    role:SetCoordXY(1, 4, mapSizeX)
                                else
                                    do
                                        for c = mapSizeY - 1, 0, -1 do
                                            -- DECOMPILER ERROR at PC192: Unhandled construct in 'MakeBoolean' P1

                                            if c % 2 == 1 and #defendRoles ~= 0 then
                                                local coord = curRow << 16 | c
                                                if not deployDic[coord] then
                                                    deployDic[coord] = true
                                                    local role =
                                                        (table.remove)(
                                                            defendRoles)
                                                    role:SetCoordXY(curRow, c,
                                                                    mapSizeX)
                                                end
                                                do
                                                    -- DECOMPILER ERROR at PC205: LeaveBlock: unexpected jumping out IF_THEN_STMT

                                                    -- DECOMPILER ERROR at PC205: LeaveBlock: unexpected jumping out IF_STMT

                                                end
                                            end
                                        end
                                        if defendRoleCount == 1 then
                                            local curCow = (mapSizeY - 1) // 2
                                            local coord = curRow << 16 | curCow
                                            if not deployDic[coord] then
                                                deployDic[coord] = true
                                                local role =
                                                    (table.remove)(defendRoles)
                                                role:SetCoordXY(curRow, curCow,
                                                                mapSizeX)
                                            end
                                        end
                                        do
                                            if longRangeRoleCount > 0 then
                                                local curRow = 0
                                                if longRangeRoleCount >= 5 then
                                                    for c = mapSizeY - 1, 0, -1 do
                                                        if #longRangeRoles ~= 0 then
                                                            local coord =
                                                                curRow << 16 | c
                                                            if not deployDic[coord] then
                                                                deployDic[coord] =
                                                                    true
                                                                local role =
                                                                    (table.remove)(
                                                                        longRangeRoles)
                                                                role:SetCoordXY(
                                                                    curRow, c,
                                                                    mapSizeX)
                                                            end
                                                            do
                                                                -- DECOMPILER ERROR at PC253: LeaveBlock: unexpected jumping out IF_THEN_STMT

                                                                -- DECOMPILER ERROR at PC253: LeaveBlock: unexpected jumping out IF_STMT

                                                            end
                                                        end
                                                    end
                                                else
                                                    if longRangeRoleCount == 4 then
                                                        for c = 0, 1 do
                                                            if #longRangeRoles ~=
                                                                0 then
                                                                local coord =
                                                                    curRow << 16 |
                                                                        c
                                                                if not deployDic[coord] then
                                                                    deployDic[coord] =
                                                                        true
                                                                    local role =
                                                                        (table.remove)(
                                                                            longRangeRoles)
                                                                    role:SetCoordXY(
                                                                        curRow,
                                                                        c,
                                                                        mapSizeX)
                                                                end
                                                                do
                                                                    -- DECOMPILER ERROR at PC279: LeaveBlock: unexpected jumping out IF_THEN_STMT

                                                                    -- DECOMPILER ERROR at PC279: LeaveBlock: unexpected jumping out IF_STMT

                                                                end
                                                            end
                                                        end
                                                        for c = mapSizeY - 1, 3, -1 do
                                                            if #longRangeRoles ~=
                                                                0 then
                                                                local coord =
                                                                    curRow << 16 |
                                                                        c
                                                                if not deployDic[coord] then
                                                                    deployDic[coord] =
                                                                        true
                                                                    local role =
                                                                        (table.remove)(
                                                                            longRangeRoles)
                                                                    role:SetCoordXY(
                                                                        curRow,
                                                                        c,
                                                                        mapSizeX)
                                                                end
                                                                do
                                                                    -- DECOMPILER ERROR at PC302: LeaveBlock: unexpected jumping out IF_THEN_STMT

                                                                    -- DECOMPILER ERROR at PC302: LeaveBlock: unexpected jumping out IF_STMT

                                                                end
                                                            end
                                                        end
                                                    else
                                                        if longRangeRoleCount ==
                                                            3 then
                                                            for c = mapSizeY - 1, 0, -1 do
                                                                -- DECOMPILER ERROR at PC318: Unhandled construct in 'MakeBoolean' P1

                                                                if c % 2 == 0 and
                                                                    #longRangeRoles ~=
                                                                    0 then
                                                                    local coord =
                                                                        curRow <<
                                                                            16 |
                                                                            c
                                                                    if not deployDic[coord] then
                                                                        deployDic[coord] =
                                                                            true
                                                                        local 
                                                                            role =
                                                                            (table.remove)(
                                                                                longRangeRoles)
                                                                        role:SetCoordXY(
                                                                            curRow,
                                                                            c,
                                                                            mapSizeX)
                                                                    end
                                                                    do
                                                                        -- DECOMPILER ERROR at PC331: LeaveBlock: unexpected jumping out IF_THEN_STMT

                                                                        -- DECOMPILER ERROR at PC331: LeaveBlock: unexpected jumping out IF_STMT

                                                                    end
                                                                end
                                                            end
                                                        else
                                                            if longRangeRoleCount ==
                                                                2 then
                                                                if defendRoleCount >
                                                                    0 then
                                                                    if #longRangeRoles >
                                                                        0 then
                                                                        local 
                                                                            coord =
                                                                            curRow <<
                                                                                16 |
                                                                                0
                                                                        if not deployDic[coord] then
                                                                            deployDic[coord] =
                                                                                true
                                                                            local 
                                                                                role =
                                                                                (table.remove)(
                                                                                    longRangeRoles)
                                                                            role:SetCoordXY(
                                                                                curRow,
                                                                                0,
                                                                                mapSizeX)
                                                                        end
                                                                    end
                                                                    do
                                                                        if #longRangeRoles >
                                                                            0 then
                                                                            local 
                                                                                coord =
                                                                                curRow <<
                                                                                    16 |
                                                                                    mapSizeY -
                                                                                    1
                                                                            if not deployDic[coord] then
                                                                                deployDic[coord] =
                                                                                    true
                                                                                local 
                                                                                    role =
                                                                                    (table.remove)(
                                                                                        longRangeRoles)
                                                                                role:SetCoordXY(
                                                                                    curRow,
                                                                                    mapSizeY -
                                                                                        1,
                                                                                    mapSizeX)
                                                                            end
                                                                        end
                                                                        do
                                                                            for c = mapSizeY -
                                                                                1, 0, -1 do
                                                                                -- DECOMPILER ERROR at PC387: Unhandled construct in 'MakeBoolean' P1

                                                                                if c %
                                                                                    2 ==
                                                                                    1 and
                                                                                    #longRangeRoles ~=
                                                                                    0 then
                                                                                    local 
                                                                                        coord =
                                                                                        curRow <<
                                                                                            16 |
                                                                                            c
                                                                                    if not deployDic[coord] then
                                                                                        deployDic[coord] =
                                                                                            true
                                                                                        local 
                                                                                            role =
                                                                                            (table.remove)(
                                                                                                longRangeRoles)
                                                                                        role:SetCoordXY(
                                                                                            curRow,
                                                                                            c,
                                                                                            mapSizeX)
                                                                                    end
                                                                                    do
                                                                                        -- DECOMPILER ERROR at PC400: LeaveBlock: unexpected jumping out IF_THEN_STMT

                                                                                        -- DECOMPILER ERROR at PC400: LeaveBlock: unexpected jumping out IF_STMT

                                                                                    end
                                                                                end
                                                                            end
                                                                            if longRangeRoleCount ==
                                                                                1 and
                                                                                #longRangeRoles >
                                                                                0 then
                                                                                local 
                                                                                    curCow =
                                                                                    (mapSizeY -
                                                                                        1) //
                                                                                        2
                                                                                local 
                                                                                    coord =
                                                                                    curRow <<
                                                                                        16 |
                                                                                        curCow
                                                                                if not deployDic[coord] then
                                                                                    deployDic[coord] =
                                                                                        true
                                                                                    local 
                                                                                        role =
                                                                                        (table.remove)(
                                                                                            longRangeRoles)
                                                                                    role:SetCoordXY(
                                                                                        curRow,
                                                                                        curCow,
                                                                                        mapSizeX)
                                                                                end
                                                                            end
                                                                            do
                                                                                local 
                                                                                    index =
                                                                                    1
                                                                                for 
                                                                                    k,
                                                                                    role in
                                                                                    pairs(
                                                                                        benchRoles) do
                                                                                    role:SetCoordXY(
                                                                                        mapSizeX,
                                                                                        banchPosArray[index],
                                                                                        mapSizeX)
                                                                                    index =
                                                                                        index +
                                                                                            1
                                                                                end
                                                                            end
                                                                        end
                                                                    end
                                                                end
                                                            end
                                                        end
                                                    end
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end

DynPlayer.RefreshCacheFightPower = function(self)
    -- function num : 0_20 , upvalues : _ENV
    if not self.__isHeroInitReady then return end
    local curPower = self:GetTotalFightingPower()
    if self.__cacheFightPower == curPower then return end
    self.__cacheFightPower = curPower
    MsgCenter:Broadcast(eMsgEventId.OnEpPlayerFightPowerChang, curPower)
end

DynPlayer.GetCacheFightPower = function(self)
    -- function num : 0_21
    return self.__cacheFightPower or 0
end

DynPlayer.UpdateHeroAttr = function(self, heroBattleData)
    -- function num : 0_22 , upvalues : _ENV
    for k, dynHero in ipairs(self.heroList) do
        local battle = heroBattleData[dynHero.dataId]
        if battle ~= nil then
            dynHero:UpdateBaseHeroData(battle.attr, battle.baseSkill,
                                       battle.athSkill)
            local mirrorDynHero = (self.mirrorHeroList)[k]
            mirrorDynHero:UpdateBaseHeroData(battle.attr, battle.baseSkill,
                                             battle.athSkill)
        end
    end
    self.__isHeroInitReady = true
    self:RefreshCacheFightPower()
end

DynPlayer.UpdateOperatorDetail = function(self, operatorDetail)
    -- function num : 0_23
    self.operatorDetail = operatorDetail
end

DynPlayer.GetOperatorDetail = function(self)
    -- function num : 0_24
    return self.operatorDetail
end

DynPlayer.GetOperatorDetailState = function(self)
    -- function num : 0_25
    return (self.operatorDetail).state
end

DynPlayer.UpdateEpBackpack = function(self, epBackpack)
    -- function num : 0_26 , upvalues : _ENV, ItemData, MoneyId, UltMpId, CS_BattleManager
    if epBackpack == nil then return end
    self.allItemDic = {}
    for k, v in pairs(self.allItemTypeDic) do
        -- DECOMPILER ERROR at PC11: Confused about usage of register: R7 in 'UnsetPending'

        (self.allItemTypeDic)[k] = {}
    end
    for k, num in pairs(epBackpack.item) do
        local itemData = (ItemData.New)(k, num) -- DECOMPILER ERROR at PC23: Confused about usage of register: R8 in 'UnsetPending'
        ;
        (self.allItemDic)[k] = itemData
        local typeDic = (self.allItemTypeDic)[itemData.type]
        if typeDic == nil then
            error("Can\'t find itemType:" .. tostring(itemData.type))
        else
            typeDic[k] = itemData
        end
    end
    local focusItemNum = self:GetItemCount(
                             (ConfigData.game_config).RandomBeforeBatteleRejudgeItem) or
                             0
    local focusLimit = epBackpack.focusLimit or 0
    if self.focusItemNum ~= focusItemNum or self.focusLimit ~= focusLimit then
        self.focusItemNum = focusItemNum
        self.focusLimit = focusLimit
        MsgCenter:Broadcast(eMsgEventId.EpFocusPointChange, self.focusItemNum,
                            focusLimit)
    end
    local money = self:GetItemCount(MoneyId)
    if self.money ~= money then
        self.money = money
        MsgCenter:Broadcast(eMsgEventId.EpMoneyChange, self.money)
    end
    local ultMp = self:GetItemCount(UltMpId)
    if self.playerUltSkillMp ~= ultMp then
        self.playerUltSkillMp = ultMp
        local playerCtrl = CS_BattleManager:GetBattlePlayerController()
        if playerCtrl ~= nil then
            (playerCtrl.UltSkillHandle):UpdateUltMpFromItem(
                self.playerUltSkillMp)
        end
    end
    do
        if epBackpack.algData ~= nil then
            if ExplorationManager.epCtrl ~= nil then
                (ExplorationManager.epCtrl):RollbackNormalChipBattleRoom();
                (ExplorationManager.epCtrl):RollbackTempChipCurBattleRoom(
                    self.epBuffChipDic);
                (ExplorationManager.epCtrl):RollbackTempChipCurBattleRoom(
                    self.hiddenChipDic);
                (ExplorationManager.epCtrl):RollbackTempChipNextBattleRoom(
                    self.hiddenChipDic)
            end
            for k, chipData in pairs(self.chipDic) do
                self:__RollBackChipInternal(chipData)
            end
            self.chipDic = {}
            for k, chipData in pairs(self.chipSpecifyDic) do
                self:__RollBackChipInternal(chipData)
            end
            self.chipSpecifyDic = {}
            for k, buffChip in pairs(self.epBuffChipDic) do
                self:__RollBackBuffChip(buffChip)
            end
            self.epBuffChipDic = {}
            for k, buffChip in pairs(self.hiddenChipDic) do
                self:__RollBackBuffChip(buffChip)
            end
            self.hiddenChipDic = {}
            self.chipList = {}
            self:__UpdateAllChip((epBackpack.algData).alg, nil,
                                 (epBackpack.algData).tmpAlg, nil,
                                 (epBackpack.algData).hiddenAlg, nil)
        end
        -- DECOMPILER ERROR at PC186: Confused about usage of register: R6 in 'UnsetPending'

        if epBackpack.algUpperLimit ~= (self.chipLimitInfo).limit then
            (self.chipLimitInfo).limit = epBackpack.algUpperLimit
            MsgCenter:Broadcast(eMsgEventId.OnChipLimitChange)
        end
    end
end

DynPlayer.UpdateChipDiff = function(self, diffData)
    -- function num : 0_27
    self:__UpdateAllChip(diffData.update, diffData.delete, diffData.tmpUpdate,
                         diffData.tmpDelete, diffData.hiddenUpdate,
                         diffData.hiddenDelete)
end

DynPlayer.__UpdateAllChip = function(self, chipUpdate, chipDelete,
                                     tmpChipUpdate, tmpChipDelete, hiddenUpdate,
                                     hiddenDelete)
    -- function num : 0_28 , upvalues : _ENV, ChipData, DynEpBuffChip, CS_BattleManager
    local haveHiddenChipUpdate = (hiddenUpdate ~= nil and
                                     (table.count)(hiddenUpdate) > 0) or
                                     (hiddenDelete ~= nil and
                                         (table.count)(hiddenDelete) > 0)
    if ExplorationManager.epCtrl ~= nil then
        (ExplorationManager.epCtrl):RollbackNormalChipBattleRoom()
        if haveHiddenChipUpdate then
            (ExplorationManager.epCtrl):RollbackTempChipCurBattleRoom(
                self.hiddenChipDic);
            (ExplorationManager.epCtrl):RollbackTempChipNextBattleRoom(
                self.hiddenChipDic)
        end
    end
    local haveTmpChipUpdate = false
    if (tmpChipUpdate ~= nil and (table.count)(tmpChipUpdate) > 0) or
        tmpChipDelete ~= nil and (table.count)(tmpChipDelete) > 0 then
        haveTmpChipUpdate = true
        if ExplorationManager.epCtrl ~= nil then
            (ExplorationManager.epCtrl):RollbackTempChipCurBattleRoom(
                self.epBuffChipDic)
        end
    end
    if chipDelete ~= nil then
        for k, v in pairs(chipDelete) do
            local chipId = k >> 32
            local heroId = k & CommonUtil.UInt32Max
            if heroId > 0 then
                local chipData = (self.chipSpecifyDic)[k]
                if chipData ~= nil then
                    self:__RollBackChipInternal(chipData)
                end -- DECOMPILER ERROR at PC85: Confused about usage of register: R17 in 'UnsetPending'
                
                (self.chipSpecifyDic)[k] = nil
            else
                local chipData = (self.chipDic)[chipId]
                if chipData ~= nil then
                    self:__RollBackChipInternal(chipData)
                end -- DECOMPILER ERROR at PC95: Confused about usage of register: R17 in 'UnsetPending'
                
                (self.chipDic)[chipId] = nil
            end
        end
    end
    if tmpChipDelete ~= nil then
        for chipId, num in pairs(tmpChipDelete) do
            local buffChip = (self.epBuffChipDic)[chipId]
            if buffChip ~= nil then self:__RollBackBuffChip(buffChip) end -- DECOMPILER ERROR at PC112: Confused about usage of register: R15 in 'UnsetPending'
            
            (self.epBuffChipDic)[chipId] = nil
        end
    end
    if hiddenDelete ~= nil then
        for chipId, num in pairs(hiddenDelete) do
            local buffChip = (self.hiddenChipDic)[chipId]
            if buffChip ~= nil then self:__RollBackBuffChip(buffChip) end -- DECOMPILER ERROR at PC129: Confused about usage of register: R15 in 'UnsetPending'
            
            (self.hiddenChipDic)[chipId] = nil
        end
    end
    if chipUpdate ~= nil then
        for k, num in pairs(chipUpdate) do
            local chipId = k >> 32
            local heroId = k & CommonUtil.UInt32Max
            if heroId > 0 then
                local chipData = (self.chipSpecifyDic)[k]
                if chipData ~= nil then
                    self:__RollBackChipInternal(chipData)
                    chipData:SetCount(num)
                    self:__ExecuteChipInternal(chipData)
                else
                    local dynHero = (self.heroDic)[heroId]
                    if dynHero == nil then
                        error("Can\'t find dynHero, id = " .. tostring(heroId))
                    else
                        local chipData =
                            (ChipData.NewChipForOneHero)(dynHero, chipId, num) -- DECOMPILER ERROR at PC176: Confused about usage of register: R19 in 'UnsetPending'
                        ;
                        (self.chipSpecifyDic)[k] = chipData
                        self:__ExecuteChipInternal(chipData)
                    end
                end
            else
                local chipData = (self.chipDic)[chipId]
                if chipData ~= nil then
                    self:__RollBackChipInternal(chipData)
                    chipData:SetCount(num)
                    self:__ExecuteChipInternal(chipData)
                else
                    local chipData = (ChipData.New)(chipId, num) -- DECOMPILER ERROR at PC200: Confused about usage of register: R18 in 'UnsetPending'
                    ;
                    (self.chipDic)[chipId] = chipData
                    self:__ExecuteChipInternal(chipData)
                end
            end
        end
    end
    if tmpChipUpdate ~= nil then
        for chipId, num in pairs(tmpChipUpdate) do
            local buffChip = (self.epBuffChipDic)[chipId]
            if buffChip ~= nil then
                self:__RollBackBuffChip(buffChip)
                buffChip:SetCount(num)
                self:__ExecuteBuffChip(buffChip)
            else
                local buffChip = (DynEpBuffChip.New)(chipId, num) -- DECOMPILER ERROR at PC231: Confused about usage of register: R16 in 'UnsetPending'
                ;
                (self.epBuffChipDic)[chipId] = buffChip
                self:__ExecuteBuffChip(buffChip)
            end
        end
    end
    if hiddenUpdate ~= nil then
        for chipId, num in pairs(hiddenUpdate) do
            local buffChip = (self.hiddenChipDic)[chipId]
            if buffChip ~= nil then
                self:__RollBackBuffChip(buffChip)
                buffChip:SetCount(num)
                self:__ExecuteBuffChip(buffChip)
            else
                local buffChip = (DynEpBuffChip.New)(chipId, num) -- DECOMPILER ERROR at PC262: Confused about usage of register: R16 in 'UnsetPending'
                ;
                (self.hiddenChipDic)[chipId] = buffChip
                self:__ExecuteBuffChip(buffChip)
            end
        end
    end
    local chipList = {}
    for chipId, chipData in pairs(self.chipDic) do
        (table.insert)(chipList, chipData)
    end
    for k, chipData in pairs(self.chipSpecifyDic) do
        (table.insert)(chipList, chipData)
    end
    self.chipList = chipList
    self:__SortChipList()
    self:UpdateChipLimitNum()
    if ExplorationManager.epCtrl ~= nil then
        (ExplorationManager.epCtrl):ExecuteNormalChipBattleRoom()
        if haveHiddenChipUpdate then
            (ExplorationManager.epCtrl):ExecuteTempChipCurBattleRoom(
                self.hiddenChipDic);
            (ExplorationManager.epCtrl):ExecuteTempChipNextBattleRoom(
                self.hiddenChipDic)
        end
    end
    if haveTmpChipUpdate and ExplorationManager.epCtrl ~= nil then
        (ExplorationManager.epCtrl):ExecuteTempChipCurBattleRoom(
            self:GetEpBuffChipDic())
    end
    CS_BattleManager:UpdateBattleRoleData()
    MsgCenter:Broadcast(eMsgEventId.OnEpChipListChange, self.chipList)
    self:RefreshCacheFightPower()
    -- DECOMPILER ERROR: 32 unprocessed JMP targets
end

DynPlayer.__SortChipList = function(self)
    -- function num : 0_29 , upvalues : _ENV
    (table.sort)(self.chipList, function(a, b)
        -- function num : 0_29_0
        do return a.dataId < b.dataId end
        -- DECOMPILER ERROR: 1 unprocessed JMP targets
    end)
end

DynPlayer.SetChipDiscardId = function(self, id)
    -- function num : 0_30
    -- DECOMPILER ERROR at PC1: Confused about usage of register: R2 in 'UnsetPending'

    (self.chipLimitInfo).discardId = id
end

DynPlayer.GetChipDiscardId = function(self)
    -- function num : 0_31
    return (self.chipLimitInfo).discardId
end

DynPlayer.GetChipDiscardLimit = function(self)
    -- function num : 0_32
    return (self.chipLimitInfo).limit
end

DynPlayer.UpdateChipLimitNum = function(self)
    -- function num : 0_33 , upvalues : _ENV
    -- DECOMPILER ERROR at PC5: Confused about usage of register: R1 in 'UnsetPending'

    (self.chipLimitInfo).count = (table.count)(self.chipDic)
end

DynPlayer.IsChipOverLimitNum = function(self)
    -- function num : 0_34
    do
        return (self.chipLimitInfo).limit < (self.chipLimitInfo).count,
               (self.chipLimitInfo).count, (self.chipLimitInfo).limit
    end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

DynPlayer.GetItemBag = function(self, type)
    -- function num : 0_35
    return (self.allItemTypeDic)[type]
end

DynPlayer.GetItemCount = function(self, dataId)
    -- function num : 0_36
    local itemData = self:GetItemById(dataId)
    if itemData ~= nil or not 0 then return itemData:GetCount() end
end

DynPlayer.GetItemCountByType = function(self, type, dataId)
    -- function num : 0_37
    local itemData = self:GetItemById(type, dataId)
    if itemData ~= nil or not 0 then return itemData:GetCount() end
end

DynPlayer.GetItemById = function(self, dataId)
    -- function num : 0_38 , upvalues : _ENV
    local itemCfg = (ConfigData.item)[dataId]
    if itemCfg == nil then
        error("item cfg is null,Id:" .. tostring(dataId))
        return
    end
    return (self.allItemDic)[dataId]
end

DynPlayer.GetMoneyIconId = function(self)
    -- function num : 0_39 , upvalues : _ENV, MoneyId
    local cfg = (ConfigData.item)[MoneyId]
    return cfg ~= nil and cfg.icon or nil
end

DynPlayer.GetMoneyCount = function(self)
    -- function num : 0_40
    return self.money
end

DynPlayer.GetChipList = function(self)
    -- function num : 0_41
    return self.chipList
end

DynPlayer.GetChipLimitInfo = function(self)
    -- function num : 0_42
    return self.chipLimitInfo
end

DynPlayer.GetNormalChipDic = function(self)
    -- function num : 0_43
    return self.chipDic
end

DynPlayer.GetEpBuffChipDic = function(self)
    -- function num : 0_44
    return self.epBuffChipDic
end

DynPlayer.GetHiddenChipDic = function(self)
    -- function num : 0_45
    return self.hiddenChipDic
end

DynPlayer.__RollBackChipInternal = function(self, chipData, isMirror)
    -- function num : 0_46 , upvalues : _ENV
    if isMirror then
        if (self.mirrorDynPlayer):ContainChip(chipData) then
            chipData:RollbackChipDynPlayer(self.mirrorDynPlayer)
            return
        end
        for k, v in pairs(self.mirrorHeroList) do
            chipData:RollbackChipHero(v)
        end
    else
        do
            if self:ContainChip(chipData) then
                chipData:RollbackChipDynPlayer(self)
                return
            end
            for k, v in pairs(self.heroList) do
                chipData:RollbackChipHero(v)
            end
        end
    end
end

DynPlayer.__ExecuteChipInternal = function(self, chipData, isMirror)
    -- function num : 0_47 , upvalues : _ENV
    local isForDynPlayer = chipData:IsValidDynPlayer()
    if isForDynPlayer then
        if isMirror then
            chipData:ExecuteChipDynPlayer(self.mirrorDynPlayer)
        else
            chipData:ExecuteChipDynPlayer(self)
        end
        return
    end
    local validRoleList = nil
    if isMirror then
        validRoleList = chipData:GetValidRoleList(self.mirrorHeroList,
                                                  eBattleRoleBelong.player)
    else
        validRoleList = chipData:GetValidRoleList(self.heroList,
                                                  eBattleRoleBelong.player)
    end
    for k, v in pairs(validRoleList) do chipData:ExecuteChipHero(v) end
end

DynPlayer.ExecuteChip = function(self, chipData, isOwnData)
    -- function num : 0_48 , upvalues : _ENV
    local oldChip = nil
    if chipData:IsCopyItem() then
        oldChip = (self.chipSpecifyDic)[chipData.dataId]
    else
        oldChip = (self.chipDic)[chipData.dataId]
    end
    if oldChip ~= nil then
        self:__RollBackChipInternal(oldChip)
        if not isOwnData or not 1 then local count = chipData:GetCount() end
        oldChip:AddCount(count)
        self:__ExecuteChipInternal(oldChip)
    else
        do
            self:__ExecuteChipInternal(chipData)
            -- DECOMPILER ERROR at PC40: Confused about usage of register: R4 in 'UnsetPending'

            if chipData:IsCopyItem() then
                (self.chipSpecifyDic)[chipData.dataId] = chipData
            else
                -- DECOMPILER ERROR at PC44: Confused about usage of register: R4 in 'UnsetPending'


                (self.chipDic)[chipData.dataId] = chipData
            end
            (table.insert)(self.chipList, chipData);
            (table.sort)(self.chipList, function(a, b)
                -- function num : 0_48_0
                do return a.dataId < b.dataId end
                -- DECOMPILER ERROR: 1 unprocessed JMP targets
            end)
        end
    end
end

DynPlayer.RollBackChip = function(self, chipData, isOwnData)
    -- function num : 0_49 , upvalues : _ENV
    local oldChip = nil
    if chipData:IsCopyItem() then
        oldChip = (self.chipSpecifyDic)[chipData.dataId]
    else
        oldChip = (self.chipDic)[chipData.dataId]
    end
    if oldChip ~= nil then
        if not isOwnData or not 1 then
            local chipCount = chipData:GetCount()
        end
        local count = oldChip:GetCount() - chipCount
        if count < 0 then
            error("Chip:卸载的数量大于已有的数量")
            return
        end
        self:__RollBackChipInternal(oldChip)
        if count > 0 then
            oldChip:SetCount(count)
            self:__ExecuteChipInternal(oldChip)
        else
            -- DECOMPILER ERROR at PC48: Confused about usage of register: R6 in 'UnsetPending'

            if chipData:IsCopyItem() then
                (self.chipSpecifyDic)[chipData.dataId] = nil
            else
                -- DECOMPILER ERROR at PC52: Confused about usage of register: R6 in 'UnsetPending'


                (self.chipDic)[chipData.dataId] = nil
            end
            (table.removebyvalue)(self.chipList, oldChip)
        end
    else
        do
            error("没有该芯片可以卸载,id = " ..
                      tostring(chipData.dataId))
        end
    end
end

DynPlayer.__RollBackBuffChip = function(self, buffChip)
    -- function num : 0_50 , upvalues : _ENV
    if self:ContainTempChip(buffChip) then
        buffChip:RollbackChipDynPlayer(self)
        return
    end
    for k, v in pairs(self.heroList) do buffChip:RollbackChipHero(v) end
end

DynPlayer.__ExecuteBuffChip = function(self, buffChip)
    -- function num : 0_51 , upvalues : _ENV
    if buffChip:IsValidDynPlayer() then
        buffChip:ExecuteChipDynPlayer(self)
        return
    end
    local validRoleList = buffChip:GetValidRoleList(self.heroList,
                                                    eBattleRoleBelong.player)
    for k, v in pairs(validRoleList) do buffChip:ExecuteChipHero(v) end
end

DynPlayer.GetChipCount = function(self, chipId)
    -- function num : 0_52
    local chipData = (self.chipDic)[chipId]
    if chipData ~= nil then
        return chipData:GetCount()
    else
        return 0
    end
end

DynPlayer.GetChipCombatEffect = function(self, chipData, isOwnData)
    -- function num : 0_53
    local originPower = self:GetMirrorTeamFightPower(true, true)
    local oldPower = self:GetTotalFightingPower(true, true)
    self:ExecuteChip(chipData, isOwnData)
    local powerChange = self:GetTotalFightingPower(true, true) - oldPower
    self:RollBackChip(chipData, isOwnData)
    local combatEffect = 0
    if originPower > 0 then combatEffect = powerChange / originPower end
    return combatEffect
end

DynPlayer.GetChipOriginFightPower = function(self, chipData)
    -- function num : 0_54
    local originPower = self:GetMirrorTeamFightPower(true, true)
    self:__ExecuteChipInternal(chipData, true)
    local newPower = self:GetMirrorTeamFightPower(true, true)
    self:__RollBackChipInternal(chipData, true)
    local powerChange = newPower - originPower
    if originPower <= 0 then return 0 end
    return powerChange / originPower
end

DynPlayer.GetMirrorTeamFightPower = function(self, fullHpPower, includeOnBench)
    -- function num : 0_55 , upvalues : _ENV
    if not fullHpPower then fullHpPower = false end
    local fightingPower = 0
    for k, mirrDynHero in ipairs(self.mirrorHeroList) do
        local dynHero = (self.heroList)[k]
        if (not dynHero:IsDead() or fullHpPower) and
            (not dynHero.onBench or includeOnBench) then
            fightingPower = fightingPower +
                                mirrDynHero:GetFightingPower(fullHpPower)
        end
    end
    local dynPlayerFightingPower = (self.mirrorDynPlayer):GetFightingPower(
                                       fullHpPower, fightingPower)
    fightingPower = fightingPower + dynPlayerFightingPower
    return fightingPower
end

DynPlayer.GetTotalFightingPower = function(self, fullHpPower, includeOnBench)
    -- function num : 0_56 , upvalues : _ENV
    if not fullHpPower then fullHpPower = false end
    local fightingPower = 0
    for k, dynHero in pairs(self.heroList) do
        if (not dynHero:IsDead() or fullHpPower) and
            (not dynHero.onBench or includeOnBench) then
            fightingPower = fightingPower +
                                dynHero:GetFightingPower(fullHpPower)
        end
    end
    local dynPlayerFightingPower = self:GetFightingPower(fullHpPower,
                                                         fightingPower)
    fightingPower = fightingPower + dynPlayerFightingPower
    return fightingPower
end

DynPlayer.UpdateFormationDetail = function(self, epForm)
    -- function num : 0_57 , upvalues : _ENV, CS_BattleManager
    local stageCfg = ExplorationManager:GetSectorStageCfg()
    if epForm.initial then self:DeployHeroTeam(stageCfg) end
    for k, v in pairs(epForm.data) do
        local dynHero = (self.heroDic)[k]
        if dynHero == nil then
            error("Can\'t find dynHero, id = " .. tostring(k))
        else
            dynHero:UpdateHpPer(v.hpPer)
            if not epForm.initial then
                dynHero:SetCoord(v.position, stageCfg.size_row)
            end
            dynHero:UpdateTotalDamage(v.damage)
        end
    end
    self.playerSkillMp = epForm.mp
    CS_BattleManager:UpdateBattleRoleData()
    MsgCenter:Broadcast(eMsgEventId.OnEpPlayerHeroDataChange)
    self:RefreshCacheFightPower()
end

DynPlayer.GetFightingPower = function(self, fullHp, rolesFighter)
    -- function num : 0_58 , upvalues : _ENV
    local fightingPower = 0
    if not rolesFighter then
        fightingPower =
            ((((((CS.BattleConsts).BattleDynPlayerFightPowerFormula).battleFormula):BindOption(
                ((CS.BattleFormula).eFormationOption).ReplaceHpWithMaxHp)):BindArgData(
                ((CS.FormulaOperand).OperandValue)(not fullHp or 0))):GetValue(
                self, self)):AsLong()
        fightingPower =
            (((((CS.BattleConsts).BattleDynPlayerFightPowerFormula).battleFormula):BindArgData(
                ((CS.FormulaOperand).OperandValue)(rolesFighter or 0))):GetValue(
                self, self)):AsLong()
        local skillFight = self:GetSkillFightingPower(fullHp, rolesFighter)
        fightingPower = fightingPower + skillFight
        self.fightingPower = fightingPower
        return fightingPower
    end
end

DynPlayer.GetSkillFightingPower = function(self, fullHp, herosFighter)
    -- function num : 0_59 , upvalues : _ENV, cs_GameData
    local skillList = {}
    local skillDic = {}
    if self.playerOriginSkillList ~= nil then
        for k, v in pairs(self.playerOriginSkillList) do
            (table.insert)(skillList, v)
            skillDic[v.dataId] = v
        end
    end
    do
        if self.playerItemSkillDict ~= nil then
            for k, v in pairs(self.playerItemSkillDict) do
                local oldSkill = skillDic[k.dataId]
                if oldSkill == nil or oldSkill.level < k.level then
                    if oldSkill then
                        (table.removebyvalue)(skillList, oldSkill)
                    end
                    (table.insert)(skillList, k)
                    skillDic[k.dataId] = k
                end
            end
        end
        do
            local fightingPower = 0
            for k, battleSkill in pairs(skillList) do
                local skillCfg = (cs_GameData.listBattleSkillDatas):GetDataById(
                                     battleSkill.dataId)
                if skillCfg == nil then
                    error("battle skill cfg is null,id:" ..
                              tostring(battleSkill.dataId))
                else
                    if skillCfg.combatFormula ~= nil then
                        if fullHp then
                            fightingPower =
                                fightingPower +
                                    (((((skillCfg.combatFormula):BindOption(
                                        ((CS.BattleFormula).eFormationOption).ReplaceHpWithMaxHp)):BindData(
                                        ((CS.BattleFormula).eFormulaBindType).SkillLevel,
                                        ((CS.FormulaOperand).OperandValue)(
                                            battleSkill.level))):BindArgData(
                                        herosFighter)):GetValue(self, self)):AsLong()
                        else
                            fightingPower =
                                fightingPower +
                                    ((((skillCfg.combatFormula):BindData(
                                        ((CS.BattleFormula).eFormulaBindType).SkillLevel,
                                        ((CS.FormulaOperand).OperandValue)(
                                            battleSkill.level))):BindArgData(
                                        herosFighter)):GetValue(self, self)):AsLong()
                        end
                    end
                end
            end
            return fightingPower
        end
    end
end

DynPlayer.GetFormulaAttr = function(self, attrEnum)
    -- function num : 0_60 , upvalues : _ENV, ExplorationEnum
    local attrId = (GR.EnumToInt)(attrEnum)
    if attrId == eHeroAttr.hp then
        local maxHp = (self.dynData):GetRealAttr(eHeroAttr.maxHp)
        local hp = (self.dynData).hpPer * maxHp //
                       ExplorationEnum.eHeroHpPercent
        if hp == 0 and (self.dynData).hpPer > 0 then hp = 1 end
        return hp
    else
        do
            if attrId == eHeroAttr.intensity then
                return (self.dynData).intensity
            else
                if attrId == eHeroAttr.attack_range then
                    return (self.dynData).attackRange
                else
                    return (self.dynData):GetRealAttr(attrId)
                end
            end
        end
    end
end

DynPlayer.UpdateEpBuff = function(self, epBuff)
    -- function num : 0_61 , upvalues : _ENV, DynEpBuff
    if epBuff == nil then return end
    self.epBuffList = {}
    for groupId, buffGroup in pairs(epBuff.data) do
        for _, buff in pairs(buffGroup.data) do
            local epBuff = (DynEpBuff.New)(buff);
            (table.insert)(self.epBuffList, epBuff)
        end
    end
    MsgCenter:Broadcast(eMsgEventId.OnEpBuffListChange, self.epBuffList)
end

DynPlayer.GetEpBuffList = function(self)
    -- function num : 0_62
    return self.epBuffList
end

DynPlayer.RecordLastMoney = function(self)
    -- function num : 0_63
    self.__lastMoney = self:GetMoneyCount()
end

DynPlayer.GetLastMoney = function(self)
    -- function num : 0_64
    return self.__lastMoney
end

DynPlayer.GetPlayerSkillMp = function(self)
    -- function num : 0_65
    return self.playerSkillMp
end

DynPlayer.GetDynPlayerName = function(self)
    -- function num : 0_66 , upvalues : _ENV
    return ConfigData.GetTipCp
end

DynPlayer.GetOriginAttr = function(self, attrId)
    -- function num : 0_67
    if self.dynData ~= nil then return (self.dynData):GetOriginAttr(attrId) end
end

DynPlayer.GetBaseAttr = function(self, attrId)
    -- function num : 0_68
    if self.dynData ~= nil then return (self.dynData):GetBaseAttr(attrId) end
end

DynPlayer.GetRatioAttr = function(self, attrId)
    -- function num : 0_69
    if self.dynData ~= nil then return (self.dynData):GetRatioAttr(attrId) end
end

DynPlayer.GetExtraAttr = function(self, attrId)
    -- function num : 0_70
    if self.dynData ~= nil then return (self.dynData):GetExtraAttr(attrId) end
end

DynPlayer.UpdateEpEventData = function(self, epOp)
    -- function num : 0_71
    if epOp.deco then
        if (epOp.deco)[1] then
            self:UpdateEpSaveMoneyList(((epOp.deco)[1]).arrParams,
                                       epOp.curPostion, epOp.path)
        else
            self:UpdateEpSaveMoneyList()
        end
        if (epOp.deco)[2] then
            self:UpdateEpBattleSkillLockDic(((epOp.deco)[2]).mapParams)
        else
            self:UpdateEpBattleSkillLockDic()
        end
    else
        self:UpdateEpSaveMoneyList()
        self:UpdateEpBattleSkillLockDic()
    end
end

DynPlayer.UpdateEpSaveMoneyList = function(self, arrParams, curPostion, path)
    -- function num : 0_72
    self.epSaveMoneyList = arrParams
    self.epCurPostion = curPostion
    self.epPath = path
end

DynPlayer.GetEpSaveMoney = function(self)
    -- function num : 0_73 , upvalues : _ENV
    local saveMoney = 0
    if not self.epSaveMoneyList or not self.epCurPostion or not self.epPath then
        return saveMoney
    end
    if #self.epSaveMoneyList % 3 ~= 0 then
        error("#self.epSaveMoneyList % 3 ~= 0")
        return saveMoney
    end
    for index = 1, #self.epSaveMoneyList, 3 do
        local param1 = (self.epSaveMoneyList)[index]
        local param2 = (self.epSaveMoneyList)[index + 1]
        local param3 = (self.epSaveMoneyList)[index + 2]
        local pathCount = #self.epPath - param1 - 1
        saveMoney = saveMoney + param2 * (1 + pathCount * param3 / 100)
    end
    return saveMoney
end

DynPlayer.UpdateEpBattleSkillLockDic = function(self, mapParams)
    -- function num : 0_74
    self.epBattleSkillLockDic = mapParams
end

DynPlayer.IsEpBattleSkillLock = function(self, skillId)
    -- function num : 0_75
    if self.epBattleSkillLockDic then
        return (self.epBattleSkillLockDic)[skillId]
    else
        return false
    end
end

return DynPlayer


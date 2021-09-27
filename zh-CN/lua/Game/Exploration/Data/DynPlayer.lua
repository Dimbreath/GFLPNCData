local DynChipHolder = require("Game.Exploration.Data.DynChipHolder")
local DynPlayer = class("DynPlayer", DynChipHolder)
local ItemData = require("Game.PlayerData.Item.ItemData")
local ChipData = require("Game.PlayerData.Item.ChipData")
local DynHero = require("Game.Exploration.Data.DynHero")
local DynPlayerData = require("Game.PlayerData.DynPlayer.DynPlayerData")
local DynEpBuffChip = require("Game.Exploration.Data.DynEpBuffChip")
local DynBattleSkill = require("Game.Exploration.Data.DynBattleSkill")
local DynCampFetter = require("Game.Exploration.Data.DynCampFetter")
local DynEpBuff = require("Game.Exploration.Data.DynEpBuff")
local AllDynServerGrid = require("Game.Exploration.Data.ServerGrid.AllDynServerGrid")
local DynChipSuitMgr = require("Game.Exploration.Data.ChipSuit.DynChipSuitMgr")
local DynRewardBag = require("Game.Exploration.Data.RewardBag.DynRewardBag")
local HeroData = require("Game.PlayerData.Hero.HeroData")
local CS_BattleManager = (CS.BattleManager).Instance
local ExplorationEnum = require("Game.Exploration.ExplorationEnum")
local HeroAttrUtility = require("Game.Exploration.Data.HeroAttrUtility")
local DeployTeamUtil = require("Game.Exploration.Util.DeployTeamUtil")
DynPlayer.ctor = function(self)
  -- function num : 0_0 , upvalues : DynPlayerData, _ENV, DynChipSuitMgr, AllDynServerGrid, DynRewardBag, ExplorationEnum
  self.money = 0
  self.energy = 0
  self.dynData = (DynPlayerData.New)()
  self.playerSkillMp = 0
  self.playerOriginSkillList = {}
  self.dynName = self:__getDynName()
  self.CSTId = nil
  self.allItemDic = {}
  self.allItemTypeDic = {}
  for k,v in pairs(eItemType) do
    -- DECOMPILER ERROR at PC22: Confused about usage of register: R6 in 'UnsetPending'

    (self.allItemTypeDic)[v] = {}
  end
  self.chipLimitInfo = {count = 0, limit = 0, firstLimit = true, discardId = nil}
  self.chipList = {}
  self.chipDic = {}
  self.epBuffChipDic = {}
  self.tmpBuffChipDic = {}
  self.campFetterDic = {}
  self.activeCampFetterId = nil
  self.epBuffList = {}
  self.__chipSuitMgr = (DynChipSuitMgr.New)(self)
  self.allDynServerGrid = (AllDynServerGrid.New)()
  self.dynRewardBag = (DynRewardBag.New)()
  self.epBattleSkillLockDic = {}
  self.__cacheFightPower = nil
  self.__isHeroInitReady = false
  self.playerClientState = (ExplorationEnum.ePlayerClientState).OutSideRoom
  self.cstSkillsRecordDic = {}
end

DynPlayer.CreateDefaultPlayer = function(self, epRoleStc, epRoleDyc, epStc, epStmGoods)
  -- function num : 0_1
  local epHeros = epRoleStc.heroes
  local playerSkillDic = (epRoleStc.player).skillGroup
  self:InitDynPlayer(0, epHeros, playerSkillDic, epStc.treeId, epRoleDyc)
  self:UpdateFormationDetail(epRoleDyc)
  self:UpdateFormationStc(epStc)
  ;
  (self.dynRewardBag):InitEpDynRewardBag(epStmGoods)
end

DynPlayer.InitDynPlayerAttr = function(self, attrData)
  -- function num : 0_2
  if self.dynData == nil then
    return 
  end
  ;
  (self.dynData):RefreshDynData(attrData)
end

DynPlayer.InitDynPlayer = function(self, money, heroDatas, playerSkillDic, CSTId, epRoleDyc)
  -- function num : 0_3
  self.money = money
  self:InitHeroTeam(heroDatas, epRoleDyc)
  self:InitPlayerSkill(playerSkillDic, CSTId)
  self:InitCampFetter()
end

DynPlayer.__getDynName = function(self)
  -- function num : 0_4 , upvalues : _ENV
  return ConfigData:GetTipContent(TipContent.CommanderDPSName)
end

DynPlayer.InitHeroTeam = function(self, heroDatas, epRoleDyc)
  -- function num : 0_5 , upvalues : _ENV, HeroData, DynHero
  self.heroList = {}
  self.heroDic = {}
  local tmpHeroIndexDic = {}
  for uid,heroElem in pairs(heroDatas) do
    if heroElem ~= nil then
      local heroTeamIndex = ((((epRoleDyc.role).role)[uid]).dync).formationIdx
      local roleType = (((epRoleDyc.role).role)[uid]).roleType
      local heroCfg = (ConfigData.hero_data)[heroElem.dataId]
      local oriHeroData = nil
      if roleType == proto_object_EplBattleRoleType.BattleRoleNormal then
        oriHeroData = (PlayerDataCenter.heroDic)[heroElem.dataId]
      end
      if oriHeroData == nil or not oriHeroData.skinId then
        local heroData = (HeroData.New)({
basic = {id = heroElem.dataId, level = heroElem.level, exp = 0, star = heroElem.rank, potentialLvl = heroElem.potential, ts = -1, career = heroCfg.career, company = heroCfg.camp, skinId = heroElem.skinId, cat = heroElem.cat, containSpecialModelSign = ((((epRoleDyc.role).role)[uid]).dync).model}
})
        for k,v in pairs(heroElem.skillGroup) do
          if (heroData.skillDic)[k] ~= nil then
            ((heroData.skillDic)[k]):UpdateSkill(v)
          end
        end
        do
          local dynHeroData = (DynHero.New)(heroData, uid, roleType)
          dynHeroData:SetDynHeroFmtIdx(heroTeamIndex)
          -- DECOMPILER ERROR at PC92: Confused about usage of register: R15 in 'UnsetPending'

          ;
          (self.heroDic)[heroData.dataId] = dynHeroData
          tmpHeroIndexDic[dynHeroData] = heroTeamIndex
          ;
          (table.insert)(self.heroList, dynHeroData)
          -- DECOMPILER ERROR at PC99: LeaveBlock: unexpected jumping out IF_THEN_STMT

          -- DECOMPILER ERROR at PC99: LeaveBlock: unexpected jumping out IF_STMT

          -- DECOMPILER ERROR at PC99: LeaveBlock: unexpected jumping out IF_THEN_STMT

          -- DECOMPILER ERROR at PC99: LeaveBlock: unexpected jumping out IF_STMT

        end
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
end

DynPlayer.CheckRoleTypeAndInsertHeroList = function(self, dynHeroData, attrDic, skillDic, hpPer)
  -- function num : 0_6 , upvalues : _ENV
  if dynHeroData.cat == (BattleUtil.battleRoleCat).waitToCasterHero then
    (table.insert)(self.heroWaitToCasterList, dynHeroData)
  end
  ;
  (table.insert)(self.heroList, dynHeroData)
  -- DECOMPILER ERROR at PC19: Confused about usage of register: R5 in 'UnsetPending'

  ;
  (self.heroDic)[dynHeroData.dataId] = dynHeroData
end

DynPlayer.CheckAndSortHeroList = function(self, tmpHeroIndexDic)
  -- function num : 0_7 , upvalues : _ENV
  if #self.heroList > 0 then
    (table.sort)(self.heroList, function(hero1, hero2)
    -- function num : 0_7_0 , upvalues : tmpHeroIndexDic
    do return tmpHeroIndexDic[hero1] < tmpHeroIndexDic[hero2] end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  end
  if #self.heroWaitToCasterList > 0 then
    (table.sort)(self.heroWaitToCasterList, function(hero1, hero2)
    -- function num : 0_7_1 , upvalues : tmpHeroIndexDic
    do return tmpHeroIndexDic[hero1] < tmpHeroIndexDic[hero2] end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  end
end

DynPlayer.CreateSupportDynHero = function(self, stc)
  -- function num : 0_8 , upvalues : _ENV
  local dyc = {coordination = 0, hpPer = 10000}
  local dynHero = self:CreateDynHero(stc, dyc, proto_object_EplBattleRoleType.BattleRoleAssist)
  return dynHero
end

DynPlayer.CreateDynHeroHeroData = function(self, stc, dyc, roleType, roleCat)
  -- function num : 0_9 , upvalues : _ENV, HeroData
  local heroCfg = (ConfigData.hero_data)[stc.dataId]
  local heroData = (HeroData.New)({
basic = {id = stc.dataId, level = stc.level, exp = 0, star = stc.rank, potentialLvl = stc.potential, ts = -1, career = heroCfg.career, company = heroCfg.camp, skinId = stc.skinId, cat = roleCat or 0, containSpecialModelSign = dyc.containSpecialModelSign}
})
  for k,v in pairs(stc.skillGroup) do
    if (heroData.skillDic)[k] ~= nil then
      ((heroData.skillDic)[k]):UpdateSkill(v)
    end
  end
  return heroData
end

DynPlayer.CreateDynHero = function(self, stc, dyc, roleType, roleCat)
  -- function num : 0_10 , upvalues : DynHero
  local heroData = self:CreateDynHeroHeroData(stc, dyc, roleType, roleCat)
  local dynHeroData = (DynHero.New)(heroData, stc.uid, roleType)
  dynHeroData:UpdateHpPer(dyc.hpPer)
  dynHeroData:UpdateBaseHeroData(stc.attr, stc.skillGroup, stc.athSkillGroup)
  return dynHeroData
end

DynPlayer.ChangeDynPlayerHeroList = function(self, enter, quit, change, battlRoleType)
  -- function num : 0_11 , upvalues : _ENV, DynHero
  for k,role in pairs(change) do
    self:UpdateDynPlayerHeroFull(role)
  end
  local newHeroList = {}
  local heroUidDic = {}
  local mirrorHeroDic = {}
  local addHeroList = {}
  local removeHeroList = {}
  local heroNum = 0
  for k,dynHero in ipairs(self.heroList) do
    local mirrorHero = (self.mirrorHeroList)[k]
    if quit[dynHero.uid] ~= nil then
      (table.insert)(removeHeroList, dynHero)
    else
      ;
      (table.insert)(newHeroList, dynHero)
      mirrorHeroDic[mirrorHero.uid] = mirrorHero
      if not dynHero:IsBench() then
        heroNum = heroNum + 1
      end
    end
  end
  for k,role in pairs(enter) do
    local dynHero = self:CreateDynHero((role.data).stc, (role.data).dyc, role.roleType)
    dynHero:SetDynHeroFmtIdx(((role.data).dyc).formationIdx)
    dynHero.onBench = (ConfigData.game_config).max_stage_hero <= heroNum
    if not dynHero:IsBench() then
      heroNum = heroNum + 1
    end
    ;
    (table.insert)(newHeroList, dynHero)
    ;
    (table.insert)(addHeroList, dynHero)
    local stc = (role.data).stc
    local mirrorHero = (DynHero.New)(dynHero.heroData, dynHero.uid, battlRoleType)
    mirrorHero:UpdateBaseHeroData(stc.attr, stc.skillGroup, stc.athSkillGroup)
    mirrorHeroDic[mirrorHero.uid] = mirrorHero
  end
  ;
  (table.sort)(newHeroList, function(a, b)
    -- function num : 0_11_0
    do return a:GetDynHeroFmtIdx() < b:GetDynHeroFmtIdx() end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  local newMirrorHeroList = {}
  for k,dynHero in ipairs(newHeroList) do
    newMirrorHeroList[k] = mirrorHeroDic[dynHero.uid]
    heroUidDic[dynHero.uid] = dynHero
  end
  self:SetPlayerNewHeroList(newHeroList, newMirrorHeroList, heroUidDic, mirrorHeroDic, enter)
  do return addHeroList, newHeroList, removeHeroList end
  -- DECOMPILER ERROR: 4 unprocessed JMP targets
end

DynPlayer.SetPlayerNewHeroList = function(self, newHeroList, newMirrorHeroList, heroUidDic, mirrorHeroDic, enterHeroUidDic)
  -- function num : 0_12 , upvalues : _ENV, DeployTeamUtil, CS_BattleManager
  self.heroList = newHeroList
  self.heroDic = {}
  for k,dynHero in ipairs(newHeroList) do
    -- DECOMPILER ERROR at PC9: Confused about usage of register: R11 in 'UnsetPending'

    (self.heroDic)[dynHero.dataId] = dynHero
  end
  self.mirrorHeroList = newMirrorHeroList
  local size_row, size_col, deploy_rows = (BattleUtil.GetCurSceneBattleFieldSize)()
  ;
  (DeployTeamUtil.DeployHeroTeam)(self.heroList, size_row, size_col, deploy_rows)
  CS_BattleManager:UpdateBattleRoleData()
  MsgCenter:Broadcast(eMsgEventId.OnEpPlayerHeroDataChange)
  self:RefreshCacheFightPower()
  local addHeroList = {}
  for uid,_ in pairs(enterHeroUidDic) do
    local dynHero = heroUidDic[uid]
    ;
    (table.insert)(addHeroList, dynHero)
  end
  self:ExecuteAllChip2NewHeroList(addHeroList)
  self:ExecuteAllSuitChip2NewHeroList(addHeroList)
end

DynPlayer.ExecuteAllChip2NewHeroList = function(self, newHeroList)
  -- function num : 0_13 , upvalues : _ENV
  for k,chipData in pairs(self.chipList) do
    local validRoleList = chipData:GetValidRoleList(newHeroList, eBattleRoleBelong.player)
    for k,v in pairs(validRoleList) do
      chipData:ExecuteChipData(v)
    end
  end
  for k,buffChip in pairs(self.epBuffChipDic) do
    local validRoleList = buffChip:GetValidRoleList(newHeroList, eBattleRoleBelong.player)
    for k,v in pairs(validRoleList) do
      buffChip:ExecuteBuffChip(v)
    end
  end
  for k,buffChip in pairs(self.tmpBuffChipDic) do
    local validRoleList = buffChip:GetValidRoleList(newHeroList, eBattleRoleBelong.player)
    for k,v in pairs(validRoleList) do
      buffChip:ExecuteChipData(v)
    end
  end
end

DynPlayer.ExecuteAllSuitChip2NewHeroList = function(self, newHeroList)
  -- function num : 0_14
  (self.__chipSuitMgr):ExecuteAllSuitChipForList(newHeroList)
end

DynPlayer.InitMirrorHeroTeam = function(self)
  -- function num : 0_15 , upvalues : _ENV, DynHero, DynPlayer
  self.mirrorHeroList = {}
  for k,dynHero in pairs(self.heroList) do
    local dynHeroData = (DynHero.New)(dynHero.heroData, dynHero.uid, dynHero.roleType)
    ;
    (table.insert)(self.mirrorHeroList, dynHeroData)
  end
  self.mirrorDynPlayer = (DynPlayer.New)()
end

DynPlayer.UpdateDynPlayerHeroFull = function(self, role)
  -- function num : 0_16 , upvalues : _ENV
  local dynHeroData = (self.heroDic)[((role.data).stc).dataId]
  if dynHeroData == nil then
    error("Cant get dynHeroData, heroId:" .. tostring(((role.data).stc).dataId))
    return 
  end
  local stc = (role.data).stc
  local dyc = (role.data).dyc
  local heroData = self:CreateDynHeroHeroData((role.data).stc, (role.data).dyc, role.roleType)
  dynHeroData:InitDynHeroData(heroData, stc.uid, role.roleType)
  dynHeroData:UpdateHpPer(dyc.hpPer)
  dynHeroData:UpdateBaseHeroData(stc.attr, stc.skillGroup, stc.athSkillGroup)
end

DynPlayer.GetDeployAliveHeroCount = function(self)
  -- function num : 0_17 , upvalues : _ENV
  local count = 0
  for k,dynHero in pairs(self.heroList) do
    if not dynHero.onBench and not dynHero:IsDead() then
      count = count + 1
    end
  end
  return count
end

DynPlayer.InitPlayerSkill = function(self, playerSkillDic, CSTId)
  -- function num : 0_18 , upvalues : _ENV, DynBattleSkill
  self.playerOriginSkillList = {}
  self.CSTId = CSTId
  local curSkillIds = {}
  if playerSkillDic ~= nil then
    for skillId,skillLevel in pairs(playerSkillDic) do
      local data = (DynBattleSkill.New)(skillId, skillLevel, eBattleSkillLogicType.Original)
      ;
      (table.insert)(self.playerOriginSkillList, data)
      ;
      (table.insert)(curSkillIds, skillId)
    end
  end
  do
    self:SetCstSkillsRecordByTreeId(CSTId, curSkillIds)
  end
end

DynPlayer.GetCSTId = function(self)
  -- function num : 0_19
  return self.CSTId
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
    local battle = nil
    for k1,v1 in pairs(heroBattleData) do
      if v1.dataId == dynHero.dataId then
        battle = v1
      end
    end
    if battle ~= nil then
      dynHero:UpdateBaseHeroData(battle.attr, battle.skillGroup, battle.athSkillGroup)
      local mirrorDynHero = (self.mirrorHeroList)[k]
      mirrorDynHero:UpdateBaseHeroData(battle.attr, battle.skillGroup, battle.athSkillGroup)
    end
  end
  self.__isHeroInitReady = true
  self:RefreshCacheFightPower()
end

DynPlayer.UpdateOperatorDetail = function(self, operatorDetail)
  -- function num : 0_23 , upvalues : _ENV
  self.operatorDetail = operatorDetail
  if ExplorationManager.epCtrl ~= nil then
    local epSpecialRoomData = ((ExplorationManager.epCtrl).mapData):GetEpSpecialRoomData()
    epSpecialRoomData:SetEpRoomType(operatorDetail.specialCat)
  end
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
  -- function num : 0_26 , upvalues : _ENV, ItemData
  if epBackpack == nil then
    return 
  end
  self.allItemDic = {}
  for k,v in pairs(self.allItemTypeDic) do
    -- DECOMPILER ERROR at PC11: Confused about usage of register: R7 in 'UnsetPending'

    (self.allItemTypeDic)[k] = {}
  end
  -- DECOMPILER ERROR at PC18: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (epBackpack.item)[ConstGlobalItem.EpMoney] = epBackpack.eplGold
  for k,num in pairs(epBackpack.item) do
    local itemData = (ItemData.New)(k, num)
    -- DECOMPILER ERROR at PC28: Confused about usage of register: R8 in 'UnsetPending'

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
  local money = epBackpack.eplGold
  if self.money ~= money then
    self._lastMoneyAdd = money - self.money
    self.money = money
    MsgCenter:Broadcast(eMsgEventId.EpMoneyChange, self.money)
  end
  if epBackpack.algData ~= nil then
    self:__UpdateAllChip((epBackpack.algData).alg, nil, (epBackpack.algData).tmp, nil, (epBackpack.algData).tmpBuff, nil)
  end
  -- DECOMPILER ERROR at PC107: Confused about usage of register: R5 in 'UnsetPending'

  if epBackpack.algUpperLimit ~= (self.chipLimitInfo).limit then
    (self.chipLimitInfo).limit = epBackpack.algUpperLimit
    MsgCenter:Broadcast(eMsgEventId.OnChipLimitChange)
  end
end

DynPlayer.UpdateChipDiff = function(self, diffData)
  -- function num : 0_27
  self:__UpdateAllChip(diffData.update, diffData.delete, diffData.tmpUpdate, diffData.tmpDelete, diffData.tmpBuffUpdate, diffData.tmpBuffDelete)
end

DynPlayer.InitDynPlayerChip = function(self, chipUpdate)
  -- function num : 0_28
  self:__UpdateAllChip(chipUpdate)
end

DynPlayer.__UpdateAllChip = function(self, chipUpdate, chipDelete, tmpChipUpdate, tmpChipDelete, tmpBuffUpdate, tmpBuffDelete)
  -- function num : 0_29 , upvalues : _ENV, ChipData, DynEpBuffChip, CS_BattleManager
  if ExplorationManager.epCtrl ~= nil then
    (ExplorationManager.epCtrl):RollbackNormalChipBattleRoom()
  end
  local haveTmpChipUpdate = false
  if (tmpChipUpdate ~= nil and (table.count)(tmpChipUpdate) > 0) or tmpChipDelete ~= nil and (table.count)(tmpChipDelete) > 0 then
    haveTmpChipUpdate = true
    if ExplorationManager.epCtrl ~= nil then
      (ExplorationManager.epCtrl):RollbackTempChipCurBattleRoom(self.epBuffChipDic)
    end
  end
  local chipShowDel = {}
  local chipShowAdd = {}
  if chipDelete ~= nil then
    for chipId,v in pairs(chipDelete) do
      local chipData = (self.chipDic)[chipId]
      if chipData ~= nil then
        self:__RollBackChipInternal(chipData)
      end
      -- DECOMPILER ERROR at PC51: Confused about usage of register: R16 in 'UnsetPending'

      ;
      (self.chipDic)[chipId] = nil
      chipShowDel[chipId] = true
    end
  end
  do
    if tmpChipDelete ~= nil then
      for chipId,num in pairs(tmpChipDelete) do
        local buffChip = (self.epBuffChipDic)[chipId]
        if buffChip ~= nil then
          self:__RollBackBuffChip(buffChip)
        end
        -- DECOMPILER ERROR at PC69: Confused about usage of register: R16 in 'UnsetPending'

        ;
        (self.epBuffChipDic)[chipId] = nil
      end
    end
    do
      if tmpBuffDelete ~= nil then
        for chipId,num in pairs(tmpBuffDelete) do
          local chipData = (self.tmpBuffChipDic)[chipId]
          if chipData ~= nil then
            self:__RollBackChipInternal(chipData)
          end
          -- DECOMPILER ERROR at PC86: Confused about usage of register: R16 in 'UnsetPending'

          ;
          (self.tmpBuffChipDic)[chipId] = nil
          chipShowDel[chipId] = true
        end
      end
      do
        if chipUpdate ~= nil then
          for chipId,num in pairs(chipUpdate) do
            local chipData = (self.chipDic)[chipId]
            if chipData ~= nil then
              self:__RollBackChipInternal(chipData)
              chipData:SetCount(num)
              self:__ExecuteChipInternal(chipData)
            else
              local chipData = (ChipData.New)(chipId, num)
              -- DECOMPILER ERROR at PC115: Confused about usage of register: R17 in 'UnsetPending'

              ;
              (self.chipDic)[chipId] = chipData
              self:__ExecuteChipInternal(chipData)
              chipShowAdd[chipId] = true
            end
          end
        end
        do
          if tmpChipUpdate ~= nil then
            for chipId,num in pairs(tmpChipUpdate) do
              local buffChip = (self.epBuffChipDic)[chipId]
              if buffChip ~= nil then
                self:__RollBackBuffChip(buffChip)
                buffChip:SetCount(num)
                self:__ExecuteBuffChip(buffChip)
              else
                local buffChip = (DynEpBuffChip.New)(chipId, num)
                -- DECOMPILER ERROR at PC147: Confused about usage of register: R17 in 'UnsetPending'

                ;
                (self.epBuffChipDic)[chipId] = buffChip
                self:__ExecuteBuffChip(buffChip)
              end
            end
          end
          do
            if tmpBuffUpdate ~= nil then
              for chipId,num in pairs(tmpBuffUpdate) do
                local chipData = (self.tmpBuffChipDic)[chipId]
                if chipData ~= nil then
                  self:__RollBackBuffChip(chipData)
                  chipData:SetCount(num)
                  self:__ExecuteBuffChip(chipData)
                else
                  local chipData = (ChipData.New)(chipId, num)
                  chipData:SetIsShowTemp(true)
                  -- DECOMPILER ERROR at PC181: Confused about usage of register: R17 in 'UnsetPending'

                  ;
                  (self.tmpBuffChipDic)[chipId] = chipData
                  self:__ExecuteBuffChip(chipData)
                  chipShowAdd[chipId] = true
                end
              end
            end
            do
              local chipList = {}
              for chipId,chipData in pairs(self.chipDic) do
                (table.insert)(chipList, chipData)
              end
              for k,chipData in pairs(self.tmpBuffChipDic) do
                (table.insert)(chipList, chipData)
              end
              self.chipList = chipList
              self:__SortChipList()
              self:UpdateChipLimitNum()
              if ExplorationManager.epCtrl ~= nil then
                (ExplorationManager.epCtrl):ExecuteNormalChipBattleRoom()
              end
              if haveTmpChipUpdate and ExplorationManager.epCtrl ~= nil then
                (ExplorationManager.epCtrl):ExecuteTempChipCurBattleRoom(self:GetEpBuffChipDic())
              end
              self:__UpdateChipSuitDiff(chipShowDel, chipShowAdd)
              MsgCenter:Broadcast(eMsgEventId.OnEpChipListChange, self.chipList)
              CS_BattleManager:UpdateBattleRoleData()
              self:RefreshCacheFightPower()
            end
          end
        end
      end
    end
  end
end

DynPlayer.__UpdateChipSuitDiff = function(self, chipShowDel, chipShowAdd)
  -- function num : 0_30
  (self.__chipSuitMgr):UpdateChipSuitDiff(chipShowDel, chipShowAdd)
end

DynPlayer.__SortChipList = function(self)
  -- function num : 0_31 , upvalues : _ENV
  (table.sort)(self.chipList, function(a, b)
    -- function num : 0_31_0
    do return a.dataId < b.dataId end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
end

DynPlayer.SetChipDiscardId = function(self, id)
  -- function num : 0_32
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R2 in 'UnsetPending'

  (self.chipLimitInfo).discardId = id
end

DynPlayer.GetChipDiscardId = function(self)
  -- function num : 0_33
  return (self.chipLimitInfo).discardId
end

DynPlayer.GetChipUpgradeLimitPrice = function(self)
  -- function num : 0_34 , upvalues : _ENV, ExplorationEnum
  local discardId = self:GetChipDiscardId()
  local discardCfg = (ConfigData.exploration_discard)[discardId]
  if discardCfg == nil then
    error("can\'t read discardCfg with discardId=" .. tostring(discardId))
    return ConstGlobalItem.EpMoney, 0
  end
  if not discardCfg.upgrade_scaleId then
    local costItemId = ConstGlobalItem.EpMoney
  end
  local costItemNum = 0
  local levelCfg = discardCfg.upgrade_level
  local scaleValuesCfg = discardCfg.upgrade_scaleValues
  local levelCount = #levelCfg
  local chipDiscardLimit = self:GetChipDiscardLimit()
  for i = 1, levelCount do
    -- DECOMPILER ERROR at PC38: Unhandled construct in 'MakeBoolean' P1

    if i <= 1 and chipDiscardLimit <= levelCfg[1] then
      costItemNum = scaleValuesCfg[1]
    end
    -- DECOMPILER ERROR at PC46: Unhandled construct in 'MakeBoolean' P1

    if levelCount <= i and levelCfg[i - 1] <= chipDiscardLimit then
      costItemNum = scaleValuesCfg[i]
    end
    if levelCfg[i - 1] <= chipDiscardLimit and chipDiscardLimit < levelCfg[i] then
      costItemNum = scaleValuesCfg[i]
    end
  end
  costItemNum = costItemNum - (PlayerDataCenter.playerBonus):GetChipCeilingCostReduce()
  local scaleNum = self:GetSpecificBuffLogicPerPara((ExplorationEnum.eBuffLogicId).buyChipLimitNum)
  costItemNum = (math.floor)((costItemNum) * ((100 + scaleNum) / 100))
  return costItemId, costItemNum
end

DynPlayer.GetChipDiscardLimit = function(self)
  -- function num : 0_35
  return (self.chipLimitInfo).limit
end

DynPlayer.UpdateChipLimitNum = function(self)
  -- function num : 0_36 , upvalues : _ENV
  local count = 0
  if self.tmpBuffChipDic ~= nil then
    count = (table.count)(self.tmpBuffChipDic)
  end
  for _,chipData in pairs(self.chipDic) do
    if not chipData:IsConsumeSkillChip() then
      count = count + 1
    end
  end
  -- DECOMPILER ERROR at PC21: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self.chipLimitInfo).count = count
end

DynPlayer.IsChipOverLimitNum = function(self)
  -- function num : 0_37
  do return (self.chipLimitInfo).limit < (self.chipLimitInfo).count, (self.chipLimitInfo).count, (self.chipLimitInfo).limit end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

DynPlayer.IsChipFull = function(self)
  -- function num : 0_38
  do return (self.chipLimitInfo).limit <= (self.chipLimitInfo).count end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

DynPlayer.GetItemBag = function(self, type)
  -- function num : 0_39
  return (self.allItemTypeDic)[type]
end

DynPlayer.GetItemCount = function(self, dataId)
  -- function num : 0_40
  local itemData = self:GetItemById(dataId)
  if itemData ~= nil or not 0 then
    return itemData:GetCount()
  end
end

DynPlayer.GetItemCountByType = function(self, type, dataId)
  -- function num : 0_41
  local itemData = self:GetItemById(type, dataId)
  if itemData ~= nil or not 0 then
    return itemData:GetCount()
  end
end

DynPlayer.SetWeekExtrReward = function(self, weekExtrReward)
  -- function num : 0_42
  if not weekExtrReward then
    self.weekExtrReward = {}
  end
end

DynPlayer.GetWeekExtrReward = function(self)
  -- function num : 0_43
  return self.weekExtrReward
end

DynPlayer.GetEpRewardItemDic = function(self)
  -- function num : 0_44 , upvalues : _ENV
  local rewardsDic = {}
  for k,itemData in pairs(self.allItemDic) do
    if itemData:IsExplorationHold() then
      rewardsDic[k] = itemData:GetCount()
    end
  end
  if ExplorationManager:GetIsInWeeklyChallenge() and self.weekExtrReward ~= nil then
    for id,num in pairs(self.weekExtrReward) do
      if num > 0 then
        if rewardsDic[id] == nil then
          rewardsDic[id] = num
        else
          rewardsDic[id] = rewardsDic[id] + num
        end
      end
    end
  end
  do
    return rewardsDic
  end
end

DynPlayer.GetItemById = function(self, dataId)
  -- function num : 0_45 , upvalues : _ENV
  local itemCfg = (ConfigData.item)[dataId]
  if itemCfg == nil then
    error("item cfg is null,Id:" .. tostring(dataId))
    return 
  end
  return (self.allItemDic)[dataId]
end

DynPlayer.GetMoneyIconId = function(self)
  -- function num : 0_46 , upvalues : _ENV
  local cfg = (ConfigData.item)[ConstGlobalItem.EpMoney]
  return cfg ~= nil and cfg.icon or nil
end

DynPlayer.GetMoneyCount = function(self)
  -- function num : 0_47
  return self.money
end

DynPlayer.GetEpMoneyLastAddNum = function(self)
  -- function num : 0_48
  return self._lastMoneyAdd or 0
end

DynPlayer.GetChipList = function(self)
  -- function num : 0_49
  return self.chipList
end

DynPlayer.GetChipLimitInfo = function(self)
  -- function num : 0_50
  return self.chipLimitInfo
end

DynPlayer.GetNormalChipDic = function(self)
  -- function num : 0_51
  return self.chipDic
end

DynPlayer.GetEpBuffChipDic = function(self)
  -- function num : 0_52
  return self.epBuffChipDic
end

DynPlayer.GetTmpBuffChipDic = function(self)
  -- function num : 0_53
  return self.tmpBuffChipDic
end

DynPlayer.GetChipSuitSortList = function(self)
  -- function num : 0_54
  return (self.__chipSuitMgr):GetChipSuitListData()
end

DynPlayer.GetChipTagIdCount = function(self, tagId)
  -- function num : 0_55
  return (self.__chipSuitMgr):GetChipTagIdCount(tagId)
end

DynPlayer.__RollBackChipInternal = function(self, chipData, isMirror)
  -- function num : 0_56 , upvalues : _ENV
  if isMirror then
    if (self.mirrorDynPlayer):ContainChip(chipData) then
      chipData:RollbackChipData(self.mirrorDynPlayer)
      return 
    end
    for k,v in pairs(self.mirrorHeroList) do
      chipData:RollbackChipData(v)
    end
  else
    do
      if self:ContainChip(chipData) then
        chipData:RollbackChipData(self)
        return 
      end
      for k,v in pairs(self.heroList) do
        chipData:RollbackChipData(v)
      end
    end
  end
end

DynPlayer.__ExecuteChipInternal = function(self, chipData, isMirror)
  -- function num : 0_57 , upvalues : _ENV
  local isForDynPlayer = chipData:IsValidDynPlayer()
  if isForDynPlayer then
    if isMirror then
      chipData:ExecuteChipData(self.mirrorDynPlayer)
    else
      chipData:ExecuteChipData(self)
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
    chipData:ExecuteChipData(v)
  end
end

DynPlayer.ExecuteChip = function(self, chipData, isOwnData)
  -- function num : 0_58 , upvalues : _ENV
  local oldChip = (self.chipDic)[chipData.dataId]
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
      -- DECOMPILER ERROR at PC27: Confused about usage of register: R4 in 'UnsetPending'

      ;
      (self.chipDic)[chipData.dataId] = chipData
      ;
      (table.insert)(self.chipList, chipData)
      ;
      (table.sort)(self.chipList, function(a, b)
    -- function num : 0_58_0
    do return a.dataId < b.dataId end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
    end
  end
end

DynPlayer.RollBackChip = function(self, chipData, isOwnData)
  -- function num : 0_59 , upvalues : _ENV
  local oldChip = (self.chipDic)[chipData.dataId]
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
      -- DECOMPILER ERROR at PC35: Confused about usage of register: R6 in 'UnsetPending'

      ;
      (self.chipDic)[chipData.dataId] = nil
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
  -- function num : 0_60 , upvalues : _ENV
  buffChip:RollbackBuffChip(self)
  for k,v in pairs(self.heroList) do
    buffChip:RollbackBuffChip(v)
  end
end

DynPlayer.__ExecuteBuffChip = function(self, buffChip)
  -- function num : 0_61 , upvalues : _ENV
  if buffChip:IsValidDynPlayer() then
    buffChip:ExecuteBuffChip(self)
    return 
  end
  local validRoleList = buffChip:GetValidRoleList(self.heroList, eBattleRoleBelong.player)
  for k,v in pairs(validRoleList) do
    buffChip:ExecuteBuffChip(v)
  end
end

DynPlayer.GetChipCount = function(self, chipId)
  -- function num : 0_62
  local chipData = (self.chipDic)[chipId]
  if chipData ~= nil then
    return chipData:GetCount()
  else
    return 0
  end
end

local FightingPowerNumber = 100
DynPlayer.GetChipCombatEffect = function(self, chipData, isOwnData, noContainBench)
  -- function num : 0_63 , upvalues : FightingPowerNumber
  local containBench = not noContainBench
  local originPower = self:GetMirrorTeamFightPower(true, containBench)
  local oldPower = self:GetTotalFightingPower(true, containBench)
  local noOldChip = (self.chipDic)[chipData.dataId] == nil
  self:ExecuteChip(chipData, isOwnData)
  if noOldChip then
    (self.__chipSuitMgr):TempAddChipSuit(chipData)
  end
  local powerChange = self:GetTotalFightingPower(true, containBench) - oldPower
  self:RollBackChip(chipData, isOwnData)
  if noOldChip then
    (self.__chipSuitMgr):TempSubChipSuit(chipData, true)
  end
  local combatEffect = 0
  if originPower > 0 then
    combatEffect = powerChange / originPower * FightingPowerNumber
  end
  do return combatEffect end
  -- DECOMPILER ERROR: 4 unprocessed JMP targets
end

DynPlayer.GetChipDiscardFightPower = function(self, chipData, noContainBench)
  -- function num : 0_64 , upvalues : FightingPowerNumber
  local containBench = not noContainBench
  chipData = (self.chipDic)[chipData.dataId]
  local originPower = self:GetMirrorTeamFightPower(true, containBench)
  local oldPower = self:GetTotalFightingPower(true, containBench)
  self:__RollBackChipInternal(chipData)
  ;
  (self.__chipSuitMgr):TempSubChipSuit(chipData, false)
  local powerChange = oldPower - self:GetTotalFightingPower(true, containBench)
  self:__ExecuteChipInternal(chipData)
  ;
  (self.__chipSuitMgr):TempAddChipSuit(chipData)
  local combatEffect = 0
  if originPower > 0 then
    combatEffect = powerChange / originPower * FightingPowerNumber
  end
  return combatEffect
end

DynPlayer.GetMirrorTeamFightPower = function(self, fullHpPower, includeOnBench)
  -- function num : 0_65 , upvalues : _ENV
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
  local dynPlayerFightingPower = (self.mirrorDynPlayer):GetPlayerFightingPower(fightingPower)
  fightingPower = fightingPower + dynPlayerFightingPower
  return fightingPower
end

DynPlayer.GetTotalFightingPower = function(self, fullHpPower, includeOnBench)
  -- function num : 0_66 , upvalues : _ENV
  if not fullHpPower then
    fullHpPower = false
  end
  local fightingPower = 0
  for k,dynHero in pairs(self.heroList) do
    if (not dynHero:IsDead() or fullHpPower) and (not dynHero.onBench or includeOnBench) then
      fightingPower = fightingPower + dynHero:GetFightingPower(fullHpPower)
    end
  end
  local dynPlayerFightingPower = self:GetPlayerFightingPower(fightingPower)
  fightingPower = fightingPower + dynPlayerFightingPower
  return fightingPower
end

DynPlayer.UpdateFormationDetail = function(self, epRoleDyc)
  -- function num : 0_67 , upvalues : _ENV, CS_BattleManager, DeployTeamUtil
  local size_row, size_col, deploy_rows = ExplorationManager:GetEpSceneBattleFieldSize()
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
      CS_BattleManager:UpdatePlayerData()
      if epRoleDyc.role ~= nil then
        local benchX = (ConfigData.buildinConfig).BenchX
        if (epRoleDyc.role).initial then
          (DeployTeamUtil.DeployHeroTeam)(self.heroList, size_row, size_col, deploy_rows)
        end
        local emptyBenchPos = {}
        for i = 0, (ConfigData.game_config).battleMap_bench_count - 1 do
          (table.insert)(emptyBenchPos, i)
        end
        local newSet2BenchDynRole = {}
        for k,v in pairs((epRoleDyc.role).role) do
          local dynHero = self:GetDynHeroByUid(k)
          if dynHero == nil then
            error("Can\'t find dynHero, id = " .. tostring(k))
          else
            dynHero:UpdateHpPer((v.dync).hpPer)
            if not (epRoleDyc.role).initial then
              dynHero:SetCoord((v.dync).coordination, benchX)
            end
            if dynHero.onBench then
              (table.removebyvalue)(emptyBenchPos, dynHero.y)
            else
              if benchX <= (BattleUtil.Pos2XYCoord)((v.dync).coordination) then
                (table.insert)(newSet2BenchDynRole, dynHero)
              end
            end
          end
        end
        if #emptyBenchPos < #newSet2BenchDynRole then
          error("have to move " .. tostring(#newSet2BenchDynRole) .. " hero to bench, but bench only have " .. tostring(#emptyBenchPos) .. " empyt slots")
        end
        for index,dynHero in ipairs(newSet2BenchDynRole) do
          if emptyBenchPos[index] ~= nil then
            dynHero:SetCoordXY(benchX, emptyBenchPos[index], benchX)
          end
        end
        CS_BattleManager:UpdateBattleRoleData()
        MsgCenter:Broadcast(eMsgEventId.OnEpPlayerHeroDataChange)
        self:RefreshCacheFightPower()
      end
    end
  end
end

DynPlayer.UpdateFormationStc = function(self, epStc)
  -- function num : 0_68 , upvalues : _ENV
  for k,v in pairs(epStc.record) do
    local dynHero = self:GetDynHeroByUid(k)
    if dynHero == nil then
      error("Can\'t find dynHero, id = " .. tostring(k))
    else
      dynHero:UpdateTotalDamage((v.record)[2])
    end
  end
end

DynPlayer.UpdateRolePos = function(self, formData, stageCfg)
  -- function num : 0_69 , upvalues : _ENV
  if formData == nil then
    return 
  end
  for k,v in pairs(formData) do
    local dynHero = self:GetDynHeroByUid(k)
    if dynHero == nil then
      error("Can\'t find dynHero, id = " .. tostring(k))
    else
      dynHero:SetCoord((v.dync).coordination, (ConfigData.buildinConfig).BenchX)
    end
  end
end

DynPlayer.GetDynHeroByDataId = function(self, id)
  -- function num : 0_70
  return (self.heroDic)[id]
end

DynPlayer.GetDynHeroByUid = function(self, id)
  -- function num : 0_71 , upvalues : _ENV
  for k,v in pairs(self.heroDic) do
    if v.uid == id then
      return v
    end
  end
  return nil
end

DynPlayer.GetChipReturnMoney = function(self, chipId, count)
  -- function num : 0_72 , upvalues : _ENV
  local haveChipData = (self.chipDic)[chipId]
  if haveChipData ~= nil and not haveChipData:IsConsumeSkillChip() then
    local maxLevel = haveChipData:GetChipMaxLevel()
    local overflowCount = haveChipData:GetCount() + count - maxLevel
    overflowCount = (math.min)(overflowCount, maxLevel)
    if overflowCount > 0 then
      local epTypeCfg = ExplorationManager:GetEpTypeCfg()
      if epTypeCfg == nil then
        return 0
      end
      local moneyReturn = (epTypeCfg.chip_return_price)[overflowCount]
      return moneyReturn
    end
  end
  do
    return 0
  end
end

DynPlayer.IsNormalChipFullLevel = function(self, chipId)
  -- function num : 0_73
  local haveChipData = (self.chipDic)[chipId]
  if haveChipData ~= nil and haveChipData:IsChipFullLevel() then
    return true
  end
  return false
end

DynPlayer.IsChipNewAndUpgradeState = function(self, chipId)
  -- function num : 0_74
  local haveChip = (self.chipDic)[chipId]
  if haveChip == nil then
    return true, false
  end
  return false, not haveChip:IsChipFullLevel()
end

DynPlayer.GetPlayerFightingPower = function(self, rolesFighter)
  -- function num : 0_75 , upvalues : _ENV
  if self._rolesPowerTab == nil then
    self._rolesPowerTab = {}
  end
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._rolesPowerTab).power = rolesFighter or 0
  local rolePower = (ConfigData.GetFormulaValue)(eFormulaType.Commander, self._rolesPowerTab)
  local skillFight = self:GetSkillFightingPower(rolePower)
  local fightingPower = rolePower + skillFight
  fightingPower = (math.floor)(fightingPower)
  self.fightingPower = fightingPower
  return fightingPower
end

DynPlayer.GetSkillFightingPower = function(self, heroPower)
  -- function num : 0_76 , upvalues : _ENV
  local skillList = {}
  local skillDic = {}
  if self.playerOriginSkillList ~= nil then
    for k,v in pairs(self.playerOriginSkillList) do
      (table.insert)(skillList, v)
      skillDic[v.dataId] = v
    end
  end
  do
    if self.__itemSkillDic ~= nil then
      for k,v in pairs(self.__itemSkillDic) do
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
        local battleCfg = (ConfigData.battle_skill)[battleSkill.dataId]
        if battleSkill.type ~= eBattleSkillLogicType.Chip and battleSkill.type ~= eBattleSkillLogicType.TempChip then
          do
            local isChipType = battleCfg == nil or battleCfg.skill_comat == ""
            fightingPower = fightingPower + PlayerDataCenter:GetBattleSkillFightPower(battleSkill.dataId, battleSkill.level, heroPower, isChipType)
            -- DECOMPILER ERROR at PC83: LeaveBlock: unexpected jumping out IF_THEN_STMT

            -- DECOMPILER ERROR at PC83: LeaveBlock: unexpected jumping out IF_STMT

          end
        end
      end
      do return fightingPower end
      -- DECOMPILER ERROR: 2 unprocessed JMP targets
    end
  end
end

DynPlayer.GetHeroList = function(self)
  -- function num : 0_77
  return self.heroList
end

DynPlayer.InitCampFetter = function(self)
  -- function num : 0_78 , upvalues : _ENV, DynCampFetter
  self.campFetterDic = {}
  self.activeCampFetterId = nil
  local campCount = {}
  for k,dynHero in pairs(self.heroList) do
    local campId = dynHero:GetCamp()
    campCount[campId] = (campCount[campId] or 0) + 1
  end
  for campId,campCount in pairs(campCount) do
    local campConnCfg = ConfigData:GetCampFetter(campId, campCount)
    if campConnCfg ~= nil then
      local dynCampFetter = (DynCampFetter.New)(campId, campConnCfg, campCount)
      -- DECOMPILER ERROR at PC43: Unhandled construct in 'MakeBoolean' P1

      if dynCampFetter:GetIsHaveActiveFetterSkill() and self.activeCampFetterId ~= nil then
        error("Has mult active campFeetter")
      else
        self.activeCampFetterId = campId
      end
      -- DECOMPILER ERROR at PC47: Confused about usage of register: R9 in 'UnsetPending'

      ;
      (self.campFetterDic)[campId] = dynCampFetter
    end
  end
end

DynPlayer.UpdateEpBuff = function(self, epBuff)
  -- function num : 0_79 , upvalues : _ENV, DynEpBuff
  if epBuff == nil then
    return 
  end
  self.epBuffList = {}
  for groupId,buffGroup in pairs(epBuff.data) do
    for _,buff in pairs(buffGroup.data) do
      local epBuff = (DynEpBuff.New)(buff.id)
      epBuff:InitDynEpBuffInfo(buff)
      ;
      (table.insert)(self.epBuffList, epBuff)
    end
  end
  for uid,value in pairs(epBuff.campFetter) do
    local campId = uid >> 32
    local heroNum = uid & CommonUtil.UInt32Max
    local dynCampFetter = (self.campFetterDic)[campId]
    if dynCampFetter:GetActiveFetterUID() ~= uid then
      dynCampFetter:SetActiveValue(value, uid)
    else
      dynCampFetter:SetActiveValue(value)
    end
  end
  MsgCenter:Broadcast(eMsgEventId.OnEpBuffListChange, self.epBuffList)
end

DynPlayer.GetEpBuffList = function(self)
  -- function num : 0_80
  return self.epBuffList
end

DynPlayer.GetEpBuffCount = function(self, buffId)
  -- function num : 0_81 , upvalues : _ENV
  local num = 0
  for index,epBuff in ipairs(self.epBuffList) do
    if buffId == epBuff.dataId then
      num = num + 1
    end
  end
  return num
end

DynPlayer.IsHaveSpecificTypeBuff = function(self, logicType)
  -- function num : 0_82 , upvalues : _ENV
  for _,dynEpBuff in ipairs(self.epBuffList) do
    local bool, logic_num, logic_per = dynEpBuff:GetSpecificLogicPara(logicType)
    if bool then
      return true, logic_num, logic_per
    end
  end
  return false
end

DynPlayer.GetSpecificBuffLogicPerPara = function(self, logicType)
  -- function num : 0_83 , upvalues : _ENV
  local perNum = 0
  for _,dynEpBuff in ipairs(self.epBuffList) do
    local bool, logic_num, logic_per = dynEpBuff:GetSpecificLogicPara(logicType)
    if bool then
      perNum = logic_per[1]
    end
  end
  return perNum
end

DynPlayer.UpdateAllDynServerGrid = function(self, epBattleGrid)
  -- function num : 0_84
  (self.allDynServerGrid):UpdateAllServerGrid(epBattleGrid, self)
end

DynPlayer.UpdateEpCommonData = function(self, epCommonData)
  -- function num : 0_85 , upvalues : _ENV
  if epCommonData == nil then
    return 
  end
  local haveUpdateMonster = false
  do
    if self.epCommonData ~= nil then
      local monster = (self.epCommonData).monster
      if monster ~= nil and (monster.lv ~= (epCommonData.monster).lv or monster.exp ~= (epCommonData.monster).exp) then
        haveUpdateMonster = true
        self.epMonsterLvUp = monster.lv < (epCommonData.monster).lv
        self:SetHasDebuffSelect(not self.epMonsterLvUp or epCommonData.buffChoices ~= nil)
        self.epMonsterOldLevel = monster.lv
        self._lastEpMonsterLvExpAdd = (math.max)((epCommonData.monster).exp - monster.exp, 0)
      end
    end
    self.lastEpCommonData = self.epCommonData
    self.epCommonData = epCommonData
    self._questChoiceDic = (self.epCommonData).questChoices
    if haveUpdateMonster then
      MsgCenter:Broadcast(eMsgEventId.UpdateEpMonsterLevel, (self.epCommonData).monster)
    end
    -- DECOMPILER ERROR: 5 unprocessed JMP targets
  end
end

DynPlayer.GetEnterFiledNum = function(self)
  -- function num : 0_86 , upvalues : _ENV
  local enterFieldNum = self:GetMaxRoleCountInStageLocally()
  if self.epCommonData == nil or (self.epCommonData).data == nil or not ((self.epCommonData).data)[proto_object_EplCommon.EplCommonEnterFiledNum] then
    return enterFieldNum
  end
end

DynPlayer.GetMaxRoleCountInStageLocally = function(self)
  -- function num : 0_87 , upvalues : _ENV
  if (BattleUtil.IsInTDBattle)() then
    return (ConfigData.game_config).max_stage_hero_in_td
  else
    return (ConfigData.game_config).max_stage_hero
  end
end

DynPlayer.HasEpMonsterLvUp = function(self, isCloseNextTip)
  -- function num : 0_88
  if self.epMonsterLvUp then
    if isCloseNextTip then
      self.epMonsterLvUp = false
    end
    return true, self.epMonsterOldLevel, ((self.epCommonData).monster).lv
  end
end

DynPlayer.GetEpMonsterLevelLastExpAdd = function(self)
  -- function num : 0_89
  return self._lastEpMonsterLvExpAdd or 0
end

DynPlayer.GetMonsterLevelData = function(self)
  -- function num : 0_90
  if self.epCommonData ~= nil then
    return (self.epCommonData).monster
  end
end

DynPlayer.HasDebuffSelect = function(self)
  -- function num : 0_91 , upvalues : _ENV
  do return not self.__IsHaveRandomDebuff or self:GetOperatorDetailState() == proto_object_ExplorationCurGridState.ExplorationCurGridState_MonsterLvUpgrade end
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

DynPlayer.SetHasDebuffSelect = function(self, bool)
  -- function num : 0_92
  self.__IsHaveRandomDebuff = bool
end

DynPlayer.GetEpDebuffSelectDic = function(self)
  -- function num : 0_93
  if self.epCommonData ~= nil then
    return (self.epCommonData).buffChoices
  end
end

DynPlayer.RecordLastMoney = function(self)
  -- function num : 0_94
  self.__lastMoney = self:GetMoneyCount()
end

DynPlayer.GetLastMoney = function(self)
  -- function num : 0_95
  return self.__lastMoney
end

DynPlayer.GetPlayerSkillMp = function(self)
  -- function num : 0_96
  return self.playerSkillMp
end

DynPlayer.GetDynPlayerName = function(self)
  -- function num : 0_97 , upvalues : _ENV
  return ConfigData.GetTipCp
end

DynPlayer.GetOriginMaxMp = function(self)
  -- function num : 0_98 , upvalues : _ENV
  if self.dynData ~= nil then
    return (self.dynData):GetOriginAttr(eHeroAttr.moveSpeed)
  end
end

DynPlayer.GetOriginAttrMaxRatio = function(self, attrId)
  -- function num : 0_99 , upvalues : _ENV
  if attrId < 100 then
    return ((ConfigData.attribute)[attrId]).uplimit_multy
  end
end

DynPlayer.GetAttrMaxNum = function(self, attrId)
  -- function num : 0_100 , upvalues : _ENV
  if attrId < 100 then
    return ((ConfigData.attribute)[attrId]).uplimit_num
  end
end

DynPlayer.GetAttrMinRatio = function(self, attrId)
  -- function num : 0_101 , upvalues : _ENV
  if attrId < 100 then
    return ((ConfigData.attribute)[attrId]).downlimit_multy
  end
end

DynPlayer.OffsetAttrFromChip = function(self, property, value)
  -- function num : 0_102 , upvalues : HeroAttrUtility
  (HeroAttrUtility.OffsetAttrFormDynPlayer)(self.dynData, property, value)
end

DynPlayer.GetOriginAttr = function(self, attrId)
  -- function num : 0_103
  if self.dynData ~= nil then
    return (self.dynData):GetOriginAttr(attrId)
  end
end

DynPlayer.GetBaseAttr = function(self, attrId)
  -- function num : 0_104
  if self.dynData ~= nil then
    return (self.dynData):GetBaseAttr(attrId)
  end
end

DynPlayer.GetRatioAttr = function(self, attrId)
  -- function num : 0_105
  if self.dynData ~= nil then
    return (self.dynData):GetRatioAttr(attrId)
  end
end

DynPlayer.GetExtraAttr = function(self, attrId)
  -- function num : 0_106
  if self.dynData ~= nil then
    return (self.dynData):GetExtraAttr(attrId)
  end
end

DynPlayer.UpdateEpEventData = function(self, epOp)
  -- function num : 0_107
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
  -- function num : 0_108
  self.epSaveMoneyList = arrParams
end

DynPlayer.GetEpSaveMoney = function(self)
  -- function num : 0_109 , upvalues : _ENV
  local saveMoney = 0
  if not self.epSaveMoneyList then
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
    saveMoney = saveMoney + param2 * (100 + param1 * param3)
  end
  saveMoney = (saveMoney) // 100
  return saveMoney
end

DynPlayer.UpdateEpBattleSkillLockDic = function(self, mapParams)
  -- function num : 0_110
  self.epBattleSkillLockDic = mapParams
end

DynPlayer.IsEpBattleSkillLock = function(self, skillId)
  -- function num : 0_111
  if self.epBattleSkillLockDic then
    return (self.epBattleSkillLockDic)[skillId]
  else
    return false
  end
end

DynPlayer.GetQuestChioceDic = function(self)
  -- function num : 0_112
  return self._questChoiceDic
end

DynPlayer.GetQuestId = function(self)
  -- function num : 0_113
  return (self.operatorDetail).questID
end

DynPlayer.GetCstSkillsRecord = function(self)
  -- function num : 0_114
  return self.cstSkillsRecordDic
end

DynPlayer.SetCstSkillsRecordByTreeId = function(self, treeId, skills)
  -- function num : 0_115
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R3 in 'UnsetPending'

  if treeId or 0 ~= 0 then
    (self.cstSkillsRecordDic)[treeId] = skills
  end
end

DynPlayer.SetResultSettlementData = function(self)
  -- function num : 0_116 , upvalues : _ENV
  local treeId = self:GetCSTId()
  local allFriendshipData = PlayerDataCenter.allFriendshipData
  local oldHeroLevelDic = {}
  local oldHeroExpDic = {}
  for heroId,dynHeroData in pairs(self.heroDic) do
    oldHeroLevelDic[dynHeroData.dataId] = (dynHeroData.heroData).level
    oldHeroExpDic[dynHeroData.dataId] = (dynHeroData.heroData).curExp
  end
  local resultSettlementData = {oldHeroLevelDic = oldHeroLevelDic, oldHeroExpDic = oldHeroExpDic}
  return resultSettlementData
end

return DynPlayer


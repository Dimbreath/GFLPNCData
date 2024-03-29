local UIExplorationResult = class("UIExplorationResult", UIBaseWindow)
local base = UIBaseWindow
local JumpManager = require("Game.Jump.JumpManager")
local UINBaseItemWithCount = require("Game.CommonUI.Item.UINBaseItemWithCount")
local eDynConfigData = require("Game.ConfigData.eDynConfigData")
local cs_ResLoader = CS.ResLoader
local cs_MessageCommon = CS.MessageCommon
local cs_DoTween = ((CS.DG).Tweening).DOTween
local HeroData = require("Game.PlayerData.Hero.HeroData")
local SectorEnum = require("Game.Sector.SectorEnum")
UIExplorationResult.EpResultType = {None = 0, CompleteEp = 1, CompleteEpFloor = 2, Fail = 3}
UIExplorationResult.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, cs_ResLoader, UINBaseItemWithCount, UIExplorationResult
  self.sectorNetworkCtrl = NetworkManager:GetNetwork(NetworkTypeID.Sector)
  self.isWin = false
  self.rewardsRecord = {}
  self.rewardList = {}
  self.resloader = (cs_ResLoader.Create)()
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Return, self, self.OnReturnClicked)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Again, self, self.OnRestartClicked)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Detail, self, self.ShowAllChips)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_ViewAllReward, self, self.ShowAllItems)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_GoNext, self, self.OnGoNextBtnClicked)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Exit, self, self.OnExitBtnClicked)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_FailGetReward, self, self.OnBtnFailGetReward)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_GiveUp, self, self.OnBtnFailGiveUp)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_SuccessSettle, self, self.OnBtnSuccessSettle)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_GotoItem1, self, self.Jump2HeroState)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_GotoItem2, self, self.Jump2HeroState)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Recomme, self, self.OnClickRecomme)
  ;
  (((self.ui).btn_Again).gameObject):SetActive(false)
  self.rewardItemPool = (UIItemPool.New)(UINBaseItemWithCount, (self.ui).rewardItem)
  ;
  (((self.ui).rewardItem).gameObject):SetActive(false)
  ;
  (((self.ui).btn_Recomme).gameObject):SetActive(false)
  self.__epResultType = (UIExplorationResult.EpResultType).None
end

UIExplorationResult.IsEpResultType = function(self, resultType)
  -- function num : 0_1
  do return self.__epResultType == resultType end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

UIExplorationResult.SetReturnCallback = function(self, callback)
  -- function num : 0_2
  self.returnCallback = callback
end

UIExplorationResult.CompleteExploration = function(self, rewards, firstClearRewards, needFirsPassReward, resultSettlementData, rewardDic)
  -- function num : 0_3 , upvalues : _ENV, UIExplorationResult
  AudioManager:PlayAudioById(3009)
  if not rewardDic then
    self.rewardsRecord = {}
    if not (ExplorationManager:GetDynPlayer()):GetWeekExtrReward() then
      local weekExtrReward = table.emptytable
    end
    ;
    (table.merge)(self.rewardsRecord, weekExtrReward)
    self.__isWCDouble = (ExplorationManager:GetDynPlayer()).weekExtrIsDouble
    self.__epResultType = (UIExplorationResult.EpResultType).CompleteEp
    if not rewards then
      self.backRewards = {}
      self.firstClearRewards = firstClearRewards
      self.isWin = true
      self.resultSettlementData = resultSettlementData
      self:UpdataResultsUI(self.isWin, false, needFirsPassReward)
      self:__PopAddFriend()
    end
  end
end

UIExplorationResult.CompleteExplorationFloor = function(self)
  -- function num : 0_4 , upvalues : _ENV, UIExplorationResult
  if ExplorationManager:HasEpRewardBag() then
    self.rewardsRecord = ((ExplorationManager:GetDynPlayer()).dynRewardBag):GetEpRewardBagDataDic()
  else
    self.rewardsRecord = (ExplorationManager:GetDynPlayer()):GetEpRewardItemDic()
  end
  self.__epResultType = (UIExplorationResult.EpResultType).CompleteEpFloor
  self.backRewards = {eplGold = (ExplorationManager:GetDynPlayer()):GetMoneyCount()}
  self.isWin = true
  self:UpdataResultsUI(self.isWin, true)
end

UIExplorationResult.FailExploration = function(self, rewards, rewardDic)
  -- function num : 0_5 , upvalues : _ENV, UIExplorationResult
  AudioManager:PlayAudioById(3010)
  if not rewardDic then
    self.rewardsRecord = {}
    if not (ExplorationManager:GetDynPlayer()):GetWeekExtrReward() then
      local weekExtrReward = table.emptytable
    end
    ;
    (table.merge)(self.rewardsRecord, weekExtrReward)
    self.__epResultType = (UIExplorationResult.EpResultType).Fail
    if not rewards then
      self.backRewards = {}
      self.isWin = false
      self:UpdataResultsUI(self.isWin)
      local returnStamina, remainLevelCount, costStamina = ExplorationManager:GetReturnStamina()
      ;
      ((self.ui).tex_RePoint):SetIndex(0, tostring(returnStamina))
      -- DECOMPILER ERROR at PC49: Confused about usage of register: R7 in 'UnsetPending'

      ;
      ((self.ui).tex_AgainPoint).text = tostring(costStamina)
      GuideManager:TryTriggerGuide(eGuideCondition.InEpResultFail)
      self:__PopAddFriend()
    end
  end
end

UIExplorationResult.__PopAddFriend = function(self)
  -- function num : 0_6 , upvalues : _ENV
  if ExplorationManager.astAv ~= nil and (PlayerDataCenter.friendDataCenter):TryGetFriendData((ExplorationManager.astAv).uid) == nil and not (PlayerDataCenter.friendDataCenter):GetIsFriendFull() then
    UIManager:ShowWindowAsync(UIWindowTypeID.MessageSideAddFriend, function(window)
    -- function num : 0_6_0 , upvalues : _ENV, self
    if window == nil then
      return 
    end
    window:InitAddHeroSide((ExplorationManager.astAv).uid, self.resloader)
  end
)
  end
end

UIExplorationResult.OnReturnClicked = function(self)
  -- function num : 0_7
  if self.isWin then
    self:__AfterSettleWin()
  else
    if self.returnCallback ~= nil then
      (self.returnCallback)()
    end
  end
end

UIExplorationResult.OnRestartClicked = function(self)
  -- function num : 0_8 , upvalues : _ENV, JumpManager
  local moduleId = ExplorationManager:GetEpModuleId()
  local stageCfg = ExplorationManager:GetSectorStageCfg()
  local againCostStamina = stageCfg.cost_strength_num
  if moduleId == proto_csmsg_SystemFunctionID.SystemFunctionID_Exploration and (PlayerDataCenter.stamina):GetCurrentStamina() < againCostStamina then
    JumpManager:Jump((JumpManager.eJumpTarget).BuyStamina)
    return 
  else
    if moduleId == proto_csmsg_SystemFunctionID.SystemFunctionID_Endless and (PlayerDataCenter.infinityData):IsInfinityDungeonCompleted(stageCfg.dungeonId) and (PlayerDataCenter.stamina):GetCurrentStamina() < againCostStamina then
      JumpManager:Jump((JumpManager.eJumpTarget).BuyStamina)
      return 
    end
  end
  ;
  (ExplorationManager.resultCtrl):ExecuteBattleEndClear()
  ExplorationManager:RestartExploratcion()
end

UIExplorationResult.OnGoNextBtnClicked = function(self)
  -- function num : 0_9 , upvalues : _ENV
  ExplorationManager:EnterNextSectionExploration()
end

UIExplorationResult.OnExitBtnClicked = function(self)
  -- function num : 0_10
end

UIExplorationResult.EpFailNoReward = function(self)
  -- function num : 0_11
end

UIExplorationResult.OnBtnFailGetReward = function(self)
  -- function num : 0_12
end

UIExplorationResult.OnBtnFailGiveUp = function(self)
  -- function num : 0_13 , upvalues : _ENV
  local returnStamina, _, costStamina = ExplorationManager:GetReturnStamina()
  if costStamina == 0 then
    if self.returnCallback ~= nil then
      (self.returnCallback)()
    end
    return 
  end
  local msg = nil
  if returnStamina == 0 then
    msg = ConfigData:GetTipContent(TipContent.exploration_Player_ExitExpo)
  else
    msg = (string.format)(ConfigData:GetTipContent(TipContent.exploration_Player_ExitExpoWithStaminaBack), returnStamina)
  end
  ;
  ((CS.MessageCommon).ShowMessageBox)(msg, function()
    -- function num : 0_13_0 , upvalues : self
    if self.returnCallback ~= nil then
      (self.returnCallback)()
    end
  end
, nil, false)
end

UIExplorationResult.OnBtnSuccessSettle = function(self)
  -- function num : 0_14 , upvalues : _ENV
  if ExplorationManager:HasEpRewardBag() then
    if self.isWin then
      self:__AfterSettleWin()
    else
      if self.returnCallback ~= nil then
        (self.returnCallback)()
      end
    end
    self:Delete()
  else
    if ExplorationManager:GetIsInWeeklyChallenge() then
      if self.isWin then
        self:__AfterSettleWin()
      else
        self:Delete()
        if self.returnCallback ~= nil then
          (self.returnCallback)()
        end
      end
    else
      if self.returnCallback ~= nil then
        (self.returnCallback)()
      end
    end
  end
end

UIExplorationResult.__ResetAllResultGroup = function(self)
  -- function num : 0_15
  ((self.ui).normalBtnGroup):SetActive(false)
  ;
  ((self.ui).overBtnGroup):SetActive(false)
  ;
  ((self.ui).failureBtnGroup):SetActive(false)
  ;
  ((self.ui).completeBtnGroup):SetActive(false)
end

UIExplorationResult.ShowWCTokenTip = function(self)
  -- function num : 0_16 , upvalues : _ENV
  if not ExplorationManager:GetIsInWeeklyChallenge() then
    return 
  end
  local rewardDic = (ExplorationManager:GetDynPlayer()):GetWeekExtrReward()
  if rewardDic ~= nil and (table.count)(rewardDic) > 0 then
    return 
  end
  ;
  ((self.ui).noReward):SetActive(true)
  ;
  ((self.ui).tex_noReward):SetIndex(0)
end

UIExplorationResult.UpdataResultsUI = function(self, isWin, isFloor, needFirsPassReward)
  -- function num : 0_17 , upvalues : _ENV
  local resultBG_Material = ((self.ui).img_ResultBG).material
  local hasEpRewardBag = ExplorationManager:HasEpRewardBag()
  self:__ResetAllResultGroup()
  if not isFloor then
    isFloor = false
  end
  if isWin then
    AudioManager:PlayAudioById(1003)
    ;
    ((self.ui).completeBtnGroup):SetActive(true)
    ;
    ((self.ui).img_ResultState):SetIndex(0)
    ;
    ((self.ui).tex_ResultState):SetIndex(0)
    ;
    ((self.ui).vectoryNode):SetActive(true)
    ;
    ((self.ui).failureNode):SetActive(false)
    resultBG_Material:SetFloat("_Decoloration", 0)
    -- DECOMPILER ERROR at PC50: Confused about usage of register: R6 in 'UnsetPending'

    ;
    ((self.ui).img_ResultBG).color = (self.ui).col_Success
  else
    AudioManager:PlayAudioById(1004)
    ;
    ((self.ui).img_ResultState):SetIndex(1)
    ;
    ((self.ui).tex_ResultState):SetIndex(1)
    ;
    ((self.ui).vectoryNode):SetActive(false)
    ;
    ((self.ui).failureNode):SetActive(true)
    resultBG_Material:SetFloat("_Decoloration", 1)
    ;
    ((self.ui).suggestBtn):SetActive(true)
    ;
    ((self.ui).suggestTips):SetActive(false)
    if not hasEpRewardBag then
      local returnStamina, remainLevelCount, costStamina, rewardReturnStamina = ExplorationManager:GetReturnStamina()
      if costStamina <= 0 then
        ((self.ui).normalBtnGroup):SetActive(true)
      else
        local retreatStamina = nil
        ExplorationManager:GetReturnStamina()
        ;
        ((self.ui).failureBtnGroup):SetActive(true)
        -- DECOMPILER ERROR at PC117: Confused about usage of register: R11 in 'UnsetPending'

        ;
        ((self.ui).tex_GetRewardPoint).text = tostring(rewardReturnStamina)
        -- DECOMPILER ERROR at PC123: Confused about usage of register: R11 in 'UnsetPending'

        ;
        ((self.ui).tex_RetreatPoint).text = tostring(returnStamina)
      end
    end
    do
      do
        local battleFailJumpUnlock = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_BattleFailJump)
        if not battleFailJumpUnlock then
          (((self.ui).failureNode).gameObject):SetActive(false)
        end
        ;
        (((((self.ui).tex_CurLevelLayer).transform).parent).gameObject):SetActive(isFloor)
        if isFloor then
          ((self.ui).completeBtnGroup):SetActive(false)
          ;
          ((self.ui).overBtnGroup):SetActive(true)
          ;
          ((self.ui).tex_CurLevelLayer):SetIndex(0, tostring(ExplorationManager:GetCurLevelIndex() + 1))
          ;
          ((self.ui).tex_ResultState):SetIndex(2)
          resultBG_Material:SetFloat("_Decoloration", 0)
          -- DECOMPILER ERROR at PC181: Confused about usage of register: R6 in 'UnsetPending'

          ;
          ((self.ui).img_ResultBG).color = (self.ui).col_Over
        end
        ;
        (((self.ui).tex_LevelName).gameObject):SetActive(not isFloor)
        if not isFloor then
          local sectorStageCfg = ExplorationManager:GetSectorStageCfg()
          if sectorStageCfg ~= nil then
            if sectorStageCfg.endlessCfg ~= nil then
              ((self.ui).tex_LevelCount):SetIndex(1, tostring((sectorStageCfg.endlessCfg).index * 10))
            else
              if sectorStageCfg.challengeCfg ~= nil then
                ((self.ui).tex_LevelCount):SetIndex(2)
              else
                local sectorId = ConfigData:GetSectorIdShow(sectorStageCfg.sector)
                ;
                ((self.ui).tex_LevelCount):SetIndex(0, tostring(sectorId) .. "-" .. tostring(sectorStageCfg.num))
              end
            end
            do
              do
                -- DECOMPILER ERROR at PC241: Confused about usage of register: R7 in 'UnsetPending'

                ;
                ((self.ui).tex_LevelName).text = (LanguageUtil.GetLocaleText)(sectorStageCfg.name)
                self:ShowReward(isWin, isFloor, needFirsPassReward)
                self:ShowChip()
                self:ShowCoin()
                self:ShowPowerIncrease()
                self:ShowMVP()
                self:ShowGBack()
                if #self.rewardList <= 0 then
                  local hasReward = isFloor or not hasEpRewardBag
                  if not hasReward then
                    (((self.ui).btn_Return).gameObject):SetActive(true)
                    ;
                    (((self.ui).btn_Again).gameObject):SetActive(false)
                  end
                  ;
                  ((self.ui).normalBtnGroup):SetActive(not hasReward)
                  ;
                  ((self.ui).completeBtnGroup):SetActive(hasReward)
                  ;
                  ((self.ui).noReward):SetActive(not hasReward)
                  ;
                  ((self.ui).rewardTips):SetActive(hasReward)
                  local dropList = ((ExplorationManager:GetDynPlayer()).dynRewardBag):GetEpRewardBagDataList()
                  do
                    local hasEpBagDrop = dropList ~= nil and #dropList > 0
                    ;
                    ((self.ui).tex_noReward):SetIndex(hasEpBagDrop and 1 or 0)
                    self:ShowWCTokenTip()
                    -- DECOMPILER ERROR: 7 unprocessed JMP targets
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

UIExplorationResult.IsCanShowAth = function(self)
  -- function num : 0_18 , upvalues : _ENV
  return FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_Algorithm)
end

UIExplorationResult.UpdateAthReward = function(self)
  -- function num : 0_19 , upvalues : _ENV
  if PlayerDataCenter.lastAthDiff ~= nil then
    local athIndex = 0
    for i = 1, #self.rewardList do
      local item = (self.rewardList)[i]
      if (item.itemCfg).type == eItemType.Arithmetic or (item.itemCfg).drop_type == 4 then
        athIndex = athIndex + 1
        local ath = (PlayerDataCenter.lastAthDiff)[athIndex]
        if ath ~= nil then
          item = {num = 1, itemCfg = ath.itemCfg, isAth = true, ath = athData}
          -- DECOMPILER ERROR at PC37: Confused about usage of register: R8 in 'UnsetPending'

          ;
          (self.rewardList)[i] = item
          ;
          (table.remove)(PlayerDataCenter.lastAthDiff, #PlayerDataCenter.lastAthDiff)
        end
      end
    end
    -- DECOMPILER ERROR at PC48: Confused about usage of register: R2 in 'UnsetPending'

    PlayerDataCenter.lastAthDiff = nil
    ExplorationManager:RewardSort(self.rewardList)
  end
end

UIExplorationResult.ShowReward = function(self, isWin, isFloor, needFirsPassReward)
  -- function num : 0_20 , upvalues : _ENV, cs_DoTween, cs_MessageCommon
  local isShowAth = self:IsCanShowAth()
  self.rewardList = {}
  local hasRandomAth = false
  local items = {}
  local addItem = function(itemId, num)
    -- function num : 0_20_0 , upvalues : _ENV, isFloor, hasRandomAth, isShowAth, items
    local isAthItem = (itemId >= 8000 and itemId <= 8100) or ((ConfigData.item)[itemId]).type == eItemType.Arithmetic
    if isAthItem and not isFloor and PlayerDataCenter.lastAthDiff ~= nil then
      hasRandomAth = true
      return 
    end
    -- DECOMPILER ERROR at PC36: Unhandled construct in 'MakeBoolean' P1

    if (not isAthItem or isShowAth) and items[itemId] ~= nil then
      items[itemId] = items[itemId] + num
    else
      items[itemId] = num
    end
    -- DECOMPILER ERROR: 5 unprocessed JMP targets
  end

  for itemId,num in pairs(self.rewardsRecord) do
    do
      addItem(itemId, num)
    end
  end
  if self.firstClearRewards ~= nil then
    do
      for itemId,num in pairs(self.firstClearRewards) do
        addItem(itemId, num)
      end
    end
  end
  do
    for itemId,itemNum in pairs(items) do
      local itemCfg = (ConfigData.item)[itemId]
      if itemCfg == nil then
        error("can\'t get itemCfg with id=" .. tostring(itemId))
      end
      ;
      (table.insert)(self.rewardList, {num = itemNum, itemCfg = itemCfg})
    end
    if hasRandomAth and not isFloor then
      if PlayerDataCenter.lastAthDiff ~= nil then
        for _,athData in ipairs(PlayerDataCenter.lastAthDiff) do
          (table.insert)(self.rewardList, {num = 1, itemCfg = athData.itemCfg, isAth = true, athData = athData})
        end
      end
      do
        -- DECOMPILER ERROR at PC81: Confused about usage of register: R8 in 'UnsetPending'

        PlayerDataCenter.lastAthDiff = nil
        ExplorationManager:RewardSort(self.rewardList)
        local containAth = false
        for k,v in ipairs(self.rewardList) do
          if not containAth and (v.itemCfg).type == eItemType.Arithmetic then
            containAth = true
          end
          local rewardItem = (self.rewardItemPool):GetOne()
          ;
          ((rewardItem.ui).obj_isDouble):SetActive(self.__isWCDouble)
          rewardItem:InitItemWithCount(v.itemCfg, v.num, function()
    -- function num : 0_20_1 , upvalues : _ENV, self, k
    UIManager:ShowWindowAsync(UIWindowTypeID.GlobalItemDetail, function(win)
      -- function num : 0_20_1_0 , upvalues : self, k
      if win ~= nil then
        win:InitListDetail(self.rewardList, k)
      end
    end
)
  end
)
        end
        local rewardSequence = (cs_DoTween.Sequence)()
        for index,item in ipairs((self.rewardItemPool).listItem) do
          item:SetFade(0)
          rewardSequence:AppendCallback(function()
    -- function num : 0_20_2 , upvalues : _ENV, item, self
    if ((ConfigData.game_config).itemWithGreatFxDic)[(item.itemCfg).id] then
      item:LoadGetGreatRewardFx(self.resloader, 5)
    else
      item:LoadGetRewardFx(self.resloader, 5)
    end
  end
)
          rewardSequence:Append((item:GetFade()):DOFade(1, 0.15))
        end
        rewardSequence:SetDelay(0.15)
        rewardSequence:Play()
        if self.rewardSequence ~= nil then
          (self.rewardSequence):Kill()
        end
        self.rewardSequence = rewardSequence
        if containAth and (ConfigData.game_config).athMaxNum <= #(PlayerDataCenter.allAthData):GetAllAthList() then
          (cs_MessageCommon.ShowMessageTips)(ConfigData:GetTipContent(TipContent.Ath_MaxCount))
        end
      end
    end
  end
end

UIExplorationResult.ShowChip = function(self)
  -- function num : 0_21 , upvalues : _ENV
  self.chipList = ((ExplorationManager.epCtrl).dynPlayer):GetChipList()
  local chipNum = 0
  for _,chipData in ipairs(self.chipList) do
    chipNum = chipNum + chipData:GetCount()
  end
  -- DECOMPILER ERROR at PC21: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.ui).tex_ChipCount).text = tostring(chipNum)
  -- DECOMPILER ERROR at PC26: Confused about usage of register: R2 in 'UnsetPending'

  if chipNum <= 0 then
    ((self.ui).btn_Detail).interactable = false
  else
    -- DECOMPILER ERROR at PC30: Confused about usage of register: R2 in 'UnsetPending'

    ;
    ((self.ui).btn_Detail).interactable = true
  end
end

UIExplorationResult.ShowCoin = function(self)
  -- function num : 0_22 , upvalues : _ENV
  local CCNum = (ExplorationManager:GetDynPlayer()):GetMoneyCount()
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.ui).tex_MoneyCount).text = tostring(CCNum)
end

UIExplorationResult.ShowPowerIncrease = function(self)
  -- function num : 0_23 , upvalues : _ENV
  local newPower = ((ExplorationManager.epCtrl).dynPlayer):GetTotalFightingPower(true, false)
  local oldPower = ((ExplorationManager.epCtrl).dynPlayer):GetMirrorTeamFightPower(true, false) or 1
  local increase = (newPower / oldPower - 1) * 100
  if increase <= 0 or not increase then
    increase = 0
  end
  ;
  ((self.ui).tex_BuffRate):SetIndex(0, GetPreciseDecimalStr(increase, 0))
end

UIExplorationResult.ShowMVP = function(self)
  -- function num : 0_24 , upvalues : _ENV, HeroData, cs_ResLoader
  if not self.isWin then
    return 
  end
  if ExplorationManager.epMvpData ~= nil then
    local heroId, MvpType, diggestRate = (ExplorationManager.epMvpData):GetEpMvpData()
    local heroData = (PlayerDataCenter.heroDic)[heroId]
    do
      if heroData == nil then
        local heroCfg = (ConfigData.hero_data)[heroId]
        heroData = (HeroData.New)({
basic = {id = heroId, level = 1, exp = 0, star = heroCfg.rank, potentialLvl = 0, ts = -1, career = heroCfg.career, company = heroCfg.camp}
})
      end
      local cvCtr = ControllerManager:GetController(ControllerTypeId.Cv, true)
      cvCtr:PlayCv(heroId, ConfigData:GetVoicePointRandom(5))
      ;
      ((self.ui).tex_MvpType):SetIndex(MvpType)
      ;
      ((self.ui).tex_Rate):SetIndex(0, GetPreciseDecimalStr(diggestRate * 100, 0))
      if self.bigImgResloader ~= nil then
        (self.bigImgResloader):Put2Pool()
      end
      self.bigImgResloader = (cs_ResLoader.Create)()
      ;
      (self.bigImgResloader):LoadABAssetAsync(PathConsts:GetCharacterBigImgPrefabPath(heroData:GetResPicName()), function(prefab)
    -- function num : 0_24_0 , upvalues : _ENV, self
    DestroyUnityObject(self.bigImgGameObject)
    self.bigImgGameObject = prefab:Instantiate((self.ui).heroBigImgNode)
    local commonPicCtrl = (self.bigImgGameObject):FindComponent(eUnityComponentID.CommonPicController)
    commonPicCtrl:SetPosType("HeroList")
  end
)
    end
  end
end

UIExplorationResult.ShowAllChips = function(self)
  -- function num : 0_25 , upvalues : _ENV
  UIManager:ShowWindowAsync(UIWindowTypeID.ViewChips, function(windows)
    -- function num : 0_25_0 , upvalues : self
    if windows ~= nil then
      self.viewAllChipWin = windows
      if self.chipList ~= nil then
        windows:InitChips(self.chipList, self.resloader)
      end
    end
  end
)
end

UIExplorationResult.ShowAllItems = function(self)
  -- function num : 0_26 , upvalues : _ENV
  UIManager:ShowWindowAsync(UIWindowTypeID.ViewItems, function(windows)
    -- function num : 0_26_0 , upvalues : self
    if windows ~= nil then
      self.viewAllItemWin = windows
      windows:InitItems(self.rewardList, self.resloader)
    end
  end
)
end

UIExplorationResult.ShowGBack = function(self)
  -- function num : 0_27 , upvalues : _ENV
  local convertItemId = (ConfigData.game_config).epMoneyConvert
  local convertMoney = (self.backRewards).exByte or 0
  do
    if convertMoney > 0 then
      local itemCfg = (ConfigData.item)[convertItemId]
      -- DECOMPILER ERROR at PC21: Confused about usage of register: R4 in 'UnsetPending'

      if itemCfg ~= nil then
        ((self.ui).img_BackItemIcom).sprite = CRH:GetSprite(itemCfg.small_icon)
        -- DECOMPILER ERROR at PC29: Confused about usage of register: R4 in 'UnsetPending'

        ;
        ((self.ui).Tex_BackCount).text = "+" .. tostring(convertMoney)
        ;
        ((self.ui).resTransformation):SetActive(true)
        return 
      end
    end
    ;
    ((self.ui).resTransformation):SetActive(false)
  end
end

UIExplorationResult.Jump2HeroState = function(self)
  -- function num : 0_28 , upvalues : _ENV, JumpManager
  (ExplorationManager.resultCtrl):ExecuteBattleEndClear()
  ExplorationManager:ExitExploration((Consts.SceneName).Main, function()
    -- function num : 0_28_0 , upvalues : JumpManager
    JumpManager:Jump((JumpManager.eJumpTarget).Hero)
  end
)
end

UIExplorationResult.OnClickRecomme = function(self)
  -- function num : 0_29 , upvalues : _ENV
  local recommeCtr = ControllerManager:GetController(ControllerTypeId.RecommeFormation, true)
  recommeCtr:ReqRecommeFormation(self:GetDungeonId(), false)
end

UIExplorationResult.GetDungeonId = function(self)
  -- function num : 0_30 , upvalues : _ENV
  local dungeonId = nil
  local moduleId = ExplorationManager:GetEpModuleId()
  if moduleId == proto_csmsg_SystemFunctionID.SystemFunctionID_Exploration then
    dungeonId = (ExplorationManager.stageCfg).id
  else
    if moduleId == proto_csmsg_SystemFunctionID.SystemFunctionID_Endless then
      dungeonId = (ExplorationManager.stageCfg).dungeonId
    end
  end
  return dungeonId
end

UIExplorationResult.__AfterSettleWin = function(self)
  -- function num : 0_31 , upvalues : _ENV
  local avgPlayCtrl = ControllerManager:GetController(ControllerTypeId.AvgPlay)
  avgPlayCtrl:TryPlayTaskAvg(2, function()
    -- function num : 0_31_0 , upvalues : self
    if self.returnCallback ~= nil then
      (self.returnCallback)()
    end
  end
)
end

UIExplorationResult.OnDelete = function(self)
  -- function num : 0_32 , upvalues : base
  if self.resLoader ~= nil then
    (self.resLoader):Put2Pool()
    self.resLoader = nil
  end
  if self.bigImgResloader ~= nil then
    (self.bigImgResloader):Put2Pool()
    self.bigImgResloader = nil
  end
  if self.viewAllChipWin ~= nil then
    (self.viewAllChipWin):Delete()
  end
  if self.viewAllItemWin ~= nil then
    (self.viewAllItemWin):Delete()
  end
  if self.rewardSequence ~= nil then
    (self.rewardSequence):Kill()
    self.rewardSequence = nil
  end
  ;
  (base.OnDelete)(self)
end

return UIExplorationResult


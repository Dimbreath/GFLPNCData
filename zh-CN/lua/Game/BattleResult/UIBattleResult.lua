local UIBattleResult = class("UIBattleResult", UIBaseWindow)
local base = UIBaseWindow
local ItemData = require("Game.PlayerData.Item.ItemData")
local UIRewardItem = require("Game.CommonUI.Item.UINBaseItemWithCount")
local UICharacterItem = require("Game.BattleResult.UIBattleResultCharacterItem")
local UINBattleResultWeekly = require("Game.BattleResult.WeeklyReward.UINBattleResultWeekly")
local cs_ResLoader = CS.ResLoader
local cs_BattleStatistics = (CS.BattleStatistics).Instance
local cs_GameObject = (CS.UnityEngine).GameObject
local cs_DOTween = ((CS.DG).Tweening).DOTween
local cs_CanvasGroup = (CS.UnityEngine).CanvasGroup
local cs_MessageCommon = CS.MessageCommon
UIBattleResult.OnInit = function(self)
  -- function num : 0_0 , upvalues : cs_ResLoader, _ENV, UIRewardItem, UICharacterItem
  self.resloader = (cs_ResLoader.Create)()
  self.rewardItemPool = (UIItemPool.New)(UIRewardItem, (self.ui).obj_rewardItem)
  self.heroHeadItemPool = (UIItemPool.New)(UICharacterItem, (self.ui).obj_heroHeadItem)
  ;
  ((self.ui).obj_rewardItem):SetActive(false)
  if not (BattleUtil.IsInTDBattle)() then
    (UIUtil.AddButtonListener)((self.ui).btn_skada, self, self.__OnBtnSkadaClick)
  else
    ;
    (((self.ui).btn_skada).gameObject):SetActive(false)
  end
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_continue, self, self.__OnBtnContinueClick)
  self.__playAnim = BindCallback(self, self.StartExpAnimation)
  MsgCenter:AddListener(eMsgEventId.OnShowBattleResultComplete, self.__playAnim)
  self:__ToFackCameraCanvas()
end

UIBattleResult.__ToFackCameraCanvas = function(self)
  -- function num : 0_1 , upvalues : cs_GameObject, _ENV
  local fakeCameraBattle = ((cs_GameObject.Find)("FakeCameraBattle")):FindComponent(eUnityComponentID.Camera)
  local epMapCamera = (((ExplorationManager.epCtrl).sceneCtrl).epSceneEntity):GetEpMapCamera()
  self:AlignToFakeCamera(fakeCameraBattle, epMapCamera)
end

UIBattleResult.InitBattleResultData = function(self, playerRoleList, enemyRoleList, mvpGrade)
  -- function num : 0_2 , upvalues : _ENV
  self.__playerRoleList = playerRoleList
  self.__enemyRoleList = enemyRoleList
  self.isInfinity = ExplorationManager:GetEpModuleId() == proto_csmsg_SystemFunctionID.SystemFunctionID_Endless
  self.isPerodicChallenge = ExplorationManager:GetEpModuleId() == proto_csmsg_SystemFunctionID.SystemFunctionID_DailyChallenge
  local floor = ExplorationManager:GetCurLevelIndex() + 1
  local step = ((ExplorationManager.epCtrl):GetCurrentRoomData()).x
  local roomType = ((ExplorationManager.epCtrl):GetCurrentRoomData()):GetRoomType()
  local roomTypeCfg = (ConfigData.exploration_roomtype)[roomType]
  -- DECOMPILER ERROR at PC46: Confused about usage of register: R8 in 'UnsetPending'

  ;
  ((self.ui).tex_levelName).text = (LanguageUtil.GetLocaleText)(roomTypeCfg.title)
  self:__InitBattleReward()
  self:__InitMvpHeroPic(self.__playerRoleList, mvpGrade)
  if ExplorationManager:GetEpModuleId() == proto_csmsg_SystemFunctionID.SystemFunctionID_WeeklyChallenge then
    self:_InitWeeklyReward()
  end
  if GuideManager:TryTriggerGuide(eGuideCondition.InEpBattleResult) then
    -- DECOMPILER ERROR: 4 unprocessed JMP targets
  end
end

UIBattleResult._InitWeeklyReward = function(self)
  -- function num : 0_3 , upvalues : UINBattleResultWeekly
  ((self.ui).rewardLayout):SetActive(false)
  self.weeklyResultNode = (UINBattleResultWeekly.New)()
  ;
  (self.weeklyResultNode):Init((self.ui).weeklyRewardLayout)
  ;
  (self.weeklyResultNode):InitBattleResultWeekly(self.roomMoneyNum)
  ;
  (self.weeklyResultNode):Show()
end

UIBattleResult.SetContinueCallback = function(self, callback)
  -- function num : 0_4
  self.continueCallback = callback
end

UIBattleResult.__SetGlobalExpNode = function(self, globalExpFrom)
  -- function num : 0_5 , upvalues : _ENV
  if ((PlayerDataCenter.AllBuildingData).oasisBuilt)[eBuildingId.OasisLibrary] == nil then
    ((self.ui).obj_globalExpNode):SetActive(false)
    return 
  end
  ;
  ((self.ui).obj_globalExpNode):SetActive(true)
  local globalExpTo = PlayerDataCenter:GetItemCount((ConfigData.game_config).globalExpItemId)
  local globalExpCeiling = (PlayerDataCenter.playerBonus):GetGlobalExpCeiling()
  ;
  ((self.ui).tex_globalExp):SetIndex(0, tostring((math.floor)(globalExpTo - globalExpFrom)))
  local fromFill = globalExpFrom / globalExpCeiling
  -- DECOMPILER ERROR at PC43: Confused about usage of register: R5 in 'UnsetPending'

  ;
  ((self.ui).img_globalExp).fillAmount = fromFill
  if globalExpTo < globalExpCeiling then
    if globalExpFrom == 0 then
      return 
    end
    local toFill = globalExpTo / globalExpCeiling
    if self.globalExpTween == nil then
      local tween = ((self.ui).img_globalExp):DOFillAmount(toFill, 1)
      self.globalExpTween = tween
    else
      do
        ;
        (self.globalExpTween):ChangeEndValue(toFill, true)
        ;
        (self.globalExpTween):Restart()
      end
    end
  end
end

UIBattleResult.__InitBattleReward = function(self)
  -- function num : 0_6 , upvalues : _ENV, ItemData, cs_DOTween
  (FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_Algorithm))
  local isShowAth = nil
  local isCompletedInfinity = nil
  do
    if self.isInfinity then
      local stageCfg = ExplorationManager:GetSectorStageCfg()
      isCompletedInfinity = (PlayerDataCenter.infinityData):IsInfinityDungeonCompleted(stageCfg.dungeonId)
    end
    -- DECOMPILER ERROR at PC25: Unhandled construct in 'MakeBoolean' P3

    local couldShowDrop = (not self.isPerodicChallenge and not self.isInfinity)
    local curRoomData = (ExplorationManager.epCtrl):GetCurrentRoomData()
    local rewardDic = {}
    self.rewardDic = rewardDic
    for k,itemData in ipairs(curRoomData.rewardList) do
      if couldShowDrop or not (itemData.itemCfg).explorationHold then
        local dataId = itemData.dataId
        do
          local isAthItem = (dataId >= 8000 and dataId <= 8100) or ((ConfigData.item)[dataId]).type == eItemType.Arithmetic
          do
            if not isAthItem or isShowAth then
              if rewardDic[dataId] == nil then
                rewardDic[dataId] = {data = itemData, count = itemData:GetCount(), itemCfg = itemData.itemCfg}
              else
                do
                  -- DECOMPILER ERROR at PC81: Confused about usage of register: R13 in 'UnsetPending'

                  (rewardDic[dataId]).count = (rewardDic[dataId]).count + itemData:GetCount()
                  -- DECOMPILER ERROR at PC82: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                  -- DECOMPILER ERROR at PC82: LeaveBlock: unexpected jumping out IF_STMT

                  -- DECOMPILER ERROR at PC82: LeaveBlock: unexpected jumping out IF_THEN_STMT

                  -- DECOMPILER ERROR at PC82: LeaveBlock: unexpected jumping out IF_STMT

                end
              end
            end
          end
          -- DECOMPILER ERROR at PC82: LeaveBlock: unexpected jumping out DO_STMT

          -- DECOMPILER ERROR at PC82: LeaveBlock: unexpected jumping out IF_THEN_STMT

          -- DECOMPILER ERROR at PC82: LeaveBlock: unexpected jumping out IF_STMT

        end
      end
    end
    if curRoomData.rewardExtraDic ~= nil then
      for dataId,count in pairs(curRoomData.rewardExtraDic) do
        if couldShowDrop or not ((ConfigData.item)[dataId]).explorationHold then
          if rewardDic[dataId] == nil then
            local itemData = (ItemData.New)(dataId, count)
            rewardDic[dataId] = {data = itemData, count = count, itemCfg = itemData.itemCfg}
          else
            -- DECOMPILER ERROR at PC117: Confused about usage of register: R11 in 'UnsetPending'

            (rewardDic[dataId]).count = (rewardDic[dataId]).count + count
          end
        end
      end
    end
    local moneyId = 1
    local moneyData = nil
    local rewardList = {}
    for k,v in pairs(rewardDic) do
      if k ~= moneyId then
        (table.insert)(rewardList, v)
      else
        moneyData = v
        rewardDic[k] = nil
      end
    end
    self.roomMoneyNum = 0
    if moneyData == nil then
      ((self.ui).obj_ccNode):SetActive(false)
    else
      ((self.ui).obj_ccNode):SetActive(true)
      -- DECOMPILER ERROR at PC158: Confused about usage of register: R9 in 'UnsetPending'

      ;
      ((self.ui).tex_ccCount).text = tostring(moneyData.count)
      self.roomMoneyNum = moneyData.count
    end
    ExplorationManager:RewardSort(rewardList)
    for k,v in ipairs(rewardList) do
      local rewardItem = (self.rewardItemPool):GetOne()
      rewardItem:InitItemWithCount(v.itemCfg, v.count, function()
    -- function num : 0_6_0 , upvalues : _ENV, rewardList, k
    UIManager:ShowWindowAsync(UIWindowTypeID.GlobalItemDetail, function(win)
      -- function num : 0_6_0_0 , upvalues : rewardList, k
      if win ~= nil then
        win:InitListDetail(rewardList, k)
      end
    end
)
  end
)
    end
    local rewardSequence = (cs_DOTween.Sequence)()
    for index,item in ipairs((self.rewardItemPool).listItem) do
      item:SetFade(0)
      rewardSequence:AppendCallback(function()
    -- function num : 0_6_1 , upvalues : _ENV, item, self
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
    rewardSequence:Pause()
    if self.rewardSequence ~= nil then
      (self.rewardSequence):Kill()
    end
    self.rewardSequence = rewardSequence
    local hasReward = #rewardList > 0
    ;
    ((self.ui).obj_rewardNode):SetActive(hasReward)
    -- DECOMPILER ERROR: 21 unprocessed JMP targets
  end
end

UIBattleResult.__InitCharacterExp = function(self, lastHeroList)
  -- function num : 0_7 , upvalues : _ENV
  local heroList = (ExplorationManager.dynPlayer).heroList
  local levelupRoleIdDic = {}
  local hasLevelup = false
  self.heroHeadDic = {}
  local heroItem = nil
  for k,dynHero in ipairs(heroList) do
    heroItem = (self.heroHeadDic)[k]
    if heroItem == nil then
      heroItem = (self.heroHeadItemPool):GetOne()
    end
    heroItem:InitCharacterItem(dynHero, self.resloader, nil)
    heroItem:RefershExpData(lastHeroList[k - 1])
    -- DECOMPILER ERROR at PC30: Confused about usage of register: R11 in 'UnsetPending'

    ;
    (self.heroHeadDic)[k] = heroItem
    local oldLevel = (lastHeroList[k - 1]).level
    if dynHero:GetLevel() < oldLevel then
      levelupRoleIdDic[dynHero.dataId] = true
      hasLevelup = true
    end
  end
  if hasLevelup then
    ExplorationManager:RequestHeroAttr(levelupRoleIdDic)
  end
end

UIBattleResult.__InitMvpHeroPic = function(self, playerRoleList, mvpGrade)
  -- function num : 0_8
  local dynHero = (mvpGrade.role).character
  ;
  ((self.ui).tex_heroMvp):SetIndex(mvpGrade.MvpType)
  -- DECOMPILER ERROR at PC14: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.ui).img_heroMvp).color = ((self.ui).color_MVP)[mvpGrade.MvpType + 1]
  -- DECOMPILER ERROR at PC19: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.ui).tex_mvpName).text = dynHero:GetName()
  ;
  ((self.ui).tex_mvpDesc):SetIndex(mvpGrade.MvpType)
end

UIBattleResult.__OnBtnSkadaClick = function(self)
  -- function num : 0_9 , upvalues : _ENV, cs_BattleStatistics
  UIManager:ShowWindowAsync(UIWindowTypeID.ResultSkada, function(window)
    -- function num : 0_9_0 , upvalues : cs_BattleStatistics, self
    if window == nil then
      return 
    end
    window:InitBattleSkada(cs_BattleStatistics, self.__playerRoleList, self.__enemyRoleList)
  end
)
end

UIBattleResult.__OnBtnContinueClick = function(self)
  -- function num : 0_10
  self:ExitBattleResult()
end

UIBattleResult.ExitBattleResult = function(self)
  -- function num : 0_11
  if self.continueCallback ~= nil then
    (self.continueCallback)()
  end
  self:FadeDelete()
end

UIBattleResult.FadeDelete = function(self)
  -- function num : 0_12 , upvalues : _ENV
  if self.__fadeTween ~= nil then
    (self.__fadeTween):Kill()
    self.__fadeTween = nil
  end
  self.__fadeTween = UIManager:PlayDoFade((self.ui).canvasGroup, 1, 0, 0.5, function()
    -- function num : 0_12_0 , upvalues : self
    self:Delete()
  end
)
end

UIBattleResult.StartExpAnimation = function(self)
  -- function num : 0_13 , upvalues : _ENV, cs_MessageCommon
  AudioManager:PlayAudioById(1003)
  local containAth = false
  for id,num in pairs(self.rewardDic) do
    local itemCfg = (ConfigData.item)[id]
    if itemCfg ~= nil and itemCfg.type == eItemType.Arithmetic then
      containAth = true
      break
    end
  end
  do
    if containAth and (ConfigData.game_config).athMaxNum <= #(PlayerDataCenter.allAthData):GetAllAthList() then
      (cs_MessageCommon.ShowMessageTips)(ConfigData:GetTipContent(TipContent.Ath_MaxCount))
    end
    self.__animationStart = true
    if self.rewardSequence ~= nil then
      (self.rewardSequence):Restart()
    end
  end
end

UIBattleResult.Update = function(self)
  -- function num : 0_14 , upvalues : _ENV
  if not self.__animationStart then
    return 
  end
  for k,heroItem in pairs(self.heroHeadDic) do
    heroItem:UpdateExp()
  end
end

UIBattleResult.OnDelete = function(self)
  -- function num : 0_15 , upvalues : _ENV, base
  self.__playerRoleList = nil
  self.__enemyRoleList = nil
  if self.resloader ~= nil then
    (self.resloader):Put2Pool()
    self.resloader = nil
  end
  if self.rewardSequence ~= nil then
    (self.rewardSequence):Kill()
    self.rewardSequence = nil
  end
  if self.weeklyResultNode ~= nil then
    (self.weeklyResultNode):Delete()
  end
  MsgCenter:RemoveListener(eMsgEventId.OnShowBattleResultComplete, self.__playAnim)
  ;
  (base.OnDelete)(self)
end

return UIBattleResult


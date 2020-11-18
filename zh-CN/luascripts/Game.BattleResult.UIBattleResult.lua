-- params : ...
-- function num : 0 , upvalues : _ENV
local UIBattleResult = class("UIBattleResult", UIBaseWindow)
local base = UIBaseWindow
local ItemData = require("Game.PlayerData.Item.ItemData")
local UIRewardItem = require("Game.CommonUI.Item.UINBaseItemWithCount")
local UICharacterItem = require("Game.BattleResult.UIBattleResultCharacterItem")
local UIBattleSkadaPage = require("Game.BattleResult.Skada.UIBattleSkadaPage")
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
  ;
  ((self.ui).obj_heroHeadItem):SetActive(false)
  ;
  ((self.ui).obj_userSkillNode):SetActive(false)
  ;
  ((self.ui).obj_globalExpNode):SetActive(false)
  ;
  ((self.ui).obj_skadaPage):SetActive(false)
  ;
  ((self.ui).obj_skadaInfoPage):SetActive(false)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_skada, self, self.__OnBtnSkadaClick)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_continue, self, self.__OnBtnContinueClick)
  self.__updateHandle = BindCallback(self, self.Update)
  UpdateManager:AddUpdate(self.__updateHandle)
  self.__playAnim = BindCallback(self, self.StartExpAnimation)
  MsgCenter:AddListener(eMsgEventId.OnShowBattleResultComplete, self.__playAnim)
  self:__ToFackCameraCanvas()
end

UIBattleResult.__ToFackCameraCanvas = function(self)
  -- function num : 0_1 , upvalues : cs_GameObject, _ENV
  local fakeCameraBattle = ((cs_GameObject.Find)("FakeCameraBattle")):FindComponent(eUnityComponentID.Camera)
  self:AlignToFakeCamera(fakeCameraBattle)
end

UIBattleResult.InitBattleResultData = function(self, resultData, mvpGrade)
  -- function num : 0_2 , upvalues : _ENV
  self.resultData = resultData
  local floor = ExplorationManager:GetCurLevelIndex() + 1
  local step = ((ExplorationManager.epCtrl):GetCurrentRoomData()).x
  local roomType = ((ExplorationManager.epCtrl):GetCurrentRoomData()):GetRoomType()
  local roomTypeCfg = (ConfigData.exploration_roomtype)[roomType]
  -- DECOMPILER ERROR at PC25: Confused about usage of register: R7 in 'UnsetPending'

  ;
  ((self.ui).tex_levelName).text = (LanguageUtil.GetLocaleText)(roomTypeCfg.title)
  self:__SetGlobalExpNode(resultData.globalExpFrom)
  self:__SetCommanderExpNode()
  self:__InitBattleReward()
  self:__InitCharacterExp(resultData.lastHeroList)
  self:__InitMvpHeroPic(resultData.playerRoleList, mvpGrade)
  if GuideManager:TryTriggerGuide(eGuideCondition.InEpBattleResult) then
  end
end

UIBattleResult.SetContinueCallback = function(self, callback)
  -- function num : 0_3
  self.continueCallback = callback
end

UIBattleResult.__SetGlobalExpNode = function(self, globalExpFrom)
  -- function num : 0_4 , upvalues : _ENV
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

UIBattleResult.__SetCommanderExpNode = function(self)
  -- function num : 0_5 , upvalues : _ENV
  local funcUnLockCrtl = ControllerManager:GetController(ControllerTypeId.FunctionUnlock, true)
  local isCSUnlock = funcUnLockCrtl:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_commander_skill)
  if not isCSUnlock then
    return 
  end
  local needRefreshTree = false
  local neddRefreshMaster = false
  local treeData, level = nil, nil
  local exp = 0
  local masterLevel = nil
  local masterExp = 0
  local lastDiff = (PlayerDataCenter.CommanderSkillModualData):GetCSLastDiff()
  local msg = lastDiff.differMsg
  if msg == nil then
    return 
  end
  if msg.update ~= nil then
    for treeId,data in pairs(msg.update) do
      level = data.first
      exp = data.second
      treeData = ((PlayerDataCenter.CommanderSkillModualData).CommanderSkillTreeDataDic)[treeId]
      if treeData == nil then
        error("can\'t read treeData with treeId " .. treeId)
        return 
      end
      needRefreshTree = true
      do break end
    end
  end
  do
    if msg.proficentUpdate ~= nil then
      masterLevel = (msg.proficentUpdate).first
      masterExp = (msg.proficentUpdate).second
      neddRefreshMaster = true
    end
    ;
    ((self.ui).obj_userSkillNode):SetActive(false)
    if needRefreshTree then
      ((self.ui).obj_userSkillNode):SetActive(true)
      ;
      ((self.ui).tex_AddPlayerSkillExp):SetIndex(0, tostring(exp - lastDiff.oldTreeExp))
      ;
      ((self.ui).text_playerSkillName):SetIndex(0, treeData:GetName())
      -- DECOMPILER ERROR at PC90: Confused about usage of register: R12 in 'UnsetPending'

      ;
      ((self.ui).tex_PlayerSkillLv).text = level
      local totalExp = ((ConfigData.commander_skill_level)[level]).exp or 0
      -- DECOMPILER ERROR at PC101: Confused about usage of register: R13 in 'UnsetPending'

      ;
      ((self.ui).img_playerSkillExp).fillAmount = exp / totalExp
    end
    do
      if neddRefreshMaster then
        ((self.ui).obj_userSkillNode):SetActive(true)
        ;
        ((self.ui).tex_AddPlayerSkillExp):SetIndex(0, tostring(masterExp - lastDiff.oldMasterExp))
        ;
        ((self.ui).text_playerSkillName):SetIndex(1)
        -- DECOMPILER ERROR at PC125: Confused about usage of register: R12 in 'UnsetPending'

        ;
        ((self.ui).tex_PlayerSkillLv).text = masterLevel
        local totalExp = nil
        if not ((ConfigData.commander_skill_master_level)[level]).exp then
          totalExp = (ConfigData.commander_skill_master_level)[level] == nil or 0
          error("暂时未做满级的循环处理")
          totalExp = 0
          -- DECOMPILER ERROR at PC147: Confused about usage of register: R13 in 'UnsetPending'

          ;
          ((self.ui).img_playerSkillExp).fillAmount = masterExp / totalExp
        end
      end
    end
  end
end

UIBattleResult.__InitBattleReward = function(self)
  -- function num : 0_6 , upvalues : _ENV, ItemData, cs_DOTween
  local hasRandomAth = false
  local isInfinity = ExplorationManager:GetEpModuleId() == proto_csmsg_SystemFunctionID.SystemFunctionID_Endless
  local isCompletedInfinity = nil
  do
    if isInfinity then
      local stageCfg = ExplorationManager:GetSectorStageCfg()
      isCompletedInfinity = ((PlayerDataCenter.infinityData).completed)[stageCfg.dungeonId] or false
    end
    local curRoomData = (ExplorationManager.epCtrl):GetCurrentRoomData()
    local rewardDic = {}
    self.rewardDic = rewardDic
    for k,itemData in ipairs(curRoomData.rewardList) do
      if not isInfinity or isCompletedInfinity or not (itemData.itemCfg).explorationHold then
        local dataId = itemData.dataId
        do
          if (dataId >= 8000 and dataId < 9000) or ((ConfigData.item)[dataId]).type == eItemType.Arithmetic then
            hasRandomAth = true
          elseif rewardDic[dataId] == nil then
            rewardDic[dataId] = {data = itemData, count = itemData:GetCount()}
          else
            do
              -- DECOMPILER ERROR at PC73: Confused about usage of register: R12 in 'UnsetPending'

              (rewardDic[dataId]).count = (rewardDic[dataId]).count + itemData:GetCount()
              -- DECOMPILER ERROR at PC74: LeaveBlock: unexpected jumping out IF_ELSE_STMT

              -- DECOMPILER ERROR at PC74: LeaveBlock: unexpected jumping out IF_STMT

              -- DECOMPILER ERROR at PC74: LeaveBlock: unexpected jumping out IF_ELSE_STMT

              -- DECOMPILER ERROR at PC74: LeaveBlock: unexpected jumping out IF_STMT

            end
          end
        end
      end
    end
    if curRoomData.rewardExtraDic ~= nil then
      for dataId,count in pairs(curRoomData.rewardExtraDic) do
        if not isInfinity or isCompletedInfinity or not ((ConfigData.item)[dataId]).explorationHold then
          if dataId >= 8000 and dataId < 9000 then
            hasRandomAth = true
          elseif rewardDic[dataId] == nil then
            local itemData = (ItemData.New)(dataId, count)
            rewardDic[dataId] = {data = itemData, count = count}
          else
            -- DECOMPILER ERROR at PC115: Confused about usage of register: R11 in 'UnsetPending'

            (rewardDic[dataId]).count = (rewardDic[dataId]).count + count
          end
        end
      end
    end
    if hasRandomAth then
      if PlayerDataCenter.lastAthDiff ~= nil then
        for _,athData in ipairs(PlayerDataCenter.lastAthDiff) do
          local itemData = (ItemData.New)(athData.id, 1)
          rewardDic[athData.id] = {data = itemData, count = 1, isAth = true, athData = athData}
        end
      end
      -- DECOMPILER ERROR at PC143: Confused about usage of register: R6 in 'UnsetPending'

      PlayerDataCenter.lastAthDiff = nil
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
    if moneyData == nil then
      ((self.ui).obj_ccNode):SetActive(false)
    else
      ((self.ui).obj_ccNode):SetActive(true)
      -- DECOMPILER ERROR at PC181: Confused about usage of register: R9 in 'UnsetPending'

      ;
      ((self.ui).tex_ccCount).text = tostring(moneyData.count)
    end
    ;
    (table.sort)(rewardList, function(data1, data2)
    -- function num : 0_6_0
    if (data2.data).quality < (data1.data).quality then
      return true
    else
      if (data1.data).dataId >= (data2.data).dataId then
        do return (data1.data).quality ~= (data2.data).quality end
        do return false end
        -- DECOMPILER ERROR: 2 unprocessed JMP targets
      end
    end
  end
)
    for k,v in ipairs(rewardList) do
      local rewardItem = (self.rewardItemPool):GetOne()
      if v.isAth then
        rewardItem:InitItemWithCount((v.data).itemCfg, v.count, function()
    -- function num : 0_6_1 , upvalues : _ENV, v
    UIManager:ShowWindowAsync(UIWindowTypeID.GlobalItemDetail, function(win)
      -- function num : 0_6_1_0 , upvalues : v
      if win ~= nil then
        win:InitAthDetail((v.data).itemCfg, v.athData)
      end
    end
)
  end
)
      else
        rewardItem:InitItemWithCount((v.data).itemCfg, v.count)
      end
    end
    local rewardSequence = (cs_DOTween.Sequence)()
    for index,item in ipairs((self.rewardItemPool).listItem) do
      item:SetFade(0)
      rewardSequence:Append((item:GetFade()):DOFade(1, 0.2))
    end
    rewardSequence:SetDelay(0.5)
    rewardSequence:SetAutoKill(false)
    rewardSequence:Pause()
    if self.rewardSequence ~= nil then
      (self.rewardSequence):Kill()
    end
    self.rewardSequence = rewardSequence
    local hasReward = #rewardList > 0
    -- DECOMPILER ERROR at PC267: Confused about usage of register: R11 in 'UnsetPending'

    if not hasReward or not Color.white then
      ((self.ui).img_rewardBg).color = (Color.New)(0, 0, 0, 0.4)
      ;
      ((self.ui).obj_rewardText):SetActive(hasReward)
      -- DECOMPILER ERROR: 27 unprocessed JMP targets
    end
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
  -- function num : 0_8 , upvalues : _ENV
  local heroData = ((mvpGrade.role).character).heroData
  ;
  ((self.ui).tex_heroMvp):SetIndex(mvpGrade.MvpType)
  -- DECOMPILER ERROR at PC15: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.ui).img_heroMvp).color = ((self.ui).color_MVP)[mvpGrade.MvpType + 1]
  -- DECOMPILER ERROR at PC25: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.ui).tex_mvpName).text = tostring((LanguageUtil.GetLocaleText)((heroData.heroCfg).name))
  ;
  ((self.ui).tex_mvpDesc):SetIndex(mvpGrade.MvpType)
end

UIBattleResult.__OnBtnSkadaClick = function(self)
  -- function num : 0_9 , upvalues : UIBattleSkadaPage, cs_BattleStatistics
  if self.skadaPage == nil then
    self.skadaPage = (UIBattleSkadaPage.New)()
    ;
    (self.skadaPage):Init((self.ui).obj_skadaPage)
    ;
    (self.skadaPage):InitBattleSkadaPage((self.ui).obj_skadaInfoPage, cs_BattleStatistics, (self.resultData).playerRoleList, (self.resultData).enemyRoleList, self.resloader)
  end
  ;
  (self.skadaPage):Show()
end

UIBattleResult.__OnBtnContinueClick = function(self)
  -- function num : 0_10
  if self.continueCallback ~= nil then
    (self.continueCallback)()
  end
  self:FadeDelete()
end

UIBattleResult.FadeDelete = function(self)
  -- function num : 0_11 , upvalues : _ENV
  if self.__fadeTween ~= nil then
    (self.__fadeTween):Kill()
    self.__fadeTween = nil
  end
  self.__fadeTween = UIManager:PlayDoFade((self.ui).canvasGroup, 1, 0, 0.5, function()
    -- function num : 0_11_0 , upvalues : self
    self:Delete()
  end
)
end

UIBattleResult.StartExpAnimation = function(self)
  -- function num : 0_12 , upvalues : _ENV, cs_MessageCommon
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
  -- function num : 0_13 , upvalues : _ENV
  if not self.__animationStart then
    return 
  end
  for k,heroItem in pairs(self.heroHeadDic) do
    heroItem:UpdateExp()
  end
end

UIBattleResult.OnDelete = function(self)
  -- function num : 0_14 , upvalues : _ENV, base
  if self.resloader ~= nil then
    (self.resloader):Put2Pool()
    self.resloader = nil
  end
  if self.globalExpTween ~= nil then
    (self.globalExpTween):Kill()
    self.globalExpTween = nil
  end
  if self.rewardSequence ~= nil then
    (self.rewardSequence):Kill()
    self.rewardSequence = nil
  end
  UpdateManager:RemoveUpdate(self.__updateHandle)
  MsgCenter:RemoveListener(eMsgEventId.OnShowBattleResultComplete, self.__playAnim)
  ;
  (base.OnDelete)(self)
end

return UIBattleResult


-- params : ...
-- function num : 0 , upvalues : _ENV
local UINHomeRightList = class("UINHomeRightList", UIBaseNode)
local base = UIBaseNode
local UINHomeRightListTog = require("Game.Home.UI.UINHomeRightListTog")
local UINHomeGeneralBtn = require("Game.Home.UI.UINHomeGeneralBtn")
local HomeEnum = require("Game.Home.HomeEnum")
local JumpManager = require("Game.Jump.JumpManager")
local CS_coroutine = require("XLua.Common.cs_coroutine")
local CS_EventTriggerListener = CS.EventTriggerListener
local cs_Input = (CS.UnityEngine).Input
UINHomeRightList.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, HomeEnum, UINHomeRightListTog, CS_EventTriggerListener, cs_Input
  self.homeController = ControllerManager:GetController(ControllerTypeId.HomeController, false)
  self._ChangeTog = BindCallback(self, self.ChangeTog)
  self.btnDatasDic = {}
  self.curTogType = (HomeEnum.eHomeTogTypeOrder)[1]
  ;
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  self.togPool = (UIItemPool.New)(UINHomeRightListTog, (self.ui).tog_FuncPageItem)
  ;
  ((self.ui).tog_FuncPageItem):SetActive(false)
  ;
  (((self.ui).scrollRect_pageList).onValueChanged):AddListener(BindCallback(self, self.OnValueChange))
  local eventTrigger = (CS_EventTriggerListener.Get)(((self.ui).scrollRect_pageList).gameObject)
  eventTrigger:onEndDrag("+", BindCallback(self, self.OnEndDrag))
  cs_Input.multiTouchEnabled = false
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Lottery, self, self.OnClickLotteryBtn)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Dorm, self, self.OnClickDormBtn)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_ShopToHeroChip, self, self.OnClickFrgShopBtn)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_HeroList_BIG, self, self.OnClickHeroListBtn)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Exproation, self, self.OnClickEpBtn)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Oasis_BIG, self, self.OnClickOasisBtn)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Warehouse, self, self.OnClickWarehouseBtn)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Store, self, self.OnClickShopBtn)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Factor, self, self.OnClickFactoryBtn)
  self.m_OnLateUpdate = BindCallback(self, self.OnLateUpdate)
  UpdateManager:AddLateUpdate(self.m_OnLateUpdate)
end

UINHomeRightList.InitHomeRightList = function(self, homeUI)
  -- function num : 0_1 , upvalues : HomeEnum
  self.bind = homeUI.bind
  self.homeUI = homeUI
  self:PrepareBtnList()
  self:GenTogs((HomeEnum.eHomeTogType).ControlCenter)
  self:RefreshLotteryBtn()
  self:RefreshDormBtn()
  self:RefreshFrgShopBtn()
  self:RefreshHeroListBtn()
  self:RefreshEpBtn()
  self:RefreshOasisBtn()
  self:RefreshWarehouseBtn()
  self:RefreshShopBtn()
  self:RefreshFactoryBtn()
end

UINHomeRightList.GenTogs = function(self, defaultSelectType)
  -- function num : 0_2 , upvalues : _ENV, HomeEnum
  (self.togPool):HideAll()
  local defualtSelectItem = nil
  for _,type in pairs(HomeEnum.eHomeTogTypeOrder) do
    local item = (self.togPool):GetOne()
    item:InitTog(type, self._ChangeTog)
    -- DECOMPILER ERROR at PC21: Confused about usage of register: R9 in 'UnsetPending'

    ;
    (item.gameObject).name = "Tog_FuncPageItem" .. tostring(type)
    if type == defaultSelectType or not defualtSelectItem then
      defualtSelectItem = item
    end
    item:ChangeColorOnClick(type ~= defaultSelectType and not defualtSelectItem)
  end
  -- DECOMPILER ERROR at PC39: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((defualtSelectItem.ui).tog_FuncPageItem).isOn = true
  -- DECOMPILER ERROR: 3 unprocessed JMP targets
end

UINHomeRightList.ChangeTog = function(self, type)
  -- function num : 0_3
  self.curTogType = type
  self:AttachToType(type)
  self:ChangeCanvasGroup(type)
  ;
  ((self.ui).tex_CurrPage):SetIndex(type)
end

UINHomeRightList.AttachToType = function(self, typeIndex)
  -- function num : 0_4 , upvalues : _ENV
  self.currNPos = ((self.ui).scrollRect_pageList).verticalNormalizedPosition
  self.scrollNPos = (self.normalizedPosition4TypeDic)[typeIndex]
  self.totalCostTime = (math.abs)(self.scrollNPos - self.currNPos) / 3
  self.passedTime = 0
  self.attaching = true
end

UINHomeRightList.OnLateUpdate = function(self)
  -- function num : 0_5 , upvalues : _ENV
  if self.attaching then
    if not self.waitEpTimeLine and (math.abs)(((self.ui).scrollRect_pageList).verticalNormalizedPosition - self.scrollNPos) < 0.01 then
      self.attaching = false
    end
    self.passedTime = self.passedTime + Time.deltaTime
    -- DECOMPILER ERROR at PC32: Confused about usage of register: R1 in 'UnsetPending'

    ;
    ((self.ui).scrollRect_pageList).verticalNormalizedPosition = (Mathf.Lerp)(self.currNPos, self.scrollNPos, self.passedTime / self.totalCostTime)
  end
end

UINHomeRightList.WaitEpTimeLine = function(self, bool)
  -- function num : 0_6
  self.waitEpTimeLine = bool
end

UINHomeRightList.ChangeCanvasGroup = function(self, type)
  -- function num : 0_7 , upvalues : _ENV, HomeEnum
  for index,canvasGroup in ipairs((self.ui).canvasGroupList) do
    local isCurIndex = type == index
    canvasGroup.interactable = isCurIndex
    canvasGroup.alpha = isCurIndex and 1 or 0.3
  end
  local isHuman = type == (HomeEnum.eHomeTogType).ControlCenter or type == (HomeEnum.eHomeTogType).HumanResource
  -- DECOMPILER ERROR at PC31: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).HeroListFade).interactable = isHuman
  -- DECOMPILER ERROR at PC40: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).HeroListFade).alpha = isHuman and 1 or 0.3
  local isInfrastructure = type == (HomeEnum.eHomeTogType).ControlCenter or type == (HomeEnum.eHomeTogType).Infrastructure
  -- DECOMPILER ERROR at PC53: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.ui).OasisFade).interactable = isInfrastructure
  -- DECOMPILER ERROR at PC62: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.ui).OasisFade).alpha = isInfrastructure and 1 or 0.3
  -- DECOMPILER ERROR: 10 unprocessed JMP targets
end

UINHomeRightList.PrepareBtnList = function(self)
  -- function num : 0_8 , upvalues : HomeEnum, _ENV
  self.changPosMid = (((((self.ui).posPoint_top).transform).position).y + ((((self.ui).posPoint_down).transform).position).y) / 2
  self.normalizedPosition4TypeDic = {[(HomeEnum.eHomeTogType).HumanResource] = 1, [(HomeEnum.eHomeTogType).ControlCenter] = 0.5, [(HomeEnum.eHomeTogType).Infrastructure] = 0}
  -- DECOMPILER ERROR at PC44: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self.btnDatasDic)[(HomeEnum.eChangeBtnType).HeroData] = {
big = {sizeDelta = (Vector2.New)(706, 253)}
, 
small = {sizeDelta = (Vector2.New)(532, 168)}
}
  -- DECOMPILER ERROR at PC65: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self.btnDatasDic)[(HomeEnum.eChangeBtnType).Oasis] = {
big = {sizeDelta = (Vector2.New)(706, 253)}
, 
small = {sizeDelta = (Vector2.New)(532, 168)}
}
end

UINHomeRightList.OnValueChange = function(self, pos)
  -- function num : 0_9 , upvalues : _ENV, HomeEnum
  local nowNPos = pos.y
  local btn_HeroList_BIG_Rate = 1 - (((((self.ui).posPoint_top).transform).position).y - ((((self.ui).posPoint_HeroDataBig_Top).transform).position).y) / (((((self.ui).posPoint_top).transform).position).y - self.changPosMid)
  -- DECOMPILER ERROR at PC40: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (((self.ui).btn_HeroList_BIG).transform).sizeDelta = (Vector2.Lerp)((((self.btnDatasDic)[(HomeEnum.eChangeBtnType).HeroData]).big).sizeDelta, (((self.btnDatasDic)[(HomeEnum.eChangeBtnType).HeroData]).small).sizeDelta, btn_HeroList_BIG_Rate)
  local btn_Oasis_BIG_Rate = 1 - (((((self.ui).posPoint_OasisBig_Bottom).transform).position).y - ((((self.ui).posPoint_down).transform).position).y) / (self.changPosMid - ((((self.ui).posPoint_down).transform).position).y)
  -- DECOMPILER ERROR at PC79: Confused about usage of register: R5 in 'UnsetPending'

  ;
  ((self.ui).OasisLayout).sizeDelta = (Vector2.Lerp)((((self.btnDatasDic)[(HomeEnum.eChangeBtnType).Oasis]).big).sizeDelta, (((self.btnDatasDic)[(HomeEnum.eChangeBtnType).Oasis]).small).sizeDelta, btn_Oasis_BIG_Rate)
  -- DECOMPILER ERROR at PC84: Confused about usage of register: R5 in 'UnsetPending'

  ;
  (((self.heroListBtn).ui).fade_Big).alpha = 1 - btn_HeroList_BIG_Rate
  -- DECOMPILER ERROR at PC88: Confused about usage of register: R5 in 'UnsetPending'

  ;
  (((self.heroListBtn).ui).fade_Small).alpha = btn_HeroList_BIG_Rate
  -- DECOMPILER ERROR at PC93: Confused about usage of register: R5 in 'UnsetPending'

  ;
  (((self.oasisBtn).ui).fade_Big).alpha = 1 - btn_Oasis_BIG_Rate
  -- DECOMPILER ERROR at PC97: Confused about usage of register: R5 in 'UnsetPending'

  ;
  (((self.oasisBtn).ui).fade_Small).alpha = btn_Oasis_BIG_Rate
end

UINHomeRightList.OnEndDrag = function(self)
  -- function num : 0_10 , upvalues : HomeEnum
  local currNPos = ((self.ui).scrollRect_pageList).verticalNormalizedPosition
  if self.normalizedPosition4TypeDic ~= nil then
    local curTypeNPos = (self.normalizedPosition4TypeDic)[self.curTogType]
    local hasNext = false
    local hasBefore = false
    hasNext = (HomeEnum.eHomeTogTypeOrder)[self.curTogType + 1] ~= nil
    hasBefore = (HomeEnum.eHomeTogTypeOrder)[self.curTogType - 1] ~= nil
    if curTypeNPos < currNPos and hasBefore then
      local beforeTypeNpos = (self.normalizedPosition4TypeDic)[self.curTogType - 1]
      -- DECOMPILER ERROR at PC47: Confused about usage of register: R6 in 'UnsetPending'

      if (beforeTypeNpos - curTypeNPos) / 3 < currNPos - curTypeNPos then
        (((((self.togPool).listItem)[self.curTogType - 1]).ui).tog_FuncPageItem).isOn = true
      else
        self:AttachToType(self.curTogType)
      end
    end
  end
  do
    if currNPos < curTypeNPos and hasNext then
      local nextTypeNpos = (self.normalizedPosition4TypeDic)[self.curTogType + 1]
      -- DECOMPILER ERROR at PC73: Confused about usage of register: R6 in 'UnsetPending'

      if (curTypeNPos - nextTypeNpos) / 3 < curTypeNPos - currNPos then
        (((((self.togPool).listItem)[self.curTogType + 1]).ui).tog_FuncPageItem).isOn = true
      else
        self:AttachToType(self.curTogType)
      end
    end
    -- DECOMPILER ERROR: 6 unprocessed JMP targets
  end
end

UINHomeRightList.OnClickLotteryBtn = function(self)
  -- function num : 0_11 , upvalues : _ENV
  if (self.lotteryBtn).isUnlock then
    local ctrl = ControllerManager:GetController(ControllerTypeId.Lottery, true)
    ctrl:InitLottery(function()
    -- function num : 0_11_0 , upvalues : self
    (self.homeUI):OpenOtherWin()
  end
)
  end
end

UINHomeRightList.RefreshLotteryBtn = function(self)
  -- function num : 0_12 , upvalues : UINHomeGeneralBtn, _ENV
  if self.lotteryBtn == nil then
    self.lotteryBtn = (UINHomeGeneralBtn.New)()
    ;
    (self.lotteryBtn):Init(((self.ui).btn_Lottery).gameObject)
    ;
    (self.homeController):AddRedDotEvent((self.lotteryBtn):GetRedDotFunc(), RedDotStaticTypeId.Main, RedDotStaticTypeId.Lottery)
  end
  local isUnlock, unlockDes = (self.homeController):IsFuncUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_Lottery)
  ;
  (self.lotteryBtn):RefeshUnlockInfo(isUnlock, unlockDes)
  ;
  (((self.lotteryBtn).ui).obj_costList):SetActive(isUnlock)
  if isUnlock then
    self.LotteryCostDic = {}
    self.LotteryAutoCostDic = {}
    self:InitLotteryCostItem(((self.lotteryBtn).ui).costItemList)
  end
end

UINHomeRightList.InitLotteryCostItem = function(self, costItemList)
  -- function num : 0_13 , upvalues : _ENV
  for index,go in ipairs(costItemList) do
    go:SetActive(false)
  end
  local totalShow = 1
  for gashaponId,itemId in ipairs((ConfigData.gashapon_para).costId_dic) do
    local costItem = nil
    if (self.LotteryCostDic)[itemId] ~= nil then
      costItem = (self.LotteryCostDic)[itemId]
      -- DECOMPILER ERROR at PC28: Confused about usage of register: R9 in 'UnsetPending'

      ;
      (costItem.tex_Count).text = PlayerDataCenter:GetItemCount(itemId)
    else
      if totalShow <= 2 then
        local costItem = {}
        costItem.go = costItemList[totalShow]
        ;
        (costItem.go):SetActive(true)
        costItem.img_Icon = (costItem.go):FindComponent("Img_Icon", eUnityComponentID.Image)
        costItem.tex_Count = (costItem.go):FindComponent("Tex_Count", eUnityComponentID.Text)
        local itemCfg = (ConfigData.item)[itemId]
        if itemCfg == nil then
          error("Can\'t find itemCfg by Id:" .. tostring(itemId))
        else
          -- DECOMPILER ERROR at PC71: Confused about usage of register: R11 in 'UnsetPending'

          ;
          (costItem.img_Icon).sprite = CRH:GetSprite(itemCfg.small_icon)
          -- DECOMPILER ERROR at PC77: Confused about usage of register: R11 in 'UnsetPending'

          ;
          (costItem.tex_Count).text = PlayerDataCenter:GetItemCount(itemId)
          totalShow = totalShow + 1
          local isAuto = (PlayerDataCenter.allEffectorData):IsAutoGenerateResource(itemId)
          -- DECOMPILER ERROR at PC87: Confused about usage of register: R12 in 'UnsetPending'

          if isAuto then
            (self.LotteryAutoCostDic)[itemId] = costItem
          end
          -- DECOMPILER ERROR at PC89: Confused about usage of register: R12 in 'UnsetPending'

          ;
          (self.LotteryCostDic)[itemId] = costItem
        end
      else
        break
      end
    end
  end
end

UINHomeRightList.RefreshLotteryCost = function(self, fromeAuto)
  -- function num : 0_14 , upvalues : _ENV
  if not fromeAuto or not self.LotteryAutoCostDic then
    local costItemDic = self.LotteryCostDic
  end
  if costItemDic ~= nil then
    for itemId,costItem in pairs(costItemDic) do
      -- DECOMPILER ERROR at PC17: Confused about usage of register: R8 in 'UnsetPending'

      (costItem.tex_Count).text = PlayerDataCenter:GetItemCount(itemId)
    end
  end
end

UINHomeRightList.OnClickDormBtn = function(self)
  -- function num : 0_15 , upvalues : _ENV
  if (self.dormBtn).isUnlock then
    (ControllerManager:GetController(ControllerTypeId.Dorm, true)):EnterDorm()
  end
end

UINHomeRightList.RefreshDormBtn = function(self)
  -- function num : 0_16 , upvalues : UINHomeGeneralBtn
  if self.dormBtn == nil then
    self.dormBtn = (UINHomeGeneralBtn.New)()
    ;
    (self.dormBtn):Init(((self.ui).btn_Dorm).gameObject)
  end
  ;
  (self.dormBtn):RefeshUnlockInfo(false)
end

UINHomeRightList.OnClickFrgShopBtn = function(self)
  -- function num : 0_17 , upvalues : _ENV
  if (self.frgShopBtn).isUnlock then
    UIManager:ShowWindowAsync(UIWindowTypeID.Shop, function(win)
    -- function num : 0_17_0 , upvalues : _ENV, self
    if win ~= nil then
      local ShopEnum = require("Game.Shop.ShopEnum")
      win:InitShopTogList((ShopEnum.ShopId)[(ShopEnum.eShopType).Charcter])
      ;
      (self.homeUI):OpenOtherWin()
    end
  end
)
  end
end

UINHomeRightList.RefreshFrgShopBtn = function(self)
  -- function num : 0_18 , upvalues : UINHomeGeneralBtn, _ENV
  if self.frgShopBtn == nil then
    self.frgShopBtn = (UINHomeGeneralBtn.New)()
    ;
    (self.frgShopBtn):Init(((self.ui).btn_ShopToHeroChip).gameObject)
  end
  local isUnlock, unlockDes = (self.homeController):IsFuncUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_Store)
  ;
  (self.frgShopBtn):RefeshUnlockInfo(isUnlock, unlockDes)
end

UINHomeRightList.OnClickHeroListBtn = function(self)
  -- function num : 0_19 , upvalues : _ENV
  if (self.heroListBtn).isUnlock then
    ((self.bind).mainCanvasGruop):DOFade(0, 0.25)
    UIManager:ShowWindowAsync(UIWindowTypeID.HeroList, function(win)
    -- function num : 0_19_0 , upvalues : self
    if win == nil then
      return 
    end
    win:SetReturnEvent(function()
      -- function num : 0_19_0_0 , upvalues : self, win
      ((self.bind).mainCanvasGruop):DOFade(1, 0.5)
      win:CloseSelf()
    end
)
    ;
    (self.homeUI):OpenOtherWin()
  end
)
  end
end

UINHomeRightList.RefreshHeroListBtn = function(self)
  -- function num : 0_20 , upvalues : UINHomeGeneralBtn, _ENV
  if self.heroListBtn == nil then
    self.heroListBtn = (UINHomeGeneralBtn.New)()
    ;
    (self.heroListBtn):Init(((self.ui).btn_HeroList_BIG).gameObject)
    ;
    (self.homeController):AddRedDotEvent((self.heroListBtn):GetRedDotFunc(), RedDotStaticTypeId.Main, RedDotStaticTypeId.HeroWindow)
  end
  local isUnlock, unlockDes = (self.homeController):IsFuncUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_HeroGroup)
  ;
  (self.heroListBtn):RefeshUnlockInfo(isUnlock, unlockDes)
  self:RefreshCollectRate()
end

UINHomeRightList.RefreshCollectRate = function(self)
  -- function num : 0_21 , upvalues : _ENV
  local totalCount = (ConfigData.hero_data).totalHeroCount
  local collectRate = 0
  collectRate = (math.ceil)(PlayerDataCenter.heroCount / totalCount * 100)
  ;
  (((self.heroListBtn).ui).tex_CollectRate):SetIndex(0, tostring(collectRate))
end

UINHomeRightList.OnClickEpBtn = function(self, doNotOpenEpStages)
  -- function num : 0_22 , upvalues : _ENV
  if (self.epBtn).isUnlock then
    self.doNotOpenEpStages = doNotOpenEpStages
    ;
    (self.homeUI):SetTo(AreaConst.Sector)
    ;
    (UIManager:ShowWindow(UIWindowTypeID.ClickContinue)):InitContinue(nil, nil, nil, Color.clear, false)
    ;
    ((self.bind).sectorPlayableDirector):Play()
    self.sectorBtnClicked = true
  end
end

UINHomeRightList.RefreshEpBtn = function(self)
  -- function num : 0_23 , upvalues : UINHomeGeneralBtn, _ENV
  if self.epBtn == nil then
    self.epBtn = (UINHomeGeneralBtn.New)()
    ;
    (self.epBtn):Init(((self.ui).btn_Exproation).gameObject)
    ;
    (self.homeController):AddRedDotEvent((self.epBtn):GetRedDotFunc(), RedDotStaticTypeId.Main, RedDotStaticTypeId.Sector)
    ;
    (UIUtil.AddButtonListener)(((self.epBtn).ui).btn_ContinueEp, self, function()
    -- function num : 0_23_0 , upvalues : _ENV
    ExplorationManager:ContinueLastExploration()
  end
)
    ;
    (UIUtil.AddButtonListener)(((self.epBtn).ui).btn_AddEpPoint, self, BindCallback(self, self.QickBuyStamina))
    ;
    (UIUtil.AddButtonListener)(((self.epBtn).ui).btn_pountInfo, self, BindCallback(self, self.ShowStaminaDetail))
    ;
    ((self.bind).sectorPlayableDirector):stopped("+", function(director)
    -- function num : 0_23_1 , upvalues : self, _ENV
    -- DECOMPILER ERROR at PC9: Confused about usage of register: R1 in 'UnsetPending'

    if (self.bind).sectorPlayableDirector == director then
      if not self.sectorBtnClicked then
        ((self.bind).sectorPlayableDirector).initialTime = 0
        return 
      end
      self.sectorBtnClicked = false
      UIManager:DeleteWindow(UIWindowTypeID.Home)
      UIManager:HideWindow(UIWindowTypeID.ClickContinue)
      ;
      ((CS.GSceneManager).Instance):LoadSceneByAB((Consts.SceneName).Sector, function()
      -- function num : 0_23_1_0 , upvalues : self, _ENV
      if (self.homeUI).enterSectorJumpCallback ~= nil then
        (ControllerManager:GetController(ControllerTypeId.SectorController, true)):SetFrom(AreaConst.Home)
        ;
        ((self.homeUI).enterSectorJumpCallback)()
        -- DECOMPILER ERROR at PC18: Confused about usage of register: R0 in 'UnsetPending'

        ;
        (self.homeUI).enterSectorJumpCallback = nil
      else
        if ExplorationManager:HasUncompletedEp() and not self.doNotOpenEpStages then
          (ControllerManager:GetController(ControllerTypeId.SectorController, true)):SetFrom(AreaConst.Exploration)
        else
          ;
          (ControllerManager:GetController(ControllerTypeId.SectorController, true)):SetFrom(AreaConst.Home)
        end
      end
    end
)
    end
  end
)
  end
  local isUnlock, unlockDes = (self.homeController):IsFuncUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_Exploration)
  ;
  (self.epBtn):RefeshUnlockInfo(isUnlock, unlockDes)
  self:RefreshContinueEp()
  self:RefreshStamina()
end

UINHomeRightList.RefreshCurEpStage = function(self)
  -- function num : 0_24 , upvalues : _ENV
  local sectorId, stageIndex, differIdex = (PlayerDataCenter.sectorStage):GetEpStageCfg4Home()
  ;
  (((self.epBtn).ui).tex_LevelName):SetIndex(differIdex, tostring(sectorId), tostring(stageIndex))
end

UINHomeRightList.RefreshNormalStage = function(self, stageId)
  -- function num : 0_25 , upvalues : _ENV
  local stageCfg = (ConfigData.sector_stage)[stageId]
  local sectorId = stageCfg.sector
  local difficultyId = stageCfg.difficulty
  local stageIndex = 0
  local difflist = (((ConfigData.sector_stage).sectorDiffDic)[sectorId])[difficultyId]
  for index,id in ipairs(difflist) do
    if id == stageId then
      stageIndex = index
    end
  end
  ;
  (((self.epBtn).ui).tex_LevelName):SetIndex(difficultyId, tostring(sectorId), tostring(stageIndex))
end

UINHomeRightList.RefreshEndlessStage = function(self, stageId)
  -- function num : 0_26 , upvalues : _ENV
  local eDynConfigData = require("Game.ConfigData.eDynConfigData")
  ConfigData:LoadDynCfg(eDynConfigData.endless)
  local endlessLevelDic = ((ConfigData.endless).levelDic)[stageId]
  local sectorId = endlessLevelDic.sectorId
  local depth = endlessLevelDic.index * 10
  local sectorCfg = (ConfigData.sector)[sectorId]
  ConfigData:ReleaseDynCfg(eDynConfigData.endless)
  -- DECOMPILER ERROR at PC23: Confused about usage of register: R7 in 'UnsetPending'

  ;
  (package.loaded)[eDynConfigData] = nil
  ;
  (((self.epBtn).ui).tex_LevelName):SetIndex(3, tostring((LanguageUtil.GetLocaleText)(sectorCfg.name)), tostring(depth))
end

UINHomeRightList.RefreshContinueEp = function(self)
  -- function num : 0_27 , upvalues : _ENV
  local hasHasUncompletedEp, stageId, moduleId = ExplorationManager:HasUncompletedEp()
  ;
  ((((self.epBtn).ui).btn_ContinueEp).gameObject):SetActive(hasHasUncompletedEp)
  ;
  (((self.epBtn).ui).tex_LevelType):SetIndex(hasHasUncompletedEp and 0 or 1)
  if moduleId ~= proto_csmsg_SystemFunctionID.SystemFunctionID_Endless then
    do
      local isEndless = not hasHasUncompletedEp
      if isEndless then
        self:RefreshEndlessStage(stageId)
      else
        self:RefreshNormalStage(stageId)
      end
      self:RefreshCurEpStage()
      -- DECOMPILER ERROR: 4 unprocessed JMP targets
    end
  end
end

UINHomeRightList.RefreshStamina = function(self)
  -- function num : 0_28 , upvalues : _ENV
  local ceiling = (PlayerDataCenter.stamina):GetStaminaCeiling()
  local stamina, remainSecond = (PlayerDataCenter.stamina):GetCurrentStamina()
  -- DECOMPILER ERROR at PC14: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (((self.epBtn).ui).tex_EpPoint).text = tostring(stamina)
  ;
  (((self.epBtn).ui).tex_EpPointLimit):SetIndex(0, tostring(ceiling))
end

UINHomeRightList.QickBuyStamina = function(self)
  -- function num : 0_29 , upvalues : JumpManager
  JumpManager:Jump((JumpManager.eJumpTarget).BuyStamina)
end

UINHomeRightList.ShowStaminaDetail = function(self)
  -- function num : 0_30 , upvalues : _ENV
  if GuideManager.inGuide then
    return 
  end
  local window = UIManager:ShowWindow(UIWindowTypeID.GlobalItemDetail)
  if self.parentWindowType ~= nil then
    window:ParentWindowType(self.parentWindowType)
  end
  window:InitCommonItemDetail((ConfigData.item)[ItemIdOfKey])
end

UINHomeRightList.OnClickOasisBtn = function(self)
  -- function num : 0_31 , upvalues : _ENV
  if (self.oasisBtn).isUnlock then
    (self.homeUI):OpenOtherCoverWin()
    ;
    (self.homeUI):SetTo(AreaConst.Oasis)
    ;
    ((self.bind).oasisPlayableDirector):Play()
    ;
    (UIManager:ShowWindow(UIWindowTypeID.ClickContinue)):InitContinue(nil, nil, nil, Color.clear, false)
    AudioManager:PlayAudioById(1016)
    local homeClicked = function()
    -- function num : 0_31_0 , upvalues : _ENV, self
    (UIManager:ShowWindow(UIWindowTypeID.ClickContinue)):InitContinue(nil, nil, nil, Color.clear, false)
    ;
    ((self.bind).oasisPlayableDirector):Pause()
    -- DECOMPILER ERROR at PC17: Confused about usage of register: R0 in 'UnsetPending'

    ;
    ((self.bind).oasisPlayableDirector).time = 0
    ;
    ((self.bind).oasisPlayableDirector):Evaluate()
    ;
    ((self.homeController).oasisController):OnExitOasis()
    AudioManager:PlayAudioById(1017)
    self.__tlOasisCo = (TimelineUtil.Rewind)((self.bind).oasisPlayableDirector, function()
      -- function num : 0_31_0_0 , upvalues : _ENV, self
      UIManager:ShowWindow(UIWindowTypeID.Home)
      ;
      (self.homeUI):OnShow()
      UIManager:HideWindow(UIWindowTypeID.ClickContinue)
    end
)
  end

    -- DECOMPILER ERROR at PC38: Confused about usage of register: R2 in 'UnsetPending'

    ;
    ((self.homeController).oasisController).backToHomeEvent = BindCallback(self, homeClicked)
  end
end

UINHomeRightList.RefreshOasisBtn = function(self)
  -- function num : 0_32 , upvalues : UINHomeGeneralBtn, _ENV
  if self.oasisBtn == nil then
    self.oasisBtn = (UINHomeGeneralBtn.New)()
    ;
    (self.oasisBtn):Init(((self.ui).btn_Oasis_BIG).gameObject)
    ;
    (self.homeController):AddRedDotEvent((self.oasisBtn):GetRedDotFunc(), RedDotStaticTypeId.Main, RedDotStaticTypeId.Oasis)
  end
  local isUnlock, unlockDes = (self.homeController):IsFuncUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_Building)
  ;
  (self.oasisBtn):RefeshUnlockInfo(isUnlock, unlockDes)
  self:RefreshBuiltRate()
end

UINHomeRightList.RefreshBuiltRate = function(self)
  -- function num : 0_33 , upvalues : _ENV
  local rate = (PlayerDataCenter.AllBuildingData):GetOasisBuiltRate()
  rate = (math.floor)(rate * 100)
  ;
  (((self.oasisBtn).ui).text_Rate):SetIndex(0, tostring(rate))
end

UINHomeRightList.OnClickWarehouseBtn = function(self)
  -- function num : 0_34
  if (self.warehouseBtn).isUnlock then
  end
end

UINHomeRightList.RefreshWarehouseBtn = function(self)
  -- function num : 0_35 , upvalues : UINHomeGeneralBtn
  if self.warehouseBtn == nil then
    self.warehouseBtn = (UINHomeGeneralBtn.New)()
    ;
    (self.warehouseBtn):Init(((self.ui).btn_Warehouse).gameObject)
  end
  ;
  (self.warehouseBtn):RefeshUnlockInfo(false)
end

UINHomeRightList.OnClickShopBtn = function(self)
  -- function num : 0_36 , upvalues : _ENV
  if (self.shopBtn).isUnlock then
    UIManager:ShowWindowAsync(UIWindowTypeID.Shop, function(win)
    -- function num : 0_36_0 , upvalues : self
    if win ~= nil then
      win:InitShopTogList(nil)
      ;
      (self.homeUI):OpenOtherWin()
    end
  end
)
  end
end

UINHomeRightList.RefreshShopBtn = function(self)
  -- function num : 0_37 , upvalues : UINHomeGeneralBtn, _ENV
  if self.shopBtn == nil then
    self.shopBtn = (UINHomeGeneralBtn.New)()
    ;
    (self.shopBtn):Init(((self.ui).btn_Store).gameObject)
    ;
    (self.homeController):AddRedDotEvent((self.shopBtn):GetRedDotFunc(), RedDotStaticTypeId.Main, RedDotStaticTypeId.ShopWindow)
  end
  local isUnlock, unlockDes = (self.homeController):IsFuncUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_Store)
  ;
  (self.shopBtn):RefeshUnlockInfo(isUnlock, unlockDes)
end

UINHomeRightList.OnClickFactoryBtn = function(self)
  -- function num : 0_38 , upvalues : _ENV
  if (self.factoryBtn).isUnlock then
    (self.homeUI):SetTo(AreaConst.FactoryDorm)
    ;
    (UIManager:ShowWindow(UIWindowTypeID.ClickContinue)):InitContinue(nil, nil, nil, Color.clear, false)
    ;
    ((self.bind).factorydormPlayableDirector):Play()
    self.factoryBtnClicked = true
  end
end

UINHomeRightList.RefreshFactoryEnergy = function(self)
  -- function num : 0_39 , upvalues : _ENV
  local factoryCtrl = ControllerManager:GetController(ControllerTypeId.Factory, false)
  if factoryCtrl == nil then
    warn("factoryCtrl not inited")
    return 
  end
  local datas = factoryCtrl:GetAllRoomEnegey()
  local totalCeiling = 0
  local totalValue = 0
  for roomIndex,data in pairs(datas) do
    totalCeiling = totalCeiling + data.ceiling
    totalValue = totalValue + data.value
    local factoryNode = RedDotController:AddRedDotNodeWithPath(RedDotDynPath.FactoryLine, RedDotStaticTypeId.Main, RedDotStaticTypeId.Factory, roomIndex)
    if data.ceiling <= data.value then
      factoryNode:SetRedDotCount(1)
    else
      factoryNode:SetRedDotCount(0)
    end
  end
  if totalCeiling == 0 then
    (((self.factoryBtn).ui).tex_energy):SetIndex(0, "0")
    -- DECOMPILER ERROR at PC59: Confused about usage of register: R5 in 'UnsetPending'

    ;
    (((self.factoryBtn).ui).img_fill).fillAmount = 0
  else
    local rate = (totalValue) / (totalCeiling)
    ;
    (((self.factoryBtn).ui).tex_energy):SetIndex(0, tostring((math.ceil)(rate * 100)))
    -- DECOMPILER ERROR at PC77: Confused about usage of register: R6 in 'UnsetPending'

    ;
    (((self.factoryBtn).ui).img_fill).fillAmount = rate
  end
end

UINHomeRightList.RefreshFactoryBtn = function(self)
  -- function num : 0_40 , upvalues : UINHomeGeneralBtn, _ENV
  if self.factoryBtn == nil then
    self.factoryBtn = (UINHomeGeneralBtn.New)()
    ;
    (self.factoryBtn):Init(((self.ui).btn_Factor).gameObject)
    ;
    (self.homeController):AddRedDotEvent((self.factoryBtn):GetRedDotFunc(), RedDotStaticTypeId.Main, RedDotStaticTypeId.Factory)
  end
  local isUnlock, unlockDes = (self.homeController):IsFuncUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_Factory)
  ;
  (self.factoryBtn):RefeshUnlockInfo(isUnlock, unlockDes)
  if isUnlock then
    self:RefreshFactoryEnergy()
  end
  ;
  ((self.bind).factorydormPlayableDirector):stopped("+", function(director)
    -- function num : 0_40_0 , upvalues : self, _ENV
    -- DECOMPILER ERROR at PC9: Confused about usage of register: R1 in 'UnsetPending'

    if (self.bind).factorydormPlayableDirector == director then
      if not self.factoryBtnClicked then
        ((self.bind).factorydormPlayableDirector).initialTime = 0
        return 
      end
      self.factoryBtnClicked = false
      UIManager:DeleteWindow(UIWindowTypeID.Home)
      UIManager:HideWindow(UIWindowTypeID.ClickContinue)
      ;
      (ControllerManager:GetController(ControllerTypeId.Factory, true)):OpenFactory()
    end
  end
)
end

UINHomeRightList.OnDelete = function(self)
  -- function num : 0_41 , upvalues : _ENV, cs_Input, base
  if self.__tlOasisCo ~= nil then
    (TimelineUtil.StopTlCo)(self.__tlOasisCo)
  end
  cs_Input.multiTouchEnabled = true
  UpdateManager:RemoveLateUpdate(self.m_OnLateUpdate)
  ;
  (base.OnDelete)(self)
end

return UINHomeRightList


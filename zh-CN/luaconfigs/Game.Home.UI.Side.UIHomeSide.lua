-- params : ...
-- function num : 0 , upvalues : _ENV
local UIHomeSide = class("UIHomeSide", UIBaseWindow)
local base = UIBaseWindow
local UINHomeGeneralBtn = require("Game.Home.UI.UINHomeGeneralBtn")
local UINHomeSideResItem = require("Game.Home.UI.Side.UINHomeSideResItem")
local UINHomeSideBuildingItem = require("Game.Home.UI.Side.UINHomeSideBuildingItem")
local cs_MessageCommon = CS.MessageCommon
local BuildingBelong = require("Game.Oasis.Data.BuildingBelong")
local UINHomeSideNoticeItem = require("Game.Home.UI.Side.UINHomeSideNoticeItem")
UIHomeSide.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINHomeSideResItem, UINHomeSideBuildingItem
  self.homeController = ControllerManager:GetController(ControllerTypeId.HomeController, true)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Return, self, self.CloseSide)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_background, self, self.CloseSide)
  ;
  (((self.ui).tween_side).onRewind):AddListener(BindCallback(self, self.OnClose))
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_CleanNotice, self, self.OnClickCleanNotice)
  self.__RefreshBuildingList = BindCallback(self, self.RefreshBuildingList)
  self.__RefreshResourceProduction = BindCallback(self, self.RefreshResourceProduction)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_GetAll, self, self.OnClickCollectResource)
  self.__CollectResourceCallback = BindCallback(self, self.CollectResourceCallback)
  self.produceItemPool = (UIItemPool.New)(UINHomeSideResItem, (self.ui).obj_produceItem)
  ;
  ((self.ui).obj_produceItem):SetActive(false)
  self.buildingItemPool = (UIItemPool.New)(UINHomeSideBuildingItem, (self.ui).obj_buildingItem)
  ;
  ((self.ui).obj_buildingItem):SetActive(false)
  self.__CloseSide = BindCallback(self, self.CloseSide)
  self.__RefeshNotices = function()
    -- function num : 0_0_0 , upvalues : self
    ((self.ui).loop_messageList):RefreshCells()
  end

  -- DECOMPILER ERROR at PC96: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).loop_messageList).onInstantiateItem = BindCallback(self, self.m_OnNewItem)
  -- DECOMPILER ERROR at PC103: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).loop_messageList).onChangeItem = BindCallback(self, self.m_OnChangeItem)
  self.noticeItemDic = {}
  self.sideNoticeList = nil
end

UIHomeSide.InitSide = function(self, homeUI)
  -- function num : 0_1
  self.homeUI = homeUI
  self.resloader = homeUI.resloader
end

UIHomeSide.OpenSide = function(self)
  -- function num : 0_2 , upvalues : _ENV
  self:Show()
  ;
  ((((CS.UnityEngine).UI).LayoutRebuilder).ForceRebuildLayoutImmediate)(((self.ui).layout).transform)
  self:RefeshNotices()
  ;
  (self.homeController):SetNeedUpdateProduction(true, self.__RefreshResourceProduction)
  ;
  (self.homeController):SetNeedUpdateConstruct(true, self.__RefreshBuildingList)
  ;
  ((self.ui).tween_side):DOPlayForward()
  AudioManager:PlayAudioById(1088)
end

UIHomeSide.CloseSide = function(self)
  -- function num : 0_3 , upvalues : _ENV
  (UIManager:ShowWindow(UIWindowTypeID.ClickContinue)):InitContinue(nil, nil, nil, Color.clear, false)
  ;
  (self.homeController):SetNeedUpdateProduction(false, nil)
  ;
  (self.homeController):SetNeedUpdateConstruct(false, nil)
  ;
  ((self.ui).tween_side):DOPlayBackwards()
  AudioManager:PlayAudioById(1089)
end

UIHomeSide.OnClose = function(self)
  -- function num : 0_4 , upvalues : _ENV
  UIManager:HideWindow(UIWindowTypeID.ClickContinue)
  self:Hide()
end

UIHomeSide.RefeshNotices = function(self, playTween)
  -- function num : 0_5 , upvalues : _ENV
  local sideNoticeList = NoticeManager:GetSideNoticeList()
  self.sideNoticeList = sideNoticeList
  local noMessage = #sideNoticeList <= 0
  ;
  ((self.ui).obj_messageEmpty):SetActive(noMessage)
  ;
  ((self.ui).obj_cleanMessage):SetActive(not noMessage)
  ;
  (((self.ui).loop_messageList).gameObject):SetActive(not noMessage)
  if playTween and noMessage then
    ((((self.ui).canvasGroup_emptyNode):DOFade(0, 0.6)):From()):SetLink(((self.ui).canvasGroup_emptyNode).gameObject)
  end
  local num = #sideNoticeList
  -- DECOMPILER ERROR at PC45: Confused about usage of register: R5 in 'UnsetPending'

  ;
  ((self.ui).loop_messageList).totalCount = num
  ;
  ((self.ui).loop_messageList):RefillCells()
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

UIHomeSide.m_OnNewItem = function(self, go)
  -- function num : 0_6 , upvalues : UINHomeSideNoticeItem
  local noticeItem = (UINHomeSideNoticeItem.New)()
  noticeItem:Init(go)
  noticeItem:InitSideResItem(self.__CloseSide, self.resloader, self.__RefeshNotices)
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self.noticeItemDic)[go] = noticeItem
end

UIHomeSide.m_OnChangeItem = function(self, go, index)
  -- function num : 0_7 , upvalues : _ENV
  local noticeItem = (self.noticeItemDic)[go]
  if noticeItem == nil then
    error("Can\'t find noticeItem by gameObject")
    return 
  end
  local noticeData = (self.sideNoticeList)[index + 1]
  if noticeData == nil then
    error("Can\'t find noticeData by index, index = " .. tonumber(index))
  end
  noticeItem:RefreshSideResItem(noticeData)
end

UIHomeSide.m_GetItemGoByIndex = function(self, dataIndex)
  -- function num : 0_8
  local go = ((self.ui).loop_messageList):GetCellByIndex(dataIndex - 1)
  do
    if go ~= nil then
      local noticeItem = (self.noticeItemDic)[go]
      return noticeItem
    end
    return nil
  end
end

UIHomeSide.OnClickCleanNotice = function(self)
  -- function num : 0_9 , upvalues : _ENV
  local playTweenNum = 0
  local HideOver = BindCallback(self, function()
    -- function num : 0_9_0 , upvalues : playTweenNum, self, _ENV
    playTweenNum = playTweenNum - 1
    if playTweenNum <= 0 then
      self.sideNoticeList = nil
      NoticeManager:CleanAllNotice()
      self:RefeshNotices(true)
    end
  end
)
  for dataIndex,noticeData in ipairs(self.sideNoticeList) do
    local noticeItem = self:m_GetItemGoByIndex(dataIndex)
    if noticeItem ~= nil then
      playTweenNum = playTweenNum + 1
      noticeItem:PlayHideTween(HideOver)
    end
  end
end

UIHomeSide.RefreshBuildingList = function(self, constructingBuildingLists)
  -- function num : 0_10 , upvalues : BuildingBelong, _ENV
  local oasisBuildingLists = constructingBuildingLists[BuildingBelong.Oasis]
  local sectorBuildingLists = constructingBuildingLists[BuildingBelong.Sector]
  local noBuild = #oasisBuildingLists <= 0 and #sectorBuildingLists <= 0
  ;
  ((self.ui).obj_constructionEmpty):SetActive(noBuild)
  ;
  ((self.ui).obj_constructionScroll):SetActive(not noBuild)
  ;
  (self.buildingItemPool):HideAll()
  for _,buildData in ipairs(oasisBuildingLists) do
    local item = (self.buildingItemPool):GetOne()
    item:RefreshBuildingItem(buildData)
  end
  for _,buildData in ipairs(sectorBuildingLists) do
    local item = (self.buildingItemPool):GetOne()
    item:RefreshBuildingItem(buildData, true)
  end
  -- DECOMPILER ERROR: 3 unprocessed JMP targets
end

UIHomeSide.RefreshResourceProduction = function(self, allResDic, allBuildDic)
  -- function num : 0_11 , upvalues : _ENV
  self.allBuildDic = allBuildDic
  local count = 0
  for itemId,data in pairs(allResDic) do
    count = count + 1
  end
  local noProdece = count == 0
  ;
  ((self.ui).obj_prodeceNode):SetActive(not noProdece)
  ;
  ((self.ui).obj_produceEmpty):SetActive(noProdece)
  ;
  (self.produceItemPool):HideAll()
  for itemId,data in pairs(allResDic) do
    local item = (self.produceItemPool):GetOne()
    item:Updatenfo(data)
  end
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

UIHomeSide.OnClickCollectResource = function(self)
  -- function num : 0_12 , upvalues : _ENV
  if self.allBuildDic ~= nil then
    local legalBuildingIdDic = {}
    for buildId,_ in pairs(self.allBuildDic) do
      local builtData = ((PlayerDataCenter.AllBuildingData).built)[buildId]
      if builtData ~= nil and builtData:CanGetBuildRes(true) then
        legalBuildingIdDic[buildId] = true
      end
    end
    if (table.count)(legalBuildingIdDic) <= 0 then
      return 
    end
    ;
    (self.homeController):SetNeedUpdateProduction(false, nil)
    local BuildingNetworkCtrl = (NetworkManager:GetNetwork(NetworkTypeID.Building)):SendBuildingCollectGroup(legalBuildingIdDic, self.__CollectResourceCallback)
    for _,item in ipairs((self.produceItemPool).listItem) do
      item:PlayCollect()
    end
  end
end

UIHomeSide.CollectResourceCallback = function(self, objList)
  -- function num : 0_13 , upvalues : _ENV, cs_MessageCommon
  self.allBuildDic = nil
  ;
  (self.homeController):SetNeedUpdateProduction(true, self.__RefreshResourceProduction)
  if objList.Count == 0 then
    return 
  end
  local resDic = objList[0]
  for itemId,count in pairs(resDic) do
    local itemCfg = (ConfigData.item)[itemId]
    if itemCfg ~= nil then
      local msg = ConfigData:GetTipContent(TipContent.Building_GainReward) .. (LanguageUtil.GetLocaleText)(itemCfg.name) .. " x " .. tostring(count)
      ;
      (cs_MessageCommon.ShowMessageTips)(msg, true)
    end
  end
end

UIHomeSide.OnDelete = function(self)
  -- function num : 0_14 , upvalues : base
  (self.homeController):SetNeedUpdateProduction(false, nil)
  ;
  (self.homeController):SetNeedUpdateConstruct(false, nil)
  ;
  (base.OnDelete)(self)
end

return UIHomeSide


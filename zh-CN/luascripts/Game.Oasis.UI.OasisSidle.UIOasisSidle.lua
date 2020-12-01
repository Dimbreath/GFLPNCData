-- params : ...
-- function num : 0 , upvalues : _ENV
local UIOasisSidle = class("UIOasisSidle", UIBaseNode)
local base = UIBaseNode
local cs_UIMnager = CS.UIManager
local cs_Screen = (CS.UnityEngine).Screen
local cs_coroutine = require("XLua.Common.cs_coroutine")
local UIBuildingItem = require("Game.Oasis.UI.OasisSidle.UIOasisBuildingItem")
local ItemDetail = require("Game.Oasis.UI.OasisSidle.UIOasisBuildingItemDetail")
local firstIconId = 1001
UIOasisSidle.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  self:ResetSidlePos()
  self.isSidleShow = false
  self.ConstructEvent = nil
  self.UpdrageEvent = nil
  self.ConfirmOverEvent = nil
  self.CloseDetailEvent = nil
  self.NewBuildingEvent = nil
  self.BuildingLevelUpEvent = nil
  self.OpenSidleEvent = nil
  self.buildingUIItems = {}
  self.buildingRows = {}
  self.buildingIndexItem = {}
  self.buildingIdIndex = {}
  self.__closeSideBarOrDetail = BindCallback(self, self.CloseSidebarOrDetail)
  self.coWaiteForEndFrame = ((CS.UnityEngine).WaitForEndOfFrame)()
  self.__onItemRefresh = BindCallback(self, self.OnItemRefresh)
  MsgCenter:AddListener(eMsgEventId.UpdateItem, self.__onItemRefresh)
  MsgCenter:AddListener(eMsgEventId.UpdateARGItem, self.__onItemRefresh)
end

UIOasisSidle.SetHideEvent = function(self, onSidleHideEvent)
  -- function num : 0_1
  self.onSidleHideEvent = onSidleHideEvent
end

UIOasisSidle.InitializeSidle = function(self, buildingUIModel, resLoader, sidleLoadedCallback)
  -- function num : 0_2 , upvalues : cs_coroutine, _ENV, firstIconId, UIBuildingItem
  self.completedLoadItem = false
  self.resLoader = resLoader
  if buildingUIModel == nil or buildingUIModel.buildingDataList == nil then
    return 
  end
  local buildingDtaList = buildingUIModel.buildingDataList
  local buildingIndex = 0
  self.loadItemCo = (cs_coroutine.start)(function()
    -- function num : 0_2_0 , upvalues : self, _ENV, buildingDtaList, firstIconId, buildingIndex, UIBuildingItem, sidleLoadedCallback
    self.startLoadItemCo = true
    ;
    (coroutine.yield)(self.coWaiteForEndFrame)
    for _,data in ipairs(buildingDtaList) do
      (coroutine.yield)(self.coWaiteForEndFrame)
      if data ~= nil then
        local buildingItem, rowIns = nil, nil
        if data.id == firstIconId then
          buildingItem = (self.ui).firstBuildingBtn
          rowIns = ((buildingItem.transform).parent).gameObject
          -- DECOMPILER ERROR at PC26: Confused about usage of register: R7 in 'UnsetPending'

          ;
          (self.buildingRows)[0] = rowIns
          -- DECOMPILER ERROR at PC29: Confused about usage of register: R7 in 'UnsetPending'

          ;
          (self.buildingIdIndex)[firstIconId] = 0
        else
          buildingIndex = buildingIndex + 1
          buildingItem = self:__createItem(buildingIndex)
          -- DECOMPILER ERROR at PC43: Confused about usage of register: R7 in 'UnsetPending'

          ;
          (self.buildingIdIndex)[data.id] = buildingIndex
        end
        buildingItem.name = data.id
        local item = (UIBuildingItem.New)()
        item:Init(buildingItem)
        item:InitItem(rowIns, data, self.resLoader, BindCallback(self, self.OnClickBuildingItem, item), self)
        item:Show()
        -- DECOMPILER ERROR at PC66: Confused about usage of register: R8 in 'UnsetPending'

        ;
        (self.buildingUIItems)[data.id] = item
        -- DECOMPILER ERROR at PC71: Confused about usage of register: R8 in 'UnsetPending'

        ;
        (self.buildingIndexItem)[(self.buildingIdIndex)[data.id]] = item
      end
    end
    self.startLoadItemCo = false
    self.completedLoadItem = true
    if sidleLoadedCallback ~= nil then
      sidleLoadedCallback()
    end
  end
)
end

UIOasisSidle.__createItem = function(self, buildingIndex)
  -- function num : 0_3
  local rowIns = self:__getAndCreateRowIns(buildingIndex)
  local button = ((self.ui).buildingItem):Instantiate(rowIns.transform)
  return button, rowIns
end

UIOasisSidle.__getAndCreateRowIns = function(self, buildingIndex)
  -- function num : 0_4 , upvalues : _ENV
  if (self.buildingRows)[buildingIndex] == nil then
    if buildingIndex % 2 == 1 then
      local rowIns = ((self.ui).rowItem):Instantiate((self.ui).sidebarContent)
      rowIns.name = tostring(buildingIndex) .. "_" .. tostring(buildingIndex + 1)
      -- DECOMPILER ERROR at PC23: Confused about usage of register: R3 in 'UnsetPending'

      ;
      (self.buildingRows)[buildingIndex] = rowIns
      rowIns:SetActive(true)
    else
      do
        -- DECOMPILER ERROR at PC32: Confused about usage of register: R2 in 'UnsetPending'

        ;
        (self.buildingRows)[buildingIndex] = (self.buildingRows)[buildingIndex - 1]
        return (self.buildingRows)[buildingIndex]
      end
    end
  end
end

UIOasisSidle.OnClickBuildingItem = function(self, buildingItem)
  -- function num : 0_5
  local result = false
  -- DECOMPILER ERROR at PC10: Unhandled construct in 'MakeBoolean' P1

  if not buildingItem.isBuild and self.NewBuildingEvent ~= nil then
    result = (self.NewBuildingEvent)(buildingItem.id)
  end
  if self.BuildingLevelUpEvent ~= nil then
    result = (self.BuildingLevelUpEvent)(buildingItem.id, false)
  end
  if result then
    self:__createDetailItem(buildingItem)
  end
end

UIOasisSidle.__createDetailItem = function(self, buildingUIItem)
  -- function num : 0_6 , upvalues : ItemDetail, cs_coroutine, _ENV
  local buildingData = buildingUIItem.buildingData
  self:__closedDetailItem()
  self.openedBuildingIndex = (self.buildingIdIndex)[buildingData.id]
  if self.openedBuildingIndex == nil then
    return 
  end
  self.currentBuildItem = (self.buildingIndexItem)[self.openedBuildingIndex]
  if self.currentBuildItem == nil then
    return 
  end
  local rowRectTrans = ((self.currentBuildItem).rowIns).transform
  self:DisplayRowChildren(rowRectTrans, false)
  if self.detailItemUI == nil then
    self.detailItemUI = (ItemDetail.New)()
    ;
    (self.detailItemUI):Init((self.ui).detailItem)
    ;
    (self.detailItemUI):InjectResloader(self.resloader)
  end
  ;
  (self.detailItemUI):ResetQuestState()
  ;
  (self.detailItemUI):UpdateWithItemData(self.currentBuildItem)
  ;
  (self.detailItemUI):OnShowInRect(rowRectTrans)
  -- DECOMPILER ERROR at PC54: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.ui).scrollRect).vertical = false
  if self.openedBuildingIndex > 0 then
    self.startCenterCo = true
    self.centerOnDetailCo = (cs_coroutine.start)(function()
    -- function num : 0_6_0 , upvalues : _ENV, self, rowRectTrans
    (coroutine.yield)(self.coWaiteForEndFrame)
    local centerOnDetailOfs = -(rowRectTrans.anchoredPosition).y - (rowRectTrans.rect).height // 2 - (self.ui).topOfs
    local pos = ((self.ui).sidebarContent).anchoredPosition
    pos:Set(pos.x, centerOnDetailOfs)
    -- DECOMPILER ERROR at PC23: Confused about usage of register: R2 in 'UnsetPending'

    ;
    ((self.ui).sidebarContent).anchoredPosition = pos
    self.startCenterCo = false
  end
)
  else
    local pos = ((self.ui).sidebarContent).anchoredPosition
    pos:Set(pos.x, 0)
    -- DECOMPILER ERROR at PC73: Confused about usage of register: R5 in 'UnsetPending'

    ;
    ((self.ui).sidebarContent).anchoredPosition = pos
  end
  do
    self.openedDetail = true
    UIManager:HideWindow(UIWindowTypeID.BuildingQueue)
    self:ItemsShowCantClickState(true)
    if GuideManager:TryTriggerGuide(eGuideCondition.InOassisBuildingDetail) then
      (self.detailItemUI):UpdateState()
      return self.detailItemUI
    end
  end
end

UIOasisSidle.ItemsShowCantClickState = function(self, isShow)
  -- function num : 0_7 , upvalues : _ENV
  if self.buildingUIItems ~= nil then
    for k,v in pairs(self.buildingUIItems) do
      if v ~= nil then
        ((v.ui).mentionCantClick):SetActive(isShow)
      end
    end
  end
end

UIOasisSidle.FocusToComfirmItem = function(self)
  -- function num : 0_8 , upvalues : _ENV
  if self.buildingUIItems == nil then
    return 
  end
  local buildingItem = nil
  for k,v in pairs(self.buildingUIItems) do
    if v ~= nil and v.waitForConfirm then
      buildingItem = v
      break
    end
  end
  do
    if buildingItem == nil then
      return 
    end
    local rowTrans = (buildingItem.rowIns).transform
    local centerOnDetailOfs = -(rowTrans.anchoredPosition).y - (rowTrans.rect).height // 2 - (self.ui).topOfs
    local pos = ((self.ui).sidebarContent).anchoredPosition
    pos:Set(pos.x, centerOnDetailOfs)
    -- DECOMPILER ERROR at PC42: Confused about usage of register: R5 in 'UnsetPending'

    ;
    ((self.ui).sidebarContent).anchoredPosition = pos
  end
end

UIOasisSidle.__closedDetailItem = function(self)
  -- function num : 0_9 , upvalues : _ENV
  if self.openedBuildingIndex ~= nil and (self.buildingRows)[self.openedBuildingIndex] ~= nil then
    if self.detailItemUI ~= nil then
      self:DisplayRowChildren(((self.buildingRows)[self.openedBuildingIndex]).transform, true)
      ;
      (self.detailItemUI):Hide()
      self.openedBuildingIndex = nil
      -- DECOMPILER ERROR at PC24: Confused about usage of register: R1 in 'UnsetPending'

      ;
      ((self.ui).scrollRect).vertical = true
      if self.CloseDetailEvent ~= nil then
        (self.CloseDetailEvent)(not ((self.detailItemUI).buildingData).isBuild)
      end
      self.openedDetail = false
    end
    self:ItemsShowCantClickState(false)
    UIManager:ShowWindow(UIWindowTypeID.BuildingQueue)
  end
end

UIOasisSidle.DisplayRowChildren = function(self, rowItemTrans, isShow)
  -- function num : 0_10
  local count = rowItemTrans.childCount
  for i = 0, count - 1 do
    ((rowItemTrans:GetChild(i)).gameObject):SetActive(isShow)
  end
end

UIOasisSidle.CloseSidebarButtonAndCloseDetail = function(self)
  -- function num : 0_11
  if self.openedDetail then
    self:__closedDetailItem()
  end
  self:OnSidleShow(false)
end

UIOasisSidle.CloseSidebarOrDetail = function(self)
  -- function num : 0_12
  if self.openedDetail then
    self:__closedDetailItem()
    return false
  end
  self:OnSidleShow(false)
  return true
end

UIOasisSidle.ResetSidlePos = function(self)
  -- function num : 0_13 , upvalues : cs_UIMnager, cs_Screen, _ENV
  local position = (((self.ui).sidebarTween).transform).anchoredPosition
  position.x = position.x + (cs_UIMnager.Instance).CurNotchValue / 100 * cs_Screen.width
  -- DECOMPILER ERROR at PC15: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (((self.ui).sidebarTween).transform).anchoredPosition = position
  ;
  ((self.ui).sidebarTween):CreateTween()
  ;
  (((self.ui).sidebarTween).onRewind):AddListener(BindCallback(self, function()
    -- function num : 0_13_0 , upvalues : self
    self:HandleSlideRelativeUI()
  end
))
end

UIOasisSidle.OnSidleShow = function(self, isShow)
  -- function num : 0_14 , upvalues : _ENV
  if isShow and not self.isSidleShow then
    ((self.ui).sidebarTween):DORestart()
    self.isSidleShow = true
    self:HandleSlideRelativeUI()
    self:FocusToComfirmItem()
    AudioManager:PlayAudioById(1001)
    ;
    (UIUtil.Push2BackStack)(self.__closeSideBarOrDetail)
  else
    if not isShow and self.isSidleShow then
      self.isSidleShow = false
      self:HandleSlideRelativeUI()
    end
  end
end

UIOasisSidle.HandleSlideRelativeUI = function(self)
  -- function num : 0_15
  if self.isSidleShow then
    self.isSidleShow = true
    if self.onSidleHideEvent ~= nil then
      (self.onSidleHideEvent)()
    end
  end
end

UIOasisSidle.SendConfirmCompleted = function(self, id)
  -- function num : 0_16
  if self.ConfirmOverEvent ~= nil then
    (self.ConfirmOverEvent)(id)
  end
end

UIOasisSidle.RecvConfirmCompleted = function(self, id)
  -- function num : 0_17
  local item = (self.buildingUIItems)[id]
  if item == nil then
    return 
  end
  item:ResetConfirmState()
end

UIOasisSidle.Update = function(self, timestamp, isSecond)
  -- function num : 0_18 , upvalues : _ENV
  if self.buildingUIItems == nil then
    return 
  end
  for k,v in pairs(self.buildingUIItems) do
    if v ~= nil then
      v:Update(timestamp, isSecond)
    end
  end
end

UIOasisSidle.UpdateItemUI = function(self, buildingData)
  -- function num : 0_19 , upvalues : _ENV
  local id = buildingData.id
  if id == nil or (self.buildingUIItems)[id] == nil then
    return 
  end
  local item = (self.buildingUIItems)[id]
  item:UpdateWithData(buildingData)
  if self.detailItemUI ~= nil and (self.detailItemUI).active and (self.detailItemUI).id == id then
    (self.detailItemUI):UpdateWithItemData(item)
  end
  for k,v in pairs(self.buildingUIItems) do
    if v ~= nil and k ~= id then
      v:UpdateUI()
    end
  end
end

UIOasisSidle.OnItemRefresh = function(self)
  -- function num : 0_20 , upvalues : _ENV
  for k,v in pairs(self.buildingUIItems) do
    if v ~= nil then
      v:UpdateUI()
    end
  end
  if self.detailItemUI ~= nil and (self.detailItemUI).active then
    (self.detailItemUI):UpdateState()
  end
end

UIOasisSidle.UpdateProcessEvent = function(self, id, progress, remainTimeText, waitConfirmOver, second)
  -- function num : 0_21
  local item = (self.buildingUIItems)[id]
  if item ~= nil then
    item:UpdateProcess(progress, remainTimeText, waitConfirmOver, second)
    if self.openedDetail and self.currentBuildItem ~= nil and (self.currentBuildItem).id == id then
      (self.detailItemUI):UpdateProcessEvent(progress, remainTimeText, second)
      if waitConfirmOver then
        (self.detailItemUI):UpdateWithItemData(item)
      end
    end
  end
end

UIOasisSidle.OnDelete = function(self)
  -- function num : 0_22 , upvalues : _ENV, cs_coroutine
  MsgCenter:RemoveListener(eMsgEventId.UpdateItem, self.__onItemRefresh)
  MsgCenter:RemoveListener(eMsgEventId.UpdateARGItem, self.__onItemRefresh)
  if self.buildingUIItems ~= nil then
    for k,v in pairs(self.buildingUIItems) do
      if v ~= nil then
        v:OnDelete()
      end
    end
  end
  do
    if self.detailItemUI ~= nil then
      (self.detailItemUI):OnDelete()
    end
    if not IsNull((self.ui).sidebarTween) then
      ((self.ui).sidebarTween):DOKill()
    end
    if self.startCenterCo and self.centerOnDetailCo ~= nil then
      (cs_coroutine.stop)(self.centerOnDetailCo)
      self.startCenterCo = false
      self.centerOnDetailCo = nil
    end
    if self.startLoadItemCo and self.loadItemCo ~= nil then
      (cs_coroutine.stop)(self.loadItemCo)
      self.startLoadItemCo = false
      self.loadItemCo = nil
    end
    self.coWaiteForEndFrame = nil
  end
end

return UIOasisSidle

-- params : ...
-- function num : 0 , upvalues : _ENV
local UIOasisSidle = class("UIOasisSidle", UIBaseNode)
local base = UIBaseNode
local cs_UIMnager = CS.UIManager
local cs_Screen = (CS.UnityEngine).Screen
local cs_coroutine = require("XLua.Common.cs_coroutine")
local UIBuildingItem = require("Game.Oasis.UI.OasisSidle.UIOasisBuildingItem")
local ItemDetail = require("Game.Oasis.UI.OasisSidle.UIOasisBuildingItemDetail")
local firstIconId = 1001
UIOasisSidle.OnInit = function(self)
    -- function num : 0_0 , upvalues : _ENV
    (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
    self:ResetSidlePos()
    self.isSidleShow = false
    self.ConstructEvent = nil
    self.UpdrageEvent = nil
    self.ConfirmOverEvent = nil
    self.CloseDetailEvent = nil
    self.NewBuildingEvent = nil
    self.BuildingLevelUpEvent = nil
    self.OpenSidleEvent = nil
    self.buildingUIItems = {}
    self.buildingRows = {}
    self.buildingIndexItem = {}
    self.buildingIdIndex = {}
    self.__closeSideBarOrDetail = BindCallback(self, self.CloseSidebarOrDetail)
    self.coWaiteForEndFrame = ((CS.UnityEngine).WaitForEndOfFrame)()
    self.__onItemRefresh = BindCallback(self, self.OnItemRefresh)
    MsgCenter:AddListener(eMsgEventId.UpdateItem, self.__onItemRefresh)
    MsgCenter:AddListener(eMsgEventId.UpdateARGItem, self.__onItemRefresh)
end

UIOasisSidle.SetHideEvent = function(self, onSidleHideEvent)
    -- function num : 0_1
    self.onSidleHideEvent = onSidleHideEvent
end

UIOasisSidle.InitializeSidle = function(self, buildingUIModel, resLoader,
                                        sidleLoadedCallback)
    -- function num : 0_2 , upvalues : cs_coroutine, _ENV, firstIconId, UIBuildingItem
    self.completedLoadItem = false
    self.resLoader = resLoader
    if buildingUIModel == nil or buildingUIModel.buildingDataList == nil then
        return
    end
    local buildingDtaList = buildingUIModel.buildingDataList
    local buildingIndex = 0
    self.loadItemCo = (cs_coroutine.start)(
                          function()
            -- function num : 0_2_0 , upvalues : self, _ENV, buildingDtaList, firstIconId, buildingIndex, UIBuildingItem, sidleLoadedCallback
            self.startLoadItemCo = true;
            (coroutine.yield)(self.coWaiteForEndFrame)
            for _, data in ipairs(buildingDtaList) do
                (coroutine.yield)(self.coWaiteForEndFrame)
                if data ~= nil then
                    local buildingItem, rowIns = nil, nil
                    if data.id == firstIconId then
                        buildingItem = (self.ui).firstBuildingBtn
                        rowIns = ((buildingItem.transform).parent).gameObject -- DECOMPILER ERROR at PC26: Confused about usage of register: R7 in 'UnsetPending'
                        ;
                        (self.buildingRows)[0] = rowIns -- DECOMPILER ERROR at PC29: Confused about usage of register: R7 in 'UnsetPending'
                        ;
                        (self.buildingIdIndex)[firstIconId] = 0
                    else
                        buildingIndex = buildingIndex + 1
                        buildingItem = self:__createItem(buildingIndex) -- DECOMPILER ERROR at PC43: Confused about usage of register: R7 in 'UnsetPending'
                        ;
                        (self.buildingIdIndex)[data.id] = buildingIndex
                    end
                    buildingItem.name = data.id
                    local item = (UIBuildingItem.New)()
                    item:Init(buildingItem)
                    item:InitItem(rowIns, data, self.resLoader, BindCallback(
                                      self, self.OnClickBuildingItem, item),
                                  self)
                    item:Show() -- DECOMPILER ERROR at PC66: Confused about usage of register: R8 in 'UnsetPending'
                    ;
                    (self.buildingUIItems)[data.id] = item -- DECOMPILER ERROR at PC71: Confused about usage of register: R8 in 'UnsetPending'
                    ;
                    (self.buildingIndexItem)[(self.buildingIdIndex)[data.id]] =
                        item
                end
            end
            self.startLoadItemCo = false
            self.completedLoadItem = true
            if sidleLoadedCallback ~= nil then sidleLoadedCallback() end
        end)
end

UIOasisSidle.__createItem = function(self, buildingIndex)
    -- function num : 0_3
    local rowIns = self:__getAndCreateRowIns(buildingIndex)
    local button = ((self.ui).buildingItem):Instantiate(rowIns.transform)
    return button, rowIns
end

UIOasisSidle.__getAndCreateRowIns = function(self, buildingIndex)
    -- function num : 0_4 , upvalues : _ENV
    if (self.buildingRows)[buildingIndex] == nil then
        if buildingIndex % 2 == 1 then
            local rowIns = ((self.ui).rowItem):Instantiate(
                               (self.ui).sidebarContent)
            rowIns.name = tostring(buildingIndex) .. "_" ..
                              tostring(buildingIndex + 1) -- DECOMPILER ERROR at PC23: Confused about usage of register: R3 in 'UnsetPending'
            ;
            (self.buildingRows)[buildingIndex] = rowIns
            rowIns:SetActive(true)
        else
            do
                -- DECOMPILER ERROR at PC32: Confused about usage of register: R2 in 'UnsetPending'


                (self.buildingRows)[buildingIndex] =
                    (self.buildingRows)[buildingIndex - 1]
                return (self.buildingRows)[buildingIndex]
            end
        end
    end
end

UIOasisSidle.OnClickBuildingItem = function(self, buildingItem)
    -- function num : 0_5
    local result = false
    -- DECOMPILER ERROR at PC10: Unhandled construct in 'MakeBoolean' P1

    if not buildingItem.isBuild and self.NewBuildingEvent ~= nil then
        result = (self.NewBuildingEvent)(buildingItem.id)
    end
    if self.BuildingLevelUpEvent ~= nil then
        result = (self.BuildingLevelUpEvent)(buildingItem.id, false)
    end
    if result then self:__createDetailItem(buildingItem) end
end

UIOasisSidle.__createDetailItem = function(self, buildingUIItem)
    -- function num : 0_6 , upvalues : ItemDetail, cs_coroutine, _ENV
    local buildingData = buildingUIItem.buildingData
    self:__closedDetailItem()
    self.openedBuildingIndex = (self.buildingIdIndex)[buildingData.id]
    if self.openedBuildingIndex == nil then return end
    self.currentBuildItem = (self.buildingIndexItem)[self.openedBuildingIndex]
    if self.currentBuildItem == nil then return end
    local rowRectTrans = ((self.currentBuildItem).rowIns).transform
    self:DisplayRowChildren(rowRectTrans, false)
    if self.detailItemUI == nil then
        self.detailItemUI = (ItemDetail.New)();
        (self.detailItemUI):Init((self.ui).detailItem);
        (self.detailItemUI):InjectResloader(self.resloader)
    end
    (self.detailItemUI):ResetQuestState();
    (self.detailItemUI):UpdateWithItemData(self.currentBuildItem);
    (self.detailItemUI):OnShowInRect(rowRectTrans) -- DECOMPILER ERROR at PC54: Confused about usage of register: R4 in 'UnsetPending'
    ;
    ((self.ui).scrollRect).vertical = false
    if self.openedBuildingIndex > 0 then
        self.startCenterCo = true
        self.centerOnDetailCo = (cs_coroutine.start)(
                                    function()
                -- function num : 0_6_0 , upvalues : _ENV, self, rowRectTrans
                (coroutine.yield)(self.coWaiteForEndFrame)
                local centerOnDetailOfs =
                    -(rowRectTrans.anchoredPosition).y -
                        (rowRectTrans.rect).height // 2 - (self.ui).topOfs
                local pos = ((self.ui).sidebarContent).anchoredPosition
                pos:Set(pos.x, centerOnDetailOfs) -- DECOMPILER ERROR at PC23: Confused about usage of register: R2 in 'UnsetPending'
                ;
                ((self.ui).sidebarContent).anchoredPosition = pos
                self.startCenterCo = false
            end)
    else
        local pos = ((self.ui).sidebarContent).anchoredPosition
        pos:Set(pos.x, 0) -- DECOMPILER ERROR at PC73: Confused about usage of register: R5 in 'UnsetPending'
        ;
        ((self.ui).sidebarContent).anchoredPosition = pos
    end
    do
        self.openedDetail = true
        UIManager:HideWindow(UIWindowTypeID.BuildingQueue)
        self:ItemsShowCantClickState(true)
        if GuideManager:TryTriggerGuide(eGuideCondition.InOassisBuildingDetail) then
            (self.detailItemUI):UpdateState()
            return self.detailItemUI
        end
    end
end

UIOasisSidle.ItemsShowCantClickState = function(self, isShow)
    -- function num : 0_7 , upvalues : _ENV
    if self.buildingUIItems ~= nil then
        for k, v in pairs(self.buildingUIItems) do
            if v ~= nil then
                ((v.ui).mentionCantClick):SetActive(isShow)
            end
        end
    end
end

UIOasisSidle.FocusToComfirmItem = function(self)
    -- function num : 0_8 , upvalues : _ENV
    if self.buildingUIItems == nil then return end
    local buildingItem = nil
    for k, v in pairs(self.buildingUIItems) do
        if v ~= nil and v.waitForConfirm then
            buildingItem = v
            break
        end
    end
    do
        if buildingItem == nil then return end
        local rowTrans = (buildingItem.rowIns).transform
        local centerOnDetailOfs = -(rowTrans.anchoredPosition).y -
                                      (rowTrans.rect).height // 2 -
                                      (self.ui).topOfs
        local pos = ((self.ui).sidebarContent).anchoredPosition
        pos:Set(pos.x, centerOnDetailOfs) -- DECOMPILER ERROR at PC42: Confused about usage of register: R5 in 'UnsetPending'
        ;
        ((self.ui).sidebarContent).anchoredPosition = pos
    end
end

UIOasisSidle.__closedDetailItem = function(self)
    -- function num : 0_9 , upvalues : _ENV
    if self.openedBuildingIndex ~= nil and
        (self.buildingRows)[self.openedBuildingIndex] ~= nil then
        if self.detailItemUI ~= nil then
            self:DisplayRowChildren(
                ((self.buildingRows)[self.openedBuildingIndex]).transform, true);
            (self.detailItemUI):Hide()
            self.openedBuildingIndex = nil -- DECOMPILER ERROR at PC24: Confused about usage of register: R1 in 'UnsetPending'
            ;
            ((self.ui).scrollRect).vertical = true
            if self.CloseDetailEvent ~= nil then
                (self.CloseDetailEvent)(
                    not ((self.detailItemUI).buildingData).isBuild)
            end
            self.openedDetail = false
        end
        self:ItemsShowCantClickState(false)
        UIManager:ShowWindow(UIWindowTypeID.BuildingQueue)
    end
end

UIOasisSidle.DisplayRowChildren = function(self, rowItemTrans, isShow)
    -- function num : 0_10
    local count = rowItemTrans.childCount
    for i = 0, count - 1 do
        ((rowItemTrans:GetChild(i)).gameObject):SetActive(isShow)
    end
end

UIOasisSidle.CloseSidebarButtonAndCloseDetail =
    function(self)
        -- function num : 0_11
        if self.openedDetail then self:__closedDetailItem() end
        self:OnSidleShow(false)
    end

UIOasisSidle.CloseSidebarOrDetail = function(self)
    -- function num : 0_12
    if self.openedDetail then
        self:__closedDetailItem()
        return false
    end
    self:OnSidleShow(false)
    return true
end

UIOasisSidle.ResetSidlePos = function(self)
    -- function num : 0_13 , upvalues : cs_UIMnager, cs_Screen, _ENV
    local position = (((self.ui).sidebarTween).transform).anchoredPosition
    position.x = position.x + (cs_UIMnager.Instance).CurNotchValue / 100 *
                     cs_Screen.width -- DECOMPILER ERROR at PC15: Confused about usage of register: R2 in 'UnsetPending'
    ;
    (((self.ui).sidebarTween).transform).anchoredPosition = position;
    ((self.ui).sidebarTween):CreateTween();
    (((self.ui).sidebarTween).onRewind):AddListener(
        BindCallback(self, function()
            -- function num : 0_13_0 , upvalues : self
            self:HandleSlideRelativeUI()
        end))
end

UIOasisSidle.OnSidleShow = function(self, isShow)
    -- function num : 0_14 , upvalues : _ENV
    if isShow and not self.isSidleShow then
        ((self.ui).sidebarTween):DORestart()
        self.isSidleShow = true
        self:HandleSlideRelativeUI()
        self:FocusToComfirmItem()
        AudioManager:PlayAudioById(1001);
        (UIUtil.Push2BackStack)(self.__closeSideBarOrDetail)
    else
        if not isShow and self.isSidleShow then
            self.isSidleShow = false
            self:HandleSlideRelativeUI()
        end
    end
end

UIOasisSidle.HandleSlideRelativeUI = function(self)
    -- function num : 0_15
    if self.isSidleShow then
        self.isSidleShow = true
        if self.onSidleHideEvent ~= nil then (self.onSidleHideEvent)() end
    end
end

UIOasisSidle.SendConfirmCompleted = function(self, id)
    -- function num : 0_16
    if self.ConfirmOverEvent ~= nil then (self.ConfirmOverEvent)(id) end
end

UIOasisSidle.RecvConfirmCompleted = function(self, id)
    -- function num : 0_17
    local item = (self.buildingUIItems)[id]
    if item == nil then return end
    item:ResetConfirmState()
end

UIOasisSidle.Update = function(self, timestamp, isSecond)
    -- function num : 0_18 , upvalues : _ENV
    if self.buildingUIItems == nil then return end
    for k, v in pairs(self.buildingUIItems) do
        if v ~= nil then v:Update(timestamp, isSecond) end
    end
end

UIOasisSidle.UpdateItemUI = function(self, buildingData)
    -- function num : 0_19 , upvalues : _ENV
    local id = buildingData.id
    if id == nil or (self.buildingUIItems)[id] == nil then return end
    local item = (self.buildingUIItems)[id]
    item:UpdateWithData(buildingData)
    if self.detailItemUI ~= nil and (self.detailItemUI).active and
        (self.detailItemUI).id == id then
        (self.detailItemUI):UpdateWithItemData(item)
    end
    for k, v in pairs(self.buildingUIItems) do
        if v ~= nil and k ~= id then v:UpdateUI() end
    end
end

UIOasisSidle.OnItemRefresh = function(self)
    -- function num : 0_20 , upvalues : _ENV
    for k, v in pairs(self.buildingUIItems) do
        if v ~= nil then v:UpdateUI() end
    end
    if self.detailItemUI ~= nil and (self.detailItemUI).active then
        (self.detailItemUI):UpdateState()
    end
end

UIOasisSidle.UpdateProcessEvent = function(self, id, progress, remainTimeText,
                                           waitConfirmOver, second)
    -- function num : 0_21
    local item = (self.buildingUIItems)[id]
    if item ~= nil then
        item:UpdateProcess(progress, remainTimeText, waitConfirmOver, second)
        if self.openedDetail and self.currentBuildItem ~= nil and
            (self.currentBuildItem).id == id then
            (self.detailItemUI):UpdateProcessEvent(progress, remainTimeText,
                                                   second)
            if waitConfirmOver then
                (self.detailItemUI):UpdateWithItemData(item)
            end
        end
    end
end

UIOasisSidle.OnDelete = function(self)
    -- function num : 0_22 , upvalues : _ENV, cs_coroutine
    MsgCenter:RemoveListener(eMsgEventId.UpdateItem, self.__onItemRefresh)
    MsgCenter:RemoveListener(eMsgEventId.UpdateARGItem, self.__onItemRefresh)
    if self.buildingUIItems ~= nil then
        for k, v in pairs(self.buildingUIItems) do
            if v ~= nil then v:OnDelete() end
        end
    end
    do
        if self.detailItemUI ~= nil then (self.detailItemUI):OnDelete() end
        if not IsNull((self.ui).sidebarTween) then
            ((self.ui).sidebarTween):DOKill()
        end
        if self.startCenterCo and self.centerOnDetailCo ~= nil then
            (cs_coroutine.stop)(self.centerOnDetailCo)
            self.startCenterCo = false
            self.centerOnDetailCo = nil
        end
        if self.startLoadItemCo and self.loadItemCo ~= nil then
            (cs_coroutine.stop)(self.loadItemCo)
            self.startLoadItemCo = false
            self.loadItemCo = nil
        end
        self.coWaiteForEndFrame = nil
    end
end

return UIOasisSidle


local UINAthAreaItem = class("UINAthAreaItem", UIBaseNode)
local base = UIBaseNode
local AthAreaGridData = require("Game.Arithmetic.Data.AthAreaGridData")
local UINAthTableGridState = require("Game.Arithmetic.AthMain.Table.UINAthTableGridState")
local eAthGridState = require("Game.Arithmetic.Enum.eAthGridState")
local UINAthItem = require("Game.Arithmetic.AthList.Area.UINAthItem")
local AthUtil = require("Game.Arithmetic.AthUtil")
local itemPivot = (Vector2.New)(0.5, 0.5)
local itemAnchor = (Vector2.New)(0, 1)
UINAthAreaItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINAthTableGridState
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddValueChangedListener)((self.ui).tog_Root, self, self._OnClickRootToggle)
  ;
  ((self.ui).img_State):SetActive(false)
  self.gridStatePool = (UIItemPool.New)(UINAthTableGridState, (self.ui).img_State)
  self.gridSizeX = ((((self.ui).gridHolder).rect).size).x / ((self.ui).gridSize).x
  self.gridSizeY = ((((self.ui).gridHolder).rect).size).y / ((self.ui).gridSize).y
  self.__OnClickAthItem = BindCallback(self, self.OnClickAthItem)
  self.athItemPoolDic = {}
end

UINAthAreaItem.InitAthAreaItem = function(self, areaId, athMain, dragStartFunc)
  -- function num : 0_1 , upvalues : _ENV
  self.areaId = areaId
  self.athMain = athMain
  self.dragStartFunc = dragStartFunc
  ;
  ((self.ui).img_Icon):SetIndex(areaId - 1)
  local areaCfg = (ConfigData.ath_area)[areaId]
  if areaCfg == nil then
    error("Can\'t find ath areaCfg, areaId = " .. tostring(areaId))
    return 
  end
  -- DECOMPILER ERROR at PC27: Confused about usage of register: R5 in 'UnsetPending'

  ;
  ((self.ui).tex_Name).text = (LanguageUtil.GetLocaleText)(areaCfg.name2)
end

UINAthAreaItem.RefreshAthAreaItem = function(self, heroData, resLoader, space, maxSpace)
  -- function num : 0_2 , upvalues : _ENV, AthAreaGridData, AthUtil, eAthGridState
  self:__HideAllAthItem()
  self:__ClearItemPosTween()
  self.heroData = heroData
  self.resLoader = resLoader
  self.space = space
  self.maxSpace = maxSpace
  local gridUnlockList = (ConfigData.game_config).athGridUnlockList
  if #gridUnlockList < space then
    error((string.format)("Ath grid count(%s) error, space = (%s)", #gridUnlockList, space))
    return 
  end
  self.areaGridData = (AthAreaGridData.New)(self.areaId)
  ;
  (self.areaGridData):InitAthAreaGridData(heroData, space, maxSpace)
  ;
  (self.gridStatePool):HideAll()
  for k,gridId in ipairs(AthUtil.AthUseGridList) do
    local state = ((self.areaGridData).gridStateList)[gridId]
    if state == eAthGridState.Lock then
      local stateItem = (self.gridStatePool):GetOne()
      local x, y, position = self:GetAthGridPos(gridId, true)
      ;
      (stateItem.transform):SetParent((self.ui).stateHolder)
      stateItem:InitAthGridState(position, 1)
    else
      do
        if state == eAthGridState.Disable then
          local stateItem = (self.gridStatePool):GetOne()
          local x, y, position = self:GetAthGridPos(gridId, true)
          ;
          (stateItem.transform):SetParent((self.ui).stateHolder)
          stateItem:InitAthGridState(position, 0)
        end
        do
          -- DECOMPILER ERROR at PC82: LeaveBlock: unexpected jumping out DO_STMT

          -- DECOMPILER ERROR at PC82: LeaveBlock: unexpected jumping out IF_ELSE_STMT

          -- DECOMPILER ERROR at PC82: LeaveBlock: unexpected jumping out IF_STMT

        end
      end
    end
  end
  self.athItemDic = {}
  for uid,athData in pairs((self.areaGridData).athInstalledDic) do
    self:InstallAthItem(athData)
  end
  self:SetAthItemPosTween()
end

UINAthAreaItem.SetAthAreaItemToggleOn = function(self, isOn)
  -- function num : 0_3
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R2 in 'UnsetPending'

  ((self.ui).tog_Root).isOn = isOn
end

UINAthAreaItem._OnClickRootToggle = function(self, isOn)
  -- function num : 0_4
  if isOn then
    (self.athMain):OnSelectAthAreaItem(self.areaId)
  end
  self:SetAthAreaItemToggleOnUI(isOn)
end

UINAthAreaItem.ShowAthAreaItemMask = function(self, show)
  -- function num : 0_5
  ((self.ui).img_Mask):SetActive(show)
end

UINAthAreaItem.SetAthAreaItemToggleOnUI = function(self, isOn)
  -- function num : 0_6 , upvalues : _ENV
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R2 in 'UnsetPending'

  if isOn then
    ((self.ui).img_Root).color = Color.white
    -- DECOMPILER ERROR at PC11: Confused about usage of register: R2 in 'UnsetPending'

    ;
    ((self.ui).tex_Name).color = Color.black
    -- DECOMPILER ERROR at PC17: Confused about usage of register: R2 in 'UnsetPending'

    ;
    (((self.ui).img_Icon).image).color = Color.black
  else
    -- DECOMPILER ERROR at PC23: Confused about usage of register: R2 in 'UnsetPending'

    ;
    ((self.ui).img_Root).color = (self.ui).color_NormalBg
    -- DECOMPILER ERROR at PC28: Confused about usage of register: R2 in 'UnsetPending'

    ;
    ((self.ui).tex_Name).color = (self.ui).color_NormalName
    -- DECOMPILER ERROR at PC34: Confused about usage of register: R2 in 'UnsetPending'

    ;
    (((self.ui).img_Icon).image).color = (self.ui).color_NormalName
  end
end

UINAthAreaItem.OnClickAthItem = function(self, athItem)
  -- function num : 0_7
  (self.athMain):OnClickAthItem(athItem, true)
end

UINAthAreaItem.GetAthGridPos = function(self, gridId, withUnityPos)
  -- function num : 0_8 , upvalues : _ENV, AthUtil
  local y = (math.ceil)(gridId / (AthUtil.AthGridSize).x)
  local x = gridId % (AthUtil.AthGridSize).x
  if x == 0 then
    x = (AthUtil.AthGridSize).x
  end
  if (AthUtil.AthGridSize).y < y then
    error("AthGridPos out of range, gridId == " .. tostring(gridId))
  end
  local unityPos = nil
  if withUnityPos then
    local uX = self.gridSizeX * (x - 1)
    local uY = self.gridSizeY * (y - 1) * -1
    unityPos = (Vector2.New)(uX, uY)
  end
  do
    return x, y, unityPos
  end
end

UINAthAreaItem.GetAthTableItemPos = function(self, athData, gridId)
  -- function num : 0_9 , upvalues : _ENV
  local space = athData:GetAthSize()
  local x, y = self:GetAthGridPos(gridId)
  local uX = 0
  local uY = 0
  if space == 1 then
    uX = x - 0.5
    uY = y - 0.5
  else
    if space == 2 then
      uX = x - 0.5
      uY = y
    else
      if space == 4 then
        uX = x
        uY = y
      else
        if space == 8 then
          uX = x
          uY = y + 1
        end
      end
    end
  end
  return (Vector2.New)(uX * self.gridSizeX, -(uY) * self.gridSizeY)
end

UINAthAreaItem.GetAthGridIdByScreenPos = function(self, worldPos, athData)
  -- function num : 0_10 , upvalues : _ENV, AthUtil
  local centerAnchordPos = UIManager:World2UIPosition(worldPos, (self.ui).gridHolder, nil, UIManager.UICamera)
  centerAnchordPos.y = -centerAnchordPos.y
  local athSpace = (athData:GetAthSize())
  local ltAnchordPos = nil
  if athSpace == 1 then
    ltAnchordPos = centerAnchordPos
  else
    ltAnchordPos = {}
    if athSpace == 2 then
      ltAnchordPos.x = centerAnchordPos.x
      ltAnchordPos.y = centerAnchordPos.y - self.gridSizeY / 2
    else
      if athSpace == 4 then
        ltAnchordPos.x = centerAnchordPos.x - self.gridSizeX / 2
        ltAnchordPos.y = centerAnchordPos.y - self.gridSizeY / 2
      else
        if athSpace == 8 then
          ltAnchordPos.x = centerAnchordPos.x - self.gridSizeX / 2
          ltAnchordPos.y = centerAnchordPos.y - self.gridSizeY * 1.5
        end
      end
    end
  end
  local aPosX = ltAnchordPos.x
  local aPosY = ltAnchordPos.y
  local gridHolderSize = (((self.ui).gridHolder).rect).size
  if gridHolderSize.x < aPosX or aPosX < 0 or gridHolderSize.y < aPosY or aPosY < 0 then
    return 
  end
  local gridX = (math.ceil)(aPosX / self.gridSizeX)
  local gridY = (math.ceil)(aPosY / self.gridSizeY)
  local gridId = (gridY - 1) * (AthUtil.AthGridSize).x + gridX
  return gridId
end

UINAthAreaItem.OnInstallAthItem = function(self, athData)
  -- function num : 0_11
  (self.areaGridData):InstallAthGridData(athData)
  self:InstallAthItem(athData)
end

UINAthAreaItem.InstallAthItem = function(self, athData)
  -- function num : 0_12
  local gridPos = (athData.bindInfo).grid
  local space = athData:GetAthSize()
  local athItem = self:__GetAthItem(athData)
  local unityPos = self:GetAthTableItemPos(athData, gridPos)
  -- DECOMPILER ERROR at PC12: Confused about usage of register: R6 in 'UnsetPending'

  ;
  (athItem.transform).anchoredPosition = unityPos
  -- DECOMPILER ERROR at PC15: Confused about usage of register: R6 in 'UnsetPending'

  ;
  (self.athItemDic)[athData.uid] = athItem
end

UINAthAreaItem.OnUnInstallAthItem = function(self, uid, gridPos)
  -- function num : 0_13
  local athItem = (self.athItemDic)[uid]
  if athItem == nil then
    return 
  end
  local athData = athItem:GetAthItemData()
  ;
  (self.areaGridData):UninstallAthGridData(athData, gridPos)
  self:__HideOneAthItem(athItem)
  -- DECOMPILER ERROR at PC16: Confused about usage of register: R5 in 'UnsetPending'

  ;
  (self.athItemDic)[uid] = nil
  if self.itemPosTweenDic ~= nil then
    local tween = (self.itemPosTweenDic)[uid]
    if tween ~= nil then
      tween:Kill()
      -- DECOMPILER ERROR at PC27: Confused about usage of register: R6 in 'UnsetPending'

      ;
      (self.itemPosTweenDic)[uid] = nil
    end
  end
end

UINAthAreaItem.OnReinstallAllAthTable = function(self, athInstallDic, athInstalledDic)
  -- function num : 0_14 , upvalues : _ENV
  for uid,gridPos in pairs(athInstalledDic) do
    self:OnUnInstallAthItem(uid, gridPos)
  end
  for uid,gridPos in pairs(athInstallDic) do
    local athData = ((PlayerDataCenter.allAthData).athDic)[uid]
    self:OnInstallAthItem(athData)
  end
end

UINAthAreaItem.__GetItemSizeDelta = function(self, space)
  -- function num : 0_15 , upvalues : _ENV
  local x = 0
  local y = 0
  if space == 1 then
    x = self.gridSizeX
    y = self.gridSizeY
  else
    if space == 2 then
      x = self.gridSizeX
      y = self.gridSizeY * 2
    else
      if space == 4 then
        x = self.gridSizeX * 2
        y = self.gridSizeY * 2
      else
        if space == 8 then
          x = self.gridSizeX * 2
          y = self.gridSizeY * 4
        end
      end
    end
  end
  x = x - 10
  y = y - 10
  return (Vector2.New)(x, y)
end

UINAthAreaItem.__GetAthItem = function(self, athData)
  -- function num : 0_16 , upvalues : _ENV, UINAthItem, itemAnchor, itemPivot
  local space = athData:GetAthSize()
  local pool = (self.athItemPoolDic)[space]
  do
    if pool == nil then
      local go = (self.athMain):GetAthItemGameObject(space)
      pool = (UIItemPool.New)(UINAthItem, go)
      -- DECOMPILER ERROR at PC17: Confused about usage of register: R5 in 'UnsetPending'

      ;
      (self.athItemPoolDic)[space] = pool
    end
    local item = pool:GetOne()
    item:SetAthItemDragFunc(self.dragStartFunc, true)
    item:InitAthItem(athData, self.__OnClickAthItem, self.resLoader, true)
    ;
    (item.transform):SetParent((self.ui).gridHolder)
    -- DECOMPILER ERROR at PC37: Confused about usage of register: R5 in 'UnsetPending'

    ;
    (item.transform).anchorMin = itemAnchor
    -- DECOMPILER ERROR at PC40: Confused about usage of register: R5 in 'UnsetPending'

    ;
    (item.transform).anchorMax = itemAnchor
    -- DECOMPILER ERROR at PC43: Confused about usage of register: R5 in 'UnsetPending'

    ;
    (item.transform).pivot = itemPivot
    -- DECOMPILER ERROR at PC48: Confused about usage of register: R5 in 'UnsetPending'

    ;
    (item.transform).sizeDelta = self:__GetItemSizeDelta(space)
    return item
  end
end

UINAthAreaItem.__HideOneAthItem = function(self, athItem)
  -- function num : 0_17
  local athData = athItem:GetAthItemData()
  local space = athData:GetAthSize()
  local pool = (self.athItemPoolDic)[space]
  pool:HideOne(athItem)
end

UINAthAreaItem.__HideAllAthItem = function(self)
  -- function num : 0_18 , upvalues : _ENV
  for k,pool in pairs(self.athItemPoolDic) do
    pool:HideAll()
  end
end

UINAthAreaItem.__DeleteAllAthItem = function(self)
  -- function num : 0_19 , upvalues : _ENV
  for k,pool in pairs(self.athItemPoolDic) do
    pool:DeleteAll()
  end
end

UINAthAreaItem.SetAthItemPosTween = function(self)
  -- function num : 0_20 , upvalues : _ENV
  local duration = 0.3
  local transPos = (Vector2.New)(-20, 20)
  self.itemPosTweenDic = {}
  for uid,Item in pairs(self.athItemDic) do
    local toAnchoredPos = (Item.transform).anchoredPosition
    -- DECOMPILER ERROR at PC18: Confused about usage of register: R9 in 'UnsetPending'

    ;
    (Item.transform).anchoredPosition = (Item.transform).anchoredPosition + transPos
    -- DECOMPILER ERROR at PC25: Confused about usage of register: R9 in 'UnsetPending'

    ;
    (self.itemPosTweenDic)[uid] = (Item.transform):DOAnchorPos(toAnchoredPos, duration)
    duration = duration + 0.1
  end
end

UINAthAreaItem.__ClearItemPosTween = function(self)
  -- function num : 0_21 , upvalues : _ENV
  if self.itemPosTweenDic == nil then
    return 
  end
  for k,tween in pairs(self.itemPosTweenDic) do
    tween:Kill()
  end
  self.itemPosTweenDic = nil
end

UINAthAreaItem.GetAthTableItemByUid = function(self, uid)
  -- function num : 0_22
  return (self.athItemDic)[uid]
end

UINAthAreaItem.RefreshAthAreaItemBlueDot = function(self)
  -- function num : 0_23 , upvalues : _ENV
  local canLoaded = (PlayerDataCenter.allAthData):GetHeroCanLoadedSlot(self.heroData, self.areaId)
  ;
  ((self.ui).blueDot):SetActive(canLoaded)
end

UINAthAreaItem.RefreshAthAreaItemData = function(self, updateAth)
  -- function num : 0_24 , upvalues : _ENV
  for uid,v in pairs(updateAth) do
    local athItem = (self.athItemDic)[uid]
    if athItem ~= nil then
      athItem:RereshAthItem()
    end
  end
end

UINAthAreaItem.RefreshAthAreaItemDataAll = function(self)
  -- function num : 0_25 , upvalues : _ENV
  for uid,athItem in pairs(self.athItemDic) do
    athItem:RereshAthItem()
  end
end

UINAthAreaItem.OnDelete = function(self)
  -- function num : 0_26 , upvalues : base
  self:__DeleteAllAthItem()
  self:__ClearItemPosTween()
  ;
  (base.OnDelete)(self)
end

return UINAthAreaItem


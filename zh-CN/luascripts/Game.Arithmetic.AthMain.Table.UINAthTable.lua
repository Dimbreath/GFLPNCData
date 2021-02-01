-- params : ...
-- function num : 0 , upvalues : _ENV
local UINAthTable = class("UINAthTable", UIBaseNode)
local base = UIBaseNode
local eAthGridState = require("Game.Arithmetic.Enum.eAthGridState")
local UINAthTableGridState = require("Game.Arithmetic.AthMain.Table.UINAthTableGridState")
local AthTableUtil = require("Game.Arithmetic.AthMain.Table.AthTableUtil")
local UINAthListItem = require("Game.Arithmetic.AthSortList.UINAthListItem")
local itemPivot = (Vector2.New)(0.5, 0.5)
local itemAnchor = (Vector2.New)(0, 1)
local CS_MessageCommon = CS.MessageCommon
local CS_DoTween = ((CS.DG).Tweening).DOTween
UINAthTable.ctor = function(self, athRoot, dragStartFunc)
  -- function num : 0_0
  self.athRoot = athRoot
  self.dragStartFunc = dragStartFunc
end

UINAthTable.OnInit = function(self)
  -- function num : 0_1 , upvalues : _ENV, UINAthTableGridState
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  ((self.ui).img_State):SetActive(false)
  self.gridStatePool = (UIItemPool.New)(UINAthTableGridState, (self.ui).img_State)
  self.gridSizeX = ((((self.ui).gridHolder).rect).size).x / ((self.ui).gridSize).x
  self.gridSizeY = ((((self.ui).gridHolder).rect).size).y / ((self.ui).gridSize).y
  self.gridCount = ((self.ui).gridSize).x * ((self.ui).gridSize).y
  self.athItemPoolDic = {}
  self.__OnClickAthItem = BindCallback(self, self.OnClickAthItem)
end

UINAthTable.InitAthTable = function(self, heroData, areaId, space, maxSpace, resLoader)
  -- function num : 0_2 , upvalues : _ENV, eAthGridState
  self:__HideAllAthItem()
  self:__ClearItemPosTween()
  self.heroData = heroData
  self.areaId = areaId
  self.space = space
  self.maxSpace = maxSpace
  self.resLoader = resLoader
  local gridUnlockList = (ConfigData.game_config).athGridUnlockList
  if #gridUnlockList < space then
    error((string.format)("Ath grid count(%s) error, space = (%s)", #gridUnlockList, space))
    return 
  end
  self.gridDataList = {}
  self.gridStateList = {}
  ;
  (self.gridStatePool):HideAll()
  for k,gridId in ipairs(gridUnlockList) do
    -- DECOMPILER ERROR at PC39: Confused about usage of register: R12 in 'UnsetPending'

    if k <= space then
      (self.gridStateList)[gridId] = eAthGridState.Unlock
    else
      -- DECOMPILER ERROR at PC45: Confused about usage of register: R12 in 'UnsetPending'

      if k <= maxSpace then
        (self.gridStateList)[gridId] = eAthGridState.Lock
        local stateItem = (self.gridStatePool):GetOne()
        local x, y, position = self:GetAthGridPos(gridId, true)
        ;
        (stateItem.transform):SetParent((self.ui).stateHolder)
        stateItem:InitAthGridState(position, 1)
      else
        do
          -- DECOMPILER ERROR at PC65: Confused about usage of register: R12 in 'UnsetPending'

          ;
          (self.gridStateList)[gridId] = eAthGridState.Disable
          local stateItem = (self.gridStatePool):GetOne()
          do
            local x, y, position = self:GetAthGridPos(gridId, true)
            ;
            (stateItem.transform):SetParent((self.ui).stateHolder)
            stateItem:InitAthGridState(position, 0)
            -- DECOMPILER ERROR at PC82: LeaveBlock: unexpected jumping out DO_STMT

            -- DECOMPILER ERROR at PC82: LeaveBlock: unexpected jumping out IF_ELSE_STMT

            -- DECOMPILER ERROR at PC82: LeaveBlock: unexpected jumping out IF_STMT

            -- DECOMPILER ERROR at PC82: LeaveBlock: unexpected jumping out IF_ELSE_STMT

            -- DECOMPILER ERROR at PC82: LeaveBlock: unexpected jumping out IF_STMT

          end
        end
      end
    end
  end
  self.athItemDic = {}
  local athDataList, athDic = (PlayerDataCenter.allAthData):GetHeroAthList(heroData.dataId, areaId)
  for k,athData in ipairs(athDataList) do
    self:OnInstallAthItem(athData)
  end
  self:ShowAthItemPosTween(areaId)
end

UINAthTable.GetAthGridPos = function(self, gridId, withUnityPos)
  -- function num : 0_3 , upvalues : _ENV
  local y = (math.ceil)(gridId / ((self.ui).gridSize).x)
  local x = gridId % ((self.ui).gridSize).x
  if x == 0 then
    x = ((self.ui).gridSize).x
  end
  if ((self.ui).gridSize).y < y then
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

UINAthTable.GetAthTableItemPos = function(self, athData, gridId)
  -- function num : 0_4 , upvalues : _ENV
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

UINAthTable.GetAthGridIdByScreenPos = function(self, worldPos, athData)
  -- function num : 0_5 , upvalues : _ENV
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
  local gridId = (gridY - 1) * ((self.ui).gridSize).x + gridX
  return gridId
end

UINAthTable.GetAthInstallableGrid = function(self, athData)
  -- function num : 0_6 , upvalues : eAthGridState
  for gridId = 1, self.gridCount do
    local uid = (self.gridDataList)[gridId]
    local gridState = (self.gridStateList)[gridId]
    if uid == nil and gridState == eAthGridState.Unlock and self:CheckAthInstallable(athData, gridId) then
      return gridId
    end
  end
  return nil
end

UINAthTable.GetAthTableItemByUid = function(self, uid)
  -- function num : 0_7
  return (self.athItemDic)[uid]
end

UINAthTable.CheckAthInstallable = function(self, athData, gridPos, containUid)
  -- function num : 0_8 , upvalues : AthTableUtil, _ENV, eAthGridState
  local gridIdList = (AthTableUtil.GetAthGridIdList)(athData, gridPos, ((self.ui).gridSize).x)
  for k,gridId in ipairs(gridIdList) do
    if self.gridCount < gridId or gridId < 1 then
      return 
    end
    if (self.gridStateList)[gridId] == eAthGridState.Lock then
      return 
    end
    if (self.gridStateList)[gridId] == eAthGridState.Disable then
      return 
    end
    -- DECOMPILER ERROR at PC39: Unhandled construct in 'MakeBoolean' P1

    -- DECOMPILER ERROR at PC39: Unhandled construct in 'MakeBoolean' P1

    if (self.gridDataList)[gridId] ~= nil and containUid ~= nil and (self.gridDataList)[gridId] ~= containUid then
      return 
    end
    do return  end
  end
  return true, gridIdList
end

UINAthTable.CheckAthReplaceable = function(self, athData, gridPos, withTips)
  -- function num : 0_9 , upvalues : _ENV, CS_MessageCommon
  if (PlayerDataCenter.allAthData):HeroContainAthByUid((self.heroData).dataId, athData.uid) then
    return 
  end
  local installedUid = (self.gridDataList)[gridPos]
  if installedUid == nil then
    return 
  end
  local tarItem = (self.athItemDic)[installedUid]
  local tarAthData = tarItem:GetAthItemData()
  local tarSize = tarAthData:GetAthSize()
  local curSize = athData:GetAthSize()
  local spaceOk = false
  local ok, freeSpace = (PlayerDataCenter.allAthData):GetHeroAthFreeSpace(self.heroData, self.areaId)
  if curSize - tarSize <= freeSpace then
    spaceOk = true
  else
    if withTips then
      (CS_MessageCommon.ShowMessageTips)(ConfigData:GetTipContent(TipContent.Ath_NotOneReplaceOne))
    end
  end
  local oneReplaceMore = false
  local bigSpaceReplaceSmall = tarSize < curSize
  if spaceOk and bigSpaceReplaceSmall and not self:CheckAthInstallable(athData, gridPos, installedUid) then
    tarAthData = nil
    oneReplaceMore = true
    if withTips then
      (CS_MessageCommon.ShowMessageTips)(ConfigData:GetTipContent(TipContent.Ath_NotOneReplaceOne))
    end
  end
  if spaceOk then
    return tarAthData, oneReplaceMore
  else
    return 
  end
  -- DECOMPILER ERROR: 4 unprocessed JMP targets
end

UINAthTable.GetTryReplaceAthDic = function(self, newAthData, replacedAthData)
  -- function num : 0_10 , upvalues : _ENV
  local athDataList = (PlayerDataCenter.allAthData):GetHeroAthList((self.heroData).dataId, self.areaId)
  local athInstalledDic = {}
  for k,athItem in pairs(self.athItemDic) do
    local data = athItem:GetAthItemData()
    athInstalledDic[data.uid] = (data.bindInfo).grid
  end
  ;
  (table.removebyvalue)(athDataList, replacedAthData)
  local sizeNew = newAthData:GetAthSize()
  local sizeOld = (replacedAthData:GetAthSize())
  local athInstallDic = nil
  if sizeOld < sizeNew then
    (table.insert)(athDataList, newAthData)
    athInstallDic = self:AutoSortAthTable(athDataList)
    if athInstallDic == nil then
      return 
    end
  else
    athInstallDic = {}
    for k,athData in ipairs(athDataList) do
      athInstallDic[athData.uid] = (athData.bindInfo).grid
    end
    athInstallDic[newAthData.uid] = (replacedAthData.bindInfo).grid
  end
  return athInstallDic, athInstalledDic
end

UINAthTable.CheckAthAreaSpaceOk = function(self, athData)
  -- function num : 0_11 , upvalues : _ENV
  local athSpace = athData:GetAthSize()
  local ok, freeSpace = (PlayerDataCenter.allAthData):GetHeroAthFreeSpace(self.heroData, self.areaId)
  do return not ok or athSpace <= freeSpace end
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

UINAthTable.OneKeyInstallAthTable = function(self, athList)
  -- function num : 0_12 , upvalues : _ENV
  local tryInstallSpace = 0
  local tryInstallList = {}
  local tryInstallIdDic = {}
  for k,athData in ipairs(athList) do
    local athSize = athData:GetAthSize()
    if athSize + tryInstallSpace <= self.space and tryInstallIdDic[athData.id] == nil then
      (table.insert)(tryInstallList, athData)
      tryInstallSpace = athSize + tryInstallSpace
      tryInstallIdDic[athData.id] = true
    end
  end
  do
    if tryInstallSpace ~= self.space then
      local athInstallDic, athInstalledDic = self:AutoSortAthTable(tryInstallList)
      if athInstallDic == nil then
        return 
      end
      local isEqual = true
      for k,v in pairs(athInstallDic) do
        if athInstalledDic[k] ~= v then
          isEqual = false
          break
        end
      end
      do
        if isEqual then
          return 
        end
        if self.__OnOneKeyInstallComplete == nil then
          self.__OnOneKeyInstallComplete = BindCallback(self, self.OnOneKeyInstallComplete)
        end
        self.__athInstallDic = athInstallDic
        self.__athInstalledDic = athInstalledDic
        ;
        (self.athRoot):OneKeyInstall(self.areaId, athInstallDic, self.__OnOneKeyInstallComplete)
      end
    end
  end
end

UINAthTable.OnOneKeyInstallComplete = function(self)
  -- function num : 0_13
  self:OnReinstallAllAthTable(self.__athInstallDic, self.__athInstalledDic)
end

UINAthTable.RecordAthInstalledDic = function(self)
  -- function num : 0_14 , upvalues : _ENV
  local athInstalledDic = {}
  for k,athItem in pairs(self.athItemDic) do
    local data = athItem:GetAthItemData()
    athInstalledDic[data.uid] = (data.bindInfo).grid
  end
  self.__athInstalledDic = athInstalledDic
  return athInstalledDic
end

UINAthTable.OnOneKeyUninstallComplete = function(self)
  -- function num : 0_15 , upvalues : _ENV
  self:OnReinstallAllAthTable(table.emptytable, self.__athInstalledDic)
end

UINAthTable.AutoSortAthTable = function(self, athDataList)
  -- function num : 0_16 , upvalues : _ENV
  (table.sort)(athDataList, function(a, b)
    -- function num : 0_16_0
    local sizeA = a:GetAthSize()
    local sizeB = b:GetAthSize()
    if a.id >= b.id then
      do return sizeA ~= sizeB end
      do return sizeB < sizeA end
      -- DECOMPILER ERROR: 4 unprocessed JMP targets
    end
  end
)
  local gridDataListBack = self.gridDataList
  self.gridDataList = {}
  local athInstallDic = {}
  local athInstalledDic = {}
  for k,athItem in pairs(self.athItemDic) do
    local data = athItem:GetAthItemData()
    athInstalledDic[data.uid] = (data.bindInfo).grid
  end
  local hasError = false
  for k,athData in ipairs(athDataList) do
    local installOk = false
    for i = 1, self.gridCount do
      local installable, gridIdList = self:CheckAthInstallable(athData, i)
      if installable then
        self:__InstallGridData(athData, i)
        athInstallDic[athData.uid] = i
        installOk = true
        break
      end
    end
    do
      do
        if not installOk then
          error("AutoSortAthTable error, athDataId = " .. athData.id)
          hasError = true
          break
        end
        -- DECOMPILER ERROR at PC56: LeaveBlock: unexpected jumping out DO_STMT

      end
    end
  end
  self.gridDataList = gridDataListBack
  if hasError then
    return 
  else
    return athInstallDic, athInstalledDic
  end
end

UINAthTable.ReSortAthTable = function(self, newAthData)
  -- function num : 0_17 , upvalues : _ENV
  if newAthData ~= nil and not self:CheckAthAreaSpaceOk(newAthData) then
    return 
  end
  local athDataList = (PlayerDataCenter.allAthData):GetHeroAthList((self.heroData).dataId, self.areaId)
  if newAthData ~= nil then
    (table.insert)(athDataList, newAthData)
  end
  return self:AutoSortAthTable(athDataList)
end

UINAthTable.OnReinstallAllAthTable = function(self, athInstallDic, athInstalledDic)
  -- function num : 0_18 , upvalues : _ENV
  for uid,gridPos in pairs(athInstalledDic) do
    self:OnUnInstallAthItem(uid, gridPos)
  end
  for uid,gridPos in pairs(athInstallDic) do
    local athData = ((PlayerDataCenter.allAthData).athDic)[uid]
    self:OnInstallAthItem(athData)
  end
end

UINAthTable.__InstallGridData = function(self, athData, gridPos)
  -- function num : 0_19 , upvalues : _ENV
  local installable, gridIdList = self:CheckAthInstallable(athData, gridPos)
  if not installable then
    return 
  end
  local uid = athData.uid
  for k,gridId in ipairs(gridIdList) do
    -- DECOMPILER ERROR at PC13: Confused about usage of register: R11 in 'UnsetPending'

    (self.gridDataList)[gridId] = uid
  end
end

UINAthTable.__UninstallGridData = function(self, athData, gridPos)
  -- function num : 0_20 , upvalues : AthTableUtil, _ENV
  local gridIdList = (AthTableUtil.GetAthGridIdList)(athData, gridPos, ((self.ui).gridSize).x)
  for k,gridId in ipairs(gridIdList) do
    -- DECOMPILER ERROR at PC12: Confused about usage of register: R9 in 'UnsetPending'

    (self.gridDataList)[gridId] = nil
  end
end

UINAthTable.OnClickAthItem = function(self, athItem)
  -- function num : 0_21
  (self.athRoot):OnClickAthItem(athItem, true)
end

UINAthTable.OnInstallAthItem = function(self, athData, onlyData)
  -- function num : 0_22 , upvalues : _ENV
  if athData.bindInfo == nil then
    error((string.format)("athData.bindInfo == nil, athData.uid = %s, heroId = %s", athData.uid, (self.heroData).dataId))
    return 
  end
  local gridPos = (athData.bindInfo).grid
  self:__InstallGridData(athData, gridPos)
  if not onlyData then
    local space = athData:GetAthSize()
    local athItem = self:__GetAthItem(athData)
    local unityPos = self:GetAthTableItemPos(athData, gridPos)
    -- DECOMPILER ERROR at PC31: Confused about usage of register: R7 in 'UnsetPending'

    ;
    (athItem.transform).anchoredPosition = unityPos
    -- DECOMPILER ERROR at PC34: Confused about usage of register: R7 in 'UnsetPending'

    ;
    (self.athItemDic)[athData.uid] = athItem
  end
end

UINAthTable.OnUnInstallAthItem = function(self, uid, gridPos, onlyData)
  -- function num : 0_23
  local athItem = (self.athItemDic)[uid]
  if athItem == nil then
    return 
  end
  local athData = athItem:GetAthItemData()
  self:__UninstallGridData(athData, gridPos)
  if not onlyData then
    self:__HideOneAthItem(athItem)
    -- DECOMPILER ERROR at PC17: Confused about usage of register: R6 in 'UnsetPending'

    ;
    (self.athItemDic)[uid] = nil
    if self.itemPosTweenDic ~= nil then
      local tween = (self.itemPosTweenDic)[uid]
      if tween ~= nil then
        tween:Kill()
        -- DECOMPILER ERROR at PC28: Confused about usage of register: R7 in 'UnsetPending'

        ;
        (self.itemPosTweenDic)[uid] = nil
      end
    end
  end
end

UINAthTable.__GetItemSizeDelta = function(self, space)
  -- function num : 0_24 , upvalues : _ENV
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

UINAthTable.__GetAthItem = function(self, athData)
  -- function num : 0_25 , upvalues : _ENV, UINAthListItem, itemAnchor, itemPivot
  local space = athData:GetAthSize()
  local pool = (self.athItemPoolDic)[space]
  do
    if pool == nil then
      local go = (self.athRoot):GetAthItemGameObject(space)
      pool = (UIItemPool.New)(UINAthListItem, go)
      -- DECOMPILER ERROR at PC17: Confused about usage of register: R5 in 'UnsetPending'

      ;
      (self.athItemPoolDic)[space] = pool
    end
    local item = pool:GetOne()
    item:SetAthItemDragFunc(self.dragStartFunc, true)
    item:InitAthListItem(athData, self.__OnClickAthItem, self.resLoader, true)
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

UINAthTable.__HideOneAthItem = function(self, athItem)
  -- function num : 0_26
  local athData = athItem:GetAthItemData()
  local space = athData:GetAthSize()
  local pool = (self.athItemPoolDic)[space]
  pool:HideOne(athItem)
end

UINAthTable.__HideAllAthItem = function(self)
  -- function num : 0_27 , upvalues : _ENV
  for k,pool in pairs(self.athItemPoolDic) do
    pool:HideAll()
  end
end

UINAthTable.__DeleteAllAthItem = function(self)
  -- function num : 0_28 , upvalues : _ENV
  for k,pool in pairs(self.athItemPoolDic) do
    pool:DeleteAll()
  end
end

UINAthTable.OnAthDataUpdate = function(self, updateAth)
  -- function num : 0_29 , upvalues : _ENV
  for uid,v in pairs(updateAth) do
    local athItem = (self.athItemDic)[uid]
    if athItem ~= nil then
      athItem:RereshAthItem()
    end
  end
end

UINAthTable.OnShow = function(self)
  -- function num : 0_30 , upvalues : base, _ENV
  self:SetAthTableShowTween()
  ;
  (base.OnShow)(self)
  self.__onAthDataUpdate = BindCallback(self, self.OnAthDataUpdate)
  MsgCenter:AddListener(eMsgEventId.OnAthDataUpdate, self.__onAthDataUpdate)
end

UINAthTable.OnHide = function(self)
  -- function num : 0_31 , upvalues : _ENV
  self:ShowAthItemPosTween(nil)
  MsgCenter:RemoveListener(eMsgEventId.OnAthDataUpdate, self.__onAthDataUpdate)
end

UINAthTable.SetAthTableShowTween = function(self)
  -- function num : 0_32
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R1 in 'UnsetPending'

  ((self.ui).fade).alpha = 0
  if self.tableTween == nil then
    local doTween = ((self.ui).fade):DOFade(1, 0.3)
    doTween:SetAutoKill(false)
    self.tableTween = doTween
  else
    do
      ;
      (self.tableTween):Restart()
    end
  end
end

UINAthTable.SetAthItemPosTween = function(self)
  -- function num : 0_33 , upvalues : _ENV
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

UINAthTable.__ClearItemPosTween = function(self)
  -- function num : 0_34 , upvalues : _ENV
  if self.itemPosTweenDic == nil then
    return 
  end
  for k,tween in pairs(self.itemPosTweenDic) do
    tween:Kill()
  end
  self.itemPosTweenDic = nil
end

UINAthTable.ShowAthItemPosTween = function(self, areaId)
  -- function num : 0_35
  if areaId ~= nil then
    if self.oldAreaId == nil or self.oldAreaId ~= areaId then
      self:SetAthItemPosTween()
    end
    self.oldAreaId = areaId
  else
    self.oldAreaId = nil
  end
end

UINAthTable.OnDelete = function(self)
  -- function num : 0_36 , upvalues : base
  (self.gridStatePool):DeleteAll()
  self:__ClearItemPosTween()
  self:__DeleteAllAthItem()
  if self.tableTween ~= nil then
    (self.tableTween):Kill()
    self.tableTween = nil
  end
  ;
  (base.OnDelete)(self)
end

return UINAthTable


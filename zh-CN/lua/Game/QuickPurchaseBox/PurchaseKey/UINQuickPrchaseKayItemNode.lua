local UINQuickPrchaseKayMoneyNode = class("UINQuickPrchaseKayMoneyNode", UIBaseNode)
local base = UIBaseNode
local UINQuickPrchaseKayItemNodeItem = require("Game.QuickPurchaseBox.PurchaseKey.UINQuickPrchaseKayItemNodeItem")
local cs_MessageCommon = CS.MessageCommon
UINQuickPrchaseKayMoneyNode.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINQuickPrchaseKayItemNodeItem
  self.warehouseNetwork = NetworkManager:GetNetwork(NetworkTypeID.Warehouse)
  ;
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  self.keyPackageList = nil
  self.selectNumDic = nil
  self.couldAddKey = 0
  self.__arrowColorOrange = ((self.ui).img_Arrow).color
  self.QPKItemPool = (UIItemPool.New)(UINQuickPrchaseKayItemNodeItem, (self.ui).obj_itemNode)
  ;
  ((self.ui).obj_itemNode):SetActive(false)
  self._onPackageSelectNumChange = BindCallback(self, self.OnPackageSelectNumChange)
  self._refreshStamina = BindCallback(self, self._RefreshStamina)
  MsgCenter:AddListener(eMsgEventId.StaminaUpdate, self._refreshStamina)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_ClearAll, self, self.OnClickCleanAll)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Cancel, self, self._OnClickCancle)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Confirm, self, self._OnClickConfirem)
end

UINQuickPrchaseKayMoneyNode.SetNodeData = function(self, parent)
  -- function num : 0_1
  self.parent = parent
end

UINQuickPrchaseKayMoneyNode.InitQPKNode = function(self, maxNeededKeyNum, closeCallback)
  -- function num : 0_2
  self.maxNeededKeyNum = maxNeededKeyNum
  self.closeCallback = closeCallback
  self:_RefreshStamina()
  self:RefreshQPKPackageItemList()
  self:RefreshCouldAddKey()
end

UINQuickPrchaseKayMoneyNode.RefreshQPKPackageItemList = function(self)
  -- function num : 0_3 , upvalues : _ENV
  local hasItem = #self.keyPackageList ~= 0
  ;
  ((self.ui).main):SetActive(hasItem)
  ;
  ((self.ui).empty):SetActive(not hasItem)
  -- DECOMPILER ERROR at PC22: Confused about usage of register: R2 in 'UnsetPending'

  if not hasItem then
    ((self.ui).img_Arrow).color = Color.white
    return 
  else
    -- DECOMPILER ERROR at PC28: Confused about usage of register: R2 in 'UnsetPending'

    ((self.ui).img_Arrow).color = self.__arrowColorOrange
  end
  ;
  (self.QPKItemPool):HideAll()
  self.selectNumDic = {}
  self.couldAddKey = 0
  local isSelected = false
  for index,expPacketid in ipairs(self.keyPackageList) do
    local item = (self.QPKItemPool):GetOne()
    item:InitQPKItem(expPacketid, self._onPackageSelectNumChange)
    if self.maxNeededKeyNum == nil and not isSelected then
      item:AddOne()
      isSelected = true
    end
  end
  if self.maxNeededKeyNum ~= nil then
    local selectedDic = self:CalSelectList()
    if selectedDic == nil then
      for _,item in pairs((self.QPKItemPool).listItem) do
        item:AddAll()
      end
    else
      for _,item in pairs((self.QPKItemPool).listItem) do
        local keyNum = item:GetKeyNum()
        if selectedDic[keyNum] ~= nil and selectedDic[keyNum] > 0 then
          local warehousNum = item.warehousNum
          local addNum = (Mathf.Min)(warehousNum, selectedDic[keyNum])
          item:AddNum(addNum)
          selectedDic[keyNum] = selectedDic[keyNum] - addNum
        end
      end
    end
  end
  self:RefreshCouldAddKey()
  -- DECOMPILER ERROR: 8 unprocessed JMP targets
end

UINQuickPrchaseKayMoneyNode.CalSelectList = function(self)
  -- function num : 0_4 , upvalues : _ENV
  local needNum = self.maxNeededKeyNum
  local keyPackageList = self.keyPackageList
  local sourceDic = {}
  local keyNumList = {}
  local maxAddNum = 0
  for index,packageItemId in pairs(self.keyPackageList) do
    local itemCfg = (ConfigData.item)[packageItemId]
    if itemCfg == nil then
      error("can\'t read itemCfg with id:" .. tostring(packageItemId))
    end
    local couldAddKeyNum = (itemCfg.giftOptainDic)[ConstGlobalItem.SKey]
    local itemNum = PlayerDataCenter:GetItemCount(packageItemId)
    sourceDic[couldAddKeyNum] = (sourceDic[couldAddKeyNum] or 0) + itemNum
    maxAddNum = maxAddNum + couldAddKeyNum * itemNum
    local isInserted = nil
    for index,numInList in ipairs(keyNumList) do
      if couldAddKeyNum < numInList then
        (table.insert)(keyNumList, index, couldAddKeyNum)
        isInserted = true
        break
      else
        if couldAddKeyNum == numInList then
          isInserted = true
          break
        end
      end
    end
    do
      do
        if not isInserted then
          (table.insert)(keyNumList, couldAddKeyNum)
        end
        -- DECOMPILER ERROR at PC66: LeaveBlock: unexpected jumping out DO_STMT

      end
    end
  end
  if maxAddNum <= needNum then
    return nil
  end
  local curNum = 0
  local selectedDic = {}
  local ketNumCount = #keyNumList
  while 1 do
    if curNum < needNum then
      local isHaveBiggerOne = nil
      for index = ketNumCount, 1, -1 do
        local KeyNum = keyNumList[index]
        if selectedDic[KeyNum] ~= nil and selectedDic[KeyNum] > 0 and index < ketNumCount then
          local newKeyNum = keyNumList[index + 1]
          if sourceDic[newKeyNum] > 0 then
            selectedDic[KeyNum] = selectedDic[KeyNum] - 1
            sourceDic[KeyNum] = sourceDic[KeyNum] + 1
            selectedDic[newKeyNum] = (selectedDic[newKeyNum] or 0) + 1
            sourceDic[newKeyNum] = sourceDic[newKeyNum] - 1
            curNum = curNum + newKeyNum - KeyNum
            isHaveBiggerOne = true
            break
          end
        end
      end
      do
        if not isHaveBiggerOne then
          for index,KeyNum in ipairs(keyNumList) do
            if sourceDic[KeyNum] > 0 then
              sourceDic[KeyNum] = sourceDic[KeyNum] - 1
              selectedDic[KeyNum] = (selectedDic[KeyNum] or 0) + 1
              curNum = curNum + KeyNum
              break
            end
          end
        end
        -- DECOMPILER ERROR at PC138: LeaveBlock: unexpected jumping out DO_STMT

        -- DECOMPILER ERROR at PC138: LeaveBlock: unexpected jumping out IF_THEN_STMT

        -- DECOMPILER ERROR at PC138: LeaveBlock: unexpected jumping out IF_STMT

      end
    end
  end
  return selectedDic
end

UINQuickPrchaseKayMoneyNode.OnPackageSelectNumChange = function(self, QPKItem, num)
  -- function num : 0_5
  local itemId = QPKItem.packageItemId
  self.couldAddKey = self.couldAddKey - ((self.selectNumDic)[itemId] or 0) * QPKItem:GetKeyNum()
  -- DECOMPILER ERROR at PC17: Confused about usage of register: R4 in 'UnsetPending'

  if num == nil or num == 0 then
    (self.selectNumDic)[itemId] = nil
  else
    -- DECOMPILER ERROR at PC20: Confused about usage of register: R4 in 'UnsetPending'

    ;
    (self.selectNumDic)[itemId] = num
  end
  self.couldAddKey = self.couldAddKey + ((self.selectNumDic)[itemId] or 0) * QPKItem:GetKeyNum()
  self:RefreshCouldAddKey()
end

UINQuickPrchaseKayMoneyNode.RefreshCouldAddKey = function(self)
  -- function num : 0_6 , upvalues : _ENV
  if self.couldAddKey <= 0 then
    ((self.ui).tex_CouldAddNumber):SetIndex(1)
  else
    ;
    ((self.ui).tex_CouldAddNumber):SetIndex(0, tostring(self.couldAddKey))
  end
  -- DECOMPILER ERROR at PC27: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).tex_NewNumber).text = tostring((PlayerDataCenter.stamina):GetCurrentStamina() + self.couldAddKey)
end

UINQuickPrchaseKayMoneyNode._RefreshStamina = function(self)
  -- function num : 0_7 , upvalues : _ENV
  local ceiling = (PlayerDataCenter.stamina):GetStaminaCeiling()
  local stamina, remainSecond = (PlayerDataCenter.stamina):GetCurrentStamina()
  -- DECOMPILER ERROR at PC14: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.ui).tex_NewNumber).text = tostring(stamina + self.couldAddKey)
  -- DECOMPILER ERROR at PC20: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.ui).tex_OldNumber).text = tostring(stamina)
  if ceiling <= stamina then
    ((self.ui).tex_autoAdd):SetIndex(1)
  else
    ;
    ((self.ui).tex_autoAdd):SetIndex(0, tostring(TimestampToTime(remainSecond)))
  end
end

UINQuickPrchaseKayMoneyNode.RefreshCouldUsePackList = function(self)
  -- function num : 0_8 , upvalues : _ENV
  self.keyPackageList = {}
  local keyPackageList = ((ConfigData.item).fixedPacketMappingDic)[ConstGlobalItem.SKey]
  if keyPackageList ~= nil and #keyPackageList > 0 then
    for _,expPacketid in ipairs(keyPackageList) do
      if PlayerDataCenter:GetItemCount(expPacketid) > 0 then
        (table.insert)(self.keyPackageList, expPacketid)
      end
    end
  end
  do
    ;
    (table.sort)(self.keyPackageList)
  end
end

UINQuickPrchaseKayMoneyNode.OnClickCleanAll = function(self)
  -- function num : 0_9 , upvalues : _ENV
  for _,QPKItem in pairs((self.QPKItemPool).listItem) do
    QPKItem:CleanAll()
  end
end

UINQuickPrchaseKayMoneyNode._OnClickCancle = function(self)
  -- function num : 0_10
  if self.closeCallback ~= nil then
    (self.closeCallback)()
  end
end

UINQuickPrchaseKayMoneyNode._OnClickConfirem = function(self)
  -- function num : 0_11 , upvalues : _ENV, cs_MessageCommon
  if (self.parent).isSlideOuting then
    return 
  end
  if (table.count)(self.selectNumDic) == 0 then
    (cs_MessageCommon.ShowMessageTipsWithErrorSound)(ConfigData:GetTipContent(TipContent.notSelecedKeyCard))
    return 
  end
  ;
  (self.warehouseNetwork):CS_BACKPACK_UseItemGroup(self.selectNumDic, function()
    -- function num : 0_11_0 , upvalues : _ENV, self
    local rewardDic = {}
    for packageItemId,packageNum in pairs(self.selectNumDic) do
      local itemCfg = (ConfigData.item)[packageItemId]
      if itemCfg ~= nil and itemCfg.giftOptainDic ~= nil then
        for itemId,num in pairs(itemCfg.giftOptainDic) do
          rewardDic[itemId] = (rewardDic[itemId] or 0) + num * packageNum
        end
      end
    end
    local itemIds = {}
    local itemNums = {}
    for itemId,num in pairs(rewardDic) do
      (table.insert)(itemIds, itemId)
      ;
      (table.insert)(itemNums, num)
    end
    UIManager:ShowWindowAsync(UIWindowTypeID.CommonReward, function(window)
      -- function num : 0_11_0_0 , upvalues : itemIds, itemNums
      if window == nil then
        return 
      end
      window:InitRewardsItem(itemIds, itemNums)
    end
)
    self:RefreshCouldUsePackList()
    self:RefreshQPKPackageItemList()
    local needClose = true
    if self.maxNeededKeyNum ~= nil and (PlayerDataCenter.stamina):GetCurrentStamina() < self.maxNeededKeyNum then
      self:RefreshCouldUsePackList()
      self:RefreshQPKPackageItemList()
      needClose = false
      if (table.count)(self.keyPackageList) <= 0 then
        (self.parent):SelectTog(((self.parent).eBuyKeyTogType).useMoney)
      end
    end
    if needClose and self.closeCallback ~= nil then
      (self.closeCallback)()
    end
  end
)
end

UINQuickPrchaseKayMoneyNode.GetIsHavePackageList = function(self)
  -- function num : 0_12
  do return self.keyPackageList ~= nil and #self.keyPackageList > 0 end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

UINQuickPrchaseKayMoneyNode.OnShow = function(self)
  -- function num : 0_13 , upvalues : _ENV, base
  self.timerId = TimerManager:StartTimer(1, function()
    -- function num : 0_13_0 , upvalues : self
    self:_RefreshStamina()
  end
, self, nil, nil, true)
  ;
  (base.OnShow)(self)
end

UINQuickPrchaseKayMoneyNode.OnHide = function(self)
  -- function num : 0_14 , upvalues : _ENV, base
  if self.timerId ~= nil then
    TimerManager:StopTimer(self.timerId)
    self.timerId = nil
  end
  ;
  (base.OnHide)(self)
end

UINQuickPrchaseKayMoneyNode.OnDelete = function(self)
  -- function num : 0_15 , upvalues : _ENV, base
  if self.timerId ~= nil then
    TimerManager:StopTimer(self.timerId)
    self.timerId = nil
  end
  MsgCenter:RemoveListener(eMsgEventId.StaminaUpdate, self._refreshStamina)
  ;
  (base.OnDelete)(self)
end

return UINQuickPrchaseKayMoneyNode


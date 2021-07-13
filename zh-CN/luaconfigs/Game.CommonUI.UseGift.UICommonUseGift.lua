-- params : ...
-- function num : 0 , upvalues : _ENV
local UICommonUseGift = class("UICommonUseGift", UIBaseWindow)
local base = UIBaseWindow
local UINBaseItemWithCount = require("Game.CommonUI.Item.UINBaseItemWithCount")
local cs_Canvas = (CS.UnityEngine).Canvas
local cs_MessageCommon = CS.MessageCommon
UICommonUseGift.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINBaseItemWithCount
  (UIUtil.AddButtonListener)((self.ui).btn_background, self, self.OnClickCancle)
  ;
  (UIUtil.AddButtonListener)((self.ui).buttonNo, self, self.OnClickCancle)
  ;
  (UIUtil.AddButtonListener)((self.ui).buttonYes, self, self.OnClickUse)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Add, self, self.OnClickAdd)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Reduce, self, self.OnClickReduce)
  ;
  (UIUtil.AddValueChangedListener)((self.ui).scrollbar, self, self.OnScrollbarValueChange)
  self.itemSelectPool = (UIItemPool.New)(UINBaseItemWithCount, (self.ui).obj_itemListSub)
  ;
  ((self.ui).obj_itemListSub):SetActive(false)
  self.itemFixed = (UINBaseItemWithCount.New)()
  ;
  (self.itemFixed):Init((self.ui).obj_itemGiftSub)
  self.__OnSelectItemCallback = BindCallback(self, self.OnSelectItemCallback)
  self.__OnPressItemCallback = BindCallback(self, self.OnPressItemCallback)
  self.__OnItemUpdate = BindCallback(self, self.OnItemUpdateUseGift)
  MsgCenter:AddListener(eMsgEventId.UpdateItem, self.__OnItemUpdate)
end

UICommonUseGift.InitCommonUseGift = function(self, itemCfg, defalutSelectItemId, closeFunc)
  -- function num : 0_1 , upvalues : _ENV
  self.itemCfg = itemCfg
  self.closeFunc = closeFunc
  if not ConfigData:IsManualOpenGiftItem(self.itemCfg) then
    error("道具不是礼包却打开了礼包使用界面")
    return 
  end
  local itemData = (PlayerDataCenter.itemDic)[(self.itemCfg).id]
  if itemData ~= nil then
    self.itemCountMax = itemData:GetCount()
  else
    self.itemCountMax = 0
  end
  self.itemCountUse = self.itemCountMax == 0 and 0 or 1
  self.selectItem = nil
  self:RefreshUseGiftView(defalutSelectItemId)
end

UICommonUseGift.RefreshUseGiftView = function(self, defalutSelectItemId)
  -- function num : 0_2 , upvalues : _ENV
  if (self.itemCfg).action_type == proto_csmsg_ItemActionType.ItemActionTypeRadioChoiceGift then
    self:__RefreshUseGiftViewWithSelect(defalutSelectItemId)
    ;
    ((self.ui).obj_sliderNode):SetActive(false)
  else
    self:__RefreshUseGiftViewWithNormal()
  end
  self:__UseCountChangeUpdate(self.itemCountUse, true)
end

UICommonUseGift.__RefreshUseGiftViewWithSelect = function(self, defalutSelectItemId)
  -- function num : 0_3 , upvalues : _ENV, cs_Canvas
  ((self.ui).obj_itemList):SetActive(true)
  ;
  ((self.ui).obj_itemGift):SetActive(false)
  ;
  ((self.ui).obj_ItemInfo):SetActive(false)
  local itemList = {}
  for k,v in pairs((self.itemCfg).giftOptainDic) do
    (table.insert)(itemList, k)
  end
  ;
  (table.sort)(itemList, function(a, b)
    -- function num : 0_3_0
    do return a < b end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  ;
  (self.itemSelectPool):HideAll()
  local selectIndex = 0
  for index,id in ipairs(itemList) do
    local item = (self.itemSelectPool):GetOne()
    local itemCfg = (ConfigData.item)[id]
    item:InitItemWithCount(itemCfg, ((self.itemCfg).giftOptainDic)[id] * self.itemCountUse, self.__OnSelectItemCallback)
    ;
    (item.baseItem):SetPressCallback(self.__OnPressItemCallback, true)
    if id == defalutSelectItemId then
      selectIndex = index
    end
  end
  ;
  (cs_Canvas.ForceUpdateCanvases)()
  if selectIndex == 0 then
    ((self.ui).obj_Select):SetActive(false)
  else
    self:__SelectItemStateUpdate(((self.itemSelectPool).listItem)[selectIndex])
  end
end

UICommonUseGift.__RefreshUseGiftViewWithNormal = function(self)
  -- function num : 0_4 , upvalues : _ENV
  ((self.ui).obj_itemList):SetActive(false)
  ;
  ((self.ui).obj_itemGift):SetActive(true)
  ;
  (self.itemFixed):InitItemWithCount(self.itemCfg, self.itemCountUse, self.__OnSelectItemCallback)
  -- DECOMPILER ERROR at PC23: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).tex_GiftName).text = (LanguageUtil.GetLocaleText)((self.itemCfg).name)
end

UICommonUseGift.OnClickUse = function(self)
  -- function num : 0_5 , upvalues : _ENV, cs_MessageCommon
  if self.itemCountUse < 0 then
    return 
  end
  local warehouseNetwork = NetworkManager:GetNetwork(NetworkTypeID.Warehouse)
  local callback = function()
    -- function num : 0_5_0 , upvalues : self
    self:__UseGiftSuccess()
  end

  self._heroIdSnapShoot = PlayerDataCenter:TakeHeroIdSnapShoot()
  if (self.itemCfg).action_type == proto_csmsg_ItemActionType.ItemActionTypeRadioChoiceGift then
    if self.selectItem == nil then
      (cs_MessageCommon.ShowMessageTips)(ConfigData:GetTipContent(146))
      return 
    end
    local selectId = ((self.selectItem).itemCfg).id
    warehouseNetwork:CS_BACKPACK_SelectItem((self.itemCfg).id, self.itemCountUse, {selectId}, callback)
  else
    do
      warehouseNetwork:CS_BACKPACK_UseItem((self.itemCfg).id, self.itemCountUse, callback)
    end
  end
end

UICommonUseGift.OnClickCancle = function(self)
  -- function num : 0_6
  if self.closeFunc ~= nil then
    (self.closeFunc)(false)
  end
  self:Delete()
end

UICommonUseGift.OnClickAdd = function(self)
  -- function num : 0_7
  if self.itemCountUse < self.itemCountMax then
    self:__UseCountChangeUpdate(self.itemCountUse + 1, true)
  end
end

UICommonUseGift.OnClickReduce = function(self)
  -- function num : 0_8
  if self.itemCountUse > 1 then
    self:__UseCountChangeUpdate(self.itemCountUse - 1, true)
  end
end

UICommonUseGift.OnScrollbarValueChange = function(self, value)
  -- function num : 0_9 , upvalues : _ENV
  if self.scrollbarValueCallbackEnable then
    local num = (math.tointeger)(((self.ui).scrollbar).value)
    if num ~= self.itemCountUse then
      self:__UseCountChangeUpdate(num, false)
    end
  end
end

UICommonUseGift.OnSelectItemCallback = function(self, itemCfg)
  -- function num : 0_10 , upvalues : _ENV
  if (self.itemCfg).action_type == proto_csmsg_ItemActionType.ItemActionTypeRadioChoiceGift then
    for i,v in ipairs((self.itemSelectPool).listItem) do
      if v.itemCfg == itemCfg then
        self:__SelectItemStateUpdate(v)
        break
      end
    end
  end
end

UICommonUseGift.OnPressItemCallback = function(self, itemCfg, flag)
  -- function num : 0_11 , upvalues : _ENV
  ((self.ui).obj_ItemInfo):SetActive(flag)
  -- DECOMPILER ERROR at PC13: Confused about usage of register: R3 in 'UnsetPending'

  if flag then
    ((self.ui).tex_ItemName).text = (LanguageUtil.GetLocaleText)(itemCfg.name)
    -- DECOMPILER ERROR at PC20: Confused about usage of register: R3 in 'UnsetPending'

    ;
    ((self.ui).tex_ItemInfo).text = (LanguageUtil.GetLocaleText)(itemCfg.describe)
    ;
    (((self.ui).obj_ItemInfo).transform):SetAsLastSibling()
    for i,v in ipairs((self.itemSelectPool).listItem) do
      -- DECOMPILER ERROR at PC46: Confused about usage of register: R8 in 'UnsetPending'

      if v.itemCfg == itemCfg then
        (((self.ui).obj_ItemInfo).transform).localPosition = (v.transform).localPosition + (Vector3.New)(80, 0, 0)
        break
      end
    end
  end
end

UICommonUseGift.__UseCountChangeUpdate = function(self, num, updateScrollbar)
  -- function num : 0_12 , upvalues : _ENV
  if (self.itemCfg).action_type == proto_csmsg_ItemActionType.ItemActionTypeRadioChoiceGift then
    return 
  end
  self.itemCountUse = num
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).scrollbar).minValue = 1
  -- DECOMPILER ERROR at PC14: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).scrollbar).maxValue = self.itemCountMax
  ;
  ((self.ui).tex_count):SetIndex(0, tostring(self.itemCountUse), tostring(self.itemCountMax))
  ;
  ((self.ui).obj_sliderNode):SetActive(self.itemCountMax > 1)
  if updateScrollbar then
    self.scrollbarValueCallbackEnable = false
    -- DECOMPILER ERROR at PC41: Confused about usage of register: R3 in 'UnsetPending'

    ;
    ((self.ui).scrollbar).value = self.itemCountUse
    self.scrollbarValueCallbackEnable = true
  end
  if (self.itemCfg).action_type == proto_csmsg_ItemActionType.ItemActionTypeFixedItem then
    (self.itemFixed):SetNum(self.itemCountUse)
    local des = nil
    for id,count in pairs((self.itemCfg).giftOptainDic) do
      local itemCfg = (ConfigData.item)[id]
      local tempDes = tostring(count * self.itemCountUse) .. (LanguageUtil.GetLocaleText)(itemCfg.name)
      if des == nil then
        des = tempDes
      else
        des = des .. "," .. tempDes
      end
    end
    ;
    ((self.ui).tex_GiftInfo):SetIndex(0, des)
  elseif (self.itemCfg).action_type == proto_csmsg_ItemActionType.ItemActionTypeRandomReward then
    (self.itemFixed):SetNum(self.itemCountUse)
    ;
    ((self.ui).tex_GiftInfo):SetIndex(1, (LanguageUtil.GetLocaleText)((self.itemCfg).describe))
  end
  -- DECOMPILER ERROR: 6 unprocessed JMP targets
end

UICommonUseGift.__SelectItemStateUpdate = function(self, selectItem)
  -- function num : 0_13 , upvalues : _ENV
  self.selectItem = selectItem
  ;
  (((self.ui).obj_Select).transform):SetParent((self.selectItem).transform)
  -- DECOMPILER ERROR at PC13: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (((self.ui).obj_Select).transform).localPosition = Vector3.zero
  ;
  ((self.ui).obj_Select):SetActive(true)
end

UICommonUseGift.__UseGiftSuccess = function(self)
  -- function num : 0_14 , upvalues : _ENV
  local rewardCache = NetworkManager:GetRewardShowCache()
  local rewardIds = {}
  local rewardCounts = {}
  local heroIdSnapShoot = self._heroIdSnapShoot
  for id,count in pairs(rewardCache) do
    (table.insert)(rewardIds, id)
    ;
    (table.insert)(rewardCounts, count)
  end
  local window = UIManager:GetWindow(UIWindowTypeID.CommonReward)
  if window ~= nil then
    window:Hide()
    window:Show()
    window:InitRewardsItem(rewardIds, rewardCounts, heroIdSnapShoot)
  else
    UIManager:ShowWindowAsync(UIWindowTypeID.CommonReward, function(window)
    -- function num : 0_14_0 , upvalues : rewardIds, rewardCounts, heroIdSnapShoot
    if window == nil then
      return 
    end
    window:InitRewardsItem(rewardIds, rewardCounts, heroIdSnapShoot)
  end
)
  end
  if self.closeFunc ~= nil then
    (self.closeFunc)(true)
  end
  self:Delete()
end

UICommonUseGift.OnItemUpdateUseGift = function(self, itemUpdate, resourceData)
  -- function num : 0_15 , upvalues : _ENV
  if self.itemCfg == nil then
    return 
  end
  local itemData = (PlayerDataCenter.itemDic)[(self.itemCfg).id]
  if itemData ~= nil or not 0 then
    local currrentMaxCount = itemData:GetCount()
  end
  if currrentMaxCount ~= self.itemCountMax then
    self.itemCountMax = currrentMaxCount
    if self.itemCountMax < self.itemCountUse then
      self.itemCountUse = self.itemCountMax
    end
    self:__UseCountChangeUpdate(self.itemCountUse, true)
  end
end

UICommonUseGift.OnDelete = function(self)
  -- function num : 0_16 , upvalues : _ENV, base
  MsgCenter:RemoveListener(eMsgEventId.UpdateItem, self.__OnItemUpdate)
  ;
  (base.OnDelete)(self)
end

return UICommonUseGift


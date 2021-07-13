-- params : ...
-- function num : 0 , upvalues : _ENV
local UICommonItemDetailWin = class("UICommonItemDetailWin", UIBaseWindow)
local base = UIBaseWindow
local UINBaseItem = require("Game.CommonUI.Item.UINBaseItem")
local UINAthDetailItem = require("Game.Arithmetic.AthDetail.UINAthDetailItem")
local JumpInfoItem = require("Game.CommonUI.ItemDetail.UICIDJumpInfoItem")
local JumpManager = require("Game.Jump.JumpManager")
UICommonItemDetailWin.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINBaseItem, UINAthDetailItem, JumpInfoItem
  self.isARG = false
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_return, self, self.OnBtnReturnClick)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Use, self, self.OnBtnUseClick)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Left, self, self.OnClickSwitchLeft)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Right, self, self.OnClickSwitchRight)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_UseGift, self, self.OnClickUseGift)
  self.baseItem = (UINBaseItem.New)()
  ;
  (self.baseItem):Init((self.ui).uINBaseItem)
  self.athInfoNode = (UINAthDetailItem.New)()
  ;
  (self.athInfoNode):Init((self.ui).aTHDetailItem)
  self.poolInfoItem = (UIItemPool.New)(JumpInfoItem, (self.ui).obj_jumpInfoItem)
  ;
  ((self.ui).obj_jumpInfoItem):SetActive(false)
  self.__OnItemRefresh = BindCallback(self, self.OnItemRefresh)
end

UICommonItemDetailWin.InitCommonItemDetail = function(self, itemCfg, useAction)
  -- function num : 0_1 , upvalues : _ENV
  self.itemId = itemCfg.id
  if itemCfg == nil then
    error("Can\'t find itemCfg")
    return 
  end
  self.useAction = useAction
  self.showList = {
[1] = {itemCfg = itemCfg, athData = nil}
}
  self.selectIndex = 1
  self:RefreshDetail()
  AudioManager:PlayAudioById(1072)
end

UICommonItemDetailWin.OnShow = function(self)
  -- function num : 0_2 , upvalues : _ENV
  MsgCenter:AddListener(eMsgEventId.UpdateItem, self.__OnItemRefresh)
  ;
  (self.transform):SetAsLastSibling()
end

UICommonItemDetailWin.InitAthDetail = function(self, itemCfg, athData, useAction)
  -- function num : 0_3 , upvalues : _ENV
  if itemCfg == nil then
    error("Can\'t find itemCfg")
    return 
  end
  self.useAction = useAction
  self.showList = {
[1] = {itemCfg = itemCfg, athData = athData}
}
  self.selectIndex = 1
  self:RefreshDetail()
end

UICommonItemDetailWin.InitListDetail = function(self, showList, index)
  -- function num : 0_4 , upvalues : _ENV
  if showList == nil or #showList == 0 then
    error("Can\'t find itemCfg")
    return 
  end
  self.useAction = nil
  self.showList = showList
  self.selectIndex = index
  self:RefreshDetail()
end

UICommonItemDetailWin.RefreshDetail = function(self)
  -- function num : 0_5 , upvalues : _ENV
  self.selectIndex = self.selectIndex or 1
  local selectData = (self.showList)[self.selectIndex]
  local itemCfg = selectData.itemCfg
  local athData = selectData.athData
  if itemCfg == nil then
    error("Can\'t find itemCfg")
    return 
  end
  self:RefreshSwitchState()
  self:__InitCIDData(itemCfg)
  self:__InitCIDUI(itemCfg, athData)
  ;
  (((self.ui).btn_UseGift).gameObject):SetActive(false)
  if athData == nil then
    ((self.ui).obj_normalDetail):SetActive(true)
    ;
    (self.athInfoNode):Hide()
    self.isARG = (PlayerDataCenter.allEffectorData):IsAutoGenerateResource(itemCfg.id)
    self:RefreshARGInfo(self.isARG)
    self:UpdateJumpList(itemCfg)
    if ConfigData:IsManualOpenGiftItem(itemCfg) then
      local itemData = (PlayerDataCenter.itemDic)[itemCfg.id]
      ;
      (((self.ui).btn_UseGift).gameObject):SetActive(itemData ~= nil and itemData:GetCount() > 0)
    end
  else
    ((self.ui).obj_normalDetail):SetActive(false)
    ;
    (self.athInfoNode):InitAthDetailItem(nil, athData, nil, false, false, false)
    ;
    (self.athInfoNode):Show()
    self:RefreshARGInfo(false)
  end
  -- DECOMPILER ERROR: 3 unprocessed JMP targets
end

UICommonItemDetailWin.__InitCIDData = function(self, itemCfg)
  -- function num : 0_6 , upvalues : _ENV
  self.isHeroItem = false
  if itemCfg.action_type == eItemActionType.HeroCardFrag then
    self.isHeroItem = true
  end
  self.isHaveThisHero = false
  if self.isHeroItem and (PlayerDataCenter.heroDic)[(itemCfg.arg)[1]] ~= nil then
    self.isHaveThisHero = true
  end
  self.showUseBtn = false
  if (itemCfg.can_use ~= false and itemCfg.can_use ~= nil) or self.useAction ~= nil then
    self.showUseBtn = true
  end
  self.canUse = itemCfg.can_use
end

UICommonItemDetailWin.__InitCIDUI = function(self, itemCfg, athData)
  -- function num : 0_7 , upvalues : _ENV
  (self.baseItem):InitBaseItem(itemCfg, nil)
  if athData ~= nil then
    self:_ShowCount((PlayerDataCenter.allAthData):GetAthNumById(athData.id))
  else
    self:_ShowCountByItem(itemCfg)
  end
  -- DECOMPILER ERROR at PC26: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).tex_Name).text = tostring((LanguageUtil.GetLocaleText)(itemCfg.name))
  -- DECOMPILER ERROR at PC35: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).tex_Descr).text = tostring((LanguageUtil.GetLocaleText)(itemCfg.describe))
  -- DECOMPILER ERROR at PC46: Confused about usage of register: R3 in 'UnsetPending'

  if not self.isHeroItem then
    ((self.ui).img_ItemQuality).color = ItemQualityColor[(self.baseItem):GetQuality()]
  end
  ;
  ((self.ui).obj_HeroQuailty):SetActive(self.isHeroItem)
  ;
  (((self.ui).img_ItemQuality).gameObject):SetActive(not self.isHeroItem)
  ;
  (((self.ui).btn_Use).gameObject):SetActive(self.showUseBtn)
end

UICommonItemDetailWin.RefreshARGInfo = function(self, bool)
  -- function num : 0_8 , upvalues : _ENV
  ((self.ui).obj_aRGInfo_Speed):SetActive(bool)
  ;
  ((self.ui).obj_aRGInfo_Time2Limit):SetActive(bool)
  if bool then
    local Refresh = function()
    -- function num : 0_8_0 , upvalues : _ENV, self
    local num, nextTime = (PlayerDataCenter.allEffectorData):GetCurrentARGNum(self.itemId)
    local speed = (PlayerDataCenter.allEffectorData):GetCurrentARGSpeed(self.itemId)
    local ceiling = (PlayerDataCenter.allEffectorData):GetCurrentARGCeiling(self.itemId)
    self:_ShowCount(num)
    if nextTime > 0 then
      ((self.ui).tex_speed):SetIndex(1, GetPreciseDecimalStr(speed * 3600, 1), TimestampToTime(nextTime))
    else
      ;
      ((self.ui).tex_speed):SetIndex(0, GetPreciseDecimalStr(speed * 3600, 1))
    end
    ;
    ((self.ui).text_time2Limittitle):SetIndex(0, tostring(num), tostring(ceiling))
    if num < ceiling then
      local timeStr = TimestampToTime((ceiling - num - 1) / speed + nextTime)
      ;
      ((self.ui).tex_time2Limit):SetIndex(0, timeStr)
    else
      do
        ;
        ((self.ui).tex_time2Limit):SetIndex(1)
      end
    end
  end

    Refresh()
    if self.ARGTimer ~= nil then
      (self.ARGTimer):Stop()
      self.ARGTimer = nil
    end
    self.ARGTimer = (TimerManager:GetTimer(1, Refresh)):Start()
  end
end

UICommonItemDetailWin.SetNotNeedAnyJump = function(self, bool)
  -- function num : 0_9
  self.notNeedAnyJump = bool
end

UICommonItemDetailWin.UpdateJumpList = function(self, itemCfg)
  -- function num : 0_10 , upvalues : JumpManager, _ENV
  (self.poolInfoItem):HideAll()
  local isHaveAchieveDes = itemCfg.achieve_des ~= ""
  local isHaveNormalJumpList = (itemCfg.jumpList ~= nil and #itemCfg.jumpList ~= 0 and JumpManager.couldUseItemJump)
  self.factoryController = ControllerManager:GetController(ControllerTypeId.Factory, false)
  local isHaveQuickFactory, targetOrderData = (self.factoryController):IsCouldOpenQuickProduceUI(self.itemId)
  if self.isHeroItem and self.isHaveThisHero then
    local isCouldBuyFrag = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_Store)
  end
  self.isCoulduseGift = false
  self.useGiftList = nil
  self.jumpuseGiftItem = nil
  local packetList = ((ConfigData.item).packetMappingDic)[itemCfg.id]
  if packetList ~= nil and #packetList > 0 then
    self.useGiftList = packetList
    for _,expPacketid in ipairs(packetList) do
      if PlayerDataCenter:GetItemCount(expPacketid) > 0 then
        self.isCoulduseGift = true
        break
      end
    end
  end
  if not isHaveNormalJumpList and not isHaveQuickFactory and not isCouldBuyFrag then
    local isHaveJumpList = self.isCoulduseGift
  end
  if isHaveJumpList and not self.notNeedAnyJump then
    ((self.ui).obj_jumpList):SetActive(true)
    ;
    (((self.ui).tex_achieveText).gameObject):SetActive(false)
  elseif isHaveAchieveDes then
    ((self.ui).obj_jumpList):SetActive(false)
    ;
    (((self.ui).tex_achieveText).gameObject):SetActive(true)
    -- DECOMPILER ERROR at PC114: Confused about usage of register: R9 in 'UnsetPending'

    ;
    ((self.ui).tex_achieveText).text = tostring((LanguageUtil.GetLocaleText)(itemCfg.achieve_des))
    return 
  else
    ((self.ui).obj_jumpList):SetActive(false)
    ;
    (((self.ui).tex_achieveText).gameObject):SetActive(false)
    return 
  end
  do
    if isHaveQuickFactory then
      local item = (self.poolInfoItem):GetOne()
      item:InitQuickProduce(targetOrderData, self.factoryController)
    end
    if isCouldBuyFrag then
      local frageId = itemCfg.id
      local shopCfg = ((ConfigData.shop_hero).fragId2ShopInfo)[frageId]
      if shopCfg then
        local item = (self.poolInfoItem):GetOne()
        item:InitQuickBuy(shopCfg.shopId, shopCfg.shelfId, shopCfg.resourceIds)
      end
    end
    if isHaveNormalJumpList then
      local jumpDic = {}
      for index,cfg in ipairs(itemCfg.jumpList) do
        if jumpDic[cfg.jump_id] == nil then
          jumpDic[cfg.jump_id] = {}
        end
        ;
        (table.insert)(jumpDic[cfg.jump_id], cfg.jumpArgs)
      end
      for jumpId,args in pairs(jumpDic) do
        local item = (self.poolInfoItem):GetOne()
        item:InitCIDJumpInfoItem(jumpId, args)
      end
    end
    if self.isCoulduseGift then
      self.jumpuseGiftItem = (self.poolInfoItem):GetOne()
      ;
      (self.jumpuseGiftItem):InitUseGift(self.itemId, self.useGiftList)
    end
    -- DECOMPILER ERROR: 17 unprocessed JMP targets
  end
end

UICommonItemDetailWin.OnBtnReturnClick = function(self)
  -- function num : 0_11
  self:Hide()
end

UICommonItemDetailWin.OnBtnUseClick = function(self)
  -- function num : 0_12
  if self.useAction ~= nil then
    (self.useAction)()
    return 
  end
  if self.canUse then
  end
end

UICommonItemDetailWin.OnClickSwitchLeft = function(self)
  -- function num : 0_13
  if self.selectIndex > 1 then
    self.selectIndex = self.selectIndex - 1
    self:RefreshDetail()
  end
end

UICommonItemDetailWin.OnClickSwitchRight = function(self)
  -- function num : 0_14
  if self.selectIndex < #self.showList then
    self.selectIndex = self.selectIndex + 1
    self:RefreshDetail()
  end
end

UICommonItemDetailWin.RefreshSwitchState = function(self)
  -- function num : 0_15
  ;
  (((self.ui).btn_Left).gameObject):SetActive(self.selectIndex ~= nil and self.selectIndex > 1)
  ;
  (((self.ui).btn_Right).gameObject):SetActive(self.selectIndex ~= nil and self.selectIndex < #self.showList)
  -- DECOMPILER ERROR: 3 unprocessed JMP targets
end

UICommonItemDetailWin.ParentWindowType = function(self, type)
  -- function num : 0_16
  self.parentWindowType = type
end

UICommonItemDetailWin.OnItemRefresh = function(self, itemUpdate)
  -- function num : 0_17 , upvalues : _ENV
  if itemUpdate[self.itemId] ~= nil then
    self:_ShowCountByItem((ConfigData.item)[self.itemId])
  end
  if self.useGiftList ~= nil then
    for _,itemId in ipairs(self.useGiftList) do
      if itemUpdate[itemId] ~= nil then
        self:_ShowUseGiftJump()
        break
      end
    end
  end
end

UICommonItemDetailWin._ShowUseGiftJump = function(self)
  -- function num : 0_18 , upvalues : _ENV
  self.isCoulduseGift = false
  for _,itemId in ipairs(self.useGiftList) do
    if PlayerDataCenter:GetItemCount(itemId) > 0 then
      self.isCoulduseGift = true
      break
    end
  end
  do
    -- DECOMPILER ERROR at PC24: Unhandled construct in 'MakeBoolean' P1

    if self.isCoulduseGift and self.jumpuseGiftItem == nil then
      self.jumpuseGiftItem = (self.poolInfoItem):GetOne()
      ;
      (self.jumpuseGiftItem):InitUseGift(self.itemId, self.useGiftList)
    end
    if self.jumpuseGiftItem ~= nil then
      (self.poolInfoItem):HideOne(self.jumpuseGiftItem)
    end
    self.jumpuseGiftItem = nil
  end
end

UICommonItemDetailWin._ShowCountByItem = function(self, itemCfg)
  -- function num : 0_19 , upvalues : _ENV
  if itemCfg == nil or itemCfg.type == eItemType.HeroCard then
    ((self.ui).obj_stock):SetActive(false)
    return 
  end
  local count = 0
  if itemCfg.id == ConstGlobalItem.SKey then
    count = (PlayerDataCenter.stamina):GetCurrentStamina()
  else
    count = PlayerDataCenter:GetItemCount(itemCfg.id)
  end
  self:_ShowCount(count)
end

UICommonItemDetailWin._ShowCount = function(self, count)
  -- function num : 0_20 , upvalues : _ENV
  if count <= 0 then
    ((self.ui).obj_stock):SetActive(false)
  else
    -- DECOMPILER ERROR at PC13: Confused about usage of register: R2 in 'UnsetPending'

    ;
    ((self.ui).tex_Count).text = tostring(count)
    ;
    ((self.ui).obj_stock):SetActive(true)
  end
end

UICommonItemDetailWin.OnClickUseGift = function(self)
  -- function num : 0_21 , upvalues : _ENV
  self:Hide()
  local itemCfg = (ConfigData.item)[self.itemId]
  local count = PlayerDataCenter:GetItemCount(itemCfg.id)
  if itemCfg.action_type == proto_csmsg_ItemActionType.ItemActionTypeFixedItem and count == 1 then
    local heroIdSnapShoot = PlayerDataCenter:TakeHeroIdSnapShoot()
    do
      local warehouseNetwork = NetworkManager:GetNetwork(NetworkTypeID.Warehouse)
      warehouseNetwork:CS_BACKPACK_UseItem(itemCfg.id, count, function()
    -- function num : 0_21_0 , upvalues : _ENV, itemCfg, heroIdSnapShoot
    local rewardIds = {}
    local rewardCounts = {}
    for id,num in pairs(itemCfg.giftOptainDic) do
      (table.insert)(rewardIds, id)
      ;
      (table.insert)(rewardCounts, num)
    end
    UIManager:ShowWindowAsync(UIWindowTypeID.CommonReward, function(window)
      -- function num : 0_21_0_0 , upvalues : rewardIds, rewardCounts, heroIdSnapShoot
      if window == nil then
        return 
      end
      window:InitRewardsItem(rewardIds, rewardCounts, heroIdSnapShoot)
    end
)
  end
)
    end
  else
    do
      UIManager:ShowWindowAsync(UIWindowTypeID.CommonUseGift, function(win)
    -- function num : 0_21_1 , upvalues : itemCfg
    if win == nil then
      return 
    end
    win:InitCommonUseGift(itemCfg)
  end
)
    end
  end
end

UICommonItemDetailWin.OnHide = function(self)
  -- function num : 0_22 , upvalues : _ENV
  (self.poolInfoItem):DeleteAll()
  self.notNeedAnyJump = false
  MsgCenter:RemoveListener(eMsgEventId.UpdateItem, self.__OnItemRefresh)
  if self.ARGTimer ~= nil then
    (self.ARGTimer):Stop()
    self.ARGTimer = nil
  end
end

return UICommonItemDetailWin


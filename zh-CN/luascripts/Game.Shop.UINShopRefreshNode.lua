-- params : ...
-- function num : 0 , upvalues : _ENV
local UINShopRefreshNode = class("UINShopRefreshNode", UIBaseNode)
local base = UIBaseNode
UINShopRefreshNode.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self.ctrl = ControllerManager:GetController(ControllerTypeId.Shop, false)
  ;
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Refresh, self, self.OnRefreshBtnClick)
  self._RefreshCallback = BindCallback(self, self.RefreshCallback)
end

UINShopRefreshNode.SetCallback = function(self, OpenShopePageCallback)
  -- function num : 0_1
  self.OpenShopePageCallback = OpenShopePageCallback
end

UINShopRefreshNode.InitRefreshNode = function(self, shopData)
  -- function num : 0_2 , upvalues : _ENV
  self.shopData = shopData
  ;
  (((self.ui).btn_Refresh).gameObject):SetActive(true)
  ;
  (((self.ui).tex_CashNum).gameObject):SetActive(shopData.couldFresh)
  ;
  (((self.ui).img_CashIcon).gameObject):SetActive(shopData.couldFresh)
  ;
  ((self.ui).tex_limit):SetActive(not shopData.couldFresh)
  if shopData.couldFresh then
    self.cost = shopData.refreshCost
    self.costItemCfg = (ConfigData.item)[(self.cost).costId]
    local costNum = (self.cost).costNum
    -- DECOMPILER ERROR at PC40: Confused about usage of register: R3 in 'UnsetPending'

    ;
    ((self.ui).tex_CashNum).text = costNum
    local smallIcon = (self.costItemCfg).small_icon
    -- DECOMPILER ERROR at PC49: Confused about usage of register: R4 in 'UnsetPending'

    ;
    ((self.ui).img_CashIcon).sprite = CRH:GetSprite(smallIcon)
    ;
    ((self.ui).text_Count):SetIndex(0, tostring(shopData.freshCount), tostring(shopData.couldFreshCount))
  else
    do
      ;
      ((self.ui).text_Count):SetIndex(0, tostring(shopData.couldFreshCount), tostring(shopData.couldFreshCount))
      if self.__updateSecondTimer ~= nil then
        (self.__updateSecondTimer):Stop()
        self.__updateSecondTimer = nil
      end
      self.__updateSecondTimer = TimerManager:GetTimer(1, self.UpdateTime, self, false, false, true)
      ;
      (self.__updateSecondTimer):Start()
      self:UpdateTime()
    end
  end
end

UINShopRefreshNode.UpdateTime = function(self)
  -- function num : 0_3 , upvalues : _ENV
  local time = (self.shopData):GetRemainAutoRefreshTime()
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.ui).tex_Timer).text = TimestampToTime(time)
  if time < -1 then
    (self.ctrl):ReqShopDetail((self.shopData).shopId, self._RefreshCallback)
    if self.__updateSecondTimer ~= nil then
      (self.__updateSecondTimer):Stop()
      self.__updateSecondTimer = nil
    end
  end
end

UINShopRefreshNode.OnRefreshBtnClick = function(self)
  -- function num : 0_4 , upvalues : _ENV
  if not (self.shopData).couldFresh then
    ((CS.MessageCommon).ShowMessageTips)(ConfigData:GetTipContent(TipContent.Shop_CanNotRefresh_RefreshCountInsufficient))
    return 
  end
  if (self.cost).costNum <= PlayerDataCenter:GetItemCount((self.cost).costId) then
    if self.__updateSecondTimer ~= nil then
      (self.__updateSecondTimer):Stop()
      self.__updateSecondTimer = nil
    end
    ;
    (self.ctrl):ReqRefreshShopDetail((self.shopData).shopId, self._RefreshCallback)
  else
    ;
    ((CS.MessageCommon).ShowMessageTips)((string.format)(ConfigData:GetTipContent(TipContent.Shop_CanNotRefresh_LackOfItem), (LanguageUtil.GetLocaleText)((self.costItemCfg).name)))
  end
end

UINShopRefreshNode.RefreshCallback = function(self)
  -- function num : 0_5
  if self.OpenShopePageCallback ~= nil then
    (self.OpenShopePageCallback)((self.shopData).shopId)
  end
end

UINShopRefreshNode.OnHide = function(self)
  -- function num : 0_6 , upvalues : base
  if self.__updateSecondTimer ~= nil then
    (self.__updateSecondTimer):Stop()
    self.__updateSecondTimer = nil
  end
  ;
  (base.OnHide)(self)
end

UINShopRefreshNode.OnDelete = function(self)
  -- function num : 0_7 , upvalues : base
  (base.OnDelete)(self)
end

return UINShopRefreshNode

-- params : ...
-- function num : 0 , upvalues : _ENV
local UINShopRefreshNode = class("UINShopRefreshNode", UIBaseNode)
local base = UIBaseNode
UINShopRefreshNode.OnInit = function(self)
    -- function num : 0_0 , upvalues : _ENV
    self.ctrl = ControllerManager:GetController(ControllerTypeId.Shop, false);
    (UIUtil.LuaUIBindingTable)(self.transform, self.ui);
    (UIUtil.AddButtonListener)((self.ui).btn_Refresh, self,
                               self.OnRefreshBtnClick)
    self._RefreshCallback = BindCallback(self, self.RefreshCallback)
end

UINShopRefreshNode.SetCallback = function(self, OpenShopePageCallback)
    -- function num : 0_1
    self.OpenShopePageCallback = OpenShopePageCallback
end

UINShopRefreshNode.InitRefreshNode = function(self, shopData)
    -- function num : 0_2 , upvalues : _ENV
    self.shopData = shopData;
    (((self.ui).btn_Refresh).gameObject):SetActive(true);
    (((self.ui).tex_CashNum).gameObject):SetActive(shopData.couldFresh);
    (((self.ui).img_CashIcon).gameObject):SetActive(shopData.couldFresh);
    ((self.ui).tex_limit):SetActive(not shopData.couldFresh)
    if shopData.couldFresh then
        self.cost = shopData.refreshCost
        self.costItemCfg = (ConfigData.item)[(self.cost).costId]
        local costNum = (self.cost).costNum -- DECOMPILER ERROR at PC40: Confused about usage of register: R3 in 'UnsetPending'
        ;
        ((self.ui).tex_CashNum).text = costNum
        local smallIcon = (self.costItemCfg).small_icon -- DECOMPILER ERROR at PC49: Confused about usage of register: R4 in 'UnsetPending'
        ;
        ((self.ui).img_CashIcon).sprite = CRH:GetSprite(smallIcon);
        ((self.ui).text_Count):SetIndex(0, tostring(shopData.freshCount),
                                        tostring(shopData.couldFreshCount))
    else
        do

            ((self.ui).text_Count):SetIndex(0,
                                            tostring(shopData.couldFreshCount),
                                            tostring(shopData.couldFreshCount))
            if self.__updateSecondTimer ~= nil then
                (self.__updateSecondTimer):Stop()
                self.__updateSecondTimer = nil
            end
            self.__updateSecondTimer = TimerManager:GetTimer(1, self.UpdateTime,
                                                             self, false, false,
                                                             true);
            (self.__updateSecondTimer):Start()
            self:UpdateTime()
        end
    end
end

UINShopRefreshNode.UpdateTime = function(self)
    -- function num : 0_3 , upvalues : _ENV
    local time = (self.shopData):GetRemainAutoRefreshTime() -- DECOMPILER ERROR at PC8: Confused about usage of register: R2 in 'UnsetPending'
    ;
    ((self.ui).tex_Timer).text = TimestampToTime(time)
    if time < -1 then
        (self.ctrl):ReqShopDetail((self.shopData).shopId, self._RefreshCallback)
        if self.__updateSecondTimer ~= nil then
            (self.__updateSecondTimer):Stop()
            self.__updateSecondTimer = nil
        end
    end
end

UINShopRefreshNode.OnRefreshBtnClick = function(self)
    -- function num : 0_4 , upvalues : _ENV
    if not (self.shopData).couldFresh then
        ((CS.MessageCommon).ShowMessageTips)(
            ConfigData:GetTipContent(
                TipContent.Shop_CanNotRefresh_RefreshCountInsufficient))
        return
    end
    if (self.cost).costNum <= PlayerDataCenter:GetItemCount((self.cost).costId) then
        if self.__updateSecondTimer ~= nil then
            (self.__updateSecondTimer):Stop()
            self.__updateSecondTimer = nil
        end
        (self.ctrl):ReqRefreshShopDetail((self.shopData).shopId,
                                         self._RefreshCallback)
    else

        ((CS.MessageCommon).ShowMessageTips)(
            (string.format)(ConfigData:GetTipContent(
                                TipContent.Shop_CanNotRefresh_LackOfItem),
                            (LanguageUtil.GetLocaleText)((self.costItemCfg).name)))
    end
end

UINShopRefreshNode.RefreshCallback = function(self)
    -- function num : 0_5
    if self.OpenShopePageCallback ~= nil then
        (self.OpenShopePageCallback)((self.shopData).shopId)
    end
end

UINShopRefreshNode.OnHide = function(self)
    -- function num : 0_6 , upvalues : base
    if self.__updateSecondTimer ~= nil then
        (self.__updateSecondTimer):Stop()
        self.__updateSecondTimer = nil
    end
    (base.OnHide)(self)
end

UINShopRefreshNode.OnDelete = function(self)
    -- function num : 0_7 , upvalues : base
    (base.OnDelete)(self)
end

return UINShopRefreshNode


local UINShopRefreshNode = class("UINShopRefreshNode", UIBaseNode)
local base = UIBaseNode
local cs_MessageCommon = CS.MessageCommon
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
      TimerManager:StopTimer(self.__updateSecondTimerId)
      self.__updateSecondTimerId = TimerManager:StartTimer(1, self.UpdateTime, self, false, false, true)
      self:UpdateTime()
    end
  end
end

UINShopRefreshNode.UpdateTime = function(self)
  -- function num : 0_3 , upvalues : _ENV
  local time = (self.shopData):GetRemainAutoRefreshTime()
  local d, h, m, s = TimestampToTimeInter(time, false, true)
  if h < 10 or not tostring(h) then
    local hStr = "0" .. tostring(h)
  end
  if m < 10 or not tostring(m) then
    local mStr = "0" .. tostring(m)
  end
  if s < 10 or not tostring(s) then
    local sStr = "0" .. tostring(s)
  end
  if d > 0 then
    ((self.ui).tex_Timer):SetIndex(0, tostring(d), hStr, mStr, sStr)
  else
    ;
    ((self.ui).tex_Timer):SetIndex(1, hStr, mStr, sStr)
  end
  if time < -1 then
    (self.ctrl):ReqShopDetail((self.shopData).shopId, self._RefreshCallback)
    TimerManager:StopTimer(self.__updateSecondTimerId)
  end
end

UINShopRefreshNode.OnRefreshBtnClick = function(self)
  -- function num : 0_4 , upvalues : _ENV, cs_MessageCommon
  if not (self.shopData).couldFresh then
    ((CS.MessageCommon).ShowMessageTipsWithErrorSound)(ConfigData:GetTipContent(TipContent.Shop_CanNotRefresh_RefreshCountInsufficient))
    return 
  end
  local buyFunc = function()
    -- function num : 0_4_0 , upvalues : _ENV, self
    TimerManager:StopTimer(self.__updateSecondTimerId)
    ;
    (self.ctrl):ReqRefreshShopDetail((self.shopData).shopId, self._RefreshCallback)
  end

  local ownNum = PlayerDataCenter:GetItemCount((self.cost).costId)
  if (self.cost).costNum <= ownNum then
    buyFunc()
  else
    local payCtrl = ControllerManager:GetController(ControllerTypeId.Pay, true)
    if not payCtrl:TryConvertPayItem((self.cost).costId, (self.cost).costNum - ownNum, nil, nil, buyFunc) then
      (cs_MessageCommon.ShowMessageTipsWithErrorSound)((string.format)(ConfigData:GetTipContent(TipContent.Shop_CanNotRefresh_LackOfItem), (LanguageUtil.GetLocaleText)((self.costItemCfg).name)))
    end
  end
end

UINShopRefreshNode.RefreshCallback = function(self)
  -- function num : 0_5
  if self.OpenShopePageCallback ~= nil then
    (self.OpenShopePageCallback)((self.shopData).shopId)
  end
end

UINShopRefreshNode.OnHide = function(self)
  -- function num : 0_6 , upvalues : _ENV, base
  TimerManager:StopTimer(self.__updateSecondTimerId)
  ;
  (base.OnHide)(self)
end

UINShopRefreshNode.OnDelete = function(self)
  -- function num : 0_7 , upvalues : base
  (base.OnDelete)(self)
end

return UINShopRefreshNode


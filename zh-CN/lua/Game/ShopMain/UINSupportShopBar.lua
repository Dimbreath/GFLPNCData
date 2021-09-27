local UINSupportShopBar = class("UINSupportShopBar", UIBaseNode)
local base = UIBaseNode
local ShopEnum = require("Game.Shop.ShopEnum")
UINSupportShopBar.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, ShopEnum
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Refresh, self, self.OnClickClollectSupportPoint)
  self.shopNetCtrl = NetworkManager:GetNetwork(NetworkTypeID.Shop)
  ;
  ((self.ui).redDot):SetActive(false)
  self.__onReddotChangeDotEvent = function(node)
    -- function num : 0_0_0 , upvalues : ShopEnum, self
    if node:GetRedDotCount() <= 0 then
      ((self.ui).redDot):SetActive((ShopEnum.ShopId).supportShop ~= node:GetParentNodeId())
      -- DECOMPILER ERROR: 2 unprocessed JMP targets
    end
  end

  RedDotController:AddListener(RedDotDynPath.ShopFriendSupportBtnPath, self.__onReddotChangeDotEvent)
end

UINSupportShopBar.OnShow = function(self)
  -- function num : 0_1 , upvalues : _ENV, ShopEnum
  self:RefreshSupportValueNum()
  if self.timerId ~= nil then
    TimerManager:StopTimer(self.timerId)
    self.timerId = nil
  end
  self.timerId = TimerManager:StartTimer(1, self.RefreshSupportValueNum, self, false, nil, nil, nil)
  local ok, node = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.ShopWindow, (ShopEnum.ShopId).supportShop, RedDotStaticTypeId.ShopFriendSupportBtn)
  ;
  ((self.ui).redDot):SetActive(not ok or node:GetRedDotCount() > 0)
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

UINSupportShopBar.RefreshSupportValueNum = function(self)
  -- function num : 0_2 , upvalues : _ENV
  local curPoint = (PlayerDataCenter.inforData):GetCurSupportPoint()
  local maxPoint = (ConfigData.game_config).supportPointMaxNum
  local counterElem = (ControllerManager:GetController(ControllerTypeId.TimePass)):getCounterElemData(proto_object_CounterModule.CounterMoudleSupportPointPick, 0)
  if counterElem ~= nil and PlayerDataCenter.timestamp < counterElem.nextExpiredTm then
    (((self.ui).btn_Refresh).gameObject):SetActive(false)
    ;
    ((self.ui).obj_img_Timer):SetActive(true)
    -- DECOMPILER ERROR at PC43: Confused about usage of register: R4 in 'UnsetPending'

    ;
    ((self.ui).tex_Timer).text = TimestampToTime(counterElem.nextExpiredTm - PlayerDataCenter.timestamp)
    return 
  end
  ;
  (((self.ui).btn_Refresh).gameObject):SetActive(true)
  ;
  ((self.ui).obj_img_Timer):SetActive(false)
  -- DECOMPILER ERROR at PC60: Confused about usage of register: R4 in 'UnsetPending'

  if curPoint == 0 then
    ((self.ui).btn_Refresh).interactable = false
  else
    -- DECOMPILER ERROR at PC64: Confused about usage of register: R4 in 'UnsetPending'

    ;
    ((self.ui).btn_Refresh).interactable = true
  end
  local isReachMax = maxPoint <= curPoint
  ;
  (((self.ui).tex_CoinCount).gameObject):SetActive(not isReachMax)
  ;
  (((self.ui).tex_limit).gameObject):SetActive(isReachMax)
  -- DECOMPILER ERROR at PC93: Confused about usage of register: R5 in 'UnsetPending'

  if not isReachMax then
    ((self.ui).tex_CoinCount).text = tostring(curPoint) .. "/" .. tostring(maxPoint)
  end
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

UINSupportShopBar.OnClickClollectSupportPoint = function(self)
  -- function num : 0_3 , upvalues : _ENV, ShopEnum
  local curPoint = (PlayerDataCenter.inforData):GetCurSupportPoint()
  if curPoint <= 0 then
    return 
  end
  local counterElem = (ControllerManager:GetController(ControllerTypeId.TimePass)):getCounterElemData(proto_object_CounterModule.CounterMoudleSupportPointPick, 0)
  if counterElem ~= nil and PlayerDataCenter.timestamp <= counterElem.nextExpiredTm then
    return 
  end
  ;
  (self.shopNetCtrl):CS_ASSISTANT_PickAstPoint(function(dataList)
    -- function num : 0_3_0 , upvalues : _ENV, self, ShopEnum
    if dataList.Count == 0 then
      return 
    end
    local gettedPointNum = dataList[0]
    local pointItemId = (ConfigData.game_config).supportPointItemId
    UIManager:ShowWindowAsync(UIWindowTypeID.CommonReward, function(window)
      -- function num : 0_3_0_0 , upvalues : pointItemId, gettedPointNum
      if window == nil then
        return 
      end
      window:AddNext2ShowReward({pointItemId}, {gettedPointNum})
    end
)
    self:RefreshSupportValueNum()
    local maxPoint = (ConfigData.game_config).supportPointMaxNum
    local curPoint = (PlayerDataCenter.inforData):GetCurSupportPoint()
    local ok, node = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.ShopWindow, (ShopEnum.ShopId).supportShop, RedDotStaticTypeId.ShopFriendSupportBtn)
    if maxPoint <= curPoint then
      node:SetRedDotCount(1)
    else
      node:SetRedDotCount(0)
    end
  end
)
end

UINSupportShopBar.OnHide = function(self)
  -- function num : 0_4 , upvalues : _ENV
  if self.timerId ~= nil then
    TimerManager:StopTimer(self.timerId)
    self.timerId = nil
  end
end

UINSupportShopBar.OnDelete = function(self)
  -- function num : 0_5 , upvalues : _ENV, base
  RedDotController:RemoveListener(RedDotDynPath.ShopFriendSupportBtnPath, self.__onReddotChangeDotEvent)
  ;
  (base.OnDelete)(self)
end

return UINSupportShopBar


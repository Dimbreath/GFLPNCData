local UINQuickPrchaseKayMoneyNode = class("UINQuickPrchaseKayMoneyNode", UIBaseNode)
local base = UIBaseNode
local UINBaseItemWithCount = require("Game.CommonUI.Item.UINBaseItemWithCount")
UINQuickPrchaseKayMoneyNode.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINBaseItemWithCount
  self.ctrl = ControllerManager:GetController(ControllerTypeId.Shop, false)
  ;
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  self.item = (UINBaseItemWithCount.New)()
  ;
  (self.item):Init((self.ui).uINBaseItemWithCount)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Confirm, self, self._OnClickConfirem)
end

UINQuickPrchaseKayMoneyNode.SetNodeData = function(self, parent, goodData)
  -- function num : 0_1
  self.parent = parent
  self.goodData = goodData
end

UINQuickPrchaseKayMoneyNode.InitQPKNode = function(self, maxNeededKeyNum, closeCallback)
  -- function num : 0_2
  self.maxNeededKeyNum = maxNeededKeyNum
  self.closeCallback = closeCallback
  self:RefreshShopGoodInfo()
end

UINQuickPrchaseKayMoneyNode.RefreshShopGoodInfo = function(self)
  -- function num : 0_3 , upvalues : _ENV
  if (self.goodData).isSoldOut then
    (((self.ui).btn_Confirm).gameObject):SetActive(false)
    ;
    ((self.ui).btn_CantBuy):SetActive(true)
    ;
    (((self.ui).tex_CouldAddNumber).gameObject):SetActive(false)
  else
    ;
    (((self.ui).btn_Confirm).gameObject):SetActive(true)
    ;
    ((self.ui).btn_CantBuy):SetActive(false)
    ;
    (((self.ui).tex_CouldAddNumber).gameObject):SetActive(true)
  end
  if (self.goodData).isLimit then
    ((self.ui).obj_limit):SetActive(true)
    ;
    ((self.ui).tex_LimitCount):SetIndex(0, tostring((self.goodData).totallimitTime - (self.goodData).purchases), tostring((self.goodData).totallimitTime))
  else
    ;
    ((self.ui).obj_limit):SetActive(false)
  end
  -- DECOMPILER ERROR at PC76: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).tex_Price).text = tostring((self.goodData).newCurrencyNum)
  ;
  ((self.ui).tex_CouldAddNumber):SetIndex(0, tostring((self.goodData).newCurrencyNum), tostring((self.goodData).itemNum))
  -- DECOMPILER ERROR at PC98: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).tex_ItemDec).text = (LanguageUtil.GetLocaleText)(((self.goodData).itemCfg).describe)
  ;
  (self.item):InitItemWithCount((self.goodData).itemCfg, (self.goodData).itemNum)
end

UINQuickPrchaseKayMoneyNode._OnClickConfirem = function(self)
  -- function num : 0_4 , upvalues : _ENV
  if (self.parent).isSlideOuting then
    return 
  end
  local tatalBuyNum = 1 * (self.goodData).itemNum
  local buyFunc = function()
    -- function num : 0_4_0 , upvalues : self, _ENV, tatalBuyNum
    (self.ctrl):ReqBuyGoods((self.goodData).shopId, (self.goodData).shelfId, 1, function()
      -- function num : 0_4_0_0 , upvalues : _ENV, self, tatalBuyNum
      UIManager:ShowWindowAsync(UIWindowTypeID.CommonReward, function(window)
        -- function num : 0_4_0_0_0 , upvalues : self, tatalBuyNum, _ENV
        if window == nil then
          return 
        end
        window:InitRewardsItem({(self.goodData).itemId}, {tatalBuyNum})
        local needClose = true
        if self.maxNeededKeyNum ~= nil and (PlayerDataCenter.stamina):GetCurrentStamina() < self.maxNeededKeyNum then
          self:RefreshShopGoodInfo()
          needClose = false
        end
        if needClose and self.closeCallback ~= nil then
          (self.closeCallback)()
        end
      end
)
    end
)
  end

  if (self.goodData).currencyId == ConstGlobalItem.PaidSubItem then
    local totalNeedMoney = 1 * (self.goodData).newCurrencyNum
    local ownMoney = PlayerDataCenter:GetItemCount((self.goodData).currencyId)
    if ownMoney < totalNeedMoney then
      local shopWin = UIManager:GetWindow(UIWindowTypeID.ShopMain)
      local beforeJumpCallback = function(callBack)
    -- function num : 0_4_1 , upvalues : self
    (self.parent):SlideOut(nil, true)
    if callBack ~= nil then
      callBack()
    end
  end

      local directShowShop = shopWin == nil
      local payCtrl = ControllerManager:GetController(ControllerTypeId.Pay, true)
      payCtrl:TryConvertPayItem((self.goodData).currencyId, totalNeedMoney - ownMoney, beforeJumpCallback, nil, buyFunc, directShowShop)
      return 
    end
  end
  buyFunc()
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

UINQuickPrchaseKayMoneyNode.OnDelete = function(self)
  -- function num : 0_5 , upvalues : base
  (base.OnDelete)(self)
end

return UINQuickPrchaseKayMoneyNode


-- params : ...
-- function num : 0 , upvalues : _ENV
local UINShopNormalRechargeItem = class("UINShopNormalRechargeItem", UIBaseNode)
local base = UIBaseNode
UINShopNormalRechargeItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_quartzItem, self, self.OnClickBuyRecharge)
  self._RefreshGoodsRecharge = BindCallback(self, self.RefreshRechargeSuccess)
  MsgCenter:AddListener(eMsgEventId.ShopRechargeComplete, self._RefreshGoodsRecharge)
end

UINShopNormalRechargeItem.InitRechargeItem = function(self, goodData, resloader)
  -- function num : 0_1 , upvalues : _ENV
  self.goodData = goodData
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).tex_Name).text = (LanguageUtil.GetLocaleText)((goodData.goodCfg).name)
  self.payCtrl = ControllerManager:GetController(ControllerTypeId.Pay, true)
  self.payId = ((self.goodData).goodCfg).pay_id
  local _, priceInter, priceUnit = (self.payCtrl):GetPayPriceShow(self.payId)
  -- DECOMPILER ERROR at PC29: Confused about usage of register: R6 in 'UnsetPending'

  ;
  ((self.ui).tex_CNY).text = tostring(priceInter)
  -- DECOMPILER ERROR at PC32: Confused about usage of register: R6 in 'UnsetPending'

  ;
  ((self.ui).tex_icon).text = priceUnit
  local textureName = ((self.goodData).goodCfg).icon
  resloader:LoadABAssetAsync(PathConsts:GetShopGiftBgPath(textureName), function(texture)
    -- function num : 0_1_0 , upvalues : _ENV, self
    -- DECOMPILER ERROR at PC7: Confused about usage of register: R1 in 'UnsetPending'

    if not IsNull(texture) then
      ((self.ui).img_Quartz).texture = texture
    end
  end
)
  self:RefreshRechargeItem()
end

UINShopNormalRechargeItem.RefreshRechargeItem = function(self)
  -- function num : 0_2 , upvalues : _ENV
  local _, rewardCounts = (self.payCtrl):GetPayRewards(self.payId, (self.goodData).hasDouble)
  if rewardCounts ~= nil and #rewardCounts > 1 then
    ((self.ui).extraNode):SetActive(true)
    -- DECOMPILER ERROR at PC21: Confused about usage of register: R3 in 'UnsetPending'

    ;
    ((self.ui).tex_ExtraNum).text = tostring(rewardCounts[2])
    ;
    ((self.ui).onlyOneDouble):SetActive((self.goodData).hasDouble)
  else
    ;
    ((self.ui).extraNode):SetActive(false)
  end
end

UINShopNormalRechargeItem.RefreshRechargeSuccess = function(self, shopId)
  -- function num : 0_3
  if (self.goodData).shopId == shopId then
    self:RefreshRechargeItem()
  end
end

UINShopNormalRechargeItem.OnClickBuyRecharge = function(self)
  -- function num : 0_4 , upvalues : _ENV
  local shopCtrl = ControllerManager:GetController(ControllerTypeId.Shop, true)
  shopCtrl:ReqShopRecharge(self.payId)
end

UINShopNormalRechargeItem.OnDelete = function(self)
  -- function num : 0_5 , upvalues : _ENV, base
  MsgCenter:RemoveListener(eMsgEventId.ShopRechargeComplete, self._RefreshGoodsRecharge)
  ;
  (base.OnDelete)(self)
end

return UINShopNormalRechargeItem


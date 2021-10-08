local UINBattlePassPurchaseItem1 = class("UINBattlePassPurchaseItem1", UIBaseNode)
local base = UIBaseNode
UINBattlePassPurchaseItem1.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Buy, self, self.OnBtnPassBuyClicked)
end

UINBattlePassPurchaseItem1.InitPassPurchaseItem1 = function(self, purchaseType, passInfo, buyEvent, hasBuy)
  -- function num : 0_1 , upvalues : _ENV
  self.purchaseType = purchaseType
  self.passInfo = passInfo
  self.buyEvent = buyEvent
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R5 in 'UnsetPending'

  ;
  ((self.ui).tex_Desc).text = (LanguageUtil.GetLocaleText)(((self.passInfo).passCfg).describe2)
  ;
  (((self.ui).btn_Buy).gameObject):SetActive(not hasBuy)
  ;
  ((self.ui).img_HasPurchased):SetActive(hasBuy)
end

UINBattlePassPurchaseItem1.OnBtnPassBuyClicked = function(self)
  -- function num : 0_2
  if self.buyEvent ~= nil then
    (self.buyEvent)((self.passInfo).id, self.purchaseType)
  end
end

UINBattlePassPurchaseItem1.OnDelete = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnDelete)(self)
end

return UINBattlePassPurchaseItem1


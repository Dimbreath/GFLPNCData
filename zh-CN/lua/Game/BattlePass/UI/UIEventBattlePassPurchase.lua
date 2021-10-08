local UIEventBattlePassPurchase = class("UIEventBattlePassPurchase", UIBaseWindow)
local base = UIBaseWindow
local UINBattlePassPurchaseItem1 = require("Game.BattlePass.UI.UINBattlePassPurchaseItem1")
local UINBattlePassPurchaseItem2 = require("Game.BattlePass.UI.UINBattlePassPurchaseItem2")
local BattlePassEnum = require("Game.BattlePass.BattlePassEnum")
UIEventBattlePassPurchase.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.AddButtonListener)((self.ui).btn_Close, self, self.OnBtnCloseClick)
  ;
  (UIUtil.SetTopStatus)(self, self.OnReturnClick, nil, nil, nil, true)
  self.__battlepassBuyAction = BindCallback(self, self.OnBattlepassBuyClicked)
  self.resloader = ((CS.ResLoader).Create)()
end

UIEventBattlePassPurchase.InitBattlePassPurchaseUI = function(self, passInfo)
  -- function num : 0_1
  self.passInfo = passInfo
  self:InitBattlePassPurchaseStaticUI()
  self.passPurchaseList = {}
  self:CreateSeniorPurchaseItem()
  self:CreateUltimatePurchaseItem()
end

UIEventBattlePassPurchase.InitBattlePassPurchaseStaticUI = function(self)
  -- function num : 0_2 , upvalues : _ENV
  local respath = "Res/UIPrefabs/BattlePassReHolder/" .. ((self.passInfo).passCfg).hero_res .. ".prefab"
  ;
  (self.resloader):LoadABAssetAsync(respath, function(prefab)
    -- function num : 0_2_0 , upvalues : _ENV, self
    if IsNull(prefab) then
      return 
    end
    local go = prefab:Instantiate()
    ;
    (go.transform):SetParent((self.ui).resHolder)
    -- DECOMPILER ERROR at PC20: Confused about usage of register: R2 in 'UnsetPending'

    ;
    (go.transform).localScale = (Vector3.New)(1, 1, 1)
    ;
    (go.transform):SetAsLastSibling()
    -- DECOMPILER ERROR at PC31: Confused about usage of register: R2 in 'UnsetPending'

    ;
    (go.transform).localPosition = (Vector3.New)(0, 0, 0)
    -- DECOMPILER ERROR at PC38: Confused about usage of register: R2 in 'UnsetPending'

    ;
    (go.transform).offsetMax = (Vector2.New)(0, 0)
    -- DECOMPILER ERROR at PC45: Confused about usage of register: R2 in 'UnsetPending'

    ;
    (go.transform).offsetMin = (Vector2.New)(0, 0)
  end
)
end

UIEventBattlePassPurchase.CreateSeniorPurchaseItem = function(self)
  -- function num : 0_3 , upvalues : UINBattlePassPurchaseItem1, BattlePassEnum
  local purchaseItem = (UINBattlePassPurchaseItem1.New)()
  purchaseItem:Init((self.ui).normalPurchaseItem)
  local purchaseType = (BattlePassEnum.BuyQuality).Senior
  local hasBuy = (self.passInfo).unlockSenior
  purchaseItem:InitPassPurchaseItem1(purchaseType, self.passInfo, self.__battlepassBuyAction, hasBuy)
  -- DECOMPILER ERROR at PC17: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (self.passPurchaseList)[purchaseType] = purchaseItem
end

UIEventBattlePassPurchase.CreateUltimatePurchaseItem = function(self)
  -- function num : 0_4 , upvalues : UINBattlePassPurchaseItem2, BattlePassEnum
  local purchaseItem = (UINBattlePassPurchaseItem2.New)()
  purchaseItem:Init((self.ui).seniorPurchaseItem)
  local hasDiscount = false
  local purchaseType = (BattlePassEnum.BuyQuality).Ultimate
  if (self.passInfo).unlockSenior and not (self.passInfo).unlockUltimate then
    purchaseType = (BattlePassEnum.BuyQuality).SupplyUltimate
    hasDiscount = true
  end
  purchaseItem:InitPassPurchaseItem2(purchaseType, self.passInfo, self.__battlepassBuyAction, hasDiscount)
  -- DECOMPILER ERROR at PC27: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (self.passPurchaseList)[purchaseType] = purchaseItem
end

UIEventBattlePassPurchase.OnBattlepassBuyClicked = function(self, passId, purchaseType)
  -- function num : 0_5 , upvalues : _ENV
  local battlepassCtrl = ControllerManager:GetController(ControllerTypeId.BattlePass, true)
  battlepassCtrl:BuyBattlePass(passId, purchaseType)
end

UIEventBattlePassPurchase.OnBtnCloseClick = function(self)
  -- function num : 0_6 , upvalues : _ENV
  (UIUtil.OnClickBack)()
end

UIEventBattlePassPurchase.OnReturnClick = function(self)
  -- function num : 0_7
  self:Delete()
end

UIEventBattlePassPurchase.OnDelete = function(self)
  -- function num : 0_8 , upvalues : base
  if self.resloader ~= nil then
    (self.resloader):Put2Pool()
    self.resloader = nil
  end
  ;
  (base.OnDelete)(self)
end

return UIEventBattlePassPurchase


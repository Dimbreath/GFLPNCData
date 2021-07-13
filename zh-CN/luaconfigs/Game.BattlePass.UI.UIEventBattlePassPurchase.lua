-- params : ...
-- function num : 0 , upvalues : _ENV
local UIEventBattlePassPurchase = class("UIEventBattlePassPurchase", UIBaseWindow)
local base = UIBaseWindow
local UINBattlePassPurchaseItem = require("Game.BattlePass.UI.UINBattlePassPurchaseItem")
local BattlePassEnum = require("Game.BattlePass.BattlePassEnum")
local UIHeroSkinShowTool = require("Game.CommonUI.Skin.UIHeroSkinShowTool")
UIEventBattlePassPurchase.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UIHeroSkinShowTool
  (UIUtil.SetTopStatus)(self, self.OnBtnCloseClick)
  ;
  ((self.ui).purchaseItem):SetActive(false)
  self.skinTool = (UIHeroSkinShowTool.New)()
  ;
  (self.skinTool):InitSkinShow((self.ui).heroHolder, (self.ui).picHolder, self:GetWindowSortingLayer())
  self.__battlepassBuyAction = BindCallback(self, self.OnBattlepassBuyClicked)
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
  local passCfg = (self.passInfo).passCfg
  local skinCfg = (ConfigData.skin)[passCfg.banner_skin]
  -- DECOMPILER ERROR at PC19: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).tex_Tips).text = (string.format)((LanguageUtil.GetLocaleText)(passCfg.describe), (LanguageUtil.GetLocaleText)(skinCfg.name))
  ;
  (self.skinTool):ShowSkinById(passCfg.banner_skin)
end

UIEventBattlePassPurchase.__NewPurchaseItem = function(self)
  -- function num : 0_3 , upvalues : UINBattlePassPurchaseItem
  local itemObj = ((self.ui).purchaseItem):Instantiate()
  itemObj:SetActive(true)
  local purchaseItem = (UINBattlePassPurchaseItem.New)()
  purchaseItem:Init(itemObj)
  return purchaseItem
end

UIEventBattlePassPurchase.CreateSeniorPurchaseItem = function(self)
  -- function num : 0_4 , upvalues : BattlePassEnum
  local purchaseItem = self:__NewPurchaseItem()
  local purchaseType = (BattlePassEnum.BuyQuality).Senior
  purchaseItem:InitPassPurchaseItem(purchaseType, false, self.passInfo, self.__battlepassBuyAction)
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self.passPurchaseList)[purchaseType] = purchaseItem
end

UIEventBattlePassPurchase.CreateUltimatePurchaseItem = function(self)
  -- function num : 0_5 , upvalues : BattlePassEnum
  local purchaseItem = self:__NewPurchaseItem()
  local purchaseType = (BattlePassEnum.BuyQuality).Ultimate
  purchaseItem:InitPassPurchaseItem(purchaseType, true, self.passInfo, self.__battlepassBuyAction)
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self.passPurchaseList)[purchaseType] = purchaseItem
end

UIEventBattlePassPurchase.OnBattlepassBuyClicked = function(self, passId, purchaseType)
  -- function num : 0_6 , upvalues : _ENV
  local battlepassCtrl = ControllerManager:GetController(ControllerTypeId.BattlePass, true)
  battlepassCtrl:BuyBattlePass(passId, purchaseType)
end

UIEventBattlePassPurchase.OnBtnCloseClick = function(self)
  -- function num : 0_7
  self:Delete()
end

UIEventBattlePassPurchase.OnDelete = function(self)
  -- function num : 0_8 , upvalues : base
  (base.OnDelete)(self)
end

return UIEventBattlePassPurchase


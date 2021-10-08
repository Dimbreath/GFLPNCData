local UINBattlePassPurchaseItem2 = class("UINBattlePassPurchaseItem2", UIBaseNode)
local base = UIBaseNode
local UINBaseItemWithCount = require("Game.CommonUI.Item.UINBaseItemWithCount")
UINBattlePassPurchaseItem2.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINBaseItemWithCount
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Buy, self, self.OnBtnPassBuyClicked)
  ;
  ((self.ui).baseItem):SetActive(false)
  self.baseRewardPool = (UIItemPool.New)(UINBaseItemWithCount, (self.ui).baseItem)
end

UINBattlePassPurchaseItem2.InitPassPurchaseItem2 = function(self, purchaseType, passInfo, buyEvent, hasDiscount)
  -- function num : 0_1 , upvalues : _ENV
  self.purchaseType = purchaseType
  self.passInfo = passInfo
  self.buyEvent = buyEvent
  local color = ((self.passInfo).passCfg).color
  color = (Color.New)(color[1] / 255, color[2] / 255, color[3] / 255)
  -- DECOMPILER ERROR at PC18: Confused about usage of register: R6 in 'UnsetPending'

  ;
  ((self.ui).img_Line).color = color
  -- DECOMPILER ERROR at PC21: Confused about usage of register: R6 in 'UnsetPending'

  ;
  ((self.ui).imgBG1).color = color
  -- DECOMPILER ERROR at PC24: Confused about usage of register: R6 in 'UnsetPending'

  ;
  ((self.ui).imgBG).color = color
  ;
  ((self.ui).tex_Discount):SetActive(hasDiscount)
  ;
  ((self.ui).tex_Price):SetActive(not hasDiscount)
  self:InitPassReward()
end

UINBattlePassPurchaseItem2.InitPassReward = function(self)
  -- function num : 0_2 , upvalues : _ENV
  local passCfg = (self.passInfo).passCfg
  for index,itemId in pairs(passCfg.ultimate_reward_ids) do
    if itemId ~= passCfg.condition_para1 then
      local itemCount = (passCfg.ultimate_reward_nums)[index]
      local itemCfg = (ConfigData.item)[itemId]
      if itemCfg == nil then
        error("item cfg is null,id:" .. tostring(itemId))
      else
        local baseItem = (self.baseRewardPool):GetOne()
        baseItem:InitItemWithCount(itemCfg, itemCount)
      end
    end
  end
end

UINBattlePassPurchaseItem2.OnBtnPassBuyClicked = function(self)
  -- function num : 0_3
  if self.buyEvent ~= nil then
    (self.buyEvent)((self.passInfo).id, self.purchaseType)
  end
end

UINBattlePassPurchaseItem2.OnDelete = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnDelete)(self)
end

return UINBattlePassPurchaseItem2


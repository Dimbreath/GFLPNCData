-- params : ...
-- function num : 0 , upvalues : _ENV
local UIFactoryQuickProduce = class("UIFactoryQuickProduce", UIBaseWindow)
local base = UIBaseWindow
local UINFactoryOrderNode = require("Game.Factory.UI.UINFactoryOrderNode")
UIFactoryQuickProduce.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINFactoryOrderNode
  self.factoryController = ControllerManager:GetController(ControllerTypeId.Factory, false)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_background, self, self.OnclickClose)
  ;
  (((self.ui).tween_factoryOrderNode).onRewind):AddListener(BindCallback(self, self.Delete))
  self.factoryOrderNode = (UINFactoryOrderNode.New)()
  ;
  (self.factoryOrderNode):Init((self.ui).factoryOrderNode)
  -- DECOMPILER ERROR at PC35: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.factoryOrderNode).ui).quickPurchaseRoot = (self.ui).quickPurchaseRoot
end

UIFactoryQuickProduce.OpenQuickProduce = function(self, targetOrderData, closeCallback)
  -- function num : 0_1
  ((self.ui).tween_factoryOrderNode):DOPlayForward()
  ;
  (self.factoryOrderNode):InitOrderNode(targetOrderData:GetOrderRoomIndex())
  ;
  (self.factoryOrderNode):ShowOrder(targetOrderData)
  ;
  (self.factoryOrderNode):SetCloseCommonRewardCallback(function()
    -- function num : 0_1_0 , upvalues : self, closeCallback
    self:OnclickClose()
    if closeCallback ~= nil then
      closeCallback()
    end
  end
)
end

UIFactoryQuickProduce.OnclickClose = function(self)
  -- function num : 0_2
  self:OrderNodesPlayOver()
end

UIFactoryQuickProduce.OrderNodesPlayOver = function(self)
  -- function num : 0_3
  ((self.ui).tween_factoryOrderNode):DOPlayBackwards()
end

UIFactoryQuickProduce.OnDelete = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnDelete)(self)
end

return UIFactoryQuickProduce


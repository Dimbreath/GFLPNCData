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
  self.factoryOrderNode = (UINFactoryOrderNode.New)(true)
  ;
  (self.factoryOrderNode):Init((self.ui).factoryOrderNode)
  -- DECOMPILER ERROR at PC36: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.factoryOrderNode).ui).quickPurchaseRoot = (self.ui).quickPurchaseRoot
  -- DECOMPILER ERROR at PC42: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self.factoryOrderNode).closeQuickProduceNode = BindCallback(self, self.OnclickClose)
end

UIFactoryQuickProduce.OpenQuickProduce = function(self, targetOrderData, closeCallback)
  -- function num : 0_1 , upvalues : _ENV
  ((self.ui).tween_factoryOrderNode):DOPlayForward()
  AudioManager:PlayAudioById(1070)
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
  -- function num : 0_3 , upvalues : _ENV
  ((self.ui).tween_factoryOrderNode):DOPlayBackwards()
  AudioManager:PlayAudioById(1071)
end

UIFactoryQuickProduce.OnDelete = function(self)
  -- function num : 0_4 , upvalues : base
  (self.factoryOrderNode):Delete()
  ;
  (base.OnDelete)(self)
end

return UIFactoryQuickProduce


local UILotteryExchange = class("UILotteryExchange", UIBaseWindow)
local base = UIBaseWindow
local UINLtrPtNode = require("Game.Lottery.UI.PtNode.UINLtrPtNode")
local UINLtrSHNode = require("Game.Lottery.UI.SelectHero.UINLtrSHNode")
local cs_DoTween = ((CS.DG).Tweening).DOTween
local cs_Ease = ((CS.DG).Tweening).Ease
UILotteryExchange.OnInit = function(self)
  -- function num : 0_0 , upvalues : UINLtrPtNode, UINLtrSHNode, _ENV
  self.ltrPtNode = (UINLtrPtNode.New)()
  ;
  (self.ltrPtNode):Init((self.ui).exchangeNode)
  ;
  (self.ltrPtNode):Hide()
  self.ltrSHNode = (UINLtrSHNode.New)()
  ;
  (self.ltrSHNode):Init((self.ui).selectHeroNode)
  ;
  (self.ltrSHNode):Hide()
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Close, self, self.Close)
end

UILotteryExchange.ShowLtrPtNode = function(self, curPoolData, tempResLoader, ltrCtrl)
  -- function num : 0_1
  (self.ltrPtNode):InitLtrPtNode(curPoolData, tempResLoader, ltrCtrl)
  ;
  ((self.ui).resourceItem):SetActive(true)
  ;
  (self.ltrPtNode):Show()
  ;
  (self.ltrPtNode):BindCloseFun(function()
    -- function num : 0_1_0 , upvalues : self
    self:Delete()
  end
)
end

UILotteryExchange.HideLtrPtNode = function(self)
  -- function num : 0_2
  (self.ltrPtNode):Hide()
end

UILotteryExchange.ShowLtrSHNode = function(self, itemId, curHeroCfg, ltrCfg, ltrCtrl)
  -- function num : 0_3
  (self.ltrSHNode):InitLtrSHNode(itemId, curHeroCfg, ltrCfg, ltrCtrl)
  ;
  ((self.ui).resourceItem):SetActive(false)
  ;
  (self.ltrSHNode):Show()
  ;
  (self.ltrSHNode):BindCloseFun(function()
    -- function num : 0_3_0 , upvalues : self
    self:Delete()
  end
)
end

UILotteryExchange.HideLtrSHNode = function(self)
  -- function num : 0_4
  (self.ltrSHNode):Hide()
end

UILotteryExchange.Close = function(self)
  -- function num : 0_5 , upvalues : _ENV
  (UIUtil.OnClickBack)()
  self:Delete()
end

UILotteryExchange.OnDelete = function(self)
  -- function num : 0_6 , upvalues : base
  if self.ltrPtNode ~= nil then
    (self.ltrPtNode):Delete()
  end
  if self.ltrSHNode ~= nil then
    (self.ltrSHNode):Delete()
  end
  ;
  (base.Delete)(self)
end

return UILotteryExchange


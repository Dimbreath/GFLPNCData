-- params : ...
-- function num : 0 , upvalues : _ENV
local UILotteryShow = class("UILotteryShow", UIBaseWindow)
local base = UIBaseWindow
UILotteryShow.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.AddButtonListener)((self.ui).btn_Skip, self, self.SkipLotteryShow)
  UIManager:HideWindow(UIWindowTypeID.TopStatus)
end

UILotteryShow.InitLotteryShow = function(self, showCtrl)
  -- function num : 0_1
  self.__showCtrl = showCtrl
end

UILotteryShow.SkipLotteryShow = function(self)
  -- function num : 0_2
  if self.__showCtrl ~= nil then
    (self.__showCtrl):SkipShow()
  end
end

return UILotteryShow


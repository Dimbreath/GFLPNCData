local LotteryCtrlBase = class("LotteryCtrlBase")
LotteryCtrlBase.ctor = function(self, ltrCtrl)
  -- function num : 0_0 , upvalues : _ENV
  self.ltrCtrl = ltrCtrl
  ;
  (table.insert)((self.ltrCtrl).ctrls, self)
end

LotteryCtrlBase.OnDelete = function(self)
  -- function num : 0_1
end

return LotteryCtrlBase


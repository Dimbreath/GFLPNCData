local UICADPAWarringWin = class("UICADPAWarringWin", UIBaseWindow)
local base = UIBaseWindow
UICADPAWarringWin.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.AddButtonListener)((self.ui).btn_background, self, self.CloseCADPAWarring)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Close, self, self.CloseCADPAWarring)
end

UICADPAWarringWin.CloseCADPAWarring = function(self)
  -- function num : 0_1
  self:Delete()
end

UICADPAWarringWin.OnDelete = function(self)
  -- function num : 0_2 , upvalues : base
  (base.OnDelete)(self)
end

return UICADPAWarringWin


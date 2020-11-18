-- params : ...
-- function num : 0 , upvalues : _ENV
local UICJResult = class("UICJResult", UIBaseWindow)
local base = UIBaseWindow
UICJResult.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.AddButtonListener)((self.ui).btn_Back, self, self.__OnBtnClick)
end

UICJResult.InitCJResult = function(self, isWin, clickAction)
  -- function num : 0_1
  self:RefeshWinUI(isWin)
  self:SetClickAction(clickAction)
end

UICJResult.RefeshWinUI = function(self, isWin)
  -- function num : 0_2
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R2 in 'UnsetPending'

  if not isWin or not (self.ui).col_Blue then
    ((self.ui).img_Bg).color = (self.ui).col_Red
    ;
    ((self.ui).Img_Result):SetIndex(isWin and 0 or 1)
    ;
    ((self.ui).tex_Result):SetIndex(isWin and 0 or 1)
  end
end

UICJResult.SetClickAction = function(self, clickAction)
  -- function num : 0_3
  self.clickAction = clickAction
end

UICJResult.__OnBtnClick = function(self)
  -- function num : 0_4
  if self.clickAction ~= nil then
    (self.clickAction)()
  end
  self:Delete()
end

UICJResult.OnDelete = function(self)
  -- function num : 0_5 , upvalues : base
  (base.OnDelete)(self)
end

return UICJResult


-- params : ...
-- function num : 0 , upvalues : _ENV
local UIOverclock = class("UIOverclock", UIBaseWindow)
local base = UIBaseWindow
local UINOverclockNode = require("Game.Sector.Overclock.UINOverclockNode")
local UINOverclockChipSelectNode = require("Game.Sector.Overclock.UINOverclockChipSelectNode")
UIOverclock.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINOverclockNode, UINOverclockChipSelectNode
  self.OverclockCtrl = ControllerManager:GetController(ControllerTypeId.Overclock, false)
  self.overclockNode = (UINOverclockNode.New)()
  ;
  (self.overclockNode):Init((self.ui).obj_overClockNode)
  ;
  (self.overclockNode):InitNode()
  self.ChipSelectNode = (UINOverclockChipSelectNode.New)()
  ;
  (self.ChipSelectNode):Init((self.ui).obj_sortChipNode)
  ;
  (self.OverclockCtrl):SetShowChipSelectNode(BindCallback(self, self.ShowChipSelectNode))
  ;
  ((self.ui).tex_Title):SetIndex(1)
  self.__RefreshGNum = BindCallback(self, self.RefreshGNum)
  ;
  (self.OverclockCtrl):AddChangeGCallBack(self.__RefreshGNum)
  ;
  (UIUtil.CreateTopBtnGroup)((self.ui).topButtonGroup, self, self.OnClickBackBtn)
  local topStatus = UIManager:GetWindow(UIWindowTypeID.TopStatus)
  if topStatus ~= nil then
    topStatus:Hide()
  end
end

UIOverclock.RefreshGNum = function(self, G_Num)
  -- function num : 0_1 , upvalues : _ENV
  ((self.ui).tex_Money):SetIndex(0, tostring(G_Num))
end

UIOverclock.ShowChipSelectNode = function(self, optionId4Select)
  -- function num : 0_2
  ((self.ui).tex_Title):SetIndex(0)
  ;
  (self.ChipSelectNode):Show()
  ;
  (self.overclockNode):Hide()
  ;
  (self.ChipSelectNode):InitChipSelectNode(optionId4Select, self.overclockNode)
  ;
  (self.ChipSelectNode):SetTitleCallback(function()
    -- function num : 0_2_0 , upvalues : self
    ((self.ui).tex_Title):SetIndex(1)
  end
)
end

UIOverclock.OnClickBackBtn = function(self)
  -- function num : 0_3
  (self.OverclockCtrl):CloseOverclockUI()
end

UIOverclock.OnDelete = function(self)
  -- function num : 0_4 , upvalues : base
  (self.OverclockCtrl):RemoveChangeGCallBack(self.__RefreshGNum)
  ;
  (self.OverclockCtrl):CleanCallback()
  ;
  (base.OnDelete)(self)
end

return UIOverclock


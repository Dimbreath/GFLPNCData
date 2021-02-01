-- params : ...
-- function num : 0 , upvalues : _ENV
local UIOverclock = class("UIOverclock", UIBaseWindow)
local base = UIBaseWindow
local UINOverclockNode = require("Game.Sector.Overclock.UINOverclockNode")
local UINOverclockChipSelectNode = require("Game.Sector.Overclock.New.UINOverclockChipSelectNode")
local cs_ResLoader = CS.ResLoader
UIOverclock.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINOverclockNode, UINOverclockChipSelectNode, cs_ResLoader
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
  ;
  (UIUtil.SetTopStatus)(self, self.OnClickBackBtn, {ConstGlobalItem.NormalGold})
  self.__RefreshGNum = BindCallback(self, self.RefreshGNum)
  ;
  (self.OverclockCtrl):AddChangeGCallBack(self.__RefreshGNum)
  self.resloader = (cs_ResLoader.Create)()
end

UIOverclock.RefreshGNum = function(self, G_Num)
  -- function num : 0_1 , upvalues : _ENV
  local win = (UIManager:GetWindow(UIWindowTypeID.TopStatus))
  -- DECOMPILER ERROR at PC5: Overwrote pending register: R3 in 'AssignReg'

  local resItem = .end
  if win ~= nil then
    resItem = win:GetTopStatusResItem(ConstGlobalItem.NormalGold)
    if resItem ~= nil then
      resItem:SetPassiveRefresh(false)
      resItem:UpdateCount(G_Num)
    end
  end
end

UIOverclock.ShowChipSelectNode = function(self, optionId4Select)
  -- function num : 0_2
  ((self.ui).tex_Title):SetIndex(0)
  ;
  (self.ChipSelectNode):Show()
  ;
  (self.overclockNode):Hide()
  ;
  (self.ChipSelectNode):InitChipSelectNode(optionId4Select, self.overclockNode, self.resloader)
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
  if self.resloader ~= nil then
    (self.resloader):Put2Pool()
    self.resloader = nil
  end
  ;
  (base.OnDelete)(self)
end

return UIOverclock


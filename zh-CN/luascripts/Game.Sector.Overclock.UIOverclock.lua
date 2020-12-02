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
  self.__RefreshGNum = BindCallback(self, self.RefreshGNum)
  ;
  (self.OverclockCtrl):AddChangeGCallBack(self.__RefreshGNum)
  ;
  (UIUtil.CreateTopBtnGroup)((self.ui).topButtonGroup, self, self.OnClickBackBtn)
  self.resloader = (cs_ResLoader.Create)()
  local itemCfg = (ConfigData.item)[ItemIdOfG]
  if itemCfg == nil then
    error("Can\'t find itemCfg by Id:" .. tostring(GameDefine.ItemIdOfG))
  end
  -- DECOMPILER ERROR at PC77: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.ui).img_Money).sprite = CRH:GetSprite(itemCfg.small_icon)
end

UIOverclock.RefreshGNum = function(self, G_Num)
  -- function num : 0_1 , upvalues : _ENV
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R2 in 'UnsetPending'

  ((self.ui).tex_Money).text = tostring(G_Num)
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


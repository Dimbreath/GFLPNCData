-- params : ...
-- function num : 0 , upvalues : _ENV
local UIFactoryHeroListCover = class("UIFactoryHeroListCover", UIBaseWindow)
local base = UIBaseWindow
local UINFactoryHeroList = require("Game.Factory.UI.FactoryHeroList.UINFactoryHeroList")
local cs_MessageCommon = CS.MessageCommon
UIFactoryHeroListCover.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINFactoryHeroList
  self.factoryController = ControllerManager:GetController(ControllerTypeId.Factory, false)
  self.factoryHeroList = (UINFactoryHeroList.New)()
  ;
  (self.factoryHeroList):Init((self.ui).uI_HeroList)
  ;
  (self.factoryHeroList):SetCallback(BindCallback(self, self.UpdateEnergyAddUI), BindCallback(self, self.OnConfirm))
  self.baseAccRate = 0
end

UIFactoryHeroListCover.InitSelectHero = function(self, roomIndex, closeCallback)
  -- function num : 0_1 , upvalues : _ENV
  self.roomIndex = roomIndex
  self.closeCallback = closeCallback
  ;
  (UIUtil.SetTopStatus)(self, self.OnReturnClicked)
  ;
  (self.factoryHeroList):InitFactoryHeroList(roomIndex)
end

UIFactoryHeroListCover.UpdateEnergyAddUI = function(self, heroIdList, isInit)
  -- function num : 0_2 , upvalues : _ENV
  local accRate = (self.factoryController):GetHeroEnterAccrate(self.roomIndex, heroIdList)
  local baseSpeed = (self.factoryController):GetRoomEnegeyBaseSpeedByIndex(self.roomIndex)
  if #heroIdList > 0 then
    ((self.ui).tex_TipsContent):SetIndex(0, GetPreciseDecimalStr(baseSpeed * 3600, 1), GetPreciseDecimalStr(baseSpeed * (1 + accRate) * 3600, 1))
  else
    ;
    ((self.ui).tex_TipsContent):SetIndex(1, GetPreciseDecimalStr(baseSpeed * 3600, 1))
  end
end

UIFactoryHeroListCover.OnConfirm = function(self)
  -- function num : 0_3 , upvalues : cs_MessageCommon, _ENV
  (cs_MessageCommon.ShowMessageTips)(ConfigData:GetTipContent(TipContent.Factory_HeroEnterSuccess))
  self:OnReturnClicked()
  ;
  (UIUtil.OnClickBack)()
end

UIFactoryHeroListCover.OnReturnClicked = function(self)
  -- function num : 0_4
  if self.closeCallback ~= nil then
    (self.closeCallback)()
  end
  self:Hide()
end

UIFactoryHeroListCover.OnDelete = function(self)
  -- function num : 0_5 , upvalues : base
  (self.factoryHeroList):OnDelete()
  ;
  (base.OnDelete)(self)
end

return UIFactoryHeroListCover


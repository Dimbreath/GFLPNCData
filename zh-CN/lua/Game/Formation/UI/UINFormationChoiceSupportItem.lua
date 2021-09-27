local UINFormationChoiceSupportItem = class("UINFormationChoiceSupportItem", UIBaseNode)
local base = UIBaseNode
local UINHeroCardItem = require("Game.Hero.NewUI.UINHeroCardItem")
local UINFmtHeroHpBarItem = require("Game.Formation.UI.UINFmtHeroHpBarItem")
UINFormationChoiceSupportItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINHeroCardItem
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  self.heroCardItem = (UINHeroCardItem.New)()
  ;
  (self.heroCardItem):Init((self.ui).uINHeroItem)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_img_empty, self, self.OnClick)
  local eventTrigger = ((CS.EventTriggerListener).Get)((self.heroCardItem).gameObject)
  eventTrigger:onBeginDrag("+", BindCallback(self, self.OnBeginDrag))
  eventTrigger:onDrag("+", BindCallback(self, self.OnDrag))
  eventTrigger:onEndDrag("+", BindCallback(self, self.OnEndDrag))
  eventTrigger:onClick("+", BindCallback(self, self.OnClick))
end

UINFormationChoiceSupportItem.InitAsEmpuyCard = function(self, clickAct)
  -- function num : 0_1
  self.clickAct = clickAct
  ;
  (self.heroCardItem):Hide()
  ;
  ((self.ui).img_support):SetActive(true)
  ;
  ((self.ui).img_Empty):SetActive(true)
  ;
  ((self.ui).isSupport):SetActive(false)
  ;
  ((self.ui).obj_Selected):SetActive(false)
  ;
  ((self.ui).img_TimesUseUP):SetActive(false)
  self:SetFmtChoiceSupportItemInFmt(false)
end

UINFormationChoiceSupportItem.InitChoiceItem = function(self, heroData, resloader, beginDragAct, onDragAct, endDragAct, clickAct)
  -- function num : 0_2
  self.beginDragAct = beginDragAct
  self.onDragAct = onDragAct
  self.endDragAct = endDragAct
  self.clickAct = clickAct
  self.heroData = heroData
  self.resloader = resloader
  ;
  (self.heroCardItem):Show()
  ;
  (self.heroCardItem):InitHeroCardItem(heroData, resloader)
  ;
  ((self.ui).img_support):SetActive(false)
  ;
  ((self.ui).isSupport):SetActive(true)
  ;
  ((self.ui).obj_Selected):SetActive(false)
  ;
  ((self.ui).img_TimesUseUP):SetActive(false)
  self:SetFmtChoiceSupportItemInFmt(false)
end

UINFormationChoiceSupportItem.InitAsExhaustCard = function(self)
  -- function num : 0_3
  ((self.ui).img_support):SetActive(true)
  ;
  ((self.ui).img_Empty):SetActive(false)
  ;
  ((self.ui).isSupport):SetActive(false)
  ;
  ((self.ui).obj_Selected):SetActive(false)
  ;
  ((self.ui).img_TimesUseUP):SetActive(true)
end

UINFormationChoiceSupportItem.OnBeginDrag = function(self, go, eventData)
  -- function num : 0_4
  if self.beginDragAct ~= nil then
    (self.beginDragAct)(eventData, self)
  end
end

UINFormationChoiceSupportItem.OnDrag = function(self, go, eventData)
  -- function num : 0_5
  if self.onDragAct ~= nil then
    (self.onDragAct)(eventData, self)
  end
end

UINFormationChoiceSupportItem.OnEndDrag = function(self, go, eventData)
  -- function num : 0_6
  if self.endDragAct ~= nil then
    (self.endDragAct)(eventData, self)
  end
end

UINFormationChoiceSupportItem.OnClick = function(self, go, eventData)
  -- function num : 0_7
  if self.clickAct ~= nil then
    self:clickAct()
  end
end

UINFormationChoiceSupportItem.SetSelectedState = function(self, flag)
  -- function num : 0_8
  ((self.ui).obj_Selected):SetActive(flag)
end

UINFormationChoiceSupportItem.SetFmtChoiceSupportItemInFmt = function(self, inFmt)
  -- function num : 0_9
  ((self.ui).obj_InFmt):SetActive(inFmt)
  ;
  ((self.ui).obj_Selected):SetActive(inFmt)
end

UINFormationChoiceSupportItem.UpdateFixCfg = function(self, fixCfg)
  -- function num : 0_10
  if self.heroData ~= nil then
    (self.heroData):UseFixCfg2ChangeSupportorAttr(fixCfg)
    ;
    (self.heroCardItem):InitHeroCardItem(self.heroData, self.resloader)
  end
end

UINFormationChoiceSupportItem.UpdFmtHeroChoiceItemHp = function(self, hpPer)
  -- function num : 0_11 , upvalues : UINFmtHeroHpBarItem, _ENV
  if self.hpBarItem == nil then
    self.hpBarItem = (UINFmtHeroHpBarItem.New)()
    ;
    (self.hpBarItem):Init((self.ui).hPBar)
    ;
    (self.hpBarItem):Show()
  end
  local maxHp = (self.heroData):GetAttr(eHeroAttr.maxHp)
  ;
  (self.hpBarItem):InitFmtHeroHpBarItem(hpPer, maxHp)
  if hpPer == 0 then
    ((self.ui).cantBattle):SetActive(true)
  else
    if hpPer <= 2000 then
      ((self.ui).isWound):SetActive(true)
    else
      ;
      ((self.ui).cantBattle):SetActive(false)
      ;
      ((self.ui).isWound):SetActive(false)
    end
  end
end

UINFormationChoiceSupportItem.OnDelete = function(self)
  -- function num : 0_12 , upvalues : base
  if self.hpBarItem ~= nil then
    (self.hpBarItem):Delete()
  end
  ;
  (self.heroCardItem):Delete()
  ;
  (base.OnDelete)(self)
end

return UINFormationChoiceSupportItem


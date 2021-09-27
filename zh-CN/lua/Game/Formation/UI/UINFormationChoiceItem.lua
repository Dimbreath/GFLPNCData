local UINFormationChoiceItem = class("UINFormationChoiceItem", UIBaseNode)
local base = UIBaseNode
local UINHeroCardItem = require("Game.Hero.NewUI.UINHeroCardItem")
local UINFmtHeroHpBarItem = require("Game.Formation.UI.UINFmtHeroHpBarItem")
UINFormationChoiceItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINHeroCardItem
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  self.heroCardItem = (UINHeroCardItem.New)()
  ;
  (self.heroCardItem):Init((self.ui).uINHeroItem)
  local eventTrigger = ((CS.EventTriggerListener).Get)((self.heroCardItem).gameObject)
  eventTrigger:onBeginDrag("+", BindCallback(self, self.OnBeginDrag))
  eventTrigger:onDrag("+", BindCallback(self, self.OnDrag))
  eventTrigger:onEndDrag("+", BindCallback(self, self.OnEndDrag))
end

UINFormationChoiceItem.InitChoiceItem = function(self, heroData, resloader, beginDragAct, onDragAct, endDragAct, clickAct)
  -- function num : 0_1
  self.beginDragAct = beginDragAct
  self.onDragAct = onDragAct
  self.endDragAct = endDragAct
  self.heroData = heroData
  ;
  (self.heroCardItem):Show()
  ;
  (self.heroCardItem):InitHeroCardItem(heroData, resloader, clickAct)
  self:OnShowChoiceRedTip()
  self:OnShowChoiceNorTip()
  ;
  ((self.ui).obj_Selected):SetActive(false)
end

UINFormationChoiceItem.OnBeginDrag = function(self, go, eventData)
  -- function num : 0_2
  if self.beginDragAct ~= nil then
    (self.beginDragAct)(eventData, self)
  end
end

UINFormationChoiceItem.OnDrag = function(self, go, eventData)
  -- function num : 0_3
  if self.onDragAct ~= nil then
    (self.onDragAct)(eventData, self)
  end
end

UINFormationChoiceItem.OnEndDrag = function(self, go, eventData)
  -- function num : 0_4
  if self.endDragAct ~= nil then
    (self.endDragAct)(eventData, self)
  end
end

UINFormationChoiceItem.SetSelectedState = function(self, flag)
  -- function num : 0_5
  ((self.ui).obj_Selected):SetActive(flag)
end

UINFormationChoiceItem.OnShowChoiceRedTip = function(self)
  -- function num : 0_6 , upvalues : _ENV
  if (self.heroData).isFriendSupport then
    (self.heroCardItem):SetRedDotActive(false)
    return 
  end
  if self.heroData ~= nil then
    local ok, redNode = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.HeroWindow, (self.heroData).dataId, RedDotStaticTypeId.HeroStarUp)
    if redNode:GetRedDotCount() <= 0 then
      do
        (self.heroCardItem):SetRedDotActive(not ok)
        do return  end
        ;
        (self.heroCardItem):SetRedDotActive(false)
        -- DECOMPILER ERROR: 2 unprocessed JMP targets
      end
    end
  end
end

UINFormationChoiceItem.OnShowChoiceNorTip = function(self)
  -- function num : 0_7
  ((self.ui).obj_CanLevelUp):SetActive(false)
  if self.heroData == nil then
    return 
  end
  if not (self.heroData):AbleUpLevel() then
    return 
  end
  local isCanLevelup, _ = (self.heroData):GenHeroCanQuickLevelUp()
  ;
  ((self.ui).obj_CanLevelUp):SetActive(isCanLevelup)
end

UINFormationChoiceItem.UpdFmtHeroChoiceItemHp = function(self, hpPer)
  -- function num : 0_8 , upvalues : UINFmtHeroHpBarItem, _ENV
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

UINFormationChoiceItem.OnDelete = function(self)
  -- function num : 0_9 , upvalues : base
  if self.hpBarItem ~= nil then
    (self.hpBarItem):Delete()
  end
  ;
  (self.heroCardItem):Delete()
  ;
  (base.OnDelete)(self)
end

return UINFormationChoiceItem


-- params : ...
-- function num : 0 , upvalues : _ENV
local UINFormationChoiceItem = class("UINFormationChoiceItem", UIBaseNode)
local base = UIBaseNode
local UINHeroCardItem = require("Game.Hero.NewUI.UINHeroCardItem")
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
  local lastHeroId = self.heroData ~= nil and (self.heroData).dataId or nil
  self.beginDragAct = beginDragAct
  self.onDragAct = onDragAct
  self.endDragAct = endDragAct
  self.heroData = heroData
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

UINFormationChoiceItem.OnDelete = function(self)
  -- function num : 0_8 , upvalues : base
  (self.heroCardItem):Delete()
  ;
  (base.OnDelete)(self)
end

return UINFormationChoiceItem


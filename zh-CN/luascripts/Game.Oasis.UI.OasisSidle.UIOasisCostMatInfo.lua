-- params : ...
-- function num : 0 , upvalues : _ENV
local UIOasisCostMatInfo = class("UIOasisCostMatInfo", UIBaseNode)
local base = UIBaseNode
local UINBaseItem = require("Game.CommonUI.Item.UINBaseItem")
UIOasisCostMatInfo.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINBaseItem
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_BaseItem, self, self.OnClickItem)
  self.baseItem = (UINBaseItem.New)()
  ;
  (self.baseItem):Init((self.ui).obj_BaseItem)
end

UIOasisCostMatInfo.UpdateUI = function(self, id, needCount, bagCount)
  -- function num : 0_1 , upvalues : _ENV
  self.itemCfg = (ConfigData.item)[id]
  ;
  (self.baseItem):InitBaseItem(self.itemCfg, nil)
  do
    if needCount > bagCount or not 1 then
      local index = needCount == nil or 2
    end
    ;
    ((self.ui).tex_TotalCount):SetIndex(index, tostring(bagCount), tostring(needCount))
    ;
    ((self.ui).tex_TotalCount):SetIndex(0, tostring(bagCount))
    if (self.ui).empty ~= nil then
      if bagCount == 0 then
        ((self.ui).empty):SetActive(true)
      else
        ;
        ((self.ui).empty):SetActive(false)
      end
    end
    self:__ShowCornerMark(self.itemCfg)
  end
end

UIOasisCostMatInfo.UpdateUIWithName = function(self, id, name, needCount, bagCount)
  -- function num : 0_2 , upvalues : _ENV
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R5 in 'UnsetPending'

  ((self.ui).tex_Name).text = name
  self.itemCfg = (ConfigData.item)[id]
  if self.itemCfg ~= nil then
    (self.baseItem):InitBaseItem(self.itemCfg, nil)
  end
  do
    if needCount > bagCount or not 1 then
      local index = needCount == nil or 2
    end
    ;
    ((self.ui).tex_TotalCount):SetIndex(index, tostring(bagCount), tostring(needCount))
    ;
    ((self.ui).tex_TotalCount):SetIndex(0, tostring(bagCount))
    self:__ShowCornerMark(self.itemCfg)
  end
end

UIOasisCostMatInfo.UpdateWithEmpty = function(self)
  -- function num : 0_3
  if (self.ui).empty ~= nil then
    ((self.ui).empty):SetActive(true)
  end
  if (self.ui).chipItemWithCount ~= nil then
    (((self.ui).chipItemWithCount).gameObject):SetActive(false)
  end
end

UIOasisCostMatInfo.__ShowCornerMark = function(self, itemCfg)
  -- function num : 0_4 , upvalues : _ENV
  if (self.ui).obj_IsFrag == nil or (self.ui).obj_isHreo == nil or (self.ui).img_isSmallIcon == nil then
    return 
  end
  ;
  ((self.ui).obj_IsFrag):SetActive(false)
  ;
  ((self.ui).obj_isHreo):SetActive(false)
  ;
  (((self.ui).img_isSmallIcon).gameObject):SetActive(false)
  local smallIcon = itemCfg.small_icon
  if itemCfg.action_type == eItemActionType.HeroCardFrag then
    ((self.ui).obj_IsFrag):SetActive(true)
    ;
    ((self.ui).obj_isHreo):SetActive(true)
  else
    if smallIcon ~= "" and smallIcon ~= nil then
      ((self.ui).obj_IsFrag):SetActive(true)
      ;
      (((self.ui).img_isSmallIcon).gameObject):SetActive(true)
      -- DECOMPILER ERROR at PC67: Confused about usage of register: R3 in 'UnsetPending'

      ;
      ((self.ui).img_isSmallIcon).sprite = CRH:GetSprite(smallIcon)
    end
  end
end

UIOasisCostMatInfo.OnClickItem = function(self)
  -- function num : 0_5 , upvalues : _ENV
  if self.itemCfg ~= nil then
    UIManager:ShowWindowAsync(UIWindowTypeID.GlobalItemDetail, function(win)
    -- function num : 0_5_0 , upvalues : self
    if win ~= nil then
      win:InitCommonItemDetail(self.itemCfg)
    end
  end
)
  end
end

return UIOasisCostMatInfo


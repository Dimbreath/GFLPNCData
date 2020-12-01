-- params : ...
-- function num : 0 , upvalues : _ENV
local UIViewChipsItem = class("UIViewChipsItem", UIBaseNode)
local UINChipItem = require("Game.CommonUI.Item.UINChipItem")
local base = UIBaseNode
UIViewChipsItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINChipItem
  self.OnClickEvent = nil
  ;
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_chipItem, self, self.__OnBtnClick)
  self.chipItem = (UINChipItem.New)()
  ;
  (self.chipItem):Init((self.ui).chipItem)
  ;
  (((self.ui).obj_Lock).transform):SetAsLastSibling()
end

UIViewChipsItem.InitLevelChipItem = function(self, selIdx, chipData, unlock)
  -- function num : 0_1
  self.selIdx = selIdx
  self.chipData = chipData
  self.id = chipData.dataId
  ;
  (self.chipItem):InitChipItem(self.chipData)
  -- DECOMPILER ERROR at PC13: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.ui).tex_ItemName).text = (self.chipData):GetName()
  -- DECOMPILER ERROR at PC19: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.ui).img_QuailtyColor).color = (self.chipData):GetColor()
  self:UpdateUnlock(unlock)
  self:Show()
end

UIViewChipsItem.SetClickEvent = function(self, clickEvent)
  -- function num : 0_2
  self.OnClickEvent = clickEvent
end

UIViewChipsItem.UpdateUnlock = function(self, unlock)
  -- function num : 0_3
  self.unlock = unlock
  ;
  ((self.ui).obj_Lock):SetActive(not unlock)
end

UIViewChipsItem.IsUnlock = function(self)
  -- function num : 0_4
  return self.unlock
end

UIViewChipsItem.GetIndex = function(self)
  -- function num : 0_5
  return self.selIdx
end

UIViewChipsItem.SetLevelChipItemSelect = function(self, selected)
  -- function num : 0_6
  ((self.ui).obj_OnSelect):SetActive(selected)
end

UIViewChipsItem.__OnBtnClick = function(self)
  -- function num : 0_7
  if self.OnClickEvent ~= nil then
    (self.OnClickEvent)(self)
  end
end

UIViewChipsItem.OnDelete = function(self)
  -- function num : 0_8 , upvalues : base
  (base.OnDelete)(self)
end

return UIViewChipsItem

-- params : ...
-- function num : 0 , upvalues : _ENV
local UIViewChipsItem = class("UIViewChipsItem", UIBaseNode)
local UINChipItem = require("Game.CommonUI.Item.UINChipItem")
local base = UIBaseNode
UIViewChipsItem.OnInit = function(self)
    -- function num : 0_0 , upvalues : _ENV, UINChipItem
    self.OnClickEvent = nil;
    (UIUtil.LuaUIBindingTable)(self.transform, self.ui);
    (UIUtil.AddButtonListener)((self.ui).btn_chipItem, self, self.__OnBtnClick)
    self.chipItem = (UINChipItem.New)();
    (self.chipItem):Init((self.ui).chipItem);
    (((self.ui).obj_Lock).transform):SetAsLastSibling()
end

UIViewChipsItem.InitLevelChipItem = function(self, selIdx, chipData, unlock)
    -- function num : 0_1
    self.selIdx = selIdx
    self.chipData = chipData
    self.id = chipData.dataId;
    (self.chipItem):InitChipItem(self.chipData) -- DECOMPILER ERROR at PC13: Confused about usage of register: R4 in 'UnsetPending'
    ;
    ((self.ui).tex_ItemName).text = (self.chipData):GetName() -- DECOMPILER ERROR at PC19: Confused about usage of register: R4 in 'UnsetPending'
    ;
    ((self.ui).img_QuailtyColor).color = (self.chipData):GetColor()
    self:UpdateUnlock(unlock)
    self:Show()
end

UIViewChipsItem.SetClickEvent = function(self, clickEvent)
    -- function num : 0_2
    self.OnClickEvent = clickEvent
end

UIViewChipsItem.UpdateUnlock = function(self, unlock)
    -- function num : 0_3
    self.unlock = unlock;
    ((self.ui).obj_Lock):SetActive(not unlock)
end

UIViewChipsItem.IsUnlock = function(self)
    -- function num : 0_4
    return self.unlock
end

UIViewChipsItem.GetIndex = function(self)
    -- function num : 0_5
    return self.selIdx
end

UIViewChipsItem.SetLevelChipItemSelect =
    function(self, selected)
        -- function num : 0_6
        ((self.ui).obj_OnSelect):SetActive(selected)
    end

UIViewChipsItem.__OnBtnClick = function(self)
    -- function num : 0_7
    if self.OnClickEvent ~= nil then (self.OnClickEvent)(self) end
end

UIViewChipsItem.OnDelete = function(self)
    -- function num : 0_8 , upvalues : base
    (base.OnDelete)(self)
end

return UIViewChipsItem


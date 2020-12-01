-- params : ...
-- function num : 0 , upvalues : _ENV
local UIDormItem = class("UIDormItem", UIBaseNode)
UIDormItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btnItem, self, self.OnItemClick)
end

UIDormItem.InitDormItem = function(self, dormItemData, onClickActon)
  -- function num : 0_1
  self.dormItemData = dormItemData
  self.__onClickActon = onClickActon
  self:__InitUI(dormItemData)
end

UIDormItem.__InitUI = function(self, dormItemData)
  -- function num : 0_2
end

UIDormItem.OnItemClick = function(self)
  -- function num : 0_3
  if self.__onClickActon ~= nil then
    (self.__onClickActon)(self.dormItemData)
  end
end

UIDormItem.OnDelete = function(self)
  -- function num : 0_4
end

return UIDormItem

-- params : ...
-- function num : 0 , upvalues : _ENV
local UIDormItem = class("UIDormItem", UIBaseNode)
UIDormItem.OnInit = function(self)
    -- function num : 0_0 , upvalues : _ENV
    (UIUtil.LuaUIBindingTable)(self.transform, self.ui);
    (UIUtil.AddButtonListener)((self.ui).btnItem, self, self.OnItemClick)
end

UIDormItem.InitDormItem = function(self, dormItemData, onClickActon)
    -- function num : 0_1
    self.dormItemData = dormItemData
    self.__onClickActon = onClickActon
    self:__InitUI(dormItemData)
end

UIDormItem.__InitUI = function(self, dormItemData)
    -- function num : 0_2
end

UIDormItem.OnItemClick = function(self)
    -- function num : 0_3
    if self.__onClickActon ~= nil then
        (self.__onClickActon)(self.dormItemData)
    end
end

UIDormItem.OnDelete = function(self)
    -- function num : 0_4
end

return UIDormItem


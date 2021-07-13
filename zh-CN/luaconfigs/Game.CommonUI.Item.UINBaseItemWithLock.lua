-- params : ...
-- function num : 0 , upvalues : _ENV
local UINBaseItemWithReceived = require("Game.CommonUI.Item.UINBaseItemWithReceived")
local UINBaseItemWithLock = class("UINBaseItemWithLock", UIBaseNode)
local base = UIBaseNode
UINBaseItemWithLock.OnInit = function(self)
  -- function num : 0_0 , upvalues : UINBaseItemWithReceived
  local baseItemObj = (self.transform):Find("UINBaseItemWithReceived")
  self.baseItem = (UINBaseItemWithReceived.New)()
  ;
  (self.baseItem):Init(baseItemObj)
  self.obj_lock = ((self.transform):Find("Obj_lock")).gameObject
end

UINBaseItemWithLock.InitItemWithLock = function(self, itemCfg, count, clickEvent, isPicked, islock)
  -- function num : 0_1
  self:SetLockUIActive(islock)
  ;
  (self.baseItem):InitItemWithCount(itemCfg, count, clickEvent, isPicked)
end

UINBaseItemWithLock.SetLockUIActive = function(self, islock)
  -- function num : 0_2
  (self.obj_lock):SetActive(islock)
end

UINBaseItemWithLock.SetPickedUIActive = function(self, isPicked)
  -- function num : 0_3
  (self.baseItem):SetPickedUIActive(isPicked)
end

UINBaseItemWithLock.OnDelete = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnDelete)(self)
end

return UINBaseItemWithLock


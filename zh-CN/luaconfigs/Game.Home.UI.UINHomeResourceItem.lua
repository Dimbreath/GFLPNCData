-- params : ...
-- function num : 0 , upvalues : _ENV
local UINResourceItem = require("Game.CommonUI.ResourceGroup.UINResourceItem")
local UINHomeResourceItem = class("UINHomeResourceItem", UINResourceItem)
local base = UINResourceItem
local DefaultResourceId2ImgIndex = {[1001] = 0, [1002] = 1, [1003] = 2}
UINHomeResourceItem.InitCurrencyItem = function(self, itemCfg)
  -- function num : 0_0 , upvalues : DefaultResourceId2ImgIndex, base
  local index = DefaultResourceId2ImgIndex[itemCfg.id]
  if index ~= nil then
    ((self.ui).img_ResDecor):SetIndex(index)
  end
  ;
  (base.InitCurrencyItem)(self, itemCfg)
end

return UINHomeResourceItem


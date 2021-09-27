local UINGiftPageDetail = class("UINGiftPageDetail", UIBaseNode)
local base = UIBaseNode
local UINBaseItemWithCount = require("Game.CommonUI.Item.UINBaseItemWithCount")
UINGiftPageDetail.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINBaseItemWithCount
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  self.rewardPool = (UIItemPool.New)(UINBaseItemWithCount, (self.ui).uINBaseItemWithCount)
  ;
  ((self.ui).uINBaseItemWithCount):SetActive(false)
end

UINGiftPageDetail.InitGiftPageItem = function(self, day, itemList, isReceived, showProcess)
  -- function num : 0_1 , upvalues : _ENV
  ((self.ui).tex_Day):SetIndex(0, tostring(day))
  ;
  (((self.ui).tex_WaitState).gameObject):SetActive((not isReceived and showProcess))
  ;
  ((self.ui).done):SetActive(not isReceived or showProcess)
  ;
  (self.rewardPool):HideAll()
  if itemList ~= nil then
    for _,data in ipairs(itemList) do
      local item = (self.rewardPool):GetOne()
      item:InitItemWithCount(data.itemCfg, data.count)
    end
  end
  -- DECOMPILER ERROR: 5 unprocessed JMP targets
end

return UINGiftPageDetail


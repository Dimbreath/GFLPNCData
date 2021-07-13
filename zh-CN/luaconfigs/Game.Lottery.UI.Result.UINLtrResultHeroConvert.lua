-- params : ...
-- function num : 0 , upvalues : _ENV
local UINLtrResultHeroConvert = class("UINLtrResultHeroConvert", UIBaseNode)
local base = UIBaseNode
local UINBaseItemWithCount = require("Game.CommonUI.Item.UINBaseItemWithCount")
UINLtrResultHeroConvert.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINBaseItemWithCount
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  ((self.ui).rewardItem):SetActive(false)
  self.itemPool = (UIItemPool.New)(UINBaseItemWithCount, (self.ui).rewardItem)
end

UINLtrResultHeroConvert.InitLtrResultHeroConvert = function(self, itemIdList, numList)
  -- function num : 0_1 , upvalues : _ENV
  (self.itemPool):HideAll()
  for k,id in ipairs(itemIdList) do
    local num = numList[k]
    local itemCfg = (ConfigData.item)[id]
    if itemCfg == nil then
      error("Cant get itemCfg, id = " .. tostring(id))
    else
      local item = (self.itemPool):GetOne()
      item:InitItemWithCount(itemCfg, num)
    end
  end
end

UINLtrResultHeroConvert.OnDelete = function(self)
  -- function num : 0_2 , upvalues : base
  (self.itemPool):DeleteAll()
  ;
  (base.OnDelete)(self)
end

return UINLtrResultHeroConvert


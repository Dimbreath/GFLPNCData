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

UINLtrResultHeroConvert.HideAllChild = function(self)
  -- function num : 0_1
  (self.itemPool):HideAll()
end

UINLtrResultHeroConvert.GetOneChlid = function(self, itemCfg, num)
  -- function num : 0_2 , upvalues : _ENV
  local item = (self.itemPool):GetOne()
  item:InitItemWithCount(itemCfg, num)
  if (item.ui).FxArr ~= nil then
    for _,uiparticle in ipairs((item.ui).FxArr) do
      uiparticle:Stop()
    end
  end
end

UINLtrResultHeroConvert.ShowHeroConvertFx = function(self)
  -- function num : 0_3 , upvalues : _ENV
  for _,item in ipairs((self.itemPool).listItem) do
    if (item.ui).FxArr ~= nil then
      for _,uiparticle in ipairs((item.ui).FxArr) do
        uiparticle:Play()
      end
    end
  end
end

UINLtrResultHeroConvert.OnDelete = function(self)
  -- function num : 0_4 , upvalues : base
  (self.itemPool):DeleteAll()
  ;
  (base.OnDelete)(self)
end

return UINLtrResultHeroConvert

